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
import com.fatec.av3.avaliacao_3.model.Nota;
import com.fatec.av3.avaliacao_3.model.consultaNota;

@Repository
public class NotasDao implements INotasDao {

	@Autowired
	GenericDao gDao;
	
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

	@Override
	public List<consultaNota> consultaNotas(String n) throws SQLException, ClassNotFoundException {
		List<consultaNota> notas = new ArrayList<consultaNota>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from fn_notas2((?))");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, n);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			consultaNota cn = new consultaNota();
			cn.setNota1(rs.getDouble("nota1"));
			cn.setNota2(rs.getDouble("nota2"));
			cn.setNota3(rs.getDouble("nota3"));
			cn.setNota4(rs.getDouble("nota4"));
			cn.setExame(rs.getDouble("exame"));
			cn.setMedia_final(rs.getDouble("media_final"));
			cn.setSituacao(rs.getString("situacao"));
			
			Aluno al = new Aluno();
			al.setRa(rs.getInt("ra_aluno"));
			al.setNome(rs.getString("nome_aluno"));
			cn.setRa_aluno(al);
			cn.setNome_aluno(al);
			
			notas.add(cn);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return notas;
	}

}
