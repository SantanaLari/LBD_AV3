package com.fatec.av3.avaliacao_3.persistence;

import java.sql.SQLException;
import java.util.List;

import com.fatec.av3.avaliacao_3.model.Nota;
import com.fatec.av3.avaliacao_3.model.consultaNota;

public interface INotasDao {
	
	public String inserirNotas(Nota n) throws SQLException, ClassNotFoundException;
	public List<consultaNota> consultaNotas(String n) throws SQLException, ClassNotFoundException;
}
