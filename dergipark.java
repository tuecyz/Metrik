package com.mycompany.staj1;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * @author Goktug
 */
public class dergipark {

    public static void main(String[] args) {
        dergipark dp = new dergipark();

        dp.DergiGetir();
    }
    VT_Islemler sql = new VT_Islemler();

    public void DergiGetir() {
        for (int l = 1; l < 105; l++) {
            String link = "https://dergipark.org.tr/tr/search/" + l + "?section=journal";
            String sonuc = "";
            try {
                Document doc = Jsoup.connect(link).get();
                Elements link2 = doc.select("h5.card-title a");
                for (int i = 0; i < link2.size(); i++) {
                    sonuc = link2.get(i).attr("href");
                    System.out.println("DERGI:" + sonuc);
                    SayiGetir(sonuc + "/archive");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public void SayiGetir(String sDergiLinki) {
        String sonuc = "";
        try {
            Document doc = Jsoup.connect(sDergiLinki).get();
            Elements link2 = doc.select("div.kt-widget-17__product-desc a");
            for (int i = 0; i < link2.size(); i++) {
                sonuc = link2.get(i).attr("href");
                System.out.println("SAYI:" + sonuc);
                MakaleGetir(sonuc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MakaleGetir(String sDergiLinki) {
        String sonuc = "";
        try {
            Document doc = Jsoup.connect("https:" + sDergiLinki).get();
            Elements link2 = doc.select("a.card-title.article-title");
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

        try {
            Document doc = Jsoup.connect(sMakaleLinki).get();

            Element link3 = doc.getElementById("meta_stats_total_article_view");
            String sGoruntulenme = link3.attr("content");
            System.out.println("GORUNTULENME: " + sGoruntulenme);

            Element link4 = doc.getElementById("meta_stats_total_article_download");
            String sIndırme = link4.attr("content");
            System.out.println("INDIRME: " + sIndırme);

            Element link5 = doc.getElementById("meta_stats_total_article_favorite");
            String sFavori = link5.attr("content");
            System.out.println("FAVORI: " + sFavori);

            Elements link2 = doc.select("a.doi-link");
            String sDoi = link2.attr("href");
            if (sDoi.length() > 16) {
                sDoi = sDoi.substring(16);
                System.out.println("DOI LINK: " + sDoi);
                sql.add_or_upgrade_data(sDoi, Integer.parseInt(sGoruntulenme), Integer.parseInt("0"), Integer.parseInt(sFavori), "dergipark", Integer.parseInt(sIndırme));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
