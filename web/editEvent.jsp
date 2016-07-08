<%@page import="Model.Marker"%>
<%@page import="Model.Polyline"%>
<%@page import="Model.Polygon"%>
<%@page import="Model.Circle"%>
<%@page import="Model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Event"%>
<%@page import="java.util.Calendar"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>  تعديل الحدث</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/map_syle.css" rel="stylesheet" type="text/css">

    </head>
    <body>

        <div id="main_container">
            <div class="container" id="editEvent">
                <div class="header">
                    <div class="navbar-header">
                        <a href="index.jsp"><img src="images/histopedia-logo.gif" alt="fantasy" class="histopedia-logo"></a>
                    </div>
                    <%
                        User user = new User();
                        user.setEmail((String) session.getAttribute("email"));
                        int user_id = -1;
                        if (user.getEmail() != null) {
                            user_id = user.getIdByEmail();
                        }

                        if (user_id == -1) {
                            response.sendRedirect("error.jsp");
                            return;
                        }

                        Event event = new Event();
                        int id_project = -1;
                        String id = request.getParameter("event_id");

                        if (id == null || id.equals("0")) {
                            response.sendRedirect("error.jsp");
                            return;
                        } else {
                            id_project = event.getProject_id(Integer.parseInt(id));

                            if (id_project <= 0) {
                                response.sendRedirect("error.jsp");
                                return;
                            } else {
                                int ownerOfProject = event.is_user_event(id_project, user_id);

                                if (ownerOfProject <= 0) {
                                    response.sendRedirect("error.jsp");
                                    return;
                                }
                            }

                        }

                        event = event.getEvent(Integer.parseInt(id));
                    %> 
                    <form  action="getSearchValue" method="get" class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="..بحث" id="keyword" name="keyword">
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
                            <li><a href="mypage.jsp"><span class="glyphicon glyphicon-user"></span> الشخصيه</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>           
                            <li><a href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> تسجيل الخروج</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>

                <!-- Edit Project -->
                <h1 class="page-header text-center">تعديل الحدث</h1>
                <div class="row">
                    <div class="col-md-8"></div>
                    <div class="col-md-2">

                        <a  href="editProject.jsp?project_id=<%=id_project%>" class="btn btn-default pull-right"><i class="glyphicon glyphicon-pencil"></i> عوده للمشروع <span class=""> </span></a>

                    </div>
                    <div class="col-md-2">
                        <a  href="DeleteEvent?event_id=<%=id%>" class="btn btn-danger pull-right"><i class="glyphicon glyphicon-trash"></i> مسح الحدث <span class=""> </span></a>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-md-9">
                        <div class="panel panel-default">

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead text-info">  <span class="glyphicon glyphicon-globe"></span> احداثيات الخريطه <hr></div>
                                </div>
                                <form name="coordinateForm" class="form-horizontal" role="form" 
                                      onsubmit="return checkEmptyField()" action="SaveCoordinates?event_id=<%=id%>"
                                      method="post"
                                      >
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-3"><label for="loc_lat"> الطول</label></div>
                                                    <div class="col-md-9">
                                                        <input type="text" class="form-control"  value="<%= event.getLat()%>" name = "loc_lat" id="loc_lat" readonly="readonly" >
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-3"><label for="loc_lng"> العرض</label></div>
                                                    <div class="col-md-9">
                                                        <input type="text" class="form-control" value="<%= event.getLng()%>" name = "loc_lng" id="loc_lng" readonly="readonly">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-3"><label for="zoom">زووم</label></div>
                                                    <div class="col-md-9">
                                                        <input type="text" value="<%= event.getMap_zoom_level()%>" class="form-control" name="zoom" id="zoom" readonly="readonly">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div id="editEventMap" style="height:380px;"></div>
                                    </div>

                                    <br>

                                    <div class="row">
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-success">حفظ الاحداثيات</button>
                                        </div>

                                    </div>

                                </form>



                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead text-info">  <span class="glyphicon glyphicon-calendar"></span> الخط الزمني <hr></div>
                                </div>

                                <form class="form" method="post" 
                                      action="updateEventDate?event_id=<%=id%>">

                                    <%

                                        String eventDate = event.getEventDate(Integer.parseInt(id));

                                        String[] date = eventDate.split(" ");
                                        String century = "AC";
                                        String mth = event.nameOfMonth(Integer.parseInt(date[1]) - 1);
                                        String dy = date[0];
                                        int yr = Integer.parseInt(date[2]);
                                        if (yr < 0) {
                                            century = "BC";
                                            yr *= -1;
                                        }
                                        int isChecked = event.is_published(Integer.parseInt(id));
                                        //out.print(isChecked);
                                    %>
                                    <fieldset>
                                        <div class="form-group">
                                            <label for="century">الحقبه</label>
                                            <select class="form-control"  name="century" required>

                                                <option value="AC" <%if (century.equals("AC")) {
                                                        out.println("selected");
                                                    } %>> ب.م </option>

                                                <option  value="BC"<%if (century.equals("BC")) {
                                                        out.println("selected");
                                                    } %> > ق.م </option>
                                            </select>  
                                        </div>
                                        <%
                                            int year;
                                            year = Calendar.getInstance().get(Calendar.YEAR);
                                        %>
                                        <div class="form-group">
                                            <label for="year">السنه</label>
                                            <input type="number" class="form-control" min=1 id="year" required name="year" value="<%=yr%>"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="month" >الشهر</label>
                                            <select class="form-control" name="month" required>
                                                <option value=""> - Month - </option>
                                                <option value="January" <%if (mth.equals("January")) {
                                                        out.println("selected");
                                                    } %>>يناير</option>
                                                <option value="February" <%if (mth.equals("February")) {
                                                        out.println("selected");
                                                    } %>>فبراير</option>
                                                <option value="March" <%if (mth.equals("March")) {
                                                        out.println("selected");
                                                    } %>>مارس</option>
                                                <option value="April" <%if (mth.equals("April")) {
                                                        out.println("selected");
                                                    } %>>ابريل</option>
                                                <option value="May" <%if (mth.equals("May")) {
                                                        out.println("selected");
                                                    } %>>مايو</option>
                                                <option value="June" <%if (mth.equals("June")) {
                                                        out.println("selected");
                                                    } %>>يوليو</option>
                                                <option value="July" <%if (mth.equals("July")) {
                                                        out.println("selected");
                                                    } %>>يونيو</option>
                                                <option value="August" <%if (mth.equals("August")) {
                                                        out.println("selected");
                                                    } %>> اغسطس</option>
                                                <option value="September" <%if (mth.equals("September")) {
                                                        out.println("selected");
                                                    } %>>سبتمبر</option>
                                                <option value="October" <%if (mth.equals("October")) {
                                                        out.println("selected");
                                                    } %>>اكتوبر</option>
                                                <option value="November" <%if (mth.equals("November")) {
                                                        out.println("selected");
                                                    } %>>نوفمبر</option>
                                                <option value="December" <%if (mth.equals("December")) {
                                                        out.println("selected");
                                                    } %>>ديسمبر</option>
                                            </select>
                                        </div>


                                        <div class="form-group">
                                            <label for="day"> اليوم</label>
                                            <select name="day" class="form-control" required>
                                                <option value=""> - Day -</option>
                                                <option value="1" <%if (dy.equals("1")) {
                                                        out.println("selected");
                                                    } %> >1</option>
                                                <option value="2"  <%if (dy.equals("2")) {
                                                        out.println("selected");
                                                    } %> >2</option>
                                                <option value="3"  <%if (dy.equals("3")) {
                                                        out.println("selected");
                                                    } %> >3</option>
                                                <option value="4"  <%if (dy.equals("4")) {
                                                        out.println("selected");
                                                    } %> >4</option>
                                                <option value="5" <%if (dy.equals("5")) {
                                                        out.println("selected");
                                                    } %> >5</option>
                                                <option value="6"<%if (dy.equals("6")) {
                                                        out.println("selected");
                                                    } %> >6</option>
                                                <option value="7" <%if (dy.equals("7")) {
                                                        out.println("selected");
                                                    } %> >7</option>
                                                <option value="8"<%if (dy.equals("8")) {
                                                        out.println("selected");
                                                    } %> >8</option>
                                                <option value="9"<%if (dy.equals("9")) {
                                                        out.println("selected");
                                                    } %> >9</option>
                                                <option value="10"<%if (dy.equals("10")) {
                                                        out.println("selected");
                                                    } %> >10</option>
                                                <option value="11"<%if (dy.equals("11")) {
                                                        out.println("selected");
                                                    } %> >11</option>
                                                <option value="12"<%if (dy.equals("12")) {
                                                        out.println("selected");
                                                    } %> >12</option>
                                                <option value="13"<%if (dy.equals("13")) {
                                                        out.println("selected");
                                                    } %> >13</option>
                                                <option value="14"<%if (dy.equals("14")) {
                                                        out.println("selected");
                                                    } %> >14</option>
                                                <option value="15"<%if (dy.equals("15")) {
                                                        out.println("selected");
                                                    } %> >15</option>
                                                <option value="16"<%if (dy.equals("16")) {
                                                        out.println("selected");
                                                    } %> >16</option>
                                                <option value="17"<%if (dy.equals("17")) {
                                                        out.println("selected");
                                                    } %> >17</option>
                                                <option value="18"<%if (dy.equals("18")) {
                                                        out.println("selected");
                                                    } %> >18</option>
                                                <option value="19"<%if (dy.equals("19")) {
                                                        out.println("selected");
                                                    } %> >19</option>
                                                <option value="20"<%if (dy.equals("20")) {
                                                        out.println("selected");
                                                    } %>  >20</option>
                                                <option value="21"<%if (dy.equals("21")) {
                                                        out.println("selected");
                                                    } %> >21</option>
                                                <option value="22"<%if (dy.equals("22")) {
                                                        out.println("selected");
                                                    } %> >22</option>
                                                <option value="23"<%if (dy.equals("23")) {
                                                        out.println("selected");
                                                    } %> >23</option>
                                                <option value="24"<%if (dy.equals("24")) {
                                                        out.println("selected");
                                                    } %> >24</option>
                                                <option value="25"<%if (dy.equals("25")) {
                                                        out.println("selected");
                                                    } %> >25</option>
                                                <option value="26"<%if (dy.equals("26")) {
                                                        out.println("selected");
                                                    } %> >26</option>
                                                <option value="27"<%if (dy.equals("27")) {
                                                        out.println("selected");
                                                    } %> >27</option>
                                                <option value="28"<%if (dy.equals("28")) {
                                                        out.println("selected");
                                                    } %> >28</option>
                                                <option value="29"<%if (dy.equals("29")) {
                                                        out.println("selected");
                                                    } %> >29</option>
                                                <option value="30"<%if (dy.equals("30")) {
                                                        out.println("selected");
                                                    } %> >30</option>
                                                <option value="31"<%if (dy.equals("31")) {
                                                        out.println("selected");
                                                    }%> >31</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <div class="checkbox">
                                                <label><input type="checkbox" name="Publish" 
                                                              <% if (isChecked == 1) {
                                                                      out.print("checked");
                                                                  }%>      
                                                              > نشر</label>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <input class="btn btn-success" value="حفظ التعديلات" type="submit">
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>

                <br>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead text-info">  <span class="glyphicon glyphicon-globe"></span> بيانات الخريطه <hr></div>
                                </div>
                                <div class="row">

                                    <!-- Map Ahmed Said -->


                                    <div id="ahmed" >
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#infowindow_modal">
                                            <span class="glyphicon glyphicon-comment" id="indode"> اضافه البيانات</span>
                                        </button> 

                                        <button type="submit" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-trash" id="delete-button"> مسح الشكل</span>
                                        </button> 

                                        <button type="submit" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-trash" id="de"> مسح العلامه</span>

                                        </button> 
                                        <!-- <div id="c"></div> -->
                                        <button type="submit" class="btn btn-default btn-sm" id="panel"> 
                                            <div id="color-palette"></div>
                                            <input id = "colorr" class="jscolor" value="ab2567"  style="width: 60px" readonly>
                                        </button>

                                    </div>

                                    <!-- Modal -->
                                    <div id="infowindow_modal" class="modal fade" role="dialog">
                                        <div class="modal-dialog modal-lg">

                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">اضافه معلومات للعلامه</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label for="marker id"> رقم العلامه</label>
                                                        <input type="number" class="form-control" id="title">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="content">المحتوي</label>
                                                        <textarea  class="form-control" id="textupdate"></textarea>
                                                    </div>
                                                    <div class="text text-center">
                                                        <div class="btn-group">
                                                            <button type="button" class="btn btn-primary" id="update" data-dismiss="modal">اضافه</button>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="map" style="height: 400px;"></div>


                                    <form action ="drawing" method ="POST">
                                        <textarea rows="4" cols="50" extarea   id="circletextarea" name ="circle" rows="8" cols="40" hidden>   </textarea>
                                        <textarea rows="4" cols="50" extarea   id="polygon" name ="polygon" rows="8" cols="40" hidden>   </textarea>
                                        <textarea rows="4" cols="50" extarea   id="polygoncordinats" name ="polygoncordinats" rows="8" cols="40" hidden>   </textarea>
                                        <textarea rows="4" cols="50" extarea   id="polylinetextarea" name ="polyline" rows="8" cols="40" hidden>   </textarea>
                                        <textarea rows="4" cols="50" extarea   id="polylinecordinats" name ="polylinecordinats" rows="8" cols="40" hidden>   </textarea>
                                        <textarea rows="4" cols="50" extarea   id="markertextarea" name ="marker" rows="8" cols="40" hidden>   </textarea>
                                        <input type="text" name = "event_id" value="<%= request.getParameter("event_id")%>"  hidden />
                                        <textarea rows="4" cols="50" extarea   id="info" name ="info" rows="8" cols="40" hidden>   </textarea>
                                        <br>
                                        <div class="text-center"><input type = "submit" id="savebutton" class="btn btn-success btn-lg" value ="حفظ" > </div>  


                                    </form>


                                    <!-- Map Ahmed Said -->
                                </div>
                            </div>
                        </div>    
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead text-info">  <span class="glyphicon glyphicon-pencil"></span> تفاصيل الحدث <hr></div>
                                </div>
                                <div class="row">
                                    <!-- Editor -->

                                    <%

                                        Event eventobject = new Event();
                                        eventobject = event.getEvent(Integer.parseInt(request.getParameter("event_id")));


                                    %>

                                    <form role="form" action="updatetexteditor?event_id=<%= eventobject.getEvent_id()%>" method="post">
                                        <div class="form-group">
                                            <textarea class="form-control" id="editor" name="editor"></textarea>
                                        </div>
                                        <div class="text-center">
                                            <input type="submit" value="حفظ"  class="btn btn-success btn-lg">
                                        </div>
                                    </form>
                                    <div contenteditable="true" hidden="true" id="divid"><%=eventobject.getDetails()%></div>


                                </div>

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
        <script src="//cdn.ckeditor.com/4.5.9/full/ckeditor.js"></script> 
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=drawing&language=ar"></script>
        <script type="text/javascript" src ="js/jscolor.min.js"></script>
        <script type="text/javascript">
                                          var circles = [];
                                          var polygons = [];
                                          var polylines = [];
                                          var rectangls = [];
                                          var markers = [];
                                          var drawingManager;
                                          var selectedShape;
                                          var colors = [];
                                          var selectedColor;
                                          var x = 0;
                                          var info = [];
                                          function clearSelection() {
                                              if (selectedShape) {
                                                  selectedShape.setEditable(false);
                                                  selectedShape = null;
                                              }
                                          }
                                          function setSelection(shape) {
                                              clearSelection();
                                              selectedShape = shape;
                                              shape.setEditable(true);
                                              selectColor(shape.get('fillColor') || shape.get('strokeColor'));
                                          }
                                          function deleteSelectedShape() {

                                              if (selectedShape) {
                                                  selectedShape.setMap(null);
                                                  if (selectedShape.type == google.maps.drawing.OverlayType.CIRCLE) {
                                                      for (var i = 0; i < circles.length; i++) {
                                                          if (circles[i].getCenter() == selectedShape.getCenter() &&
                                                                  circles[i].getRadius() == selectedShape.getRadius()) {
                                                              circles.splice(i, 1);
                                                              break;
                                                          }
                                                      }
                                                  }
                                                  else if (selectedShape.type == google.maps.drawing.OverlayType.POLYGON) {
                                                      for (var i = 0; i < polygons.length; i++) {
                                                          if (polygons[i].getPath().getArray() == selectedShape.getPath().getArray()) {
                                                              polygons.splice(i, 1);
                                                              break;
                                                          }
                                                      }
                                                  }
                                                  else if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
                                                      for (var i = 0; i < polylines.length; i++) {
                                                          if (polylines[i].getPath().getArray() == selectedShape.getPath().getArray()) {
                                                              polylines.splice(i, 1);
                                                              break;
                                                          }
                                                      }
                                                  }

                                                  else if (selectedShape.type == google.maps.drawing.OverlayType.RECTANGLE) {
                                                      for (var i = 0; i < rectangls.length; i++) {
                                                          if (rectangls[i].getBounds() == selectedShape.getBounds()) {
                                                              rectangls.splice(i, 1);
                                                              break;
                                                          }
                                                      }
                                                  }

                                              }
                                          }



                                          function setSelectedShapeColor(color) {
                                              if (selectedShape) {
                                                  if (selectedShape.type == google.maps.drawing.OverlayType.POLYLINE) {
                                                      selectedShape.set('strokeColor', color);
                                                  } else {
                                                      selectedShape.set('fillColor', color);
                                                  }
                                              }
                                          }

                                          function makeButton(color) {
                                              var button = document.createElement('span');
                                              button.className = 'color-button';
                                              button.style.backgroundColor = color;
                                              google.maps.event.addDomListener(button, 'click', function () {
                                                  setSelectedShapeColor(color);
                                              });
                                              return button;
                                          }

                                          function buildColorPalette() {
                                              var colorPalette = document.getElementById('color-palette');
                                              for (var i = 0; i < colors.length; ++i) {
                                                  var currColor = colors[i];
                                                  var Button = makeButton(currColor);
                                                  colorPalette.appendChild(Button);
                                              }
                                          }
                                          function fun1() {
                                              var co = "#"
                                              var color = co + document.getElementById('colorr').value;
                                              setSelectedShapeColor(color);


                                          }
                                          function HomeControl(controlDiv, map) {

                                              var controlUI = document.getElementById('ahmed');

                                              controlDiv.appendChild(controlUI);
                                              var controlText = document.createElement('div');
                                              controlUI.appendChild(controlText);


                                          }


                                          function initialize() {

                                              var map = new google.maps.Map(document.getElementById('map'), {
                                                  zoom: <%= event.getMap_zoom_level()%>,
                                                  center: new google.maps.LatLng(<%= event.getLat()%>, <%= event.getLng()%>),
                                                  mapTypeId: google.maps.MapTypeId.ROADMAP,
                                                  zoomControl: true,
                                                  zoomControlOptions: {
                                                      style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
                                                      position: google.maps.ControlPosition.TOP_LEFT
                                                  },
                                                  disableDefaultUI: true,
                                                  zoomControl: true
                                              });



                                              var polyOptions = {
                                                  strokeColor: "#FF0000",
                                                  fillColor: "#0000FF",
                                                  strokeWeight: 2,
                                                  fillOpacity: 0.45,
                                                  strokeOpacity: 1,
                                                  editable: false, draggable: true
                                              };
                                              // Creates a drawing manager attached to the map that allows the user to draw
                                              // markers, lines, and shapes.
                                              drawingManager = new google.maps.drawing.DrawingManager({
                                                  markerOptions: {
                                                      draggable: true,
                                                      animation: google.maps.Animation.DROP
                                                  },
                                                  polylineOptions: {
                                                      editable: false,
                                                      draggable: true
                                                  },
                                                  rectangleOptions: polyOptions,
                                                  circleOptions: polyOptions,
                                                  polygonOptions: polyOptions,
                                                  drawingControlOptions: {
                                                      position: google.maps.ControlPosition.TOP_CENTER,
                                                      drawingModes: [
                                                          google.maps.drawing.OverlayType.MARKER,
                                                          google.maps.drawing.OverlayType.CIRCLE,
                                                          google.maps.drawing.OverlayType.POLYGON,
                                                          google.maps.drawing.OverlayType.POLYLINE

                                                      ]

                                                  },
                                              });

                                              /*  View previous data  added by sabry  */

            <%
                ArrayList<Circle> viewCircles = event.getCircles();
                for (int i = 0; i < viewCircles.size(); i++) {
            %>
                                              var circle = new google.maps.Circle({
                                                  center: new google.maps.LatLng(<%=viewCircles.get(i).getLat()%>,<%=viewCircles.get(i).getLng()%>),
                                                  radius:<%=viewCircles.get(i).getRadius()%>,
                                                  strokeColor: "<%=viewCircles.get(i).getStrokeColor()%>",
                                                  strokeOpacity:<%=viewCircles.get(i).getStrokeOpacity()%>,
                                                  strokeWeight:<%=viewCircles.get(i).getStrokeWeight()%>,
                                                  fillColor: "<%=viewCircles.get(i).getFillColor()%>",
                                                  fillOpacity:<%=viewCircles.get(i).getFillOpacity()%>,
                                                  editable: false,
                                                  draggable: false
                                              });

                                              circle.setMap(map);

            <%}%>
            <%
                ArrayList<Polygon> viewPolygons = event.getPolygons();
                for (int i = 0; i < viewPolygons.size(); i++) {
            %>
                                              var myTrip = [];
            <%
                String coor1 = viewPolygons.get(i).getCoordinates();
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
                                                  strokeColor: "<%=viewPolygons.get(i).getStrokeColor()%>",
                                                  strokeOpacity:<%=viewPolygons.get(i).getStrokeOpacity()%>,
                                                  strokeWeight:<%=viewPolygons.get(i).getStrokeWeight()%>,
                                                  fillColor: "<%=viewPolygons.get(i).getFillColor()%>",
                                                  fillOpacity:<%=viewPolygons.get(i).getFillOpacity()%>,
                                                  editable: false,
                                                  draggable: false
                                              });

                                              flightPath.setMap(map);


            <%}%>
            <%
                ArrayList<Polyline> viewPolylines = event.getPolylines();
                for (int i = 0; i < viewPolylines.size(); i++) {
            %>
                                              var myTrip = [];
            <%
                String coor1 = viewPolylines.get(i).getCoordinates();
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
                                                  strokeColor: "<%=viewPolylines.get(i).getStrokeColor()%>",
                                                  strokeOpacity:<%=viewPolylines.get(i).getStrokeOpacity()%>,
                                                  strokeWeight:<%=viewPolylines.get(i).getStrokeWeight()%>,
                                                  editable: false,
                                                  draggable: false
                                              });

                                              flightPath.setMap(map);


            <%}%>



            <%
                ArrayList<Marker> viewMarkers = event.getMarkers();
                for (int i = 0; i < viewMarkers.size(); i++) {
            %>
                                              var myCenter = new google.maps.LatLng(<%= viewMarkers.get(i).getLat()%>,<%= viewMarkers.get(i).getLng()%>);
                                              var marker = new google.maps.Marker({
                                                  position: myCenter,
                                                  editable: false,
                                                  draggable: false
                                              }
                                              );
                                              marker.setMap(map);
                                              var infowindow = new google.maps.InfoWindow({
                                                  content: "<%= viewMarkers.get(i).getTitle()%>"
                                              });
                                              infowindow.open(map, marker);
            <%}%>


                                              //

                                              //






                                              /* end of View previous data */


                                              drawingManager.setMap(map);

                                              google.maps.event.addListener(drawingManager, 'overlaycomplete', function (e) {
                                                  // if not marker 
                                                  if (e.type !== google.maps.drawing.OverlayType.MARKER) {
                                                      // drawingManager.setDrawingMode(null); 
                                                      //u3ni only one shap can draw from the same type.
                                                      // if you chose to draw circle for example then after finishing drawing  this
                                                      // one circle cursor is in a non-drawing mode (me4 hyrsam tany ) 
                                                      // so to draw another circle ==> chose from the menu circle and so on 
                                                      drawingManager.setDrawingMode(null);
                                                      // Add an event listener that selects the newly-drawn shape when the user
                                                      // mouses down on it.
                                                      var newShape = e.overlay;
                                                      newShape.type = e.type;
                                                      google.maps.event.addListener(newShape, 'click', function (e) {
                                                          setSelection(newShape);
                                                      });
                                                  }
                                                  // added by said 
                                                  if (e.type === google.maps.drawing.OverlayType.MARKER) {

                                                      e.overlay.setTitle(x.toString());


                                                      var infowindow = new google.maps.InfoWindow({
                                                          content: ""

                                                      });
                                                      info[parseInt(e.overlay.getTitle())] = "";
                                                      google.maps.event.addListener(e.overlay, 'click', function () {
                                                          if (info[parseInt(e.overlay.getTitle())] !== "") {

                                                              infowindow.open(map, e.overlay);
                                                          }
                                                      });
                                                      x++;
                                                      google.maps.event.addListener(e.overlay, 'mouseover', function () {
                                                          if (e.overlay.getTitle() === document.getElementById("title").value) {
                                                              infowindow.setContent(document.getElementById("textupdate").value);
                                                              infowindow.open(map, e.overlay);
                                                              info[parseInt(e.overlay.getTitle())] = document.getElementById("textupdate").value;
                                                              // alert(document.getElementById("textupdate").value);

                                                          }
                                                      });

                                                  }


                                                  /////////end said




                                              });
                                              // Clear the current selection when the drawing mode is changed, or when the
                                              // map is clicked.


                                              google.maps.event.addListener(drawingManager, 'markercomplete', function (marker) {

                                                  markers.push(marker);

                                              });

                                              google.maps.event.addDomListener(drawingManager, 'circlecomplete', function (circle) {
                                                  circles.push(circle);
                                              });
                                              google.maps.event.addDomListener(drawingManager, 'polygoncomplete', function (polygon) {
                                                  polygons.push(polygon);
                                              });
                                              google.maps.event.addDomListener(drawingManager, 'polylinecomplete', function (polyline) {
                                                  polylines.push(polyline);

                                              });



                                              google.maps.event.addDomListener(savebutton, 'click', function () {

                                                  document.getElementById("circletextarea").value = "";

                                                  for (var i = 0; i < circles.length; i++) {
                                                      var circleCenter = circles[i].getCenter();
                                                      var circleRadius = circles[i].getRadius();

                                                      document.getElementById("circletextarea").value +=
                                                              circleCenter.lat() + " " + circleCenter.lng();
                                                      document.getElementById("circletextarea").value += " " + circleRadius + " " +
                                                              circles[i].get('strokeColor') + " " + circles[i].get('strokeOpacity') +
                                                              " " + circles[i].get('strokeWeight') +
                                                              " " + circles[i].get('fillColor') + " " + circles[i].get('fillOpacity') + " ";
                                                  }

                                              });
                                              google.maps.event.addDomListener(savebutton, 'click', function () {


                                                  document.getElementById("polygon").value = "";
                                                  document.getElementById("polygoncordinats").value += "";
                                                  for (var i = 0; i < polygons.length; i++) {

                                                      var arr = polygons[i].getPath().getArray();
                                                      document.getElementById("polygon").value += "polygon" +
                                                              " " + polygons[i].get('strokeColor') + " " + polygons[i].get('strokeOpacity') +
                                                              " " + polygons[i].get('strokeWeight') + " " + polygons[i].get('fillColor') + " " + polygons[i].get('fillOpacity') + " ";

                                                      document.getElementById("polygoncordinats").value += arr + "his";
                                                  }

                                              });

                                              google.maps.event.addDomListener(savebutton, 'click', function () {

                                                  document.getElementById("polylinetextarea").value = "";
                                                  document.getElementById("polylinecordinats").value += "";
                                                  for (var i = 0; i < polylines.length; i++) {

                                                      var arr = polylines[i].getPath().getArray();

                                                      document.getElementById("polylinetextarea").value += "polyline" +
                                                              " " + polylines[i].get('strokeColor') + " " + polylines[i].get('strokeOpacity') +
                                                              " " + polylines[i].get('strokeWeight') + " " + polylines[i].get('fillColor') + " " + polylines[i].get('fillOpacity') + " ";
                                                      document.getElementById("polylinecordinats").value += arr + "his";


                                                  }

                                              });

                                              google.maps.event.addDomListener(savebutton, 'click', function () {
                                                  document.getElementById("markertextarea").value = "";
                                                  for (var i = 0; i < markers.length; i++) {
                                                      document.getElementById("markertextarea").value += markers[i].getPosition() + " ";
                                                  }
                                              });


                                              google.maps.event.addDomListener(savebutton, 'click', function () {
                                                  document.getElementById("info").value = "";
                                                  document.getElementById("info").value = info;
                                              });



                                              google.maps.event.addDomListener(document.getElementById('de'), 'click', deleteMarkers);

                                              google.maps.event.addListener(drawingManager, 'drawingmode_changed', clearSelection);
                                              google.maps.event.addListener(map, 'click', clearSelection);
                                              google.maps.event.addDomListener(document.getElementById('delete-button'), 'click', deleteSelectedShape);
                                              google.maps.event.addDomListener(document.getElementById('colorr'), 'change', fun1);
                                              buildColorPalette();
                                              fun1();
                                              var homeControlDiv = document.createElement('div');
                                              var homeControl = new HomeControl(homeControlDiv, map);
                                              map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);




                                          }


                                          function deleteMarkers() {

                                              for (var i = 0; i < markers.length; i++) {
                                                  markers[i].setMap(null);
                                                  markers[i] = null;
                                              }
                                              markers = [];



                                          }

                                          google.maps.event.addDomListener(window, 'load', initialize);


                                          // Abdo Gamal Part


                                          var editEventmap;
                                          var myCenter = new google.maps.LatLng(<%= event.getLat()%>, <%= event.getLng()%>);

                                          function initializeEditEvent()
                                          {
                                              var mapProp = {
                                                  center: myCenter,
                                                  zoom: <%= event.getMap_zoom_level()%>,
                                                  mapTypeId: google.maps.MapTypeId.ROADMAP

                                              };

                                              editEventmap = new google.maps.Map(document.getElementById("editEventMap"), mapProp);

                                              google.maps.event.addListener(editEventmap, 'click', function (event) {
                                                  placeMarker(event.latLng);
                                              });


                                          }
                                          var editEventmarker;
                                          function placeMarker(location) {
                                              if (editEventmarker) {
                                                  editEventmarker.setPosition(location);
                                              } else {
                                                  editEventmarker = new google.maps.Marker({
                                                      position: location,
                                                      map: editEventmap
                                                  });
                                              }
                                              document.getElementById("zoom").value = editEventmap.getZoom();
                                              editEventmap.addListener('zoom_changed', function () {
                                                  document.getElementById("zoom").value = editEventmap.getZoom();
                                              });
                                              document.getElementById("loc_lng").value = location.lng();
                                              document.getElementById("loc_lat").value = location.lat();

                                          }

                                          google.maps.event.addDomListener(window, 'load', initializeEditEvent);

                                          function checkEmptyField() {
                                              var lan = document.forms["coordinateForm"]["loc_lat"].value;
                                              var lon = document.forms["coordinateForm"]["loc_lng"].value;
                                              var zoom = document.forms["coordinateForm"]["zoom"].value;
                                              if (lan === null || lon === null || zoom === null) {
                                                  alert("please put marker on map")
                                                  return false;
                                              }
                                              if (lan === "" || lon === "" || zoom === "") {
                                                  alert("please put marker on map")
                                                  return false;
                                              }
                                              return true;
                                          }

        </script>

        <script>
            CKEDITOR.replace('editor', {height: 400});
            CKEDITOR.instances['editor'].setData(document.getElementById('divid').innerHTML);
            
        </script>


    </body>
</html>