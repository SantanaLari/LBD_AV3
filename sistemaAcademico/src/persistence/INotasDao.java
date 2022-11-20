package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Nota;
import model.consultaNota;

public interface INotasDao {
	
	public String inserirNotas(Nota n) throws SQLException, ClassNotFoundException;
	public List<consultaNota> consultaNotas(String n) throws SQLException, ClassNotFoundException;
}
