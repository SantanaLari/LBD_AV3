package persistence;

import java.sql.SQLException;

import model.Faltas;

public interface IFaltasDao {

	public String inserirFaltas(Faltas f) throws SQLException, ClassNotFoundException;
	public String gerarPresenca(Faltas f) throws SQLException, ClassNotFoundException;
	
}
