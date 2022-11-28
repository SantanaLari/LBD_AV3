package br.edu.fateczl.sistemaAcademico.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.sistemaAcademico.model.Aluno;
import br.edu.fateczl.sistemaAcademico.model.Disciplina;
import br.edu.fateczl.sistemaAcademico.model.Falta;
import br.edu.fateczl.sistemaAcademico.persistence.FaltasDao;


@Controller
public class FaltasController {

	@Autowired
	FaltasDao fDao;
	
	@RequestMapping(name = "faltas", value="/faltas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("faltas");
	}

	@RequestMapping(name = "faltas", value="/faltas", method = RequestMethod.POST)
	public ModelAndView findAlunos(@RequestParam Map<String, String> params, ModelMap model) {
		String ra = params.get("ra");
		String disciplina = params.get("disciplina");
		String data = params.get("data");
		String presenca = params.get("presenca");
		String botao = params.get("botao");
		String erro = "";
		String saida = "";

		Falta f = new Falta(); 
		
		try {
			if(botao.equals("Inserir")) {
				if (f != null){
					f = validaCampos( params, botao, disciplina, ra, data, presenca);
					saida =  fDao.inserirFaltas(f);
					f = new Falta();
				}
			}
		}catch(SQLException| ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("f", f);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("avaliacao");
	}
	
	private Falta validaCampos(Map<String, String> params, String botao, String disciplina, String ra, String data, String presenca) {
		Aluno al = new Aluno();
		Disciplina dp = new Disciplina();
		Falta f = new Falta();
		
		if(botao.equals("Inserir")) {
			if(!params.get("disciplina").trim().isEmpty()){
				al.setRa(Integer.parseInt(params.get("ra").trim()));
				f.setAluno(al);
				dp.setCodigo(params.get("disciplina").trim());
				f.setDisciplina(dp);
				f.setData(data);
				f.setPresenca(Integer.parseInt(presenca));
			}
		}
		return f;
	}

}
