<%@page import="caisse.Caisse"%>
<%@page import="vente.InsertionVente"%>
<%@page import="vente.*"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@ page import="client.Client" %>
<%@ page import="faturefournisseur.ModePaiement" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    boolean carteExpiree = false;
    try {

        String idVente = request.getParameter("idvente");
        String idProduit = request.getParameter("idproduit");

        String payement = request.getParameter("payement");

        VenteDetailsLib venteDetails = (VenteDetailsLib) new VenteDetailsLib();
        venteDetails.setNomTable("VENTE_DETAILS_POIDS");
        VenteLib vl = null;

        Object[] resultVenteDetails = CGenUtil.rechercher(venteDetails, "SELECT * FROM VENTE_DETAILS_POIDS WHERE id like '" + idProduit + "'");
        Object[] resultVentes = CGenUtil.rechercher((VenteLib) new VenteLib(), "SELECT * FROM VENTE_CPL WHERE id like '" + idVente + "'");

        if (resultVenteDetails.length > 0) {
            venteDetails = (VenteDetailsLib) resultVenteDetails[0];
        } else {
            throw new Exception("Aucun vente details de cette id");
        }

        if (resultVentes.length > 0) {
            vl = (VenteLib) resultVentes[0];
        } else {
            throw new Exception("Aucun vente de cette id");
        }

        if (idVente != null) {
            session.setAttribute("vente", vl);
        }

        if (idProduit != null) {
            session.setAttribute("vente-detail", venteDetails);
        }

        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        String nomtable = "Vente_Details";
        InsertionVente mere = new InsertionVente();
        VenteDetailsLib fille = new VenteDetailsLib();
        fille.setNomTable("VENTE_DETAILS_VIDE");
        int nombreLigne = 1;
        As_BondeLivraisonClient blf = new As_BondeLivraisonClient();
        VenteDetails[] vente_details = null;
        if(request.getParameter("id")!=null){
            blf.setId(request.getParameter("id"));
            vente_details = blf.getListeVenteDetails("AS_BC_FILLE_AVEC_PRIX",null);
        }
        
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);

        if(request.getParameter("id")!=null && !request.getParameter("id").isEmpty()){
            if(request.getParameter("idClient")!=null && !request.getParameter("idClient").isEmpty()){
                pi.getFormu().getChamp("idClient").setDefaut(request.getParameter("idClient"));
            }

            if(request.getParameter("idPoint")!=null && !request.getParameter("idPoint").isEmpty()){
                pi.getFormu().getChamp("idMagasin").setDefaut(request.getParameter("idPoint"));
            }
        }
        
        affichage.Champ.setPageAppelCompleteAWhere(pi.getFormufle().getChampFille("idProduit"),"produits.IngredientVente","id","AS_INGREDIENT_VENTE_LIB","prixunitaire;compte_vente;libelle;idunite;idunitelib","pu;compte;designation;unite;unitelib"," AND 1=1");
        double tva = 0.0;
        if (request.getParameter("onchanged") != null && request.getParameter("onchanged").equals("true")){
            String idmagasin = request.getParameter("idMagasin");
            if(request.getParameter("idMagasin") != null && !request.getParameter("idMagasin").isEmpty()){
                session.setAttribute("idMagasin", request.getParameter("idMagasin"));
            }
            if(idmagasin == null || idmagasin.isEmpty()){
                idmagasin = (String) session.getAttribute("idMagasin");
            }
            Client c = null;
            if(request.getParameter("idClientlibelle")!=null && request.getParameter("idClientlibelle").split(" - ").length>0){
                String idclient = request.getParameter("idClientlibelle").split(" - ")[0];
                c = (Client)new Client().getById(idclient,"client",null);
                Calendar cal = Calendar.getInstance();
                cal.setTime(c.getDatecarte());
                cal.add(Calendar.YEAR, 1);
                Date dateCartePlusUnAn = cal.getTime();
                Date dateAujourdhui = new Date();
                carteExpiree = dateAujourdhui.compareTo(dateCartePlusUnAn) >= 0;
                tva = c.getTaxe();
                session.setAttribute("idclient", idclient);
            }else{
                c = (Client)new Client().getById((String) session.getAttribute("idclient"),"client",null);
                tva = c.getTaxe();
            }
            if(idmagasin!=null && c!=null){
                affichage.Champ.setPageAppelCompleteAWhere(pi.getFormufle().getChampFille("idProduit"),"produits.IngredientVente","id","AS_INGREDIENT_VENTE_LIB","prixunitaire;compte_vente;libelle;idunite;idunitelib","pu;compte;designation;unite;unitelib", " AND IDMAGASIN='"+idmagasin+"'");
            }
        }else{
            session.removeAttribute("idMagasin");
        }

        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("tva_0").setLibelle("TVA (En %)");
        pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
        pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("remise_0").setLibelle("Remise (En %)");
        pi.getFormufle().getChamp("idOrigine_0").setLibelle("Origine");

        pi.getFormufle().getChamp("qte_0").setLibelle("Quantit&eacute;");
        pi.getFormufle().getChamp("pu_0").setLibelle("PU Brut");
        pi.getFormufle().getChamp("punet_0").setLibelle("PU Net");
        pi.getFormufle().getChamp("montantht_0").setLibelle("Montant HT");
        pi.getFormufle().getChamp("montantttc_0").setLibelle("Montant TTC");
        pi.getFormufle().getChampMulitple("idVente").setVisible(false);
        pi.getFormufle().getChampMulitple("id").setVisible(false);
         pi.getFormufle().getChampMulitple("idOrigine").setVisible(false);
        pi.getFormufle().getChampMulitple("puAchat").setVisible(false);
        pi.getFormufle().getChampMulitple("puVente").setVisible(false);
        pi.getFormufle().getChampMulitple("idDevise").setVisible(false);
        pi.getFormufle().getChampMulitple("idbcfille").setVisible(false);
        pi.getFormufle().getChamp("tauxDeChange_0").setLibelle("Taux de change");
        pi.getFormufle().getChamp("unitelib_0").setLibelle("Unit&eacute;");
        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation ");
        pi.getFormufle().getChampMulitple("tauxDeChange").setVisible(false);
        pi.getFormufle().getChampMulitple("compte").setVisible(false);
        pi.getFormufle().getChampMulitple("unite").setVisible(false);
        if(vente_details!=null && vente_details.length>0){
            pi.setDefautFille(vente_details);
            pi.getFormu().getChamp("idOrigine").setDefaut(request.getParameter("id"));
            pi.getFormu().getChamp("designation").setDefaut("Facturation de la livraison num "+request.getParameter("id"));
        }
        String[] order_form = {"daty","designation","idMagasin","idClient","remarque","idDevise","estPrevu","datyPrevu","idOrigine","etat","referencefact"};
        pi.getFormu().setOrdre(order_form);

        pi.preparerDataFormu();
        for(int i=0;i<nombreLigne;i++){
            pi.getFormufle().getChamp("qte_"+i).setAutre("onChange='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("remise_"+i).setAutre("onChange='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("tva_"+i).setAutre("onChange='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("idDevise_"+i).setDefaut("AR");
            pi.getFormufle().getChamp("tva_"+i).setDefaut(tva+"");
            pi.getFormufle().getChamp("unitelib_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("compte_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("punet_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("montantht_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("montantttc_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("pu_"+i).setAutre("readonly");
        }
        String[] order = {"idProduit","idOrigine", "designation","unite","unitelib", "pu", "compte", "qte", "remise","punet", "tva","montantht","montantttc" ,"tauxDeChange","idbcfille"};
        pi.getFormufle().setColOrdre(order);

        if(request.getParameter("idBC")!=null && !request.getParameter("idBC").trim().isEmpty())
        {
            BonDeCommande bc = new BonDeCommande();
            bc.setId(request.getParameter("idBC"));
            InsertionVente v = bc.createVente();
            v.setDatyPrevu(null);
            Client c = (Client)new Client().getById(v.getIdClient(),"client",null);
            Calendar cal = Calendar.getInstance();
            cal.setTime(c.getDatecarte());
            cal.add(Calendar.YEAR, 1);
            Date dateCartePlusUnAn = cal.getTime();
            Date dateAujourdhui = new Date();
            carteExpiree = dateAujourdhui.compareTo(dateCartePlusUnAn) >= 0;
            BonDeCommandeFIlleCpl[] details = bc.getFilleBCLib();
            if (details != null && details.length > 0) {
                VenteDetailsLib[] lignes = new VenteDetailsLib[details.length];
                for (int i = 0; i < details.length; i++) {
                    BonDeCommandeFIlleCpl detail = details[i];
                    lignes[i] = detail.createVenteFilleLib();
                }
                pi.setDefautFille(lignes);
            }
            pi.getFormu().setDefaut(v);
        }

        //Variables de navigation
        String classeMere = "vente.InsertionVente";
        String classeFille = "vente.VenteDetails";
        String butApresPost = "vente/vente-fiche.jsp";
        String colonneMere = "idVente";
        //Preparer les affichages
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();

        String titre = "Echanger";
        if(request.getParameter("acte")!=null){
            titre = "Modification de la facture client";
        }
%>
<div class="content-wrapper">
    <h1><%= titre %></h1>
    <div class="box-body">
        <form id="formId" class='container' action="module.jsp?but=vente/apres-echanger.jsp&payement=<%= payement %>" method="post" >
            
            <div class="col-md-12 cardradius">
                <div class="input-container">
                    <div class="form-input">
                        <label class="input-label" for="qte">Quantite</label>
                        <span class="d-flex gap-2">
                            <input name="quantite" type="number" class="form-control" id="qte" value="<%= venteDetails.getQte() %>">
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-md-12" >
                <div id="butfillejsp">
                    <script>
                        <%
                        if(carteExpiree) {
                        %>
                        (function() {
                            if(typeof jQuery === 'undefined') {
                                window.alert('La carte du client est expiré.');
                            } else {
                                if(typeof jAlert === 'undefined') {
                                    alert('La carte du client est expiré.');
                                } else {
                                    jAlert('La carte du client est expiré.', 'Attention');
                                }
                            }
                        })();
                        <%
                        }
                        %>
                    </script>
                    <%
                        out.println(pi.getFormufle().getHtmlTableauInsert());
                    %>
                </div>
            </div>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
            <input name="nbLine" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">
        </form>
    </div>     
</div>
<script>
   const champ = document.getElementById("echeancefacture");

    document.addEventListener("DOMContentLoaded", function () {
        const champidFournisseur = document.getElementById("idClient");
        const observer = new MutationObserver(function (mutationsList) {
            for (let mutation of mutationsList) {
                if (mutation.type === "attributes" && mutation.attributeName === "value") {
                    console.log("Nouvelle valeur :", champidFournisseur.value);
                    changerValeur();
                    // Ton code ici
                }
            }
        });

        observer.observe(champidFournisseur, { attributes: true });
    });


    champ.addEventListener("input", function () {
        console.log("La valeur a changé :", this.value);
    });

    function sanitizeNumber(str) {
        return parseFloat(str.replace(/\s/g, '').replace(',', '.')) || 0;
    }
    changerValeur();
    function changerValeur() {
        const champDaty = document.getElementById("datyPrevu");

        let jour, mois, annee;
        
        const today = new Date();
        jour = today.getDate();
        mois = today.getMonth() + 1;
        annee = today.getFullYear();
        const date = new Date(annee, mois - 1, jour);

        if (isNaN(date.getTime())) {
            alert("Date invalide !");
            return;
        }

        const nbJours = sanitizeNumber(champ.value);
        date.setDate(date.getDate() + nbJours);

        const formattedDate = [
            String(date.getDate()).padStart(2, '0'),
            String(date.getMonth() + 1).padStart(2, '0'),
            date.getFullYear()
        ].join("/");

        champDaty.value = formattedDate;
        champ.dispatchEvent(new Event("input"));
    }
    

</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var val = 0;
        $('input[id^="montantttc_"]').each(function() {
            var montant = parseFloat($(this).val().replace(/\s/g, ''));
            if(!isNaN(montant)){
                val += montant;
            }
        });
        $("#montanttotal").html(Intl.NumberFormat('fr-FR', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(val));
        const deviseSelect = document.getElementById('idDevise');
        deviseSelect.addEventListener('change', function() {
            const deviseSelectionne = this.value;
            for (let i = 0; i <= 1; i++) {
                const champDevise = document.getElementById('idDevise_' + i);
                if (champDevise) {
                    champDevise.value = deviseSelectionne;
                    if (champDevise.tagName === 'SELECT') {
                        for (let j = 0; j < champDevise.options.length; j++) {
                            if (champDevise.options[j].value === deviseSelectionne) {
                                champDevise.selectedIndex = j;
                                break;
                            }
                        }
                    }
                    const event = new Event('change');
                    champDevise.dispatchEvent(event);
                }
            }
        });
    });
</script>
<script>
    function formatNumber(number) {
        return number.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }
    function calculerMontant(indice) {
        // Récupérer les valeurs des champs
        var pu = parseFloat(document.getElementById('pu_' + indice).value.replace(/\s/g, '')) || 0;
        var qte = parseFloat(document.getElementById('qte_' + indice).value.replace(/\s/g, '')) || 0;
        var remise = parseFloat(document.getElementById('remise_' + indice).value.replace(/\s/g, '')) || 0;
        var tva = parseFloat(document.getElementById('tva_' + indice).value.replace(/\s/g, '')) || 0;

        // Calculer le PU Net (PU après remise)
        var punet = pu - (pu * remise / 100) + ((pu * tva / 100));

        // Calculer le Montant HT
        var montantht = (pu - (pu * remise / 100)) * qte;

        // Calculer le Montant TTC (HT + TVA)
        var montantttc = punet *  qte;

        // Mettre à jour les champs calculés
        document.getElementById('pu_' + indice).value = formatNumber(pu);
        document.getElementById('punet_' + indice).value = formatNumber(punet);
        document.getElementById('montantht_' + indice).value = formatNumber(montantht);
        document.getElementById('montantttc_' + indice).value = formatNumber(montantttc);

        var val = 0;
        $('input[id^="montantttc_"]').each(function() {
            var montant = parseFloat($(this).val().replace(/\s/g, ''));
            if(!isNaN(montant)){
                val += montant;
            }
        });
        $("#montanttotal").html(Intl.NumberFormat('fr-FR', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(val));
    }
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script type="text/javascript">
        alert(`<%=e.getMessage()%>`);
        history.back();
    </script>
<% }%>

