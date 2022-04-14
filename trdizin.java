package com.mycompany.staj1;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * @author Goktug
 */
public class trdizin {

    public static void main(String[] args) {
        trdizin dp = new trdizin();
        dp.DergiGetir();
    }
    VT_Islemler sql = new VT_Islemler();

    public void DergiGetir() {
        for (int l = 1; l < 105; l++) {
            String link = "https://app.trdizin.gov.tr/statistics/listAcceptedJournals.xhtml?&query=defaultSearchField-AND-*";
            String sonuc = "";
            try {
                Document doc = Jsoup.connect(link).get();
                Elements link2 = doc.select("div.col-md-2.col-lg-1.d-flex.align-items-center.justify-content-center.image-perspectiveContainer a");
                for (int i = 0; i < link2.size(); i++) {
                    sonuc = link2.get(i).attr("href");
                    System.out.println("DERGI:" + sonuc);
                    MakaleGetir(sonuc);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public void MakaleGetir(String sDergiLinki) {
        String sonuc = "";
        sDergiLinki = "https://app.trdizin.gov.tr" + sDergiLinki;
        try {
            Document doc = Jsoup.connect(sDergiLinki).get();
            Elements link2 = doc.select("a.details-header__header");
            for (int i = 0; i < link2.size(); i++) {
                sonuc = link2.get(i).attr("href");
                System.out.println("MAKALE: " + sonuc);
                MakaleBilgileriniGetir(sonuc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MakaleBilgileriniGetir(String sMakaleLinki) {
        sMakaleLinki = "https://app.trdizin.gov.tr" + sMakaleLinki;
        try {
            Document doc = Jsoup.connect(sMakaleLinki).get();

            Elements link2 = doc.select("div.doi-container a");
            String sDoiLink = link2.attr("href");
            String sDoi = "";
            try {
                sDoi = sDoiLink.substring(16);
            } catch (Exception e) {
            }

            System.out.println("DOI: " + sDoi);

            Elements link3 = doc.select("span.color-passive.mr-3");
            String sGoruntulenme = link3.text();
            System.out.println("GORUNTULENME: " + sGoruntulenme);

            Elements link4 = doc.select("span.color-passive");
            String goruntulenmeveindirme[] = link4.text().split(" ");
            String sIndirme = goruntulenmeveindirme[1];
            System.out.println("INDIRME: " + sIndirme);

//          Elements link5 = doc.select("meta_stats_total_article_favorite");
//          String sFavori = link5.attr("content");
//          System.out.println("FAVORI: "+sFavori);

            if (sDoi.length() > 2) {
                sql.add_or_upgrade_data(sDoi, Integer.parseInt(sGoruntulenme), Integer.parseInt("0"), 0, "trdizin", Integer.parseInt(sIndirme));
            } else {
                System.out.println("Doi Numrasi bulunamadi :(");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
