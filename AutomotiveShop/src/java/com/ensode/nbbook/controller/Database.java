package com.ensode.nbbook.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Database {

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultset = null;
    String DRIVER = null;
    String URL = null;
    String user = null;
    String password = null;

    public Database() {
        DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        URL = "jdbc:sqlserver://localhost:1433;DatabaseName=JSP";
        user = "jspUser";
        password = "12345678";
    }

    public ArrayList<Assortment> ExecuteQuert(String query) throws SQLException {
        ArrayList<Assortment> ListAssortment = new ArrayList<Assortment>();
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, user, password);
            statement = connection.prepareStatement(query);
            resultset = statement.executeQuery();
            while (resultset.next()) {
                Assortment test = new Assortment();
                test.setCategoryId(resultset.getInt("CategoryId"));
                test.setCategoryName(resultset.getString("CategoryName"));

                ListAssortment.add(test);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return ListAssortment;
    }

   
}
