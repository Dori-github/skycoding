<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 메인페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
    .container{
        margin:0 auto;
    }
    .main-page{
        margin:0 auto;
    }
    nav{
        margin: 0 auto;
    }
    .btn_nav{
    	padding-top:10px;
    }
    .card{
        margin: 20px 20px 20px 0;
    }
    .event_btn{
        width:47%;
    }
    #update_event_btn{
    	margin-bottom: 15px;
    }
    .card img{
        width:100%; height:160px;
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="main-page container">
		<div class="btn_nav container">
				<c:if test="${mem_auth == 9}">
                <input class="btn btn-outline-warning btn-md float-start" type="button" value="이벤트 등록" style="display:block"
                			onclick="location.href='registerEventForm.do'">
                </c:if>
					<select class="float-end btn btn-outline-danger btn-md" id="form-select2" name="keyfield2" aria-label="form-select">
						<option value="1" <c:if test="${param.keyfield2==1}">selected</c:if>>마감임박순</option>
						<option value="2" <c:if test="${param.keyfield2==2}">selected</c:if>>조회순</option>
						<option value="2" <c:if test="${param.keyfield2==3}">selected</c:if>>최신순</option>
					</select>
        </div>
        <div style="clear:both; height:20px;"></div>
        <!-- 진행중 이벤트 카드 시작 -->
        <h3 style="font-size:20px;">진행중인 이벤트</h3>
        <div class="container" id="progress_event">
        	<c:if test="${empty list}">
        	<table class="table table-group-divider align-center">
       			<tr>
					<td>표시할 게시물이 없습니다</td>
				</tr>
        	</table>
        	</c:if>
        	<c:if test="${!empty list}">
	        <div class="row row-cols-1 row-cols-md-2 g-2">
			<c:forEach var="event" items="${list}">
	            <div class="col">
	              <div class="card">
	                <img src="" class="card-img-top">
	                <div class="card-body">
	                  <h5 class="card-title">${event.event_course_name}</h5>
	                  <a class="event_btn btn btn-primary float-start" href="eventDetail.do?event_id=${event.event_id}">상세보기</a>
	                  	<!-- 마감까지 남은 날짜 계산 -->
				        <jsp:useBean id="now" class="java.util.Date"/>
						<fmt:parseNumber var="today" value="${now.time/(1000*60*60*24)}" integerOnly="true"/>
  	                    <fmt:parseDate var="deadlineDate" value="${event.event_deadline}" pattern="yyyy-MM-dd"/>
  	                    <fmt:parseNumber var="deadline" value="${deadlineDate.time/(1000*60*60*24)}" integerOnly="true"/>
	                  	<!-- 마감까지 남은 날짜 계산 -->
	                  <p class="event_btn btn btn-primary float-end disabled">마감
	                  	<span class="event_rest_date">${deadline - today}</span>일 전
	                  </p>
	                </div>
	              </div>
	            </div>
	         </c:forEach>
	         <div class="row row-cols-1">
	         <input type="button" class="btn btn-outline-dark btn-md col-md-7 col" value="더보기🔍" 
	         		onclick="location.href='toProgressEvent.do'">
	         </div>
		</div>
		</c:if>
		</div>
		<!-- 진행중 이벤트 카드 끝 -->
		<hr size="1" noshade>
		<!-- 종료된 이벤트 카드 시작 -->
	    <h3 style="font-size:20px;">종료된 이벤트</h3>
		    <div class="container" id="progress_event">
		    	<c:if test="${empty list2}">
		    	<table class="table table-group-divider align-center">
		   			<tr>
						<td>표시할 게시물이 없습니다</td>
					</tr>
		    	</table>
		    	</c:if>
		    	<c:if test="${!empty list2}">
		     	<div class="end_event row row-cols-1 row-cols-md-2 g-2">
					<c:forEach var="event" items="${list2}">
		         	<div class="end_event_ col">
			           <div class="card">
			             <img class="card-img-top" 
			             	  src="">
			             <div class="card-body">
			               <h5 class="card-title">${event.event_course_name}</h5>
			               <a class="event_btn btn btn-primary float-start" 
			                  href="eventDetail.do?event_id=${event.event_id}">상세보기</a>
			               <p class="event_btn btn btn-secondary float-end disabled">마감</p>
			             </div>
			           </div>
			         </div>
		     		</c:forEach>
		     		<div style="clear:both; height:20px;"></div>
		     		<div class="row row-cols-1">
		     		<input type="button" class="btn btn-outline-dark btn-md col-md-7" value="더보기🔍" 
		     			   onclick="location.href='toEndEvent.do'">
		     		</div>
				</div>
		</c:if>
		</div>
		<!-- 종료된 이벤트 카드 끝 -->
	</div><!--end of main-page -->
</body>
</html>