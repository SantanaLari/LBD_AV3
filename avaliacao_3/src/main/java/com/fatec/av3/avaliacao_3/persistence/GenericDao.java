package com.fatec.av3.avaliacao_3.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class GenericDao {
	
private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		c = 
	    DriverManager.getConnection("jdbc:jtds:sqlserver://localhost:1433/sistemaAcademico;instance=sqlexpress;user=Larissa;password=1234567");

		return c;
	}
}
