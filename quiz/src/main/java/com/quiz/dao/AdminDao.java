package com.quiz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.quiz.model.Admin;
import com.quiz.util.DBConnection;

public class AdminDao{
    public Admin validateAdmin(String username, String password) {
        Admin admin = null;
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (password.equals(dbPass)) { // simple equals() check
                    admin = new Admin(rs.getInt("id"), username, dbPass);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
