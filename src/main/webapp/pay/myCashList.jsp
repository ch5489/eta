<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, viewport-fit=cover" />
<title>myCashList</title>
<link rel="stylesheet" type="text/css" href="/templates/styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/templates/fonts/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/templates/styles/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700;800&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="manifest" href="/templates/_manifest.json">
<meta id="theme-check" name="theme-color" content="#FFFFFF">
<link rel="apple-touch-icon" sizes="180x180" href="/templates/app/icons/icon-192x192.png">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
<style type="text/css">
  td{
    height: 100px;
  }
</style>
</head>
<body class="theme-light">
  <form name="detailform">
    <div id="page">
      <div class="page-content header-clear-medium">
        <div class="card card-style">
          <div class="content">
            <!-- <h6 class="font-700 mb-n1 color-highlight">Split Content</h6> -->

            <h1 class="pb-2">
              <i class="has-bg rounded-s bi bg-teal-dark bi-list-columns">&nbsp;</i>&nbsp;&nbsp;정산 내역 리스트
            </h1>

          </div>
        </div>

        <div class="card overflow-visible card-style">
          <div class="content mb-0">
            <div class="col-12 mb-4 pb-1" align="right" style="height: 15px">
                <select class="form-select"  id="cashState" style="display: inline-block; padding-top: 3px; padding-bottom: 3px; float: left; width: 10%">
								    <option value="all">전체</option>
								    <option value="wait">정산 대기</option>
								    <option value="complete">정산 완료</option>
								</select>
                  <select id="month" class="form-select"  style="width: 20%; display: inline-block">
										  <option value="all">전체</option>
										  <option value="01">1월</option>
										  <option value="02">2월</option>
										  <option value="03">3월</option>
										  <option value="04">4월</option>
										  <option value="05">5월</option>
										  <option value="06">6월</option>
										  <option value="07">7월</option>
										  <option value="08">8월</option>
										  <option value="09">9월</option>
										  <option value="10">10월</option>
										  <option value="11">11월</option>
										  <option value="12">12월</option>
										</select>
              <a class="btn btn-xxs border-blue-dark color-blue-dark" id="searchButton"
                style="display: inline-block; padding-top: 3px; padding-bottom: 3px">검색</a>
            </div>

            <div class="table-responsive">
              <table class="table color-theme mb-2" id="muhanlist">
                <thead>
                  <tr>
                    <th scope="col">배차번호</th>
                    <th scope="col">날짜</th>
                    <th scope="col">금액</th>
                    <th scope="col">정산 상태</th>
                  </tr>
                </thead>
                <tbody>
                <c:choose>
								  <c:when test="${empty myCashList}">
								      정산 내역이 없습니다.
								  </c:when>
								    <c:otherwise>
								    <c:set var="i" value="0" />    
								    <c:forEach var="myCashList" items="${myCashList}">
								      <c:set var="i" value="${ i+1 }" />
								     <tr class="cashItem" data-star="${myCashList.star}">
                      <td><a class="getRecord" data-callno="${myCashList.callNo}">${myCashList.callNo}</a></td>
                      <td>${myCashList.callDate}</td>
                      <td>${myCashList.realPay}원</td>
                      <td>                       <c:choose>
                          <c:when test="${myCashList.star eq 1}">
                            정산 완료
                          </c:when>
                          <c:otherwise>
                            정산 대기
                          </c:otherwise>
                       </c:choose></td>
                    </tr>
								      </c:forEach>
								  </c:otherwise>
                </c:choose>
                </tbody>
              </table>
                   <c:choose>
						      <c:when test="${monthTotal eq 0}">       
						      </c:when>
						      <c:otherwise>
						        ${month} 월 총 금액 : ${monthTotal} 원
						      </c:otherwise>
						    </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
</body>
<script>
$(document).ready(function() {
$(function () {
	
    $( ".getRecord" ).on("click" , function() {
    	
    	var callNo = $(this).data("callno");
    	  self.location = "/callres/getRecordDriver?callNo="+callNo;
     }); 
    
    $("#searchButton").on("click", function () {
        var month = $("#month").val();
        self.location = "/pay/myCashList?userNo="+${user.userNo}+"&month=" + month;
    });

    $("#cashState").on("change", function () {
        var selectedValue = this.value;
        var cashItems = $(".cashItem");

        cashItems.each(function () {
            var starValue = $(this).data("star");

            if ((selectedValue === 'complete' && starValue === 1) || (selectedValue === 'wait' && starValue !== 1) || selectedValue === 'all') {
                $(this).show(); // 보이게 설정
            } else {
                $(this).hide(); // 숨기게 설정
            }
        });
    });
});
});
</script>

</html>