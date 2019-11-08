/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import funkcionalnosti.Funkcionalnosti;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author stefan
 */
public class op140096 extends Funkcionalnosti {

    @Override
    public int unesiGradiliste(String naziv, Date datumOsnivanja) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Gradiliste (Naziv, DatumOsnivanja) values('" + naziv + "', '" + datumOsnivanja + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiGradiliste(int idGradiliste) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Gradiliste where IdGradiliste = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idGradiliste);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
        
    }

    @Override
    public List<Integer> dohvatiSvaGradilista() {
        try {
            ArrayList<Integer> gradilista = new ArrayList<Integer>();
            ResultSet rs = null;
            Statement st = DB.connection.createStatement();
            String upit = "select IdGradiliste from Gradiliste";
            rs = st.executeQuery(upit);

            while (rs.next()) {
                int id = rs.getInt("IdGradiliste");
                gradilista.add(id);
            }
            if (gradilista.isEmpty()) {
                return null;
            } else {
                return gradilista;
            }

        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    @Override
    public int unesiObjekat(String naziv, int idGradiliste) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Objekat (Naziv, IdGradiliste) values('" + naziv + "', '" + idGradiliste + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiObjekat(int idObjekat) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Objekat where IdObjekat = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idObjekat);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiSprat(int brSprata, int idObjekat) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Sprat (Broj, IdObjekat) values('" + brSprata + "', '" + idObjekat + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiSprat(int idSprat) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Sprat where IdSprat = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idSprat);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiZaposlenog(String ime, String prezime, String jmbg, String pol, String ziroRacun, String email, String brojTelefona) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Zaposleni (Ime, Prezime, JMBG, Pol, ZiroRacun, Email, BrojTelefona) "
                + "values("
                + "'" + ime + "',"
                + " '" + prezime + "',"
                + " '" + jmbg + "',"
                + " '" + pol + "',"
                + " '" + ziroRacun + "',"
                + " '" + email + "',"
                + " '" + brojTelefona + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;

    }

    @Override
    public int obrisiZaposlenog(int idZaposleni) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Zaposleni where IdZaposleni = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idZaposleni);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public BigDecimal dohvatiUkupanIsplacenIznosZaZaposlenog(int idZaposleni) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select UkupnoIsplaceno from Zaposleni where IdZaposleni = " + idZaposleni;
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               BigDecimal isplaceno = rs.getBigDecimal("UkupnoIsplaceno");
               return isplaceno;
            }
                    
