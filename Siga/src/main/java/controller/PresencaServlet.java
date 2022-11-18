package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Disciplina;
import model.Faltas;
import persistence.FaltasDao;
import persistence.GenericDao;
import persistence.IFaltasDao;

@WebServlet("/presenca")
public class PresencaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PresencaServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String disciplina = request.getParameter("disciplina");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Faltas f = new Faltas();
		
		GenericDao gDao = new GenericDao();
		IFaltasDao fDao = new FaltasDao(gDao);
		
		try {
			if(botao.equals("Gerar")) {
				f = valido(disciplina, botao);
				saida = fDao.gerarPresenca(f);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("presenca.jsp");
			request.setAttribute("f", f);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	
	}
	
	private Faltas valido(String disciplina, String botao) throws IOException {
		Faltas f = new Faltas();
		Disciplina d = new Disciplina();

		if(botao.equals("Gerar")) {
			if(disciplina.equals("") ) {
				throw new IOException("Preencher a silga da Disciplina.");
			} else {
				d.setSigla(disciplina);
				f.setDisciplina(d);
			}
		}
		return f;
	}	

}
