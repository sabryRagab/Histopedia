<%@page import="Model.Search"%>
<%@page import="Model.Project"%>
<%@page import="Model.User"%>
<%@page import="java.util.Vector"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>نتائج البحث</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/project_sytle.css" rel="stylesheet" type="text/css">
        <link href="css/search_results.css" rel="stylesheet" type="text/css">

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

                            <%
                                User user = new User();
                                int logged_id = -1;
                                user.setEmail((String) session.getAttribute("email"));
                                if (user.getEmail() != null) {
                                    logged_id = user.getIdByEmail();
                                }
                                if (logged_id != -1) {
                                    user = user.GetUserByUserId(Integer.toString(logged_id));
                            %>
                            <li><a href=<%= "\"mypage.jsp?user_id=" + user.getUser_id() + "\""%>><span class="glyphicon glyphicon-user"><%=user.getName()%></span></a></li>
                                    <% } %>

                            <li><a href="index.jsp"><span class="glyphicon glyphicon-home"></span> الصفحة الرئيسية</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>


                            <%

                                if (logged_id != -1) {

                            %>
                            <li><a href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> تسجيل الخروج</a></li>
                                <% } %>
                                <%
                                    if (logged_id == -1) {

                                %>
                            <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> إنشاء حساب جديد</a></li> 
                                <% } %>

                        </ul>
                    </div> <!-- nav -->
                </div>
                <div class="container">


                    <h1 class="text text-center text-primary">نتائج البحث</h1>

                    <div class="panel panel-default">
                        <div class="panel-body">

                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#people" data-toggle="tab" > <span class="glyphicon glyphicon-user"></span> الاشخاص</a></li>
                                <li><a href="#projects" data-toggle="tab" > <span class="glyphicon glyphicon-dashboard"></span> المشاريع</a></li>      
                            </ul>

                            <div class="tab-content">
                                <div id="people" class="tab-pane fade in active">

                                    <div class="tab-pane" id="recent_projects_content">

                                        <br>
                                        <section class="col-xs-12 col-sm-6 col-md-12">
                                            <%
                                                HttpSession session2 = request.getSession(true);
                                                Vector<User> users = new Vector<User>();
                                                users = (Vector<User>) request.getSession().getAttribute("matchusers");
                                                Vector<Project> projects = new Vector<Project>();
                                                projects = (Vector<Project>) request.getSession().getAttribute("matchprojects");

                                                if (!users.isEmpty()) {

                                                    for (int i = 0; i < users.size(); i++) {

                                            %>



                                            <article class="search-result row">
                                                <div class="col-xs-12 col-sm-12 col-md-3">
                                                    <a href=<%= "\"mypage.jsp?user_id=" + users.get(i).getUser_id() + "\""%> title="Lorem ipsum" class="thumbnail"><img src=<%=users.get(i).getPhoto()%> alt="Lorem ipsum" /></a>
                                                </div>
                                                <div class="col-xs-12 col-sm-12 col-md-2">
                                                    <ul class="meta-search">
                                                        <li><i class="glyphicon glyphicon-envelope"></i> <span><%=users.get(i).getEmail()%></span></li>
                                                        <li><i class="glyphicon glyphicon-thumbs-up"></i> <span> 4,215  </span></li>
                                                        <li><i class="glyphicon glyphicon-eye-open"></i> <span> 712,289</span></li>
                                                    </ul>
                                                </div>
                                                <div class="col-xs-12 col-sm-12 col-md-7 excerpet">
                                                    <h3><a href="#" title=""><%=users.get(i).getName()%></a></h3>
                                                    <p><%=users.get(i).getUser_desc()%></p>						

                                                </div>
                                                <span class="clearfix borda"></span>
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
                                    </div><!--people -->   


                                </div>
                                <div id="projects" class="tab-pane fade">
                                    <div class="tab-pane" id="recent_projects_content">
                                        <br>

                                        <section class="comment-list">
                                            <% System.out.println("searchResults" + projects.size());
                                                if (!projects.get(0).getName().equals("empty")) {
                                                    for (int i = 0; i < projects.size(); i++) {

                                                        user = user.GetUserByUserId(Integer.toString(projects.get(i).getUser_id()));

                                                        Search searchobject = new Search();
                                                        Vector<Search> searchvector = new Vector<Search>();
                                                        searchvector = searchobject.getMatchedSearchValue(Integer.toString(projects.get(i).getProject_id()));
                                                        System.out.println("");

                                            %>
                                            <article class="row">
                                                <div class="col-md-2 col-sm-2 hidden-xs">
                                                    <figure class="thumbnail">
                                                        <img class="img-responsive" src=<%=user.getPhoto()%> />
                                                        <figcaption class="text-center"><a href=<%= "\"mypage.jsp?user_id=" + user.getUser_id() + "\""%> ><%=user.getName()%></a></figcaption>
                                                    </figure>
                                                </div>
                                                <div class="col-md-10 col-sm-10">
                                                    <div class="panel panel-default arrow left">
                                                        <div class="panel-body">
                                                            <header>
                                                                <div class="text-left">
                                                                    <i class="fa fa-user"></i> <span class="glyphicon glyphicon-time"></span> <small><em><%=projects.get(i).getCreation_date()%></em></small>
                                                                </div>
                                                                <div class="text-right">
                                                                    <i class="fa fa-user"></i><span class="badge">3</span>
                                                                </div>
                                                            </header>

                                                            <div class="comment-post">
                                                                <h3 class="text text-left text-primary"><%=projects.get(i).getName()%> </h3>
                                                                <p>
                                                                    <%=projects.get(i).getProject_desc()%>
                                                                </p>
                                                                <a href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%> ><img class="img-responsive" src=<%=projects.get(i).getPhoto()%> /></a>
                                                            </div>
                                                            <br>
                                                            <p class="text-right"> 
                                                                <span class="glyphicon glyphicon-thumbs-up"></span> <small><em><%=projects.get(i).getLikes()%></em></small>
                                                                <br>
                                                                <span class="glyphicon glyphicon-eye-open"></span> <small><em><%=projects.get(i).getViews()%></em></small>
                                                                <br>
                                                                <br>
                                                            <p class="text-left">
                                                                <span ></span> <small><em>Tags:</em></small>
                                                            </p>
                                                            </p>


                                                            <% for (int j = 0; j < searchvector.size(); j++) {

                                                            %>
                                                            <p class="text-left"> 
                                                                <span class=""></span> <small><em><%=searchvector.get(j).getTag_name()%></em></small>
                                                            </p>
                                                            <% } %>

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
                                                    <li><a href="#"><span class="glyphicon glyphicon-chevron-left"></span> Previous</a></li>
                                                    <li><a href="#">Next <span class="glyphicon glyphicon-chevron-right"> </span></a></li>
                                                </ul>
                                            </div>

                                        </section>


                                    </div><!--recent_projects -->


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