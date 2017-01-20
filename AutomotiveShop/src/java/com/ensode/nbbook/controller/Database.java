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

    public ArrayList<StoresAssortment> ExecuteQuert(String query) throws SQLException {
        ArrayList<StoresAssortment> ListAssortment = new ArrayList<StoresAssortment>();
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, user, password);
            statement = connection.prepareStatement(query);
            resultset = statement.executeQuery();
            while (resultset.next()) {
                StoresAssortment assort = new StoresAssortment();
                assort.setId(resultset.getInt("Id"));
                assort.setProductName(resultset.getString("ProductName"));
                assort.setImagePath(resultset.getString("ImagePath"));
                assort.setPrice(resultset.getFloat("Price"));
                assort.setStock(resultset.getInt("Stock"));

                ListAssortment.add(assort);
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

    public int ExecuteQuertScalar(String query) throws SQLException {
        int result = 0;
        try {

            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, user, password);
            statement = connection.prepareStatement(query);
            resultset = statement.executeQuery();
            while (resultset.next()) {
                result = resultset.getInt("Result");
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
        return result;
    }

}
