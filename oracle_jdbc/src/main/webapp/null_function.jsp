<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%
	/*
	* nvl(값1, 값2) : 값1이 null이 아니면 값1을 반환, 값1이 null이면 값2를 반환한다
	* nvl2(값1, 값2, 값3) : 값1이 null아니면 값2반환, 값1이 null이면 값3을 반환
	* nullif(값1, 값2) : 값1과 값2가 같으면 null을 반환 (null이 아닌값이 null로 치환에 사용)
	* coalesce(값1, 값2, 값3, .....) : 입력값 중 null이 아닌 첫번째값을 반환
	*/

	//DB 설정
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "gdj66"; 
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbpw);
	System.out.println("null_function db 접속 성공");
	
	// 1) select 이름, nvl(일분기, 0) from 실적;
	String sql = "select name 이름, nvl(first_quarter, 0) 일분기 from 실적";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt+"<--stmt");
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("이름", rs.getString("이름"));
		m.put("일분기", rs.getInt("일분기"));
		list.add(m);
	}
	System.out.println(list +"<-- list");
	
	// 2) select 이름, nvl2(일분기, 'success', 'fail') from 실적;
	String sql2 = "select name 이름, nvl2(first_quarter, 'success', 'fail') 일분기 from 실적";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2+"<--stmt2");
	ResultSet rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<HashMap<String,Object>>();
	while(rs2.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("이름", rs2.getString("이름"));
		m.put("일분기", rs2.getString("일분기"));
		list2.add(m);
	}
	System.out.println(list2 +"<-- list2");
	
	// 3) select 이름, nullif(사분기, 100) from 실적;
	String sql3 = "select name 이름, nullif(fourth_quarter, 100) 사분기 from 실적";
	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	System.out.println(stmt3+"<--stmt3");
	ResultSet rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String,Object>> list3 = new ArrayList<HashMap<String,Object>>();
	while(rs3.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("이름", rs3.getString("이름"));
		m.put("사분기", rs3.getInt("사분기"));
		list3.add(m);
	}
	System.out.println(list3 +"<-- list3");
	
	// 4)select 이름, coalesce(일분기, 이분기, 삼분기, 사분기) from 실적;
	String sql4 = "select name 이름, coalesce(first_quarter, second_quarter, third_quarter, fourth_quarter) coalesce from 실적";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	System.out.println(stmt4+"<--stmt4");
	ResultSet rs4 = stmt4.executeQuery();
	
	ArrayList<HashMap<String,Object>> list4 = new ArrayList<HashMap<String,Object>>();
	while(rs4.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("이름", rs4.getString("이름"));
		m.put("coalesce", rs4.getInt("coalesce"));
		list4.add(m);
	}
	System.out.println(list4 +"<-- list4");

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>null_function.jsp</title>
<style>
	table, tr, td{
		border: 1px solid #000000;
	}
</style>
</head>
<body>
	<h1>실적 table NULL Function</h1>
		
		<h3>1) select 이름, nvl(일분기, 0) from 실적;</h3>
		<table>
			<tr>
				<td>이름</td>
				<td>일분기</td>
			</tr>
			<%
				for(HashMap<String,Object> m : list){
			%>
				<tr>
					<td><%=(String)(m.get("이름"))%></td>
					<td><%=(Integer)(m.get("일분기"))%></td>
				</tr>
			<%		
				}
			%>
		</table>
		
		<h3>2) select 이름, nvl2(일분기, 'success', 'fail') from 실적;</h3>
		<table>
			<tr>
				<td>이름</td>
				<td>일분기</td>
			</tr>
			<%
				for(HashMap<String,Object> m : list2){
			%>
				<tr>
					<td><%=(String)(m.get("이름"))%></td>
					<td><%=(String)(m.get("일분기"))%></td>
				</tr>
			<%		
				}
			%>
		</table>
		
		<h3>3) select 이름, nullif(사분기, 100) from 실적;</h3>
		<table>
			<tr>
				<td>이름</td>
				<td>일분기</td>
			</tr>
			<%
				for(HashMap<String,Object> m : list3){
			%>
				<tr>
					<td><%=(String)(m.get("이름"))%></td>
					<td><%=(Integer)(m.get("사분기"))%></td>
				</tr>
			<%		
				}
			%>
		</table>
		
		<h3>4)select 이름, coalesce(일분기, 이분기, 삼분기, 사분기) from 실적;</h3>
		<table>
			<tr>
				<td>이름</td>
				<td>일분기</td>
			</tr>
			<%
				for(HashMap<String,Object> m : list4){
			%>
				<tr>
					<td><%=(String)(m.get("이름"))%></td>
					<td><%=(Integer)(m.get("coalesce"))%></td>
				</tr>
			<%		
				}
			%>
		</table>
</body>
</html>