package com.mycompany.staj1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import org.json.simple.JSONObject;

/**
 *
 * @author goktug
 */
public class VT_Islemler {

    public static void main(String[] args) {

    }

    String DATABASE_URL = "jdbc:mysql://app.sobiad.com:3306/etkimetric?useUnicode=true&useLegacyDatetimeCode=false&serverTimezone=Turkey";
    String USERNAME = "goktug";
    String PASSWORD = "goktug2020";

    public JSONObject getJSONviaDOI(String sDoiNumarasi) {
        JSONObject donus = new JSONObject();
        JSONObject trdizin = new JSONObject();
        JSONObject dergipark = new JSONObject();
        JSONObject asosindeks = new JSONObject();
        JSONObject sobiad = new JSONObject();
        JSONObject kesifaraci = new JSONObject();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM `tblmakaleverileri` WHERE son_guncelleme_tarihi >= DATE_ADD(now(),INTERVAL -1 MONTH)   AND doi_numarasi='" + sDoiNumarasi + "'");

            while (rs.next()) {

                switch (rs.getString("kaynak")) {
                    case "trdizin":
                        trdizin.put("goruntulenme_sayisi", rs.getInt("goruntulenme_sayisi"));
                        trdizin.put("atif_sayisi", rs.getInt("atif_sayisi"));
                        trdizin.put("eklenme_tarihi", rs.getTimestamp("eklenme_tarihi"));
                        trdizin.put("son_guncelleme_tarihi", rs.getTimestamp("son_guncelleme_tarihi"));
                        trdizin.put("kaynak", rs.getString("kaynak"));
                        trdizin.put("begenme", rs.getInt("begenme"));
                        trdizin.put("indirme", rs.getInt("indirme"));
                        break;
                    case "dergipark":
                        dergipark.put("goruntulenme_sayisi", rs.getInt("goruntulenme_sayisi"));
                        dergipark.put("atif_sayisi", rs.getInt("atif_sayisi"));
                        dergipark.put("eklenme_tarihi", rs.getTimestamp("eklenme_tarihi"));
                        dergipark.put("son_guncelleme_tarihi", rs.getTimestamp("son_guncelleme_tarihi"));
                        dergipark.put("kaynak", rs.getString("kaynak"));
                        dergipark.put("begenme", rs.getInt("begenme"));
                        dergipark.put("indirme", rs.getInt("indirme"));
                        break;
                    case "asosindeks":
                        asosindeks.put("goruntulenme_sayisi", rs.getInt("goruntulenme_sayisi"));
                        asosindeks.put("atif_sayisi", rs.getInt("atif_sayisi"));
                        asosindeks.put("eklenme_tarihi", rs.getTimestamp("eklenme_tarihi"));
                        asosindeks.put("son_guncelleme_tarihi", rs.getTimestamp("son_guncelleme_tarihi"));
                        asosindeks.put("kaynak", rs.getString("kaynak"));
                        asosindeks.put("begenme", rs.getInt("begenme"));
                        asosindeks.put("indirme", rs.getInt("indirme"));
                        break;
                    case "sobiad":
                        sobiad.put("goruntulenme_sayisi", rs.getInt("goruntulenme_sayisi"));
                        sobiad.put("atif_sayisi", rs.getInt("atif_sayisi"));
                        sobiad.put("eklenme_tarihi", rs.getTimestamp("eklenme_tarihi"));
                        sobiad.put("son_guncelleme_tarihi", rs.getTimestamp("son_guncelleme_tarihi"));
                        sobiad.put("kaynak", rs.getString("kaynak"));
                        sobiad.put("begenme", rs.getInt("begenme"));
                        sobiad.put("indirme", rs.getInt("indirme"));
                        break;
                    case "kesifaraci":
                        kesifaraci.put("goruntulenme_sayisi", rs.getInt("goruntulenme_sayisi"));
                        kesifaraci.put("atif_sayisi", rs.getInt("atif_sayisi"));
                        kesifaraci.put("eklenme_tarihi", rs.getTimestamp("eklenme_tarihi"));
                        kesifaraci.put("son_guncelleme_tarihi", rs.getTimestamp("son_guncelleme_tarihi"));
                        kesifaraci.put("kaynak", rs.getString("kaynak"));
                        kesifaraci.put("begenme", rs.getInt("begenme"));
                        kesifaraci.put("indirme", rs.getInt("indirme"));
                        break;

                }
            }

            donus.put("trdizin", trdizin);
            donus.put("dergipark", dergipark);
            donus.put("asosindeks", asosindeks);
            donus.put("sobiad", sobiad);
            donus.put("kesifaraci", kesifaraci);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) {
                    st.close();
                    st = null;
                }
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception e) {
            }
        }
        return donus;
    }

    public void add_or_upgrade_data(String sDoiNumarasi, int goruntulenme_sayisi, int atif_sayisi, int begenme, String sKaynak, int indirme) {
        Timestamp now = new Timestamp(System.currentTimeMillis());

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

//kayit var mı yok mu kontrolu yapılıyor
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
            st = conn.createStatement();

            String islenecek_sql = "INSERT INTO tblmakaleverileri(doi_numarasi,goruntulenme_sayisi,atif_sayisi,eklenme_tarihi,son_guncelleme_tarihi,kaynak,begenme,indirme) "
                    + "VALUES('" + sDoiNumarasi + "',"
                    + "" + goruntulenme_sayisi + ","
                    + "" + atif_sayisi + ","
                    + "'" + now + "',"
                    + "'" + now + "',"
                    + "'" + sKaynak + "',"
                    + "" + begenme + ","
                    + "" + indirme + ")";

            rs = st.executeQuery("SELECT * FROM tblmakaleverileri WHERE doi_numarasi='" + sDoiNumarasi + "' AND kaynak='" + sKaynak + "'");
            if (rs.next() == false) {
                st.executeUpdate(islenecek_sql);
            } else {
                System.out.println("Boyle bir kayit var, guncelleniyor----------------------------------");
                islenecek_sql = "UPDATE tblmakaleverileri SET"
                        + " son_guncelleme_tarihi='" + now + "',"
                        + "goruntulenme_sayisi=" + goruntulenme_sayisi + ","
                        + "atif_sayisi=" + atif_sayisi + ","
                        + "begenme=" + begenme + ","
                        + "indirme=" + indirme + "   "
                        + "WHERE doi_numarasi='" + sDoiNumarasi + "'";
                st.executeUpdate(islenecek_sql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) {
                    st.close();
                    st = null;
                }
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception e) {
            }
        }
    }

}
