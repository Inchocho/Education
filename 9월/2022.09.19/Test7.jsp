<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Test7</title>

</head>

<body>

	<!-- 정수형으로 값을 받기위해 객체타입(Object) request.getAttribute("myKey")에 (int)로 강제형변환 -->
	<%			
		int myAge = (int)request.getAttribute("myKey");
	%>
	
	<%=myAge + "살"%>

</body>

</html>