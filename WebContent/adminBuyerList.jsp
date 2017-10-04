<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.xerces.parsers.DOMParser"%>
<%@ page import="assign2.bean.Buyer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	ArrayList<Buyer> result = (ArrayList<Buyer>) session.getAttribute("buyerList");
	int pageCount = 0;
	int curPage = 0;
	int size = result.size();
	if (size % 10 != 0)
		pageCount = size / 10 + 1;
	else
		pageCount = size / 10;
	String temp = request.getParameter("curPage");
	if (temp==null)
		temp = "1";
	curPage = Integer.parseInt(temp);

%>
<head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Buyer search result</title>
<%@ include file="adminHeader.html"%>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".bodys p").not(":first").hide();
		$(".searchbox ul li").mouseover(function() {
			var index = $(this).index();
			if (index == 0) {
				$(this).find("a").addClass("style1");
				$(".searchbox ul li").eq(1).find("a").removeClass("style1");
				$(".searchbox ul li").eq(2).find("a").removeClass("style1");
				$(".searchbox ul li").eq(3).find("a").removeClass("style1");
				$(".searchbox ul li").eq(4).find("a").removeClass("style1");
			}
			if (index == 1) {
				$(this).find("a").addClass("style1");
				$(".searchbox ul li").eq(0).find("a").removeClass("style1");
				$(".searchbox ul li").eq(2).find("a").removeClass("style1");
				$(".searchbox ul li").eq(3).find("a").removeClass("style1");
				$(".searchbox ul li").eq(4).find("a").removeClass("style1");
			}
			if (index == 2) {

				$(this).find("a").addClass("style1");
				$(".searchbox ul li").eq(0).find("a").removeClass("style1");
				$(".searchbox ul li").eq(1).find("a").removeClass("style1");
				$(".searchbox ul li").eq(3).find("a").removeClass("style1");
				$(".searchbox ul li").eq(4).find("a").removeClass("style1");
			}
			if (index == 3) {

				$(this).find("a").addClass("style1");
				$(".searchbox ul li").eq(0).find("a").removeClass("style1");
				$(".searchbox ul li").eq(1).find("a").removeClass("style1");
				$(".searchbox ul li").eq(2).find("a").removeClass("style1");
				$(".searchbox ul li").eq(4).find("a").removeClass("style1");
			}
			if (index == 4) {
				$(this).find("a").addClass("style1");
				$(".searchbox ul li").eq(1).find("a").removeClass("style1");
				$(".searchbox ul li").eq(2).find("a").removeClass("style1");
				$(".searchbox ul li").eq(3).find("a").removeClass("style1");
				$(".searchbox ul li").eq(0).find("a").removeClass("style1");
			}
			var index = $(this).index();
			$(".bodys p").eq(index).show().siblings().hide();
		});
	});
</script>

<style type="text/css">
* {
	margin: 0;
	padding: 0;
	list-style-type: none;
}

a, img {
	border: 0;
}

/* searchbox */
ul#navlist{
	margin: 0 0 0 .1px;
	padding: 0;
	width: 300px;
	}
#navlist li{
	list-style-type: none;
	background-color: #000;
	color: #ffffff;
	border: .01em solid #ffffff;
	font-weight: 600;
	text-align: center;
	padding: .5em;
	margin-bottom: .01em;
	}
#navlist li a{
	color: #ffffff;
	text-decoration: none;
	display: block;
	}
#navlist li a:hover{
	padding: .1em;
	background-color: #faebd7;
	color: #191970;
	}

.bodys input {
	height: 30px;
	line-height: 30px;
	width: 600px;
	padding: 0 10px;
	float: left;
}

.bodys .one {
	border: #000 3px solid
}

.bodys .one1 {
	background-color: #000;
}

.bodys button {
	float: left;
	border: 0;
	height: 36px;
	width: 100px;
	color: #FFF;
	line-height: 36px;
	text-align: center;
	overflow: hidden;
}
</style>
</head>
<body>
	<table>
		<tr>
			<td width="30%" valign="top">
				<form class="searchbox" action='admin' method='POST'>
					<div id="navcontainer">
						<ul id="navlist">
							<li id="active"><a href="admin?action=toAdminBuyerListStart" id="current">Search Buyer</a></li>
							<li><a href="admin?action=toAdminSellerListStart">Search Seller</a></li>
						</ul>
					</div>
				</form>
			</td>
			<td align="center">
				<center>
					<form class="searchbox" action='admin' method='POST'>
						<div class="bodys">
						<p>
							<input type="text" value="" id="" name="searchContent" class="one"
							placeholder="Please enter buyer username" />
							<input type='hidden' name="action" value='searchBuyer'/>
							<button class="one1" name='searchType' value='all'>Search</button>
						</p>
						</div>
					</form>
				</center>
			</td>
		</tr>
		
		<tr>
			<td></td>
			<td>
				<p><center>
		<table align="center" style="text-align: center;" width="70%"
			border="0">
			<tr>
			
				<td>Number</td>
				<td>Username</td>
				<td>Email</td>
				<td>Ban State</td>
			</tr>
			<%
				int number;
				for (int i = (curPage - 1) * 10; i < Math.min(size, curPage * 10); i++) {
					Buyer buyer = result.get(i);
					number = i + 1;
			%>
			<tr>
				<td><%=number%></td>
				<td><a href="admin?action=buyerDetailHistory&buyerName=<%=buyer.getUsername()%>"><%=buyer.getUsername()%></a></td>
				<td><%=buyer.getEmail() %></td>
				<%
				if (buyer.getBan() > 0) {
			    %>
				<td>Yes</td>
				<%
				} else {
				%>
				<td>No</td>
			
			<%
				}
			%>
			</tr>
			<%
				}
			%>
		</table></center>
		<br/><br/>
		<center><table>
			<tr>
				<%if (curPage > 1) {%>
				<a href = "adminBuyerList.jsp?curPage=<%=1%>">First Page</a>
				
				<tr>
			<span style="font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</tr>
			<a href = "adminBuyerList.jsp?curPage=<%=curPage-1%>">Previous Page</a>
				<%}%>
			</tr>
			<tr>
			<span style="font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</tr>
			
			<%
			if(pageCount > 1){
				int startnum = (curPage - 1) / 10;
				for(int i=1;i<=pageCount;i++){
					if(i == curPage){
			%>
			<tr><%=i+startnum*10 %></tr>
			<%
					}
					else{
			%>
			<tr> <a href="adminBuyerList.jsp?curPage=<%=i%>"> <%=i+startnum*10 %> </a> </tr>
			<%
					}
				}
			}
			%>
			
			<tr>
			<span style="font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</tr>
			<tr>
				<%if (curPage < pageCount) {%>
				<a href = "adminBuyerList.jsp?curPage=<%=curPage+1%>">Next Page</a>
				<tr>
			<span style="font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</tr>
			<a href = "adminBuyerList.jsp?curPage=<%=pageCount%>">Last Page</a>
				<%}%>
			</tr>

		</table></center>
			</td>
		</tr>
	</table>
</body>