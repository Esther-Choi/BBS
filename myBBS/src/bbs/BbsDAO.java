package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			
			String dbID = "root";
			 String dbPassword = "13579ccs";
			 
			 // mysql 드라이브(Driver : mysql에 접속할 수 있도록 매개체 역학을 해주는 하나의 라이브러리)
			 Class.forName("com.mysql.cj.jdbc.Driver");
			 conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			 
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "select bbsID from BBS order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs =  pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1)+1;
			}else {
				return 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into BBS values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Bbs bbs =new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
					
				}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	 public boolean nextPage(int pageNumber) {
		 String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1";
		 try {
			 if(getCount()>10) {
				 
				 // SQL 구문을 전달해줄 객체
				 PreparedStatement pstmt = conn.prepareStatement(SQL);
				 
				 pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
				 // 실행 결과물을 rs에 담기
				 rs = pstmt.executeQuery();
				 
				 // 결과물이 있다면(.next()의 값이 존재할 경우)
				 if(rs.next()) {
					 //다음 게시물이 존재 한다면 트루 리턴 
					 return true;
				 }
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 return false;
	 }
	 
	 // bbsID를 받아 해당 게시글 정보를 리턴해주는 메소드
	 public Bbs getBbs(int bbsID) {
		 String SQL = "select * from BBS where bbsID = ?";
		 try {
			 // SQL 구문을 전달해줄 객체
			 PreparedStatement pstmt = conn.prepareStatement(SQL);
			 
			 pstmt.setInt(1, bbsID);
			 // 실행 결과물을 rs에 담기
			 rs = pstmt.executeQuery();
			 
			 // 결과물이 있다면(.next()의 값이 존재할 경우)
			 if(rs.next()) {
				 Bbs bbs = new Bbs();
				 bbs.setBbsID(rs.getInt(1));
				 bbs.setBbsTitle(rs.getString(2));
				 bbs.setUserID(rs.getString(3));
				 bbs.setBbsDate(rs.getString(4));
				 bbs.setBbsContent(rs.getString(5));
				 bbs.setBbsAvailable(rs.getInt(6));
				 return bbs;
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 return null;
	 }
	 
	 public int getCount() {
		 String SQL = "select count(*) from BBS";
		 try {
			 // SQL 구문을 전달해줄 객체
			 PreparedStatement pstmt = conn.prepareStatement(SQL);

			 rs = pstmt.executeQuery();
			 
			 // 결과물이 있다면(.next()의 값이 존재할 경우)
			 if(rs.next()) {
				 return rs.getInt(1);
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 return -1;
	 }
	 
	 public int update(int bbsID, String bbsTitle, String bbsContent) {
		 String SQL = "update BBS set bbsTitle = ?, bbsContent = ? where bbsID = ?";
		 try {
			 // SQL 구문을 전달해줄 객체
			 PreparedStatement pstmt = conn.prepareStatement(SQL);
			 // 첫번째 인자는 위에 getNext 결과값인 게시물 번호 삽입 
			 pstmt.setString(1, bbsTitle);
			 pstmt.setString(2, bbsContent);
				 pstmt.setInt(3, bbsID);
			 
			// 데이터를 추가(Insert), 삭제(Delete), 수정(Update)하는 SQL 문을 실행
			 // 메서드의 반환 값은 해당 SQL 문 실행에 영향을 받는 행 수를 반환 (무조건 0>의 수 반환)
			 return pstmt.executeUpdate();
			 
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 return -1;  //데이터베이스 오류 
	 }
	 
	 public int delete(int bbsID) {
		 String SQL = "update BBS set bbsAvailable = 0 where bbsID = ?";
		 try {
			 // SQL 구문을 전달해줄 객체
			 PreparedStatement pstmt = conn.prepareStatement(SQL);
			 // 첫번째 인자는 위에 getNext 결과값인 게시물 번호 삽입 
			 pstmt.setInt(1, bbsID);
			 
			// 데이터를 추가(Insert), 삭제(Delete), 수정(Update)하는 SQL 문을 실행
			 // 메서드의 반환 값은 해당 SQL 문 실행에 영향을 받는 행 수를 반환 (무조건 0>의 수 반환)
			 return pstmt.executeUpdate(); 
			 
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 return -1;  //데이터베이스 오류 
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
