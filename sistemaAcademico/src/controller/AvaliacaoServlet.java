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
import model.Nota;
import model.consultaNota;
import persistence.GenericDao;
import persistence.INotasDao;
import persistence.NotasDao;

@WebServlet("/avaliacao")
public class AvaliacaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AvaliacaoServlet() {
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
		
		Nota n = new Nota();
		Disciplina dp = new Disciplina();
		List<consultaNota> listaNota = new ArrayList<consultaNota>();
		
		GenericDao gDao = new GenericDao();
		consultaNota cn = new consultaNota();
		INotasDao nDao = new NotasDao(gDao);
		
		try {
			if(botao.equals("Buscar")) {
				listaNota = nDao.consultaNotas(disciplina);
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("avaliacao.jsp");
			request.setAttribute("dp", dp);
			request.setAttribute("listaNota", listaNota);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}
	
	private Nota valido(String disciplina, String botao) throws IOException{
		Nota n = new Nota();
		Disciplina dp = new Disciplina();
		
		
		if(botao.contentEquals("Buscar")) {
			if(disciplina.equals("")) {
				throw new IOException("Preencher o campo");
			}else {
				dp.setCodigo(disciplina);
				n.setDisciplina(dp);
			}
		}
		
		return n;
	}
	

}
