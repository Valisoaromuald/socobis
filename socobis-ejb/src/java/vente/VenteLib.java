/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

/**
 *
 * @author Angela
 */
public class VenteLib extends Vente {
    private String idMagasinLib, idOrigine;
    private String etatLib;
    private double montanttotal;
    private String idDevise;
    private String idClientLib;
    private double montantpaye;
    private double montantreste;
    private double montantttc;
    private double montantTtcAr;
    protected double avoir, montantremise, montant, poids;
    private String referencefacture, modepaiementlib;
    private int mois, annee;
    private String modelivraisonlib, idprovince, provincelib, livraison;
    private double frais;
    private double colis;

    public String getLivraison() {
        return livraison;
    }

    public void setLivraison(String livraison) {
        this.livraison = livraison;
    }

    @Override
    public String toString() {
        return "VenteLib [idMagasinLib=" + idMagasinLib + ", idOrigine=" + idOrigine + ", etatLib=" + etatLib
                + ", montanttotal=" + montanttotal + ", idDevise=" + idDevise + ", idClientLib=" + idClientLib
                + ", montantpaye=" + montantpaye + ", montantreste=" + montantreste + ", montantttc=" + this.getMontantttc()
                + ", montantTtcAr=" + this.getMontantTtcAr() + ", avoir=" + avoir + ", montantremise=" + montantremise
                + ", montant=" + montant + ", poids=" + poids + ", referencefacture=" + referencefacture
                + ", modepaiementlib=" + modepaiementlib + ", mois=" + mois + ", annee=" + annee + ", modelivraisonlib="
                + modelivraisonlib + ", idprovince=" + idprovince + ", provincelib=" + provincelib + ", livraison="
                + livraison + ", frais=" + frais + ", colis=" + colis + "]";
    }

    public double getFrais() {
        return this.frais;
    }

    public void setFrais(double frais) {
        this.frais = frais;
    }

    public String getModelivraisonlib() {
        return this.modelivraisonlib;
    }

    public void setModelivraisonlib(String modelivraisonlib) {
        this.modelivraisonlib = modelivraisonlib;
    }

    public String getModepaiementlib() {
        return this.modepaiementlib;
    }

    public void setModepaiementlib(String modepaiementlib) {
        this.modepaiementlib = modepaiementlib;
    }

    public double getPoids() {
        return this.poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getMontant() {
        return this.montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontantremise() {
        return this.montantremise;
    }

    public void setMontantremise(double montantremise) {
        this.montantremise = montantremise;
    }

    public String getIdOrigine() {
        return this.idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public double getAvoir() {
        return this.avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
    }

    public String getDesignation() {
        return this.designation;
    }

    public int getMois() {
        return this.mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public String getIdprovince() {
        return this.idprovince;
    }

    public void setIdprovince(String idprovince) {
        this.idprovince = idprovince;
    }

    public String getProvincelib() {
        return this.provincelib;
    }

    public void setProvincelib(String provincelib) {
        this.provincelib = provincelib;
    }

    public int getAnnee() {
        return this.annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public double getMontantTtcAr() {
        return this.montantTtcAr;
    }

    public void setMontantTtcAr(double montantTtcAr) {
        this.montantTtcAr = montantTtcAr;
    }

    @Override
    public double getMontantttc() {
        return this.montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantpaye() {
        return this.montantpaye;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }

    public double getMontantreste() {
        return this.montantreste;
    }

    public String getIdClientLib() {
        return this.idClientLib;
    }

    public void setIdClientLib(String idClientLib) {
        this.idClientLib = idClientLib;
    }

    public String getIdDevise() {
        return this.idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public double getMontanttotal() {
        return this.montanttotal;
    }

    public void setMontanttotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public VenteLib() {
        this.setNomTable("VENTE_CPL");
    }

    public String getIdMagasinLib() {
        return this.idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }

    public String getEtatLib() {
        return this.etatLib;
    }

    public String getChaineEtat() {
        return chaineEtat(this.getEtat());
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    public String getReferencefacture() {
        return this.referencefacture;
    }

    public void setReferencefacture(String referencefacture) {
        this.referencefacture = referencefacture;
    }

    public double getColis() {
        return this.colis;
    }

    public void setColis(double colis) {
        this.colis = colis;
    }
}
