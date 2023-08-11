package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	
	public ArrayList<UserVO> list(String key, String query, int page) {
		ArrayList<UserVO> array = new ArrayList<UserVO>();
		try {
			String sql= "select * from users where " + key + " like ? order by regDate desc limit ?, 5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				UserVO vo = new UserVO();
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setPhone(rs.getString("phone"));
				vo.setRegDate(rs.getTimestamp("regDate"));
				array.add(vo);
			}
			
		}catch(Exception e) {
			System.out.println("유저목록" + e.toString());
		}
		return array;
	}
	
	public void update(UserVO vo) {
		try {
			String sql= "update users set uname=?, phone=?, photo=?, address1=?, address2=? where uid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(6, vo.getUid());
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getPhone());
			ps.setString(3, vo.getPhoto());
			ps.setString(4, vo.getAddress1());
			ps.setString(5, vo.getAddress2());
			ps.execute();
		}catch(Exception e) {
			System.out.println("유저수정" + e.toString());
		}
	}
	
	public void insert(UserVO vo) {
		try {
			String sql= "insert into users(uid, upass, uname, phone, photo, address1, address2) "
					+ "values(?, ?,?,?,?,?,?);";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getUpass());
			ps.setString(3, vo.getUname());
			ps.setString(4, vo.getPhone());
			ps.setString(5, vo.getPhoto());
			ps.setString(6, vo.getAddress1());
			ps.setString(7, vo.getAddress2());
			ps.execute();
		}catch(Exception e) {
			System.out.println("유저가입" + e.toString());
		}
	}

	
	public UserVO read(String uid) {
		UserVO vo = new UserVO();
		try {
			String sql= "select * from users where uid = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setRole(rs.getInt("role"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setPhone(rs.getString("phone"));
				vo.setRegDate(rs.getTimestamp("regDate"));
			}
			
		}catch(Exception e) {
			System.out.println("유저찾기" + e.toString());
		}
		return vo;
	}
}
