package com.fatec.av3.avaliacao_3.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fatec.av3.avaliacao_3.model.Aluno;
import com.fatec.av3.avaliacao_3.model.Falta;
import com.fatec.av3.avaliacao_3.model.consultaFalta;

@Repository
public class FaltasDao implements IFaltasDao {

	@Autowired
	GenericDao gDao;
	
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

	@Override
	public List<com.fatec.av3.avaliacao_3.model.consultaFalta> consultaFalta(String f)
			throws SQLException, ClassNotFoundException {
List<consultaFalta> faltas = new ArrayList<consultaFalta>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from fn_faltas((?))");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, f);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			consultaFalta cf = new consultaFalta();
			cf.setSemana1(rs.getString("semana1"));
			cf.setSemana2(rs.getString("semana2"));
			cf.setSemana3(rs.getString("semana3"));
			cf.setSemana4(rs.getString("semana4"));
			cf.setSemana5(rs.getString("semana5"));
			cf.setSemana6(rs.getString("semana6"));
			cf.setSemana7(rs.getString("semana7"));
			cf.setSemana8(rs.getString("semana8"));
			cf.setSemana9(rs.getString("semana9"));
			cf.setSemana10(rs.getString("semana10"));
			cf.setSemana11(rs.getString("semana11"));
			cf.setSemana12(rs.getString("semana12"));
			cf.setSemana13(rs.getString("semana13"));
			cf.setSemana14(rs.getString("semana14"));
			cf.setSemana15(rs.getString("semana15"));
			cf.setSemana16(rs.getString("semana16"));
			cf.setSemana17(rs.getString("semana17"));
			cf.setSemana18(rs.getString("semana18"));
			cf.setSemana19(rs.getString("semana19"));
			cf.setSemana20(rs.getString("semana20"));
			cf.setTotal_faltas(rs.getInt("total_faltas"));
			
			Aluno al = new Aluno();
			al.setRa(rs.getInt("ra_aluno"));
			al.setNome(rs.getString("nome_aluno"));
			cf.setRa_aluno(al);
			cf.setNome_aluno(al);
			
			faltas.add(cf);
		}
		
		return faltas;
	}

}
