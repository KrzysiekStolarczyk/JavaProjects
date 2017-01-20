/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ensode.nbbook.controller;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Kuczma
 */
public class Client {

    private String ClientName;
    private String ClientSurname;

    public String getClientName() {
        return ClientName;
    }

    public void setClientName(String ClientName) {
        this.ClientName = ClientName;
    }

    public String getClientSurname() {
        return ClientSurname;
    }

    public void setClientSurname(String ClientSurname) {
        this.ClientSurname = ClientSurname;
    }

    public int CheckPasswordClient(String login, String halo) {
        int ret = 0;
        Database database = new Database();
        try {
            ret = database.ExecuteQuertScalar("select COUNT(*) as result from  dbo.Client where [login]=\'" + login + "\' and Haslo=\'" + halo + "\'");

        } catch (SQLException e) {
            System.out.println(e.toString());
            e.printStackTrace();
        }
        return ret;
    }
}
