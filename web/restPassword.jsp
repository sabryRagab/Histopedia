<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title> إعادة تعيين كلمة المرور</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">

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
                            <input type="text" class="form-control" placeholder="Search" id="keyword" name="keyword">
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
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-home"></span> الصفحة الرئيسيه</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>
                            <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span>إنشاء حساب جديد</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>

                <br><br><br><br>
                <div class="container">
                    <div class="row">
                        <div class="row">
                            <div class="col-md-4 col-md-offset-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">

                                        <div class="text-center">
                                            <h2 class="text-center">إعادة تعيين كلمة المرور</h2>
                                            <div class="panel-body">
                                                <form class="form" action="Reset_PasswordServlet" method="post">
                                                    <fieldset>
                                                        <div class="form-group">

                                                            <div class="input-group">
                                                                <span class="input-group-addon"> <span class="glyphicon glyphicon-lock"></span></span>

                                                                <input id="Password" name="password" placeholder="كلمة المرور الجديدة" class="form-control" type="password"  required>
                                                            </div>
                                                            <br>
                                                           
                                                        </div>
                                                        <div class="form-group">

                                                            <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="return myFunction()" id = "save">حفظ</button>
                                                        </div>
                                                    </fieldset>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br><br><br><br>
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

    </body>
</html>