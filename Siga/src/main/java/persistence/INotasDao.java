package persistence;

import java.sql.SQLException;

import model.Notas;

public interface INotasDao {

	public String inserirNotas(Notas n) throws SQLException, ClassNotFoundException;
	public String gerarMedia(Notas n) throws SQLException, ClassNotFoundException;
	
}
