package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Aluno;
import model.Avaliacao;
import model.Disciplina;
import model.Notas;
import persistence.GenericDao;
import persistence.INotasDao;
import persistence.NotasDao;

@WebServlet("/notas")
public class NotasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NotasServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ra = request.getParameter("ra");
		String disciplina = request.getParameter("disciplina");
		String avaliacao = request.getParameter("avaliacao");
		String nota = request.getParameter("nota");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Notas n = new Notas();
		
		GenericDao gDao = new GenericDao();
		INotasDao nDao = new NotasDao(gDao);
		
		try {
			if(botao.equals("Inserir")) {
				n = valido(ra,disciplina, avaliacao, nota, botao);
				saida = nDao.inserirNotas(n);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("notas.jsp");
			request.setAttribute("n", n);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}
	
	private Notas valido(String ra, String disciplina, String avaliacao, String nota, String botao) throws IOException {
		Notas n = new Notas();
		Aluno al = new Aluno();
		Avaliacao av = new Avaliacao();
		Disciplina d = new Disciplina();

		if(botao.equals("Inserir")) {
			if(ra.equals("") || disciplina.equals("") || avaliacao.equals("") || nota.equals("")) {
				throw new IOException("Preencher todos os campos.");
			} else {
				al.setRa(Integer.parseInt(ra));
				n.setAluno(al);
				av.setTipo(avaliacao);
				n.setAvaliacao(av);
				d.setSigla(disciplina);
				n.setDisciplina(d);
				n.setNota(Double.parseDouble(nota));;
			}
		}
		return n;
	}	

}
