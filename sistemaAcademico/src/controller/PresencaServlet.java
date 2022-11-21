package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Disciplina;
import model.Falta;
import model.consultaFalta;
import persistence.FaltasDao;
import persistence.GenericDao;
import persistence.IFaltasDao;

@WebServlet("/presenca")
public class PresencaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PresencaServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String disciplina = request.getParameter("disciplina");
		String botao = request.getParameter("botao");
		String erro = "";
		String saida = "";
		
		Falta f = new Falta();
		Disciplina dp = new Disciplina();
		List<consultaFalta> listaFalta = new ArrayList<consultaFalta>();
		
		GenericDao gDao = new GenericDao();
		consultaFalta cf = new consultaFalta();
		IFaltasDao nDao = new FaltasDao(gDao);
		
		try {
			if(botao.equals("Buscar")) {
				listaFalta = nDao.consultaFalta(disciplina);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("presenca.jsp");
			request.setAttribute("dp", dp);
			request.setAttribute("listaFalta", listaFalta);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}

}
