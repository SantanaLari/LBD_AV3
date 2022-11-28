package br.edu.fateczl.sistemaAcademico.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.sistemaAcademico.model.Disciplina;
import br.edu.fateczl.sistemaAcademico.model.Falta;
import br.edu.fateczl.sistemaAcademico.model.consultaFalta;
import br.edu.fateczl.sistemaAcademico.persistence.FaltasDao;

@Controller
public class PresencaController {

	@Autowired
	FaltasDao fDao;
	
	@RequestMapping(name = "presenca", value="/presenca", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("presenca");
	}
	
	@RequestMapping(name = "presenca", value="/presenca", method = RequestMethod.POST)
	public ModelAndView findAlunos(@RequestParam Map<String, String> params, ModelMap model) {
		String disciplina = params.get("disciplina");
		String botao = params.get("botao");
		String erro = "";
		String saida = "";

		Disciplina dp = new Disciplina();
		Falta f = new Falta();
		List<consultaFalta> listaFalta = new ArrayList<consultaFalta>();
		
		try {
			if(botao.equals("Buscar")) {
				listaFalta = fDao.consultaFalta(disciplina);
			}
		}catch(SQLException| ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("dp", dp);
			model.addAttribute("f", f);
			model.addAttribute("listaFalta", listaFalta);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("presenca");
	}
	
}
