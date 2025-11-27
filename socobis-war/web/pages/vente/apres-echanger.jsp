<%@ page import="user.UserEJB"%>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="vente.*" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="utilitaire.*"%>
<%@ page import="constante.*"%>
<%@ page import="stock.*"%>
<%@ page import="utils.ConstanteStation"%>
<%@ page import="java.sql.Date"%>   
<%@ page import="java.time.LocalDate"%>
<%@ page import="caisse.MvtCaisse"%>
<%@ page import="paiement.LiaisonPaiement"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
Connection connection = null;
  try{
    UserEJB u = (UserEJB) session.getAttribute("u");
    String userId = null;
    try {
        if (u != null && u.getUser() != null) {
            userId = u.getUser().getTuppleID();
        }
    } catch(Exception e) {
        userId = "system";
    }


    String lien = (String) session.getAttribute("lien");
    String acte = request.getParameter("acte");
    String bute = request.getParameter("bute");

    connection = new UtilDB().GetConn();

    String[] tId = request.getParameterValues("ids");
    int nbLine = Integer.parseInt(request.getParameter("nbLine"));

    VenteLib vl = (VenteLib) session.getAttribute("vente");

    if (vl.getEtat() != ConstanteEtatPaie.getEtatValiderParDG()) {
        throw new Exception("Mila valider ilay vente");
    }

    VenteDetailsLib vdl = (VenteDetailsLib) session.getAttribute("vente-detail");

    ClassMAPTable mere = (ClassMAPTable) vl;
    ClassMAPTable fille = (ClassMAPTable) vdl;

    int qte = (int) Double.parseDouble(request.getParameter("quantite"));

    PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);
    ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();

    double montantTotalFille = 0;
    double montantTotalFacture = vl.getMontantTtcAr();
    double montantProduitTaloha = vdl.getPunet() * qte;

    for (ClassMAPTable c : cfille) {
        VenteDetailsLib tempVdl = (VenteDetailsLib) c;
        tempVdl.setIdVente(vl.getId());
        montantTotalFille += tempVdl.getQte() * tempVdl.getPunet();
    }

    double montantFactureVaovao = montantTotalFacture - montantProduitTaloha + montantTotalFille;

    System.out.println("Facture Taloha : " + montantTotalFacture + ", Facture Vaovao : " + montantFactureVaovao + ", TotalFilleVaovao : " + montantTotalFille + " , Produit taloha : " + montantProduitTaloha);

    double estchangeable = vdl.getEstchangeable();
    System.out.println(estchangeable);

    if (estchangeable == 0) {
        throw new Exception("Le produit est inchangeable");
    } else if (estchangeable == 1) {

        if (montantFactureVaovao < montantTotalFacture) {
            throw new Exception("le montant paye ne peut pas etre retourner l'argent ");
        } 
        
    } else {

        if (montantFactureVaovao - montantTotalFacture < 0) {

            System.out.println("ici");
            System.out.println("insertion " + montantProduitTaloha);
            MvtCaisse mvtCaisse = new MvtCaisse();


                mvtCaisse.setNomTable("MOUVEMENTCAISSE");

            mvtCaisse.setDesignation("Debit  à retourner ");
            mvtCaisse.setIdCaisse("CAI000238");
            mvtCaisse.setIdTiers(vl.getIdClient());
            mvtCaisse.setDaty(Date.valueOf(LocalDate.now()));
            mvtCaisse.setDebit(montantProduitTaloha);de 
            mvtCaisse.setCredit(0);
            mvtCaisse.setEtat(ConstanteEtatPaie.getEtatValiderlParDG());

            mvtCaisse.createObject(userId, connection);
        }
    }

    // Fafana leh izi raha oe leh qte alana mitovy amleh qte anleh produit asorina
    vdl.setNomTable("VENTE_DETAILS");

     if (qte > vdl.getQte()) {
            throw new Exception("quantite demande est superieure à la quantite  retournée");
    } else {
        System.out.println("Updateko ato ito zany");
        vdl.setQte(vdl.getQte() - qte);
        vdl.updateToTable(connection);
    }
    
    // Insertion anaty stock
    MvtStock mvtStockMere = new MvtStock();
    mvtStockMere.setNomTable("MVTSTOCK");

        mvtStockMere.setIdMagasin(vl.getIdMagasin());
        mvtStockMere.setIdTypeMvStock(ConstanteStation.TYPEMVTSTOCKENTREE);
        mvtStockMere.setDaty(Date.valueOf(LocalDate.now()));
        // mvtStockMere.setEtat(ConstanteEtat.getEtatValider());

    // mvtStockMere.insertToTable(connection);

    MvtStockFille mvtStockFille = new MvtStockFille();
    mvtStockFille.setNomTable("MVTSTOCKFILLE");


        mvtStockFille.setIdProduit(vdl.getIdProduit());
        mvtStockFille.setEntree(Double.valueOf(qte));
        mvtStockFille.setSortie(0);
        mvtStockFille.setPu(vdl.getPunet());

    mvtStockMere.setFille(new MvtStockFille[] {mvtStockFille});
    mvtStockMere.createObject(userId, connection);
    mvtStockMere.saveMvtStockFille(userId, connection);
    mvtStockMere.validerObject(userId, connection);

    System.out.println("ID oh : " + mvtStockMere.getId());

    if (Integer.parseInt(request.getParameter("payement")) == 1) {
        double montantAloha = vl.getMontantreste();
        montantAloha += montantFactureVaovao - montantTotalFacture;

        MvtCaisse mvtCaisse = new MvtCaisse();


        mvtCaisse.setNomTable("MOUVEMENTCAISSE");

            mvtCaisse.setDesignation("Payement anleh zavatra");
            mvtCaisse.setIdCaisse("CAI000238");
            mvtCaisse.setIdTiers(vl.getIdClient());
            mvtCaisse.setDaty(Date.valueOf(LocalDate.now()));
            mvtCaisse.setDebit(0);
            mvtCaisse.setCredit(montantAloha);
            mvtCaisse.setEtat(ConstanteEtatPaie.getEtatValiderParDG());

            mvtCaisse.createObject(userId, connection);



        LiaisonPaiement liasonPayement = new LiaisonPaiement();
            liasonPayement.setNomTable("LIAISONPAIEMENT");

            liasonPayement.setId1(mvtCaisse.getId());
            liasonPayement.setId2(vl.getId());
            liasonPayement.setMontant(montantAloha);

            liasonPayement.setEtat(ConstanteEtatPaie.getEtatValiderParDG());
            liasonPayement.createObject(userId, connection);

            // mvtCaisse.validerSimple(userId, connection);
    }

    // Insertion Ligne
    for (ClassMAPTable c : cfille) {
        c.setNomTable("VENTE_DETAILS");
        c.insertToTable(connection);
    }

    String url = lien + "?but=vente/vente-fiche.jsp&id="+ vl.getId();
    System.out.println(url);
%>

<script type="text/javascript"> document.location.replace("<%= url %>");</script>

<%
}catch (Exception e) {
  e.printStackTrace();
%>

<script type="text/javascript">
  alert(`<%=e.getMessage()%>`);
  history.back();
</script>
<%

  } finally {
    if (connection != null) {
        connection.close();
    }
  }
%>