            return new BigDecimal(-1);
        } catch (SQLException ex) {
            return new BigDecimal(-1);
        }
    }

    @Override
    public BigDecimal dohvatiProsecnuOcenuZaZaposlenog(int idZaposleni) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select ProsecnaOcena from Zaposleni where IdZaposleni = " + idZaposleni;
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               BigDecimal ocena = rs.getBigDecimal("ProsecnaOcena");
               return ocena;
            }
                    
            return new BigDecimal(-1);
        } catch (SQLException ex) {
            return new BigDecimal(-1);
        }
    }

    @Override
    public int dohvatiBrojTrenutnoZaduzeneOpremeZaZaposlenog(int idZaposleni) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select BrojZaduzeneOpreme from Zaposleni where IdZaposleni = " + idZaposleni;
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               int oprema = rs.getInt("BrojZaduzeneOpreme");
               return oprema;
            }
                    
            return -1;
        } catch (SQLException ex) {
            return -1;
        }

    }

    @Override
    public List<Integer> dohvatiSveZaposlene() {
        try {
            ArrayList<Integer> zaposleni = new ArrayList<Integer>();
            ResultSet rs = null;
            Statement st = DB.connection.createStatement();
            String upit = "select IdZaposleni from Zaposleni";
            rs = st.executeQuery(upit);

            while (rs.next()) {
                int id = rs.getInt("IdZaposleni");
                zaposleni.add(id);
            }
            if (zaposleni.isEmpty()) {
                return null;
            } else {
                return zaposleni;
            }

        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    @Override
    public int unesiMagacin(int idSef, BigDecimal plata, int idGradiliste) {
        Statement st = null;
        ResultSet rs = null;

        String upit1 = "insert into Magacin (Plata, IdGradiliste) "
                + "values("
                + "'" + plata + "',"
                + " '" + idGradiliste + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit1, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            int idMag;
            if (rs.next()) {
                idMag = rs.getInt(1);
                String upit2 = "insert into JeSef (IdMagacin, IdZaposleni) values(" + idMag + ", " + idSef + ")";
                st = DB.connection.createStatement();
                st.executeUpdate(upit2, Statement.RETURN_GENERATED_KEYS);
                rs = st.getGeneratedKeys();
                if (rs.next()) {
                    return idMag;
                } else {
                    String upit3 = "delete from Magacin where IdMagacin=" + idMag;
                    st.executeUpdate(upit3);
                    return -1;
                }
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiMagacin(int idMagacin) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Magacin where IdMagacin = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idMagacin);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int izmeniSefaZaMagacin(int idMagacin, int idSefNovo) {
        try {
            CallableStatement cstmt = DB.connection.prepareCall("{call IzmeniSefa(?, ? , ?)}");          
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER); 
            cstmt.setInt(1, idMagacin);
            cstmt.setInt(2, idSefNovo);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.executeUpdate();
            int ret = cstmt.getInt(3);
            /*vraca 1 ako je pogresio, vraca 0 ako je uspeo*/
            return ret;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int izmeniPlatuZaMagacin(int idMagacin, BigDecimal plataNovo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update Magacin "
                + "set Plata = ? where IdMagacin = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setBigDecimal(1, plataNovo);
            pst.setInt(2, idMagacin);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int isplatiPlateZaposlenimaUSvimMagacinima() {
        try {
            CallableStatement cstmt = DB.connection.prepareCall("{call PlataSviMagacini(?)}");          
            cstmt.registerOutParameter(1, java.sql.Types.INTEGER); 
            cstmt.executeUpdate();
            int ret = cstmt.getInt(1);
            /*vraca 1 ako je pogresio, vraca 0 ako je uspeo*/
            return ret;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int isplatiPlateZaposlenimaUMagacinu(int idMagacin) {
        try {
            CallableStatement cstmt = DB.connection.prepareCall("{call PlataMagacin(?, ?)}");
            cstmt.setInt(1, idMagacin); 
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER); 
            cstmt.executeUpdate();
            int ret = cstmt.getInt(2);
            /*vraca 1 ako je pogresio, vraca 0 ako je uspeo*/
            return ret;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiRobuUMagacinPoKolicini(int idRoba, int idMagacin, BigDecimal kolicina) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Sadrzi (IdRoba, IdMagacin, Kolicina, Tip)"
                + "values("
                + "'" + idRoba + "',"
                + " '" + idMagacin + "',"
                + " '" + kolicina + "',"
                + " 'K')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int unesiRobuUMagacinPoBrojuJedinica(int idRoba, int idMagacin, int brojJedinica) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Sadrzi (IdRoba, IdMagacin, Kolicina, Tip)"
                + "values("
                + "'" + idRoba + "',"
                + " '" + idMagacin + "',"
                + " '" + brojJedinica + "',"
                + " 'J')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public BigDecimal uzmiRobuIzMagacinaPoKolicini(int idRoba, int idMagacin, BigDecimal kolicina) {
        BigDecimal trenutno = pogledajKolicinuRobeUMagacinu(idRoba, idMagacin);
        int ima_dovoljno = trenutno.compareTo(kolicina);
        if (ima_dovoljno<0) //ako nema dovoljno
        {
            try {
                String upit = "update Sadrzi set Kolicina = 0 where IdRoba = ? and IdMagacin = ?";
                PreparedStatement ps = DB.connection.prepareStatement(upit);
                ps.setInt(1, idRoba);
                ps.setInt(2, idMagacin);
                ps.executeUpdate();
                return trenutno;
                
            } catch (SQLException ex) {
                Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
                return new BigDecimal(-1);
            }
            
        }
        else {//ako ima dovoljno
            try {
                
                BigDecimal ostalo = trenutno.subtract(kolicina);
                String upit = "update Sadrzi set Kolicina = ? where IdRoba = ? and IdMagacin = ?";
                PreparedStatement ps = DB.connection.prepareStatement(upit);
                ps.setBigDecimal(1, ostalo);
                ps.setInt(2, idRoba);
                ps.setInt(3, idMagacin);
                ps.executeUpdate();
                return kolicina;
                
            } catch (SQLException ex) {
                Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
                return new BigDecimal(-1);
            }
        }
    }

    @Override
    public int uzmiRobuIzMagacinaPoBrojuJedinica(int idRoba, int idMagacin, int brojJedinca) {
        int trenutno = pogledajBrojJedinicaRobeUMagacinu(idRoba, idMagacin);
        int ima_dovoljno = trenutno-brojJedinca;
        if (ima_dovoljno<0) //ako nema dovoljno
        {
            try {
                String upit = "update Sadrzi set Kolicina = 0 where IdRoba = ? and IdMagacin = ?";
                PreparedStatement ps = DB.connection.prepareStatement(upit);
                ps.setInt(1, idRoba);
                ps.setInt(2, idMagacin);
                ps.executeUpdate();
                return trenutno;
                
            } catch (SQLException ex) {
                Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
                return -1;
            }
            
        }
        else {//ako ima dovoljno
            try {
                
                int ostalo = trenutno-brojJedinca;
                String upit = "update Sadrzi set Kolicina = ? where IdRoba = ? and IdMagacin = ?";
                PreparedStatement ps = DB.connection.prepareStatement(upit);
                ps.setInt(1, ostalo);
                ps.setInt(2, idRoba);
                ps.setInt(3, idMagacin);
                ps.executeUpdate();
                return brojJedinca;
                
            } catch (SQLException ex) {
                Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
                return -1;
            }
        }
    }

    @Override
    public BigDecimal pogledajKolicinuRobeUMagacinu(int idRoba, int idMagacin) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select Kolicina from Sadrzi where IdRoba = " + idRoba  + " and IdMagacin = "+idMagacin+" and Tip = 'K'";
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               BigDecimal kolicina = rs.getBigDecimal("Kolicina");               
               return kolicina;
            }
            //ako nije nasao, znaci da ima 0 jedinica
            return new BigDecimal(0);
                    
            //return new BigDecimal(-1.0);
        } catch (SQLException ex) {
            return new BigDecimal(-1.0);
        }
    }

    @Override
    public int pogledajBrojJedinicaRobeUMagacinu(int idRoba, int idMagacin) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select Kolicina from Sadrzi where IdRoba = " + idRoba  + " and IdMagacin = "+idMagacin+" and Tip = 'J'";
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               BigDecimal kolicina = rs.getBigDecimal("Kolicina");
               return kolicina.intValue();
            }
                    
            return 0;
        } catch (SQLException ex) {
            return -1;
        }
    }

    @Override
    public int unesiTipRobe(String naziv) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Tip (Naziv) values('" + naziv + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiTipRobe(int idTipRobe) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Tip where IdTip = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idTipRobe);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiRobu(String naziv, String kod, int idTipRobe) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Roba (Naziv, Kod, IdTip) values('" + naziv + "', '" + kod + "', '" + idTipRobe + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int obrisiRobu(int idRoba) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Roba where IdRoba = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idRoba);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public List<Integer> dohvatiSvuRobu() {
        try {
            ArrayList<Integer> roba = new ArrayList<Integer>();
            ResultSet rs = null;
            Statement st = DB.connection.createStatement();
            String upit = "select IdRoba from Roba";
            rs = st.executeQuery(upit);

            while (rs.next()) {
                int id = rs.getInt("IdRoba");
                roba.add(id);
            }
            if (roba.isEmpty()) {
                return null;
            } else {
                return roba;
            }

        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    @Override
    public int zaposleniRadiUMagacinu(int idZaposleni, int idMagacin) {

        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into JeZaposlen (IdZaposleni, IdMagacin) values('" + idZaposleni + "', '" + idMagacin + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }

    }

    @Override
    public int zaposleniNeRadiUMagacinu(int idZaposleni) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from JeZaposlen where IdZaposleni = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idZaposleni);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int zaposleniZaduzujeOpremu(int idZaposlenogKojiZaduzuje, int idMagacin, int idRoba, Date datumZaduzenja, String napomena) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Zaduzio (IdZaposleni, IdMagacin, IdRoba, DatumOd, Napomena) "
                + "values('" + idZaposlenogKojiZaduzuje + "', '" + idMagacin + "', '" + idRoba + "', '" + datumZaduzenja + "', '" + napomena + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int zaposleniRazduzujeOpremu(int idZaduzenjaOpreme, Date datumRazduzenja) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update Zaduzio "
                + "set DatumDo = ? where IdZaduzio = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumRazduzenja);
            pst.setInt(2, idZaduzenjaOpreme);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiNormuUgradnogDela(String naziv, BigDecimal cenaIzrade, BigDecimal jedinicnaPlataRadnika) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Norma (Naziv, Cena, JedinicnaPlata) values('" + naziv + "', '" + cenaIzrade + "', '" + jedinicnaPlataRadnika + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int obrisiNormuUgradnogDela(int idNormaUgradnogDela) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Norma where IdNorma = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idNormaUgradnogDela);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public BigDecimal dohvatiJedinicnuPlatuRadnikaNormeUgradnogDela(int idNR) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "select JedinicnaPlata from Norma where IdNorma = " + idNR;
        try {
            st = DB.connection.createStatement();
            rs = st.executeQuery(upit);
            if (rs.next())
            {
               BigDecimal plata = rs.getBigDecimal("JedinicnaPlata");
               return plata;
            }
                    
            return new BigDecimal(-1.0);
        } catch (SQLException ex) {
            return new BigDecimal(-1.0);
        }
    }

    @Override
    public int unesiPotrebanMaterijalPoBrojuJedinica(int idRobaKojaJePotrosniMaterijal, int idNormaUgradnogDela, int brojJedinica) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into PotrebanZa (IdRoba, IdNorma, Kolicina, Tip)"
                + "values("
                + "'" + idRobaKojaJePotrosniMaterijal + "',"
                + " '" + idNormaUgradnogDela + "',"
                + " '" + brojJedinica + "',"
                + " 'J')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int unesiPotrebanMaterijalPoKolicini(int idRobaKojaJePotrosniMaterijal, int idNormaUgradnogDela, BigDecimal kolicina) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into PotrebanZa (IdRoba, IdNorma, Kolicina, Tip)"
                + "values("
                + "'" + idRobaKojaJePotrosniMaterijal + "',"
                + " '" + idNormaUgradnogDela + "',"
                + " '" + kolicina + "',"
                + " 'K')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiPotrebanMaterijal(int idRobaKojaJePotrosniMaterijal, int idNormaUgradnogDela) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from PotrebanZa where IdRoba = ? and IdNorma = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idRobaKojaJePotrosniMaterijal);
            pst.setInt(2,idNormaUgradnogDela);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int unesiPosao(int idNormaUgradnogDela, int idSprat, Date datumPocetka) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into Posao (IdNorma, IdSprat, DatumOd)"
                + "values("
                + "'" + idNormaUgradnogDela + "',"
                + " '" + idSprat + "',"
                + " '" + datumPocetka + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int obrisiPosao(int idPosao) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "delete from Posao where IdPosao = ?";
        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1,idPosao);
            int numrows = pst.executeUpdate();
            if (numrows==1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int izmeniDatumPocetkaZaPosao(int idPosao, Date datumPocetka) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update Posao "
                + "set DatumOd = ? where IdPosao = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumPocetka);
            pst.setInt(2, idPosao);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int zavrsiPosao(int idPosao, Date datumKraja) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update Posao "
                + "set DatumDo = ? where IdPosao = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumKraja);
            pst.setInt(2, idPosao);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int zaposleniRadiNaPoslu(int idZaposleni, int idPosao, Date datumPocetka) {
        Statement st = null;
        ResultSet rs = null;
        String upit = "insert into RadiNa (IdZaposleni, IdPosao, DatumOd)"
                + "values("
                + "'" + idZaposleni + "',"
                + " '" + idPosao + "',"
                + " '" + datumPocetka + "')";
        try {
            st = DB.connection.createStatement();
            st.executeUpdate(upit, Statement.RETURN_GENERATED_KEYS);
            rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int zaposleniJeZavrsioSaRadomNaPoslu(int idZaposleniNaPoslu, Date datumKraja) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update RadiNa "
                + "set DatumDo = ? where IdRadiNa = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumKraja);
            pst.setInt(2, idZaposleniNaPoslu);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int izmeniDatumPocetkaRadaZaposlenogNaPoslu(int idZaposleniNaPoslu, Date datumPocetkaNovo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update RadiNa "
                + "set DatumOd = ? where IdRadiNa = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumPocetkaNovo);
            pst.setInt(2, idZaposleniNaPoslu);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int izmeniDatumKrajaRadaZaposlenogNaPoslu(int idZaposleniNaPoslu, Date datumKrajaNovo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update RadiNa "
                + "set DatumDo = ? where IdRadiNa = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setDate(1, datumKrajaNovo);
            pst.setInt(2, idZaposleniNaPoslu);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return 0;
            } else {
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    @Override
    public int zaposleniDobijaOcenu(int idZaposleniNaPoslu, int ocena) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update RadiNa "
                + "set Ocena = ? where IdRadiNa = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setInt(1, ocena);
            pst.setInt(2, idZaposleniNaPoslu);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return idZaposleniNaPoslu;
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }

    }

    @Override
    public int obrisiOcenuZaposlenom(int idZaposleniNaPoslu) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String upit = "update RadiNa "
                + "set Ocena = ? where IdRadiNa = ?";

        try {
            pst = DB.connection.prepareStatement(upit);
            pst.setObject(1, null);
            pst.setInt(2, idZaposleniNaPoslu);
            int row_count = pst.executeUpdate();
            if (row_count == 1) {
                return idZaposleniNaPoslu;
            } else {
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(op140096.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    @Override
    public int izmeniOcenuZaZaposlenogNaPoslu(int idZaposleniNaPoslu, int ocenaNovo) {
        int ret = zaposleniDobijaOcenu(idZaposleniNaPoslu, ocenaNovo);
        if (ret==-1) return -1;
        else return 0;
    }

}
