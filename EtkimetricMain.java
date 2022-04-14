package com.mycompany.staj1;

import java.sql.Timestamp;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

/**
 * dünyanın en iyi yazılımcısı = goktug;
 */
public class EtkimetricMain {

    public static void main(String[] args) {
        EtkimetricMain em = new EtkimetricMain();
        em.get_and_check_json("10.52835/19maysbd.969967");
    }

    VT_Islemler sq = new VT_Islemler();

    public void get_and_check_json(String sDoi) {
        JSONObject jsnObject = new JSONObject();

        try {
            jsnObject = sq.getJSONviaDOI(sDoi);
            System.out.println(jsnObject);
            int kontrol = 0;
            Timestamp now = new Timestamp(System.currentTimeMillis());

            if (((JSONObject) jsnObject.get("sobiad")).get("son_guncelleme_tarihi") != null) {
                System.out.println("sobiad guncel");
            } else {
                System.out.println("sobiad guncel degil");
                kontrol = 1;
                //atif_sobiad_parcala(sDoi);
            }

            if (((JSONObject) jsnObject.get("trdizin")).get("son_guncelleme_tarihi") != null) {
                System.out.println("trdizin guncel");
            } else {
                System.out.println("trdizin guncel degil");
                kontrol = 1;
            }

            if ((((JSONObject) jsnObject.get("dergipark")).get("son_guncelleme_tarihi")) != null) {
                System.out.println("dergipark guncel");
            } else {
                System.out.println("dergipark guncel degil");
                kontrol = 1;
            }

            if (((JSONObject) jsnObject.get("bookcities")).get("son_guncelleme_tarihi") != null) {
                System.out.println("bookcities guncel");
            } else {
                System.out.println("bookcities guncel degil");
                kontrol = 1;
                //bookcities_parcala(sDoi);
            }

            if (((JSONObject) jsnObject.get("asosindeks")).get("son_guncelleme_tarihi") != null) {
                System.out.println("asosindeks guncel");
            } else {
                System.out.println("asosindeks guncel degil");
                kontrol = 1;
                //asos_indeks_parcala(sDoi);
            }

            if (kontrol == 1) {
                jsnObject = sq.getJSONviaDOI(sDoi);
                System.out.println(jsnObject);
            }

        } catch (Exception e) {
        }

    }

    public void kesif_araci_parcala(String sDoi) {
        VT_Islemler vti = new VT_Islemler();
        String link1 = "https://kesifaraci.com/modul/services/responser.jsp?param=citiation-count(doi)&doi=" + sDoi;
        try {
            Document doc = Jsoup.connect(link1).get();
            System.out.println("doc = " + doc.text());
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(doc.text());
            JSONObject jsonObject = (org.json.simple.JSONObject) obj;
            String view = "0";
            String count = "0";
            String link = "0";
            String status = "0";
            String timestamp = "0";
            if (jsonObject.get("goruntuleme") != null) {
                view = jsonObject.get("goruntuleme").toString();
            }
            if (jsonObject.get("count") != null) {
                count = jsonObject.get("count").toString();
            }
            if (jsonObject.get("link") != null) {
                link = jsonObject.get("link").toString();
            }
            if (jsonObject.get("status") != null) {
                status = jsonObject.get("status").toString();
            }
            if (jsonObject.get("timestamp") != null) {
                timestamp = jsonObject.get("timestamp").toString();
            }
            System.out.println("view:" + view + "\ncount:" + count + "\nlink:" + link + "\nstatus:" + status + "\ntimestamp:" + timestamp);
            sq.add_or_upgrade_data(sDoi, Integer.parseInt(view), Integer.parseInt(count), 0, "kesifaraci", Integer.parseInt(view));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void asos_indeks_parcala(String sDoi) {
        String link1 = "https://asosindex.com.tr/modul/dergiplatformuindirme.jsp?p=dergiplatformuindirme&doi="+sDoi;

        try {
            Document doc = Jsoup.connect(link1).get();
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(doc.text());
            JSONObject jsonObject = (org.json.simple.JSONObject) obj;
            String view = jsonObject.get("view").toString();
            String download = jsonObject.get("download").toString();
            String count = jsonObject.get("count").toString();
            String link = jsonObject.get("link").toString();
            String status = jsonObject.get("status").toString();
            String timestamp = jsonObject.get("timestamp").toString();
            System.out.println("view:" + view + "\ndownload:" + download + "\ncount:" + count + "\nlink:" + link + "\nstatus:" + status + "\ntimestamp:" + timestamp);
            sq.add_or_upgrade_data(sDoi, Integer.parseInt(view), Integer.parseInt(count), 0, "asosindeks", Integer.parseInt(download));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void atif_sobiad_parcala(String sDoi) {
        String link2 = "https://atif.sobiad.com/service/index.jsp?p=atif_doi&domain=asosjournal.com&lang=t%C3%BCrk%C3%A7e&token=ywhoU3OF5TcsaOK0jT24&doi=" + sDoi;
        String sonuc = "";
        try {
            Document doc = Jsoup.connect(link2).get();
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(doc.text());
            JSONObject jsonObject = (org.json.simple.JSONObject) obj;
            String view = jsonObject.get("goruntuleme").toString();
            String count = jsonObject.get("count").toString();
            String link = jsonObject.get("link").toString();
            String status = jsonObject.get("status").toString();
            String timestamp = jsonObject.get("timestampt").toString();
            System.out.println("goruntuleme:" + view + "\ncount:" + count + "\nlink:" + link + "\nstatus:" + status + "\ntimestamp:" + timestamp);
            sq.add_or_upgrade_data(sDoi, Integer.parseInt(view), Integer.parseInt(count), 0, "sobiad", Integer.parseInt(view));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

//    public void bookcities_parcala(String sDoi) {
//        String link1 = "https://bookcites.com/test/modul/connectTotal.jsp?p=dergiplatformatifgoruntuleme&title=B%C4%B0R%20%C4%B0NCELEME:%20TAR%C4%B0HSEL%20S%C3%9CRE%C3%87%20%C4%B0%C3%87ER%C4%B0S%C4%B0NDE%20T%C3%9CRK%20SPOR%20%C3%96RG%C3%9CTLENMES%C4%B0&author=Hikmet%20TURKAY&year=2017";
//
//        try {
//            Document doc = Jsoup.connect(link1).get();
//            JSONParser parser = new JSONParser();
//            Object obj = parser.parse(doc.text());
//            JSONObject jsonObject = (org.json.simple.JSONObject) obj;
//            String view = jsonObject.get("goruntuleme").toString();
//            String count = jsonObject.get("count").toString();
//            String link = jsonObject.get("link").toString();
//            String status = jsonObject.get("status").toString();
//            String timestamp = jsonObject.get("timestamp").toString();
//            System.out.println("view:" + view + "\ncount:" + count + "\nlink:" + link + "\nstatus:" + status + "\ntimestamp:" + timestamp);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
}
