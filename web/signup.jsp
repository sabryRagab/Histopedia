<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" %>

<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>إنشاءحساب جديد  Histopedia</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">

    </head>
    <body>
        <div id="main_container">
            <div class="container" id="signup">
                <div class="header">
                    <div class="navbar-header">
                        <a href="index.jsp"><img src="images/histopedia-logo.gif" alt="fantasy" class="histopedia-logo"></a>
                    </div>
                    <form  action="getSearchValue" method="get" class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="إبحث" id="keyword" name="keyword">
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
                            <li><a href="index.jsp"><span class="glyphicon glyphicon-home"></span> الصفحة الرئيسية</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>
                            <li class="active" ><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> إنشاء حساب جديد</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>

                <div class="row" id="signup-row">
                    <div class="col-md-3"></div> 
                    <div class="col-md-6" style="border: solid 1px #752201; background-color: #f9f9f9;
                         padding: 40px; margin:20px;"> 

                        <h4 class="text-center text-primar">إنشاء حساب جديد</h4>

                        <div id="js_output"></div>
                             <form  name="signup" action="SignupServlet" method="post" class="table table-responsive" role="form">

                             <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input name='name' id="name"  placeholder="إسم المستخدم" class="form-control" type="text" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope "></i></span>
                                    <input id="email" name="email"  placeholder="البريد الالكتروني" class="form-control" type="email" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon  glyphicon-lock "></i></span>
                                    <input id="password" name="password"  placeholder="كلمة المرور" class="form-control" type="password" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon  glyphicon-lock "></i></span>
                                    <input id="confirm_password" name="confirm_password" placeholder="تاكيد كلمة المرور" class="form-control" type="password" required>
                                </div>
                            </div>

                            <div class="form-group"> 
                                <div class="row">
                                    <div class="col-md-6 col-md-offset-3">
                                        <button type="submit" onclick="return validateSignup()" class="btn btn-block btn-default">إنشاء</button>
                                    </div>
                                    <div class="col-md-3"></div>  
                                </div>

                            </div>
                            </form>

                            <small class="text-muted">هل تمللك حساب ? <a href="index.jsp">سجل الدخول</a></small>


                        </div>
                        <div class="col-md-6"></div>
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
            <script src="js/signup_validation.js"></script>
            <!-- Hiding text overflow: http://stackoverflow.com/questions/15308061/how-to-avoid-text-overflow-in-twitter-bootstrap -->

    </body>
</html>