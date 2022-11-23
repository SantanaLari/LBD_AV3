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
import model.Falta;
import persistence.FaltasDao;
import persistence.GenericDao;
import persistence.IFaltasDao;

@WebServlet("/faltas")
public class FaltasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FaltasServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ra = request.getParameter("ra");
		String disciplina = request.getParameter("disciplina");
		String data = request.getParameter("data");
		String presenca = request.getParameter("presenca");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Falta f = new Falta();
		
		GenericDao gDao = new GenericDao();
		IFaltasDao fDao = new FaltasDao(gDao);
		
		try {
			if(botao.equals("Inserir")) {
				f = valido(ra, disciplina, data, presenca, botao);
				saida = fDao.inserirFaltas(f);
				f = new Falta();
			}
		}catch(SQLException | ClassNotFoundException | IOException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("faltas.jsp");
			request.setAttribute("f", f);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}

	private Falta valido(String ra, String disciplina, String data, String presenca, String botao) throws IOException{
		Aluno al = new Aluno();
		Disciplina dp = new Disciplina();
		Falta f = new Falta();
		
		if(botao.equals("Inserir")) {
			if(ra.equals("") || disciplina.equals("") || data.equals("") || presenca.equals("")) {
				throw new IOException("Preencher os campos");
			}else {
				al.setRa(Integer.parseInt(ra));
				f.setAluno(al);
				
				dp.setCodigo(disciplina);
				f.setDisciplina(dp);
				
				f.setData(data);
				f.setPresenca(Integer.parseInt(presenca));
			}
		}
		
		return f;
	}
}
