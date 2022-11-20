package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Falta;
import model.consultaFalta;

public interface IFaltasDao {
	
	public String inserirFaltas(Falta f) throws SQLException, ClassNotFoundException;
	public List<consultaFalta> consultaFalta(String f) throws SQLException, ClassNotFoundException;
}
