package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Nota;

public class NotasDao implements INotasDao {

	private GenericDao gDao;
	
	public NotasDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String inserirNotas(Nota n) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC pc_insereNota @ra = ?, @disciplina = ?, @avaliacao = ?, @nota = ? ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, n.getAluno().getRa());
		ps.setString(2, n.getDisciplina().getCodigo());
		ps.setInt(3, n.getAvaliacao().getCodigo());
		ps.setDouble(4, n.getNota());
		ps.execute();
		ps.close();
		c.close();
		
		return "Notas inseridas com sucesso";
	}

}
