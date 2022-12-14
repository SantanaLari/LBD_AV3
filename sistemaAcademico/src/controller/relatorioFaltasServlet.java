package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;
import persistence.GenericDao;

@WebServlet("/relatorioFaltas")
public class relatorioFaltasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public relatorioFaltasServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			geraRelatorio(request, response);
		} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void geraRelatorio(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
		String erro = "";
		String disciplina = request.getParameter("disciplina");
		String Jasper = "WEB-INF/report/faltas.jasper";
	
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("disciplina", disciplina);
		
		byte[] bytes = null;
		ServletContext contexto = getServletContext();
		
		try {
			JasperReport relatorio = (JasperReport) JRLoader.loadObjectFromFile(contexto.getRealPath(Jasper));
			bytes = JasperRunManager.runReportToPdf(relatorio, param, new GenericDao().getConnection());
		}catch(JRException e) {
			erro = e.getMessage();
		}finally {
			if(bytes != null) {
				response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream sos = response.getOutputStream();
				sos.write(bytes);
				sos.flush();
				sos.close();
			}else {
				RequestDispatcher rd = request.getRequestDispatcher("relatorioFaltas.jsp");
				request.setAttribute("erro", erro);
				rd.forward(request, response);
			}
		}
	}

}
