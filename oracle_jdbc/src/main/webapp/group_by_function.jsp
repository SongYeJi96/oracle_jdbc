<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%
	/* group by 절에서만 사용 가능한 확장 함수
	1) groupPing sets()
	2) rollup() 
	3) cube()
	*/

	//DB 설정
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "hr"; 
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbpw);
	System.out.println("group_by_function db 접속 성공");
	
	// 1) groupPing sets()
	String sql = "select department_id 부서ID, job_id 직무ID, count(*) 합계 from employees group by grouping sets(department_id, job_id)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt+"<--stmt");
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("부서ID", rs.getString("부서ID"));
		m.put("직무ID", rs.getString("직무ID"));
		m.put("합계", rs.getInt("합계"));
		list.add(m);
	}
	System.out.println(list +"<-- list");
	
	// 2) rollup()
	String sql2 = "select department_id 부서ID, job_id 직무ID, avg(salary) 평균 from employees group by rollup(department_id, job_id)";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2+"<--stmt2");
	ResultSet rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<HashMap<String,Object>>();
	while(rs2.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("부서ID", rs2.getString("부서ID"));
		m.put("직무ID", rs2.getString("직무ID"));
		m.put("평균", rs2.getInt("평균"));
		list2.add(m);
	}
	System.out.println(list2 +"<-- list2");
	
	// 3) cube()
	String sql3 = "select department_id 부서ID, job_id 직무ID, avg(salary) 평균 from employees group by cube(department_id, job_id)";
	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	System.out.println(stmt3+"<--stmt3");
	ResultSet rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String,Object>> list3 = new ArrayList<HashMap<String,Object>>();
	while(rs3.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("부서ID", rs3.getString("부서ID"));
		m.put("직무ID", rs3.getString("직무ID"));
		m.put("평균", rs3.getInt("평균"));
		list3.add(m);
	}
	System.out.println(list3 +"<-- list3");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>group_by_function</title>
</head>
<body>
	<h1>Employees table GROUP BY Function</h1>
			<h3>1) groupPing sets()</h3>
			<table border="1">
				<tr>
					<td>부서ID</td>
					<td>직업ID</td>
					<td>합계</td>
				</tr>
				<%
					for(HashMap<String,Object> m : list){
				%>
					<tr>
						<td><%=(String)(m.get("부서ID"))%></td>
						<td><%=(String)(m.get("직무ID"))%></td>
						<td><%=(Integer)(m.get("합계"))%></td>
					</tr>
				<%		
					}
				%>
			</table>
		
			<h3>2) rollup()</h3>
			<table border="1">
				<tr>
					<td>부서ID</td>
					<td>직업ID</td>
					<td>평균</td>
				</tr>
				<%
					for(HashMap<String,Object> m : list2){
				%>
					<tr>
						<td><%=(String)(m.get("부서ID"))%></td>
						<td><%=(String)(m.get("직무ID"))%></td>
						<td><%=(Integer)(m.get("평균"))%></td>
					</tr>
				<%		
					}
				%>
			</table>
		
			<h3>3) cube()</h3>
			<table border="1">
				<tr>
					<td>부서ID</td>
					<td>직업ID</td>
					<td>평균</td>
				</tr>
				<%
					for(HashMap<String,Object> m : list3){
				%>
					<tr>
						<td><%=(String)(m.get("부서ID"))%></td>
						<td><%=(String)(m.get("직업ID"))%></td>
						<td><%=(Integer)(m.get("평균"))%></td>
					</tr>
				<%		
					}
				%>
			</table>
</body>
</html>