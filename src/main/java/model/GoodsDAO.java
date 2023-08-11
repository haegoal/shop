package model;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class GoodsDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public void update(GoodsVO vo) {
		try {
			String sql="update goods set title=?,price=?,maker=?,image=? where gid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(5, vo.getGid());
			ps.setString(1, vo.getTitle());
			ps.setInt(2, vo.getPrice());
			ps.setString(3, vo.getMaker());
			ps.setString(4, vo.getImage());
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품수정" + e.toString());
		}
	}
	
	public GoodsVO read(String gid){
		GoodsVO vo = new GoodsVO();
		try {
			String sql = "select * from goods where gid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setMaker(rs.getString("maker"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
			}
		}catch(Exception e) {
			System.out.println("상품찾기" + e.toString());
		}
		return vo;
	}
	
	public int total(String query){
		int total=0;
		try {
			String sql = "select count(*) cnt from goods where title like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("검색수" + e.toString());
		}
		return total;
	}
	
	public ArrayList<GoodsVO> list(String query, int page){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql = "select * from goods where title like ? order by regDate desc limit ?,6";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ps.setInt(2, (page-1)*6);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				GoodsVO vo =new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setMaker(rs.getString("maker"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록" + e.toString());
		}
		return array;
	}
	
	public void delete(String gid) {
		try {
			String sql="delete from goods where gid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품삭제" + e.toString());
		}
	}
	
	public void insert(GoodsVO vo) {
		try {
			String sql="insert into goods(gid, title, price, maker, image) "
					+ "values(?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getTitle());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getMaker());
			ps.setString(5, vo.getImage());
			ps.execute();
		}catch(Exception e) {
			System.out.println("상품등록" + e.toString());
		}
	}
}
