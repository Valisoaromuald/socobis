/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import chatbot.AiTabDesc;
import chatbot.ClassIA;
import encaissement.EncaissementDetails;

import java.sql.Date;

import bean.Constante;

/**
 *
 * @author Angela
 */
@AiTabDesc("La structure de ma table de vente est comme ceci: ")
public class VenteDetailsLib extends VenteDetails implements ClassIA {

    protected String idProduitLib;
    protected String idCategorie;
    protected String idCategorieLib;
    protected double puRevient;
    protected double puTotal;
    protected Date daty;
    protected String idMagasin;
    protected String idMagasinLib;
    protected String idPoint;
    protected String idPointLib;
    protected double reste, montant;
    protected String idUnite;
    protected String idDeviseLib, unitelib;
    private String categorieproduitlib;
    private String idclientlib;
    protected Date datyprevu;
    private double punet, montantht, montantttc, montantremise, poids, frais;
    private double estchangeable;

    
    @Override
    public String toString() {
        return "VenteDetailsLib [idProduitLib=" + idProduitLib + ", idCategorie=" + idCategorie + ", idCategorieLib="
                + idCategorieLib + ", puRevient=" + puRevient + ", puTotal=" + puTotal + ", daty=" + daty
                + ", idMagasin=" + idMagasin + ", idMagasinLib=" + idMagasinLib + ", idPoint=" + idPoint
                + ", idPointLib=" + idPointLib + ", reste=" + reste + ", montant=" + montant + ", idUnite=" + idUnite
                + ", idDeviseLib=" + idDeviseLib + ", unitelib=" + unitelib + ", categorieproduitlib="
                + categorieproduitlib + ", idclientlib=" + idclientlib + ", datyprevu=" + datyprevu + ", punet=" + getPunet()
                + ", montantht=" + this.getMontantht() + ", montantttc=" + this.getMontantttc() + ", montantremise=" + montantremise
                + ", poids=" + poids + ", frais=" + frais + ", getQte()=" + getQte() + "]";
    }

    public String getIdclientlib() {
        return this.idclientlib;
    }

    public void setIdclientlib(String idclientlib) {
        this.idclientlib = idclientlib;
    }

    public String getCategorieproduitlib() {
        return this.categorieproduitlib;
    }

    public void setCategorieproduitlib(String categorieproduitlib) {
        this.categorieproduitlib = categorieproduitlib;
    }

    public Date getDatyprevu() {
        return this.datyprevu;
    }

    public void setDatyprevu(Date datyprevu) {
        this.datyprevu = datyprevu;
    }

    public double getFrais() {
        return this.frais;
    }

    public void setFrais(double frais) {
        this.frais = frais;
    }

    public double getPoids() {
        return this.poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getMontantremise() {
        return this.montantremise;
    }

    public void setMontantremise(double montantremise) {
        this.montantremise = montantremise;
    }

    public String getUnitelib() {
        return this.unitelib;
    }

    public void setUnitelib(String unitelib) {
        this.unitelib = unitelib;
    }

    public double getPunet() {
        return this.punet;
    }

    public void setPunet(double punet) {
        this.punet = punet;
    }

    public double getMontantht() {
        return this.montantht;
    }

    public void setMontantht(double montantht) {
        this.montantht = montantht;
    }

    public double getMontantttc() {
        return this.montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    @Override
    public String getNomTableIA() {
        return "VENTE_DETAILS_CPL_2_VISEE";
    }

    @Override
    public String getUrlListe() {
        return "/socobis/pages/module.jsp?but=vente/vente-liste.jsp&currentMenu=MNDN000000007";
    }

    @Override
    public String getUrlAnalyse() {
        return "/socobis/pages/module.jsp?but=vente/vente-analyse.jsp&currentMenu=MNDN0000000111";
    }

    @Override
    public String getUrlSaisie() {
        return "/socobis/pages/module.jsp?but=vente/vente-saisie.jsp&currentMenu=MNDN000000006";
    }

    @Override
    public ClassIA getClassListe() {
        return this;
    }

    @Override
    public ClassIA getClassAnalyse() {
        return this;
    }

    @Override
    public ClassIA getClassSaisie() {
        return this;
    }

    public double getMontant() {
        return this.montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getReste() {
        return this.reste;
    }

    public void setReste(double reste) {
        if (reste <= 0) {
            reste = 0;
        } else {
            this.reste = reste;
        }
    }

    public String getIdUnite() {
        return this.idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getIdDeviseLib() {
        return this.idDeviseLib;
    }

    public void setIdDeviseLib(String idDeviseLib) {
        this.idDeviseLib = idDeviseLib;
    }

    public String getIdPoint() {
        return this.idPoint;
    }

    public void setIdPoint(String idPoint) {
        this.idPoint = idPoint;
    }

    public String getIdPointLib() {
        return this.idPointLib;
    }

    public void setIdPointLib(String idPointLib) {
        this.idPointLib = idPointLib;
    }

    public String getIdMagasin() {
        return this.idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdMagasinLib() {
        return this.idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }

    public Date getDaty() {
        return this.daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdCategorie() {
        return this.idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getIdCategorieLib() {
        return this.idCategorieLib;
    }

    public void setIdCategorieLib(String idCategorieLib) {
        this.idCategorieLib = idCategorieLib;
    }

    public double getPuRevient() {
        return this.puRevient;
    }

    public void setPuRevient(double puRevient) {
        this.puRevient = puRevient;
    }

    public VenteDetailsLib() {
        this.setNomTable("VENTE_DETAILS_LIB");
    }

    public String getIdProduitLib() {
        return this.idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public double getPuTotal() {
        return this.puTotal;
    }

    public void setPuTotal(double puTotal) {
        this.puTotal = puTotal;
    }

    public EncaissementDetails generateEncaissementDetails() throws Exception {
        EncaissementDetails encaissementDetails = new EncaissementDetails();
        encaissementDetails.setMontant(montant);
        encaissementDetails.setIdOrigine(this.getId());
        encaissementDetails.setIdDevise(this.getIdDevise());
        encaissementDetails.setRemarque("Encaissement Vente " + this.getIdProduitLib());

        return encaissementDetails;
    }

    public double getMargeBrute() {
        return this.margeBrute;
    }


    public double getEstchangeable() {
        return estchangeable;
    }


    public void setEstchangeable(double estchangeable) {
        this.estchangeable = estchangeable;
    }

}
