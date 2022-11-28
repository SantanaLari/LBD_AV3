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
import br.edu.fateczl.sistemaAcademico.model.Nota;
import br.edu.fateczl.sistemaAcademico.model.consultaNota;
import br.edu.fateczl.sistemaAcademico.persistence.NotasDao;

@Controller
public class AvaliacaoController {

	@Autowired
	NotasDao nDao;
	
	@RequestMapping(name = "avaliacao", value="/avaliacao", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("avaliacao");
	}
	
	@RequestMapping(name = "avaliacao", value="/avaliacao", method = RequestMethod.POST)
	public ModelAndView findAlunos(@RequestParam Map<String, String> params, ModelMap model) {
		String disciplina = params.get("disciplina");
		String botao = params.get("botao");
		String erro = "";
		String saida = "";
		Nota n = validaCampos(params, botao, disciplina);
		Disciplina dp = new Disciplina();
		List<consultaNota> listaNota = new ArrayList<consultaNota>();
		
		try {
			if(botao.equals("Buscar")) {
				if (n != null){
					listaNota = nDao.consultaNotas(disciplina);
					n = new Nota();
				}
			}
		}catch(SQLException| ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("dp", dp);
			model.addAttribute("listaNota", listaNota);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("avaliacao");
	}
	
	private Nota validaCampos(Map<String, String> params, String botao, String disciplina) {
		Disciplina dp = new Disciplina();
		Nota n = new Nota();
		
		if(botao.equals("Inserir")) {
			if(!params.get("disciplina").trim().isEmpty()){
				dp.setCodigo(params.get("disciplina").trim());
				n.setDisciplina(dp);
			}
		}
		return n;
	}
	
	
}
