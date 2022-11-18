package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Faltas;

public class FaltasDao implements IFaltasDao {

	private GenericDao gDao;
	
	public FaltasDao (GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String inserirFaltas(Faltas f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC pc_insereFalta(?,?,?,?) ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, f.getAluno().getRa());
		ps.setString(2,f.getDisciplina().getSigla());
		ps.setString(3,f.getData());
		ps.setInt(4,f.getPresenca());
		ps.execute();
		ps.close();
		c.close();
		
		return "Faltas inseridas.";
	}

	@Override
	public String gerarPresenca(Faltas f) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "dbo.fn_faltas(?) ";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1,f.getDisciplina().getSigla());
		ps.execute();
		ps.close();
		c.close();
		
		return "Porcenta de presença gerados.";
	}

}
