<%@page import="javax.mail.Session"%>
<%@page import="java.util.Vector"%>
<%@page import="Model.Project"%>
<%@page import="Model.User"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>صفحة المستخدم</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/project_sytle.css" rel="stylesheet" type="text/css">

    </head>
    <body>
        <div id="main_container">
            <div class="container" id="about">
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

                <!-- Write Your data here only -->
                <br>
                <br>
                <div class="row">
                    <div class="col-md-7">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 lead"> انواع المشاريع <span class="glyphicon glyphicon-dashboard"></span> <hr></div>
                                </div>
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#recent_projects" data-toggle="tab" >الحالية</a></li>
                                    <li><a href="#top_projects" data-toggle="tab" >الافضل</a></li>
                                    <li><a href="#all_projects" data-toggle="tab" >الكل</a></li>
                                </ul>

                                <div class="tab-content">
                                    <div id="recent_projects" class="tab-pane fade in active">

                                        <div class="tab-pane" id="recent_projects_content">

                                            <br>
                                            <h3 class="text text-primary text-center"> قائمة المشاريع الحاليه</h3><hr>
                                            <section class="comment-list">



                                                <%
                                                    User user = new User();
                                                    String user_id_string = request.getParameter("user_id");
                                                    //request.getParameter("user_id");
                                                    if (user_id_string == null) {
                                                        response.sendRedirect("error.jsp");
                                                        return;
                                                    }
                                                    int user_id = Integer.parseInt(user_id_string);
                                                    user.setEmail((String) session.getAttribute("email"));
                                                    int logged_id = -1;
                                                    if (user.getEmail() != null) {
                                                        logged_id = user.getIdByEmail();
                                                    }
                                                    int check = user.check_user_id(Integer.toString(user_id));
                                                    System.out.println("check" + check);
                                                    Vector<Project> projects = new Vector<Project>();
                                                    if (check == -1) {
                                                        response.sendRedirect("error.jsp");
                                                        return;

                                                    }
                                                    System.out.println("Projectssize" + projects.size());
                                                    Project project = new Project();
                                                    projects = project.getProject(user_id);
                                                    if (projects.size() != 0) {

                                                        System.out.println("Projectssize" + projects.size());

                                                        for (int i = projects.size() - 1; i >= 0; i--) {


                                                %>
                                                <article class="row">

                                                    <div class="col-md-12 col-sm-12">
                                                        <div class="panel panel-default arrow left">
                                                            <div class="panel-body">
                                                                <header>
                                                                    <div class="text-left">
                                                                        <i class="fa fa-user"></i> <span class="glyphicon glyphicon-time"></span> <small><em><%=projects.get(i).getCreation_date()%></em></small>
                                                                    </div>
                                                                    <div class="text-right">
                                                                        <i class="fa fa-user"></i><span class="badge"><%= i + 1%></span>
                                                                    </div>
                                                                </header>





                                                                <div class="comment-post">
                                                                    <h3 class="text text-left text-primary"><%=projects.get(i).getName()%></h3>
                                                                    <p>
                                                                        <%=projects.get(i).getProject_desc()%>
                                                                    </p>
                                                                    <a href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%> ><img width="700" height="700" class="img-responsive" src= <%=projects.get(i).getPhoto()%>  /></a>
                                                                </div>
                                                                <br>
                                                                <p class="text-right"> 
                                                                    <span class="glyphicon glyphicon-thumbs-up"></span> <small><em><%=projects.get(i).getLikes()%> </em></small>
                                                                    <br>
                                                                    <span class="glyphicon glyphicon-eye-open"></span> <small><em><%=projects.get(i).getViews()%></em></small>
                                                                </p>

                                                                <br>
                                                                <div class="row">
                                                                    <div class="col-md-2"></div>
                                                                    <% if (logged_id == user_id) {%>
                                                                    <div class="col-md-3">
                                                                        <!--   <a  href="DisplayAccountServlet" class="btn btn-default pull-right"><i class="glyphicon glyphicon-pencil"></i> Edit <span class=""> </span></a> -->
                                                                        <a  href=<%= "\"editProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-default btn-block"><i class="glyphicon glyphicon-pencil"></i> تعديل <span class=""> </span></a>
                                                                    </div>
                                                                    <%
                                                                        }%>
                                                                    <div class="col-md-2"></div>
                                                                    <% if (logged_id == user_id) {%>
                                                                    <div class="col-md-3">
                                                                        <a  href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-info btn-block"><i class="glyphicon glyphicon-play-circle"></i> عرض <span class=""> </span></a>
                                                                    </div>
                                                                    <%
                                                                        }%>
                                                                    <div class="col-md-2"></div>


                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </article>
                                                <%
                                                    }


                                                %>  
                                            </section>

                                        </div><!--recent_projects -->   


                                    </div>

                                    <div id="top_projects" class="tab-pane fade">
                                        <div class="tab-pane" id="recent_projects_content">

                                            <br>
                                            <h3 class="text text-primary text-center"> قائمة افضل المشاريع</h3><hr>
                                            <section class="comment-list">
                                                <%                                                    if (check != -1) {
                                                        for (int c = 0; c < projects.size() - 1; c++) {
                                                            for (int d = 0; d < projects.size() - c - 1; d++) {
                                                                if (projects.get(d).getViews() < projects.get(d + 1).getViews()) /* For descending order use < */ {
                                                                    Project swap = new Project();
                                                                    swap = projects.get(d);
                                                                    projects.set(d, projects.get(d + 1));

                                                                    projects.set(d + 1, swap);

                                                                }
                                                            }
                                                        }
                                                        System.out.println("views" + projects.get(0).getViews());

                                                        for (int i = 0; i < projects.size(); i++) {
                                                %>
                                                <!--  project 1 -->
                                                <article class="row">

                                                    <div class="col-md-12 col-sm-12">
                                                        <div class="panel panel-default arrow left">
                                                            <div class="panel-body">
                                                                <header>
                                                                    <div class="text-left">
                                                                        <i class="fa fa-user"></i> <span class="glyphicon glyphicon-time"></span> <small><em></em><%=projects.get(i).getCreation_date()%></small>
                                                                    </div>
                                                                    <div class="text-right">
                                                                        <i class="fa fa-user"></i><span class="badge"><%= i + 1%></span>
                                                                    </div>
                                                                </header>
                                                                <div class="comment-post">
                                                                    <h3 class="text text-left text-primary"><%=projects.get(i).getName()%></h3>
                                                                    <p>
                                                                        <%=projects.get(i).getProject_desc()%>
                                                                    </p>
                                                                    <a href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%> > <img width="700" height="700" class="img-responsive" src=<%=projects.get(i).getPhoto()%>    /></a>
                                                                </div>
                                                                <br>
                                                                <p class="text-right"> 
                                                                    <span class="glyphicon glyphicon-thumbs-up"></span> <small><em><%=projects.get(i).getLikes()%> </em></small>
                                                                    <br>
                                                                    <span class="glyphicon glyphicon-eye-open"></span> <small><em><%=projects.get(i).getViews()%></em></small>
                                                                </p>

                                                                <br>
                                                                <div class="row">
                                                                    <div class="col-md-2"></div>
                                                                    <div class="col-md-3">
                                                                        <a  href=<%= "\"editProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-default btn-block"><i class="glyphicon glyphicon-pencil"></i> تعديل <span class=""> </span></a>
                                                                    </div>
                                                                    <div class="col-md-2"></div>
                                                                    <div class="col-md-3">

                                                                        <a  href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-info btn-block"><i class="glyphicon glyphicon-play-circle"></i> عرض <span class=""> </span></a>
                                                                    </div>
                                                                    <div class="col-md-2"></div>


                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </article>
                                                <%
                                                        }

                                                    }
                                                %>


                                                <div class="text-center">
                                                    <ul class="pager ">
                                                        <li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span> السابق</a></li>
                                                        <li><a href="#">التالي <span class="glyphicon glyphicon-chevron-right"> </span></a></li>
                                                    </ul>
                                                </div>

                                            </section>


                                        </div><!--recent_projects -->


                                    </div>
                                    <div id="all_projects" class="tab-pane fade">

                                        <div class="tab-pane" id="recent_projects_content">

                                            <br>
                                            <h3 class="text text-primary text-center"> قائمة جميع المشاريع</h3><hr>
                                            <section class="comment-list">
                                                <!-- project 1-->
                                                <%
                                                    if (check != -1) {
                                                        for (int i = 0; i < projects.size(); i++) {

                                                %>

                                                <article class="row">

                                                    <div class="col-md-12 col-sm-12">
                                                        <div class="panel panel-default arrow left">
                                                            <div class="panel-body">
                                                                <header>
                                                                    <div class="text-left">
                                                                        <i class="fa fa-user"></i> <span class="glyphicon glyphicon-time"></span> <small><em><%=projects.get(i).getCreation_date()%></em></small>
                                                                    </div>
                                                                    <div class="text-right">
                                                                        <i class="fa fa-user"></i><span class="badge"><%= i + 1%></span>
                                                                    </div>
                                                                </header>

                                                                <div class="comment-post">
                                                                    <h3 class="text text-left text-primary"><%=projects.get(i).getName()%></h3>
                                                                    <p>
                                                                        <%=projects.get(i).getProject_desc()%>
                                                                    </p>
                                                                    <a href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%> ><img width="700" height="700" class="img-responsive" src=<%=projects.get(i).getPhoto()%>  /></a>
                                                                </div>
                                                                <br>
                                                                <p class="text-right"> 
                                                                    <span class="glyphicon glyphicon-thumbs-up"></span> <small><em><%=projects.get(i).getLikes()%> </em></small>
                                                                    <br>
                                                                    <span class="glyphicon glyphicon-eye-open"></span> <small><em><%=projects.get(i).getViews()%></em></small>
                                                                </p>

                                                                <br>
                                                                <div class="row">
                                                                    <div class="col-md-2"></div>
                                                                    <div class="col-md-3">
                                                                        <a  href=<%= "\"editProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-default btn-block"><i class="glyphicon glyphicon-pencil"></i> تعديل <span class=""> </span></a>
                                                                    </div>
                                                                    <div class="col-md-2"></div>
                                                                    <div class="col-md-3">

                                                                        <a  href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%>class="btn btn-info btn-block"><i class="glyphicon glyphicon-play-circle"></i> عرض <span class=""> </span></a>
                                                                    </div>
                                                                    <div class="col-md-2"></div>


                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </article>

                                                <%
                                                            }
                                                        }
                                                    }
                                                %>


                                                <div class="text-center">
                                                    <ul class="pager ">
                                                        <li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span> السابق</a></li>
                                                        <li><a href="#">التالي <span class="glyphicon glyphicon-chevron-right"> </span></a></li>
                                                    </ul>
                                                </div>

                                            </section>


                                        </div><!--recent_projects -->


                                    </div>
                                </div>


                            </div>

                        </div>
                    </div>
                
                <div class="col-md-5">

                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-12 lead">الصفحة الشخصية <span class="glyphicon glyphicon-user"> </span> <hr> </div>
                            </div>
                            <div class="row">
                                <div class="col-md-8">
                                    <%
                                        user = user.GetUserByUserId(Integer.toString(user_id));
                                    %>
                                    <blockquote>
                                        <h2 class="text text-primary"><%=user.getName()%></h2>
                                        <p><small><%=user.getUser_desc()%></small></p>
                                        <small><cite title=""><%=user.getCountry()%> ,<%=user.getCity()%><i class="glyphicon glyphicon-map-marker"></i></cite></small>

                                    </blockquote>
                                    <p> <i class="glyphicon glyphicon-envelope"></i> <%=user.getEmail()%><br> </p>
                                    <p> <i class="glyphicon glyphicon-user"></i><%=user.getGender()%> <br> </p>
                                    <p> <i class="glyphicon glyphicon-thumbs-up"></i> 12,689 <br> </p>
                                    <p> <i class="glyphicon glyphicon-eye-open"></i> 712,289 <br> </p>



                                </div><!--/col-->          
                                <div class=" col-md-4 text-center">
                                    <div>
                                        <img src=<%=user.getPhoto()%> alt="" class="center-block img-circle img-responsive">
                                        <ul class="list-inline ratings text-center" title="">
                                            <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                            <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                            <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                            <li><span class="glyphicon glyphicon-star-empty"></span></li>
                                        </ul>
                                    </div>

                                </div><!--/col-->
                            </div><!--/row-->
                            <% if (logged_id == user_id) {%>
                            <div class="row">
                                <div class="col-md-12">

                                    <a  href="DisplayAccountServlet" class="btn btn-default pull-right"><i class="glyphicon glyphicon-pencil"></i> تعديل <span class=""> </span></a>
                                </div>
                            </div>
                            <% }%>
                        </div><!--/panel-body-->
                    </div><!--/panel-->

                    <% if (logged_id == user_id) {%>
                    <!-- Create Project-->
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-12 lead"><h3 class="text text-center">إنشاء مشروع جديد</h3> <hr> </div>
                                <div class="col-md-12">
                                    <form class="form-horizontal" role="form" action="CreateProjectServlet?user_id=<%=user.getUser_id()%>" method="post">

                                        <div class="form-group">
                                            <div class="col-md-3"><label class="control-label col-sm-2" for="Name">الاسم</label></div>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" id="project_name" name="project_name" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-3"><label for="Description">الوصف</label></div>
                                            <div class="col-md-9">
                                                <textarea class="form-control" placeholder="Enter project description" id="project_desc" name="project_desc" required> </textarea>
                                            </div>


                                        </div>

                                        <div class="form-group"> 
                                            <div class="col-md-3"></div>
                                            <div class="col-md-9">
                                                <div class="text text-center"><button type="submit" class="btn btn-success">إنشاء</button></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }%>

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
                        <a rel="nofollow" href="#" target="_parent">
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
    <!-- Hiding text overflow: http://stackoverflow.com/questions/15308061/how-to-avoid-text-overflow-in-twitter-bootstrap -->

</body>
</html>