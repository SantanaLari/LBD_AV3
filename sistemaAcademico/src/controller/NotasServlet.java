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
import model.Nota;
import persistence.GenericDao;
import persistence.INotasDao;
import persistence.NotasDao;

@WebServlet("/notas")
public class NotasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NotasServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ra = request.getParameter("ra");
		String disciplina = request.getParameter("disciplina");
		String avaliacao = request.getParameter("avaliacao");
		String nota = request.getParameter("nota");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Nota n = new Nota();
		
		GenericDao gDao = new GenericDao();
		INotasDao nDao = new NotasDao(gDao);
		
		try {
			if(botao.equals("Inserir")) {
				n = valido(ra, disciplina, avaliacao, nota, botao);
				saida = nDao.inserirNotas(n);
				n = new Nota();
			}
		}catch(SQLException | ClassNotFoundException | IOException e) {
				erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("notas.jsp");
			request.setAttribute("nota", n);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}
	
	private Nota valido(String ra, String disciplina, String avaliacao, String nota, String botao) throws IOException{
		Aluno al = new Aluno();
		Disciplina dp = new Disciplina();
		Avaliacao av = new Avaliacao();
		Nota n = new Nota();
		
		if(botao.equals("Inserir")) {
			if(ra.equals("0") || disciplina.equals("") || avaliacao.equals("") || nota.equals("")) {
				throw new IOException("Preencher os campos");
			}else {
				al.setRa(Integer.parseInt(ra));
				n.setAluno(al);
				
				dp.setCodigo(disciplina);
				n.setDisciplina(dp);
				
				av.setCodigo(Integer.parseInt(avaliacao));
				n.setAvaliacao(av);
				
				n.setNota(Double.parseDouble(nota));
				
			}
		}
		
		return n;
	}

}
