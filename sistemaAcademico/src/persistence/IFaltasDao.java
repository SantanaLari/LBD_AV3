package persistence;

import java.sql.SQLException;

import model.Falta;

public interface IFaltasDao {
	
	public String inserirFaltas(Falta f) throws SQLException, ClassNotFoundException;
	
}
