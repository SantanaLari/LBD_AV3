package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Falta;

public class FaltasDao implements IFaltasDao{

	private GenericDao gDao;
	
	public FaltasDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String inserirFaltas(Falta f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "exec pc_insereFalta @ra = ?, @disciplina = ?, @datas = ?, @presenca = ? ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, f.getAluno().getRa());
		ps.setString(2, f.getDisciplina().getCodigo());
		ps.setString(3, f.getData());
		ps.setInt(4, f.getPresenca());
		ps.execute();
		ps.close();
		c.close();
		
		return "Faltas inseridas com sucesso";
	}

}
