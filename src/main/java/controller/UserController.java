package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.UserDAO;
import model.UserVO;


@WebServlet(value= {"/user/login", "/user/logout", "/user/read", "/user/insert", "/user/update", 
		"/user/list.json", "/user/list"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO udao = new UserDAO();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis= request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		
		switch(request.getServletPath()) {
		case "/user/logout":
			session.removeAttribute("user");
			response.sendRedirect("/");
			break;
		case "/user/read":
			UserVO vo = (UserVO)session.getAttribute("user");
			request.setAttribute("vo", udao.read(vo.getUid()));
			request.setAttribute("pageName", "/user/read.jsp");
			dis.forward(request, response);
			break;
		case "/user/insert":
			request.setAttribute("pageName", "/user/insert.jsp");
			dis.forward(request, response);
			break;
		case "/user/list.json":
			String key = request.getParameter("key");
			String query = request.getParameter("query");
			int page = Integer.parseInt(request.getParameter("page"));
			ArrayList<UserVO> array = udao.list(key, query, page);
			Gson gson = new Gson();
			out.print(gson.toJson(array));
			break;
		case "/user/list":
			request.setAttribute("pageName", "/user/list.jsp");
			dis.forward(request, response);
			break;
		case "/user/login":
			String target = request.getParameter("target")==null ? ""
					: request.getParameter("target");
			session.setAttribute("target", target);
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String path = "/upload/photo/";
		File mdPath=new File("c:" + path);
		if(!mdPath.exists()) mdPath.mkdir();
		
		switch(request.getServletPath()) {
		case "/user/login":
			String uid = request.getParameter("uid");
			String upass = request.getParameter("upass");
			UserVO user= udao.read(uid);
			int result=0;
			if(user.getUid()!=null) {
				if(user.getUpass().equals(upass)) {
					result=1;
					session.setAttribute("user", user);
				}else {
					result=2;
				}
			}
			
			out.print(result);
			break;
		case "/user/insert":
			MultipartRequest multi = new MultipartRequest(request, "c:"+path, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
			String photo = multi.getFilesystemName("photo")== null ? "" : path + multi.getFilesystemName("photo");
			UserVO vo = new UserVO();
			vo.setUid(multi.getParameter("uid"));
			vo.setUpass(multi.getParameter("upass"));
			vo.setUname(multi.getParameter("uname"));
			vo.setAddress1(multi.getParameter("address1"));
			vo.setAddress2(multi.getParameter("address2"));
			vo.setPhone(multi.getParameter("phone"));
			vo.setPhoto(photo);
			udao.insert(vo);
			response.sendRedirect("/user/login");
			break;
		case "/user/update":
			multi = new MultipartRequest(request, "c:"+path, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
			photo = multi.getFilesystemName("photo")== null ? multi.getParameter("oldPhoto") : path + multi.getFilesystemName("photo");
			vo = new UserVO();
			vo.setUid(multi.getParameter("uid"));
			vo.setUname(multi.getParameter("uname"));
			vo.setAddress1(multi.getParameter("address1"));
			vo.setAddress2(multi.getParameter("address2"));
			vo.setPhone(multi.getParameter("phone"));
			vo.setPhoto(photo);
			udao.update(vo);
			response.sendRedirect("/user/read");
			break;
		}
	}

}
