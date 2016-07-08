<%@page import="Model.Timeline"%>
<%@page import="Model.Polyline"%>
<%@page import="Model.Polygon"%>
<%@page import="Model.Circle"%>
<%@page import="Model.Marker"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Event"%>
<%@page import="Model.User"%>
<%@page import="Model.Project"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>عرض | المشروع</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/tags_syle.css" rel="stylesheet" type="text/css">
        <script src="https://maps.googleapis.com/maps/api/js?language=ar"></script>

    </head>
    <body>
        <div id="main_container">
            <div class="container" id="viewProject">
                <div class="header">
                    <div class="navbar-header">
                        <a href="index.jsp"><img src="images/histopedia-logo.gif" alt="fantasy" class="histopedia-logo"></a>
                    </div>
                    <form  action="getSearchValue" method="get" class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder=".. بحث" id="keyword" name="keyword">
                        </div>
                        <button type="submit" class="btn btn-default btn-danger" name="Search">
                            <span class="glyphicon glyphicon-search"></span> 
                        </button>
                    </form>
                </div>
                <div class="cleaner"></div>
                <div class="navbar templatemo-nav" id="navbar">
                    <div class="navbar-header">		          	
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav nav-justified">
                            <li><a href="mypage.jsp"><span class="glyphicon glyphicon-user"></span> الصفحة الشخصية </a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>           
                            <li><a href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> تسجيل الخروج</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>

                <%
                    String project_id_string = request.getParameter("project_id");

                    if (project_id_string == null) {
                        response.sendRedirect("error.jsp");
                        return;
                    }

                    Project project = new Project();
                    project.setProject_id(Integer.parseInt(project_id_string));

                    if (!project.isPublishedAndExist()) {
                        response.sendRedirect("error.jsp");
                        return;
                    }

                    //get project data from database and set it in object
                    project.setProjectDataUsingId();
                    User user = new User();
                    user.setUser_id(project.getOwnerID());
                    //get user data from database and set it in object
                    user.getUserInformation();

                    //count number of views
                    String logged_in_user_email = (String) session.getAttribute("email");
                    if (logged_in_user_email == null || !logged_in_user_email.equals(user.getEmail())) {
                        project.setViews(project.getViews() + 1);
                        project.updateViews();
                    }
                    Event event = new Event();
                    ArrayList<Event> publishedEvents = event.getPublishedEvents(project.getProject_id());
                    publishedEvents = event.sortEventsAscending(publishedEvents);
                    Timeline timeline = new Timeline(publishedEvents);

                %>

                <!-- Project Info-->
                <h1 class="page-header text-center"> معلومات المشروع</h1>

                <div class="row">
                    <br>
                    <!-- left column -->
                    <div class="col-md-5 col-sm-6 col-xs-12">
                        <!-- about user -->
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead">الكاتب <span class="glyphicon glyphicon-user"> </span> <hr> </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8">
                                        <blockquote>
                                            <h2 class="text text-primary"><a href=""><%=user.getName()%></a></h2>
                                            <p> <%= (user.getUser_desc() == ""? "" : "<small>" + user.getUser_desc() + "</small>")  %></p>
                                            <small><cite title=""> <%= (user.getCountry() == null? "": user.getCountry()) %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>

                                        </blockquote>

                                    </div><!--/col-->          
                                    <div class=" col-md-4 text-center">
                                        <div>
                                            <img src="<%=user.getPhoto() %>" alt="" class="center-block img-circle img-responsive">
                                            <ul class="list-inline ratings text-center" title="">
                                                <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                                <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                                <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                            </ul>
                                        </div>

                                    </div><!--/col-->
                                </div><!--/row-->

                            </div><!--/panel-body-->
                        </div><!--/panel-->

                    </div>
                    <!-- Project info -->
                    <div class="col-md-7 col-sm-6 col-xs-12 personal-info">
                        <h3 class="text text-center text-primary">
                            <%= project.getName()%>
                        </h3>
                        <br>
                        <p><%= project.getProject_desc()%></p>
                        <br>

                      
                        <p> <i class="glyphicon glyphicon-eye-open"></i> <%= project.getViews()%> <br> </p>

                        
                    </div>
                </div>

                <hr>


                <div class="row">

                    <div class="col-md-6">
                        <h3 class="text-info "> احداث المشروع </h3>
                    </div>
                    <div class="col-md-6">
                        <h3 class="text text-primary pull-right"> الخط الزمني للمشروع</h3>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-9">
                        <%
                            for (int index = 0; index < publishedEvents.size(); index++) {
                                int y = publishedEvents.get(index).getYear();
                                int m = publishedEvents.get(index).getMonth();
                                Timeline tmln = new Timeline();
                                String m_string = tmln.getNameOfMonth(m);
                                int d = publishedEvents.get(index).getDay();
                        %>
                        <div id="<%= y + "-" + m_string + "-" + d%>" class="hideme">
                            <!-- Map -->
                            <div class="row" id="<%= "map" + "-" + y + "-" + m_string + "-" + d%>" style="height:400px;"> </div>
                            <br><br>
                            <div class="text text-center text-info">تفاصيل الحدث</div>
                            <br>
                            <!-- Details -->
                            <div class="row">

                                <%= publishedEvents.get(index).getDetails()%>

                            </div>
                        </div>

                        <script>


                            function initialize() {

                                var map = new google.maps.Map(document.getElementById('<%= "map" + "-" + y + "-" + m_string + "-" + d%>'), {
                                    zoom: <%= publishedEvents.get(index).getMap_zoom_level()%>,
                                    center: new google.maps.LatLng(<%= publishedEvents.get(index).getLat()%>, <%= publishedEvents.get(index).getLng()%>),
                                    mapTypeControl: false,
                                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                                    zoomControl: true
                                });
                            <%
                                ArrayList<Circle> circles = publishedEvents.get(index).getCircles();
                                for (int i = 0; i < circles.size(); i++) {
                            %>
                                var circle = new google.maps.Circle({
                                    center: new google.maps.LatLng(<%=circles.get(i).getLat()%>,<%=circles.get(i).getLng()%>),
                                    radius:<%=circles.get(i).getRadius()%>,
                                    strokeColor: "<%=circles.get(i).getStrokeColor()%>",
                                    strokeOpacity:<%=circles.get(i).getStrokeOpacity()%>,
                                    strokeWeight:<%=circles.get(i).getStrokeWeight()%>,
                                    fillColor: "<%=circles.get(i).getFillColor()%>",
                                    fillOpacity:<%=circles.get(i).getFillOpacity()%>,
                                    editable: false,
                                    draggable: false
                                });

                                circle.setMap(map);

                            <%}%>
                            <%
                                ArrayList<Polygon> polygons = publishedEvents.get(index).getPolygons();
                                for (int i = 0; i < polygons.size(); i++) {
                            %>
                                var myTrip = [];
                            <%
                                String coor1 = polygons.get(i).getCoordinates();
                                coor1 = coor1.replaceAll("^\\s+", "");
                                coor1 = coor1.replaceAll("\\s+$", "");
                                String[] arr = coor1.split(",");

                                for (int j = 0; j < arr.length; j++) {

                                    arr[j] = arr[j].replaceAll("^\\s+", "");
                                    arr[j] = arr[j].replaceAll("\\s+$", "");
                                    if (j % 2 == 0) {
                                        arr[j] = arr[j].substring(1);
                                    } else {
                                        arr[j] = arr[j].substring(0, arr[j].length() - 1);
                                    }
                                }
                                for (int j = 0; j < arr.length; j += 2) {
                            %>
                                myTrip.push(new google.maps.LatLng(<%= Double.parseDouble(arr[j])%>,<%= Double.parseDouble(arr[j + 1])%>));
                            <% }%>


                                //  (52.93539665862318, 4.46044921875),(52.1874047455997, 5.526123046875),(52.10650519075632, 4.3121337890625),(52.769539220673074, 4.4549560546875)
                                var flightPath = new google.maps.Polygon({
                                    path: myTrip,
                                    strokeColor: "<%=polygons.get(i).getStrokeColor()%>",
                                    strokeOpacity:<%=polygons.get(i).getStrokeOpacity()%>,
                                    strokeWeight:<%=polygons.get(i).getStrokeWeight()%>,
                                    fillColor: "<%=polygons.get(i).getFillColor()%>",
                                    fillOpacity:<%=polygons.get(i).getFillOpacity()%>,
                                    editable: false,
                                    draggable: false
                                });

                                flightPath.setMap(map);


                            <%}%>
                            <%
                                ArrayList<Polyline> polylines = publishedEvents.get(index).getPolylines();
                                for (int i = 0; i < polylines.size(); i++) {
                            %>
                                var myTrip = [];
                            <%
                                String coor1 = polylines.get(i).getCoordinates();
                                coor1 = coor1.replaceAll("^\\s+", "");
                                coor1 = coor1.replaceAll("\\s+$", "");
                                String[] arr = coor1.split(",");

                                for (int j = 0; j < arr.length; j++) {

                                    arr[j] = arr[j].replaceAll("^\\s+", "");
                                    arr[j] = arr[j].replaceAll("\\s+$", "");
                                    if (j % 2 == 0) {
                                        arr[j] = arr[j].substring(1);
                                    } else {
                                        arr[j] = arr[j].substring(0, arr[j].length() - 1);
                                    }
                                }
                                for (int j = 0; j < arr.length; j += 2) {
                            %>
                                myTrip.push(new google.maps.LatLng(<%= Double.parseDouble(arr[j])%>,<%= Double.parseDouble(arr[j + 1])%>));
                            <% }%>


                                //  (52.93539665862318, 4.46044921875),(52.1874047455997, 5.526123046875),(52.10650519075632, 4.3121337890625),(52.769539220673074, 4.4549560546875)
                                var flightPath = new google.maps.Polyline({
                                    path: myTrip,
                                    strokeColor: "<%=polylines.get(i).getStrokeColor()%>",
                                    strokeOpacity:<%=polylines.get(i).getStrokeOpacity()%>,
                                    strokeWeight:<%=polylines.get(i).getStrokeWeight()%>,
                                    editable: false,
                                    draggable: false
                                });

                                flightPath.setMap(map);


                            <%}%>



                            <%
                                ArrayList<Marker> markers = publishedEvents.get(index).getMarkers();
                                for (int i = 0; i < markers.size(); i++) {
                            %>
                                var myCenter = new google.maps.LatLng(<%= markers.get(i).getLat()%>,<%= markers.get(i).getLng()%>);
                                var marker = new google.maps.Marker({
                                    position: myCenter,
                                    editable: false,
                                    draggable: false
                                }
                                );
                                marker.setMap(map);
                                var infowindow = new google.maps.InfoWindow({
                                    content: "<%= markers.get(i).getTitle()%>"
                                });
                                infowindow.open(map, marker);
                            <%}%>

                            }
                            google.maps.event.addDomListener(window, 'load', initialize);
                        </script>


                        <%}%> <!-- close of published events for loop -->
                    </div>





                    <!-- Time line -->
                    <div class="col-md-3">

                        <div class="panel-group">
                            <%
                                int nYear = timeline.getYearValue().size();
                                for (int y = 0; y < nYear; y++) {
                                    int curYear = timeline.getYearValue().get(y);
                            %>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="<%= "#" + curYear%>" > <%= (curYear > 0 ? curYear : (-1 * curYear) + "      م.ق")%>  </a>
                                    </h4>
                                </div>
                                <div id="<%= curYear%>" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <%
                                            boolean[][] curArr = timeline.getMonth_day().get(y);
                                            for (int m = 1; m <= 12; m++) {

                                                ArrayList<Integer> days = new ArrayList<Integer>();
                                                for (int d = 0; d <= 31; d++) {
                                                    if (curArr[m][d]) {
                                                        days.add(d);
                                                    }
                                                }

                                                if (days.size() == 0) {
                                                    continue;
                                                }
                                                String month_string = timeline.getNameOfMonth(m);
                                        %>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <a href="<%= "#" + curYear + "-" + month_string%>"  data-toggle="collapse">
                                                    <span class="glyphicon glyphicon-plus-sign"></span>
                                                </a>
                                                <%= month_string%> 
                                            </div>
                                        </div>

                                        <div id="<%= curYear + "-" + month_string%>"  class="collapse">
                                            <%
                                                for (int i = 0; i < days.size(); i++) {
                                            %>
                                            <div class="row">

                                                <a href="<%= "#" + curYear + "-" + month_string + "-" + days.get(i)%>" id="<%= curYear + "-" + month_string + "-" + days.get(i)%>" class="view_event_anchor"> <%= days.get(i)%> </a>

                                            </div>
                                            <%}%> <!-- close of days for loop -->
                                        </div>
                                        <%}%> <!-- close of month for loop-->

                                    </div>

                                </div>
                            </div>
                            <% }%> <!-- close of years loop -->
                        </div>

                    </div>    


                </div>
            </div>


        </div>

        <footer class="container">
            <div class="credit row">
                <div class="col-md-6 col-md-offset-3">
                    <div id="templatemo_footer">
                        حقوق الملكية  2016  <a href="index.jsp">Histopedia.com</a> جميع الحقوق محفوظه


                    </div>
                </div>
                <div class="col-md-3">
                    <div style="text-align: right">
                        <a rel="nofollow" href="" target="_parent">
                            <img src="images/facebook.png" alt="Like us on Facebook">
                        </a>
                        <a href="#"><img src="images/twitter.png" alt="Follow us on Twitter"></a>
                        <a href="#"><img src="images/rss.png" alt="RSS feeds"></a>
                    </div>
                </div>				
            </div>
        </footer>	
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/templatemo_script.js"></script>
    <script type="text/javascript" src="js/tags_scrips.js"></script>
    <script src="js/manageMapView.js"></script>


</body>
</html>