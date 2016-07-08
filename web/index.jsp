<%@page import="Model.User"%>
<%@page import="java.util.Vector"%>
<%@page import="Model.Project"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>Histopedia - الصفحة الرئيسية</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <link href="css/project_sytle.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="main_container">
            <div class="container" id="home">
                <div class="header">
                    <div class="navbar-header">
                        <a href="index.jsp"><img src="images/histopedia-logo.gif" alt="fantasy" class="histopedia-logo"></a>
                    </div>
                    <form  action="getSearchValue" method="get" class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="إبحث" id="keyword" name="keyword" required>
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
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-home"></span> الرئيسية</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>
                            <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> إنشاء حساب جديد</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>
                <div class="row" >


                    <div class="col-md-8">
                        <h2 class="page-header">أفضل ١٠ مشاريع</h2>

                        <section class="comment-list">
                            <!--  project 1 -->
                            <%

                                Vector<Project> projects = new Vector<Project>();
                                Project project = new Project();
                                projects = project.getTop50Project();
                                
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
                                System.out.println("Proooooooooooooooojects size =" + projects.size());

                                for (int i = 0; i < Math.min(10, projects.size()); i++) {

                                    User user = new User();
                                    user = user.GetUserByUserId(Integer.toString(projects.get(i).getUser_id()));

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
                                                    <i class="fa fa-user"></i><span class="badge"><%= i+1 %></span>
                                                </div>
                                            </header>

                                            <div class="comment-post">
                                                <h3 class="text text-left text-primary"><%=projects.get(i).getName()%></h3>
                                                <p>
                                                    <%=projects.get(i).getProject_desc()%>
                                                </p>
                                                <%
                                                String pphoto=projects.get(i).getPhoto();
                                                System.out.println("Photooooooooooooo"+pphoto);
                                                %>
                                                <a href=<%= "\"viewProject.jsp?project_id=" + projects.get(i).getProject_id() + "\""%> ><img height="700" width="700" class="img-responsive" src=<%=pphoto%>  /></a>
                                            </div>
                                            <br>
                                            <p class="text-right"> 
                                                <span class="glyphicon glyphicon-thumbs-up"></span> <small><em><%=projects.get(i).getLikes()%></em></small>
                                                <br>
                                                <span class="glyphicon glyphicon-eye-open"></span> <small><em><%=projects.get(i).getViews()%></em></small>
                                            </p>

                                        </div>
                                    </div>
                                </div>
                            </article>
                            <% }
                            %>


                        </section>


                    </div>

                    <div class="col-md-4"> 
                        <div class="preview_footer_container">				
                            <div class="footer_item section_box col-xs-12 col-sm-4 col-md-12">
                                <h4 class="text-primary">تسجيل الدخول</h4>
                                <div id="js_output"  ></div>
                                <form  name="signin" action="SigninServlet" method="POST" class="navbar-form navbar-right" role="form">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope "></i></span>
                                            <input id="email" name="email" placeholder="البريد الالكتروني" class="form-control" type="email" required>
                                        </div>
                                    </div>
                                    <div><br></div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon  glyphicon-lock "></i></span>
                                            <input id="password" name="password" placeholder="كلمة المرور" class="form-control" type="password" required>
                                        </div>
                                    </div>
                                    <div><br></div>
                                    <div>
                                        <button type="submit" onclick="return validateSignin()" class="btn btn-info btn-block" name="sign-in">دخول</button>
                                    </div>
                                </form>
                                <!--Forgot my password?--> 
                                <p> <a href="#" data-target="#pwdModal" data-toggle="modal">هل نسيت كلمة السر؟</a></p>
                                <!--modal-->
                                <div id="pwdModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" >
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h1 class="text-center">إعادة تعيين كلمة السر</h1>
                                            </div>
                                            <div class="modal-body">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <div class="text-center">

                                                                <p>ادخل البريد الإلكتروني لإعادة تعيين كلمة السر</p>
                                                                <div class="panel-body">
                                                                    <form class="form" action="ForgetPasswordServlet" method="post" role="form">
                                                                        <fieldset>
                                                                            <div class="form-group">
                                                                                <div class="input-group">
                                                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>

                                                                                    <input  name="email" placeholder="البريد الألكتروني" class="form-control" type="email" required />
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <input type="submit" class="btn btn-lg btn-primary btn-block" value="إرسال"  />
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
                                <small class="text-muted">لست عضوا ؟ إنشاء حساب جديد  <a href="signup.jsp">سجل من هنا</a></small>

                            </div>

                            <div class="footer_item section_box col-xs-12 col-sm-4 col-md-12">
                                <h4 class="text-primary">اقتباس عن التاريخ</h4>
                                <blockquote>
                                    <p>من يقرأ التاريخ لا يدخل اليأس إلى قلبه أبداً،
                                        و سوف يرى الدنيا أياماً يداولها الله بين الناس.
                                        الأغنياء يصبحون فقراء ،
                                        والفقراء ينقلبون أغنياء،
                                        وضعفاء الأمس أقوياء اليوم ،
                                        وحكام الأمس مشردو اليوم ،
                                        والقضاة متهمون ،
                                        والغالبون مغلوبون
                                        والفلك دوار والحياة لا تقف .
                                        والحوادث لا تكف عن الجريان ..
                                        والناس يتبادلون الكراسي ،
                                        لا حزن يستمر.. ولا فرح يدوم .</p>
                                    <footer class="text-muted"> مصطفي محمود</footer>
                                </blockquote>
                                <a href="http://xn--sgb8bg.net/%D8%AD%D9%83%D9%85-%D8%B9%D9%86-%D8%A7%D9%84%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE/" class="btn btn-info" role="button">المزيد </a>
                            </div>
                        </div> <!-- preview_footer_container -->

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
        <script src="js/signin_validation.js"></script>

    </body>
</html>