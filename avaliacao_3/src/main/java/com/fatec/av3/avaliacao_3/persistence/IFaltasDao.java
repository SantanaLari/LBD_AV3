package com.fatec.av3.avaliacao_3.persistence;

import java.sql.SQLException;
import java.util.List;

import com.fatec.av3.avaliacao_3.model.Falta;
import com.fatec.av3.avaliacao_3.model.consultaFalta;

public interface IFaltasDao {

	public String inserirFaltas(Falta f) throws SQLException, ClassNotFoundException;
	public List<consultaFalta> consultaFalta(String f) throws SQLException, ClassNotFoundException;

}
