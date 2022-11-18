package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Notas;

public class NotasDao implements INotasDao {

	private GenericDao gDao;

	public NotasDao (GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String inserirNotas(Notas n) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC pc_insereNota (?,?,?,?) ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, n.getAluno().getRa());
		ps.setString(2, n.getDisciplina().getSigla());
		ps.setString(3, n.getAvaliacao().getTipo());
		ps.setDouble(4, n.getNota());
		ps.execute();
		ps.close();
		c.close();
		return "Notas inseridas.";
	}

	@Override
	public String gerarMedia(Notas n) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "dbo.fn_notas2 (?) ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, n.getDisciplina().getSigla());
		ps.execute();
		ps.close();
		c.close();
		
		return "Médias calculadas com sucesso.";
	}

}
