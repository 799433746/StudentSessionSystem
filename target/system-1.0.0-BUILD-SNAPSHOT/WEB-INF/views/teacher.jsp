<%@ page language="java" contentType="text/html; charset=iso8859-1"
         pageEncoding="iso8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page session="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso8859-1"/>
    <title>Teacher</title>
    <spring:url value="/resources/css/bootstrap.css" var="bootstrapCSS"/>
    <link href="${bootstrapCSS }" rel="stylesheet" type="text/css"/>
    <spring:url value="/resources/js/bootstrap.js" var="bootstrapJS"/>
    <script language="javascript" src="${bootstrapJS }"></script>
    <script type="application/javascript" language="JavaScript">
        function select() {
            var checkBox = document.getElementsByTagName("input");
            for (i = 0; i < checkBox.length; i++) {
                if (checkBox[i].type == "checkbox") {
                    checkBox[i].checked = !checkBox[i].checked;
                }
            }
        }
    </script>
</head>
<body background="<c:url value="/resources/image/homeBanner.jpg"/>">
<div class="btn-group">
    <a class="btn btn-primary" href="<c:url value="/"/>">Log out</a>
    <a class="btn btn-primary" href="/changeInfo/${userName}">Change Info</a>
    <a class="btn btn-primary" href="/teacher/${userName}/studentManage">Student Manage</a>
    <a class="btn btn-primary" href="/teacher/${userName}/lastMonthReport">Last Month Report</a>
    <a class="btn btn-primary" href="/teacher/${userName}/appointInfo">Appointment Info</a>
    <a class="btn btn-primary" href="/showMessage/${userName}">My Message</a>
</div>
<table class="table table-hover table-dark table-bordered" align="center">
    <form action="/teacher/${userName}/deleteMultiSession" method="post">
        <thead>
        <tr>
            <th>Session Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Session Address</th>
            <th>Times Limit</th>
            <th>Total Time Limit</th>
            <th align="center"><a href="#" class="btn btn-primary" onclick="select()">(Un)Select</a></th>
            <th><input type="submit" class="btn btn-primary" value="Delete"></th>
        </tr>
        </thead>
        <c:forEach items="${requestScope.sessions}" var="session">
            <tr>
                <td>${session.getSessionDate() }</td>
                <td>${session.getSessionStartTime() }</td>
                <td>${session.getSessionEndTime()}</td>
                <td>${session.getSessionAddress()}</td>
                <td>${session.getTimesLimit()}</td>
                <td>${session.getTotalTimeLimit() }&nbsp;Hours</td>
                <td align="center">
                    <input align="middle" type="checkbox" id="sessionList" name="sessionList"
                           value="${session.getSessionID()}">
                </td>
                <td class="btn-group">
                    <a
                        href="/teacher/${userName }/editSession/${session.getSessionID()}"
                        class="btn btn-primary">Edit</a>
                    <a
                            href="/teacher/${userName }/deleteSession/${session.getSessionID()}"
                            class="btn btn-primary">Del</a>
                </td>
            </tr>
        </c:forEach>
    </form>
    <form action="/teacher/${userName}/insertSession/"
          method="post">
        <tr>
            <td><input class="form-control" type="date" name="sessionDate"
                       id="sessionDate" min=${requestScope.presentDate }
                               value=${requestScope.presentDate }></td>
            <td><input class="form-control" type="time"
                       name="sessionStartTime" id="sessionStartTime" value="14:00"></td>
            <td><input class="form-control" type="time"
                       name="sessionEndTime" id="sessionEndTime" value="16:00"></td>
            <td><input class="form-control" type="text"
                       name="sessionAddress" id="sessionAddress" maxlength="55"></td>
            <td><input class="form-control" type="number" name="timesLimit"
                       id="timesLimit" min="1" max="30" value="10"></td>
            <td><input class="form-control" type="number"
                       name="totalTimeLimit" id="totalTimeLimit" min="10" max="60"
                       value="30"></td>
            <td><input class="btn btn-primary" type="submit"
                       value="Insert Session"></td>
        </tr>
    </form>
</table>
<form action="/teacher/${userName}/insertMultiSession/"
      method="post">
    <table class="table table-hover table-dark table-bordered" align="center">
        <tr>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Day of Week</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Session Address</th>
            <th>Times Limit</th>
            <th>Total Time Limit</th>
        </tr>
        <tr>
            <td><input class="form-control" type="date"
                       name="sessionStartDate" id="sessionStartDate"
                       min=${requestScope.presentDate } max=${nextMonthDate } value=${requestScope.presentDate }></td>
            <td><input class="form-control" type="date"
                       name="sessionEndDate" id="sessionEndDate"
                       min=${requestScope.presentDate } max=${nextMonthDate } value=${requestScope.presentDate }></td>
            <td><select id="dayOfWeek" name="dayOfWeek"
                        class="form-control">
                <option value="MONDAY">Monday</option>
                <option value="TUESDAY">Tuesday</option>
                <option value="WEDNESDAY">Wednesday</option>
                <option value="THURSDAY">Thursday</option>
                <option value="FRIDAY">Friday</option>
                <option value="SATURDAY">Saturday</option>
                <option value="SUNDAY">Sunday</option>
            </select></td>
            <td><input class="form-control" type="time"
                       name="sessionStartTime" id="sessionStartTime" value="14:00"></td>
            <td><input class="form-control" type="time"
                       name="sessionEndTime" id="sessionEndTime" value="16:00"></td>
            <td><input class="form-control" type="text"
                       name="sessionAddress" id="sessionAddress" maxlength="55"></td>
            <td><input class="form-control" type="number"
                       name="timesLimit" id="timesLimit" min="1" max="30"
                       value="10"></td>
            <td><input class="form-control" type="number"
                       name="totalTimeLimit" id="totalTimeLimit" min="10" max="60"
                       value="30"></td>
            <td><input class="btn btn-primary" type="submit"
                       value="Insert Session"></td>
        </tr>
    </table>
</form>
<c:if
        test="${requestScope.errorInfo != null && requestScope.errorType=='insertError' }">
    <div class="alert alert-danger">${requestScope.errorInfo }
        Please retry.
    </div>
</c:if>
</body>
</html>