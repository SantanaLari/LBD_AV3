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
import model.Notas;
import persistence.GenericDao;
import persistence.INotasDao;
import persistence.NotasDao;

@WebServlet("/avaliacao")
public class AvaliacaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AvaliacaoServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String disciplina = request.getParameter("disciplina");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Notas n = new Notas();
		
		GenericDao gDao = new GenericDao();
		INotasDao nDao = new NotasDao(gDao);
		
		try {
			if(botao.equals("Inserir")) {
				n = valido(disciplina, botao);
				saida = nDao.gerarMedia(n);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("avaliacao.jsp");
			request.setAttribute("n", n);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	
	}

	private Notas valido(String disciplina, String botao) throws IOException {
		Notas n = new Notas();
		Disciplina d = new Disciplina();

		if(botao.equals("Inserir")) {
			if(disciplina.equals("")) {
				throw new IOException("Preencher todos os campos.");
			} else {
				d.setSigla(disciplina);
				n.setDisciplina(d);
			}
		}
		return n;
	}	
	
}
