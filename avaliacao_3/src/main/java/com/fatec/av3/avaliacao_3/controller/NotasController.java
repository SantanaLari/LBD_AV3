package com.fatec.av3.avaliacao_3.controller;

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
import br.edu.fateczl.sistemaAcademico.model.Avaliacao;
import br.edu.fateczl.sistemaAcademico.model.Disciplina;
import br.edu.fateczl.sistemaAcademico.model.Nota;
import br.edu.fateczl.sistemaAcademico.persistence.NotasDao;

@Controller
public class NotasController {
	
	@Autowired
	NotasDao nDao;
	
	@RequestMapping(name = "notas", value="/notas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("notas");
	}
	
	@RequestMapping(name = "notas", value="/notas", method = RequestMethod.POST)
	public ModelAndView findAlunos(@RequestParam Map<String, String> params, ModelMap model) {
		String botao = params.get("botao");
		String erro = "";
		String saida = "";
		Nota n = validaCampos(params, botao);
		
		try {
			if(botao.equals("Inserir")) {
				if (n != null){
					saida = nDao.inserirNotas(n);
					n = new Nota();
				}
			}
		}catch(SQLException| ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("nota", n);
		}
		return new ModelAndView("notas");
	}
	
	private Nota validaCampos(Map<String, String> params, String botao) {
		Aluno al = new Aluno();
		Disciplina dp = new Disciplina();
		Avaliacao av = new Avaliacao();
		Nota n = new Nota();
		
		if(botao.equals("Inserir")) {
			if(!params.get("ra").trim().isEmpty() || !params.get("disciplina").trim().isEmpty() ||
			!params.get("avaliacao").trim().isEmpty() || !params.get("nota").trim().isEmpty()){
				al.setRa(Integer.parseInt(params.get("ra").trim()));
				dp.setCodigo(params.get("disciplina").trim());
				av.setCodigo(Integer.parseInt(params.get("avalicao").trim()));
				n.setNota(Double.parseDouble(params.get("nota").trim()));
				n.setAluno(al);
				n.setAvaliacao(av);
				n.setDisciplina(dp);
			}
		}
		
		return n;
	}
	
	

	
}
