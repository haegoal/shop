package model;

import java.sql.*;
import java.util.*;

public class ReviewDAO {
	
	public ArrayList<ReviewVO> list(String gid){
		ArrayList<ReviewVO> array = new ArrayList<ReviewVO>();
		try {
			String sql = "select * from view_reviews where gid=? order by rid desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ReviewVO vo =new ReviewVO();
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setRid(rs.getInt("rid"));
				vo.setContent(rs.getString("content"));
				vo.setRevDate(rs.getString("revDate"));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("리뷰목록" + e.toString());
		}
		return array;
	}
	
	public void insert(ReviewVO vo) {
		try {
			String sql="insert into reviews (uid, gid, content) values(?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.setString(3, vo.getContent());
			ps.execute();
		}catch(Exception e) {
			System.out.println("리뷰등록" + e.toString());
		}
	}
}
