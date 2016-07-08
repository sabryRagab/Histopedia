<%@page import="Model.Marker"%>
<%@page import="Model.Polyline"%>
<%@page import="Model.Polygon"%>
<%@page import="Model.Circle"%>
<%@page import="Model.Timeline"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Project"%>
<%@page import="Model.User"%>
<%@page import="Model.Event"%>
<%@page import="java.util.Calendar"%>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>تعديل | المشروع</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/tags_syle.css" rel="stylesheet" type="text/css">
        <script src="https://maps.googleapis.com/maps/api/js"></script>

        <script>
            var request;
            function checkDateExist()
            {
                var v = document.form.century.value;
                var v1 = document.form.year.value;
                var v2 = document.form.month.value;
                var v3 = document.form.day.value;
                var v5 = document.form.id.value;
                var v4 = v + " " + v1 + " " + v2 + " " + v3 + " " + v5;
                var url = "EventDate?val=" + v4;

                if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    request = new ActiveXObject("Microsoft.XMLHTTP");
                }

                try {
                    request.onreadystatechange = getInfo;
                    request.open("GET", url, true);
                    request.send();
                } catch (e) {
                    alert("Unable to connect to server");
                }
            }

            function getInfo() {
                if (request.readyState == 4) {
                    var val = request.responseText;
                    document.getElementById('error').innerHTML = val;
                    document.getElementById("text").value = val;
                }
            }
            function move() {
                var x = document.getElementById("text").value;
                if (x == "هذا التاريخ يحتوي علي حدث اختر تاريخ اخر") {
                    return false;
                }

                else {
                    return true;
                }
            }
        </script> 
    </head>
    <body>
        <div id="main_container">
            <div class="container" id="editProject">
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
                            <li><a href="mypage.jsp"><span class="glyphicon glyphicon-user"></span> الصفحة الشخصيه</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>           
                            <li><a href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> تسجيل الخروج</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>

                <%
                    Event e = new Event();
                    int year;
                    String project_id = request.getParameter("project_id");
                    //out.print(project_id);
                    if (project_id == null || project_id.equals("0")) {
                        response.sendRedirect("error.jsp");
                        return;
                    } else {
                        User user = new User();
                        user.setEmail((String) session.getAttribute("email"));
                        int logged_id = -1;
                        if (user.getEmail() != null) {
                            logged_id = user.getIdByEmail();
                        }
                        // out.print(logged_id);
                        if (logged_id == -1) {
                            response.sendRedirect("error.jsp");
                            return;
                        }
                        int is_user = e.is_user_project(Integer.parseInt(project_id), logged_id);
                        //out.print(is_user);
                        if (is_user <= 0) {
                            response.sendRedirect("error.jsp");
                            return;
                        }

                    }
                    year = Calendar.getInstance().get(Calendar.YEAR);
                %>
                <!-- edit form column -->
                <%
                    int id = Integer.parseInt(request.getParameter("project_id"));
                    Project project = new Project();
                    project.setProject_id(id);
                    project.setProjectDataUsingId();
                    //System.out.println(project.getName());
                    String[] alltTags = project.getProjectTags().split(" ");

                    User user = new User();
                    user.setUser_id(project.getOwnerID());
                    //get user data from database and set it in object
                    user.getUserInformation();

                    Event event = new Event();
                    ArrayList<Event> publishedEvents = event.getAllEvents(project.getProject_id());
                    publishedEvents = event.sortEventsAscending(publishedEvents);
                    Timeline timeline = new Timeline(publishedEvents);

                %>
                <!-- Edit Project -->
                <h1 class="page-header text-center">تعديل المشروع</h1>
                <div class="row">
                    <div class="col-md-10"></div>
                    <div class="col-md-1">
                        <a  href="viewProject.jsp?project_id=<%= project_id%>" class="btn btn-info pull-right"><i class="glyphicon glyphicon-eye-open"></i> عرض <span class=""> </span></a>
                    </div>
                    <div class="col-md-1">
                        <a  href="DeleteProjectServlet?project_id=<%= project_id%>"  class="btn btn-danger pull-right"><i class="glyphicon glyphicon-trash"></i> مسح <span class=""> </span></a>
                    </div>
                </div>
                <div class="row">
                    <br>
                    <!-- left column -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <form class="form-horizontal" 
                              action = "UpdateProjectPhotoServlet?project_id=<%= project_id%>" 
                              enctype="multipart/form-data" method="post" role="form">
                            <div class="text-center">
                                <img src='<%= project.getPhoto()%>' class="avatar img-circle img-thumbnail" alt="avatar" />
                                <h6>Upload a different photo...</h6>
                                <input type="file" class="text-center center-block well well-sm"  name='project_photo' id="project_photo" accept="image/*">
                                <input class="btn btn-success" value="Update Photo" type="submit">
                            </div>
                        </form>
                    </div>

                    <!-- edit form column -->
                    <div class="col-md-8 col-sm-6 col-xs-12 personal-info">

                        <h3>معلومات المشروع</h3>
                        <form class="form-horizontal" role="form" method = "post" 
                              action =<%= "\"UpdateProjectServlet?project_id=" + project.getProject_id() + "\""%> >


                            <div class="form-group">
                                <label class="col-lg-3 control-label">الاسم<span style="color: red">*</span></label>
                                <div class="col-lg-8">
                                    <input type="text" class="form-control" id="project_name"  name="project_name" value= "<%= project.getName()%>"    required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">الوصف<span style="color: red">*</span></label>
                                <div class="col-lg-8">
                                    <textarea 

                                        class="form-control"  rows="5" id="project_desc" name ="project_desc" required> <%= project.getProject_desc()%> </textarea>
                                </div>
                                <% if (project.getIs_published() > 0) {
                                %>                           </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label"></label>
                                <div class="col-lg-8">
                                    <input type="checkbox"  name="is_published" id="is_published" checked  > نشر </div>
                            </div>
                            <% } else { %> 

                            <div class="form-group">
                                <label class="col-lg-3 control-label"></label>
                                <div class="col-lg-8">
                                    <input type="checkbox"  name="is_published" id="is_published"   > نشر </div>
                            </div>
                            <% } %>

                            <div class="form-group">
                                <label class="col-md-3 control-label"></label>
                                <div class="col-md-8">
                                    <input class="btn btn-success" value="حفظ التعديلات" type="submit">
                                </div>
                            </div>

                        </form>
                        <br>
                    </div>




                </div>

                <div class="row">
                    <div class=" col-md-7">

                        <div class="form-group">
                            <div class="col-md-11">
                                <div class="panel panel-default">
                                    <div class="panel-heading">تاجات <a href="#" data-target="#tagsModal" data-toggle="modal" class="pull-right">إضافة تاجات ؟</a></div>
                                    <div class="panel-body">

                                        <div class="form-group category-container">
                                            <div class="col-lg-12 ">

                                                <%
                                                    for (int i = 0; i < alltTags.length; i++) {
                                                        if ((i + 1 % 5 == 0)) {
                                                %>
                                                <br>
                                                <%
                                                    }

                                                %>
                                                <span class="label label-info"> <%= alltTags[i]%></span>

                                                <%
                                                    }
                                                %>

                                            </div>



                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--modal-->
                        <div id="tagsModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" >
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h3 class="text-center">إضافة تاجات</h3>
                                    </div>
                                    <div class="modal-body">

                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <div class="text-center">

                                                    <p>أدخل التاج الخاص بالمشروع ثم اضغط إنتر لإدخال تاج اخر</p>
                                                    <div class="panel-body">
                                                        <form class="form"  method="post"
                                                              action =<%= "\"AddTagsServlet?project_id=" + request.getParameter("project_id") + "\""%>>
                                                            <fieldset>

                                                                <div class="form-group category-container">
                                                                    <div class="input-group">
                                                                        <label class="col-md-2 control-label">تاجات</label><br>
                                                                        <div class="col-md-10">
                                                                            <input type="text"  id="category" data-role="tagsinput"   name="category"  />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input class="btn btn-lg btn-primary btn-block" value="حفظ" type="submit">
                                                                </div>
                                                            </fieldset>
                                                        </form>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <div class="col-md-12">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true">إلغاء</button>
                                        </div>	
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">

                        <button type="button" class="btn btn-default pull-right" data-toggle="modal" data-target="#createEvent"> <i class="glyphicon glyphicon-new-window"></i> Add new event</button>                      

                        <!--modal-->
                        <div id="createEvent" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" >
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h1 class="text-center text-info">إضافة حدث جديد</h1>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="text-center">

                                                        <span id="error"> </span>  
                                                        <div class="panel-body">
                                                            <form class="form" name="form" onsubmit="return move()" action="setEvent?project_id=<%=project_id%>" method="post">
                                                                <input type="text" name="id" value=<%=project_id%> hidden>
                                                                <fieldset>
                                                                    <div class="row">
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <select class="form-control" name="century" onchange="checkDateExist()" required>
                                                                                    <option value="BC"> ق.م </option>
                                                                                    <option value="AC" selected> ب.م </option>
                                                                                </select>
                                                                            </div>

                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <input type="number" class="form-control" id="year" 
                                                                                       min=1   name="year" placeholder="السنة" onchange="checkDateExist()" required/>
                                                                            </div>

                                                                        </div>

                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <select class="form-control" name="month" onchange="checkDateExist()" required>
                                                                                    <option value=""> الشهر </option>
                                                                                    <option value="January">يناير</option>
                                                                                    <option value="February">فبراير</option>
                                                                                    <option value="March">مارس</option>
                                                                                    <option value="April">إبريل</option>
                                                                                    <option value="May">مايو</option>
                                                                                    <option value="June">يونيو</option>
                                                                                    <option value="July">يوليو</option>
                                                                                    <option value="August">اغسطس</option>
                                                                                    <option value="September">سبتمبر</option>
                                                                                    <option value="October">اكتوبر</option>
                                                                                    <option value="November">نوفمبر</option>
                                                                                    <option value="December">ديسمبر</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <select name="day" class="form-control"  onchange="checkDateExist()" required>
                                                                                    <option value="">اليوم</option>
                                                                                    <option value="1">1</option>
                                                                                    <option value="2">2</option>
                                                                                    <option value="3">3</option>
                                                                                    <option value="4">4</option>
                                                                                    <option value="5">5</option>
                                                                                    <option value="6">6</option>
                                                                                    <option value="7">7</option>
                                                                                    <option value="8">8</option>
                                                                                    <option value="9">9</option>
                                                                                    <option value="10">10</option>
                                                                                    <option value="11">11</option>
                                                                                    <option value="12">12</option>
                                                                                    <option value="13">13</option>
                                                                                    <option value="14">14</option>
                                                                                    <option value="15">15</option>
                                                                                    <option value="16">16</option>
                                                                                    <option value="17">17</option>
                                                                                    <option value="18">18</option>
                                                                                    <option value="19">19</option>
                                                                                    <option value="20">20</option>
                                                                                    <option value="21">21</option>
                                                                                    <option value="22">22</option>
                                                                                    <option value="23">23</option>
                                                                                    <option value="24">24</option>
                                                                                    <option value="25">25</option>
                                                                                    <option value="26">26</option>
                                                                                    <option value="27">27</option>
                                                                                    <option value="28">28</option>
                                                                                    <option value="29">29</option>
                                                                                    <option value="30">30</option>
                                                                                    <option value="31">31</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <span id="error" ></span> 
                                                                    <input type="text" name="text" id="text" hidden >


                                                                    <div class="form-group">
                                                                        <input class="btn btn-center btn-info" value="إضافة الحدث" type="submit"

                                                                               >
                                                                    </div>
                                                                </fieldset>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <div class="col-md-12">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true">إلغاء</button>
                                        </div>	
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr>


                <div class="row">

                    <div class="col-md-6">
                        <h3 class="text-info text-center"> احداث المشروع </h3>
                    </div>
                    <div class="col-md-6">
                        <h3 class="text text-primary pull-right"> الخط الزمني للمشروع</h3>
                    </div>

                </div>

                <br>

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
                            <a href="editEvent.jsp?event_id=<%= publishedEvents.get(index).getEvent_id()%>" class="btn btn-info" role="button">تعديل الحدث </a>

                            <br><br>
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
                                        <a data-toggle="collapse" href="<%= "#" + curYear%>" > <%= (curYear > 0 ? curYear : (-1 * curYear) + "      ق.م")%> </a>
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
                                                <div class="col-md-10 col-md-offset-2">
                                                    <a href="<%= "#" + curYear + "-" + month_string + "-" + days.get(i)%>" id="<%= curYear + "-" + month_string + "-" + days.get(i)%>" class="view_event_anchor"> <%= days.get(i)%> </a>
                                                </div>
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
                <!--end of content tag -->
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