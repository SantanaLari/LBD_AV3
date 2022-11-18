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
import model.Disciplina;
import model.Faltas;
import persistence.FaltasDao;
import persistence.GenericDao;
import persistence.IFaltasDao;

@WebServlet("/faltas")
public class FaltasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FaltasServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ra = request.getParameter("ra");
		String disciplina = request.getParameter("disciplina");
		String data = request.getParameter("data");
		String presenca = request.getParameter("presenca");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Faltas f = new Faltas();
		
		GenericDao gDao = new GenericDao();
		IFaltasDao fDao = new FaltasDao(gDao);
		
		try {
			if(botao.equals("Inserir")) {
				f = valido(ra,disciplina, data, presenca, botao);
				saida = fDao.inserirFaltas(f);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("faltas.jsp");
			request.setAttribute("f", f);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}
	
	private Faltas valido(String ra, String disciplina, String data, String presenca, String botao) throws IOException {
		Faltas f = new Faltas();
		Aluno al = new Aluno();
		Disciplina d = new Disciplina();

		if(botao.equals("Inserir")) {
			if(ra.equals("") || disciplina.equals("") || data.equals("") || presenca.equals("")) {
				throw new IOException("Preencher todos os campos.");
			} else {
				al.setRa(Integer.parseInt(ra));
				d.setSigla(disciplina);
				f.setDisciplina(d);
				f.setAluno(al);
				f.setData(data);
				f.setPresenca(Integer.parseInt(presenca));;
			}
		}
		return f;
	}	

}
