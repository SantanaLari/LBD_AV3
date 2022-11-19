package persistence;

import java.sql.SQLException;

import model.Nota;

public interface INotasDao {
	
	public String inserirNotas(Nota n) throws SQLException, ClassNotFoundException;

}
