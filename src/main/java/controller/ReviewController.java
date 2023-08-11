package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.ReviewDAO;
import model.ReviewVO;


@WebServlet(value= {"/review/insert", "/review/list.json"})
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewDAO dao = new ReviewDAO();
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/review/list.json":
			String gid= request.getParameter("gid");
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(gid)));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch(request.getServletPath()) {
		case "/review/insert":
			ReviewVO vo = new ReviewVO();
			vo.setGid(request.getParameter("gid"));
			vo.setUid(request.getParameter("uid"));
			vo.setContent(request.getParameter("content"));
			System.out.println(vo.toString());
			dao.insert(vo);
			break;
		}
	}

}
