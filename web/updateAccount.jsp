<%@page import="Model.User"%>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>تعديل البيانات الشخصية</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link href="css/justified-nav.css" rel="stylesheet" type="text/css">
        <link href="css/histopedia_style.css" rel="stylesheet" type="text/css">
        <script src="js/updateAccountValidation.js"></script>

    </head>
    <body>
        <%
            String email = (String) session.getAttribute("email");
            User u = (User) request.getAttribute("user");
            String name = u.getName();
            name = (name == null ? "" : name);
            String password = u.getPassword();
            password = (password == null ? "" : password);
            String country = u.getCountry();
            country = (country == null ? "" : country);
            String city = u.getCity();
            city = (city == null ? "" : city);
            String gender = u.getGender();
            gender = (gender == null ? "male" : gender);
            String user_desc = u.getUser_desc();
            user_desc = (user_desc == null ? "" : user_desc);
            String photo = u.getPhoto();
            photo = (photo == null ? "images/default_user_photo.png" : photo);

        %>

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
                            <li><a href="mypage.jsp"><span class="glyphicon glyphicon-user"></span> المستخدم</a></li>
                            <li><a href="about.html">عنا</a></li>
                            <li><a href="documentation.html">دليل المستخدم</a></li>
                            <li><a href="contact.html"><span class="glyphicon glyphicon-earphone"></span> تواصل معنا</a></li>           
                            <li><a href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> تسجيل الخروج</a></li>
                        </ul>
                    </div> <!-- nav -->
                </div>


                <h1 class="page-header text-center">تعديل البيانات الشخصية</h1>
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        
                        <form class="form-horizontal" 
                              action = "UpdateUserPhotoServlet" 
                              enctype="multipart/form-data" method="post" role="form">
                            <div class="text-center">
                                <img src="<%=photo%>" class="avatar img-circle img-thumbnail" alt="avatar">
                            <h6>إختيار صورة اخري</h6>
                            <input type="file" class="text-center center-block well well-sm" name='photo' id="photo" accept="image/*">
                            </div>
                            
                            <div class="form-group">
                                <label class="col-md-3 control-label"></label>
                                <div class="col-md-8">
                                    <input class="btn btn-success" onclick="return validateUpdateAccount()" value="حفظ" type="submit">
                                </div>
                            </div>
                            
                            
                            
                        </form>
                        
                        <div class="text-center">
                           
                        </div>
                    </div>
                    <!-- edit form column -->
                    <div class="col-md-8 col-sm-6 col-xs-12 personal-info">
                        <div id="js_output" class="alert alert-info alert-dismissable">
                            <a class="panel-close close" data-dismiss="alert">×</a> 
                            <i class="fa fa-coffee"></i>
                             <strong>.إنذار</strong>. استخدام هذا لإظهار رسائل مهمة للمستخدم.
                        </div>
                        <h3>معلومات المستخدم</h3>
                        <form name="editForm" class="form-horizontal" action="UpdateAccountServlet" role="form">
                            <div class="form-group">
                                <label class="col-lg-3 control-label">الاسم<span style="color: red">*</span></label>
                                <div class="col-lg-8">
                                    <input class="form-control" value="<%=name%>" type="text" name='name' id="name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">البريد الالكتروني<span style="color: red">*</span></label>
                                <div class="col-lg-8">
                                    <input class="form-control" value="<%=email%>" type="email" name="email" id="email" required readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-lg-3 control-label">البلد</label>
                                <div class="col-lg-8">
                                    <select name="country" id='country' value=<%=country%> class="form-control">
                                        <option value="" <%if (country.equals("")) {%> selected="selected" <%}%> >Country</option>
                                        <option value="Afganistan" <%if (country.equals("Afganistan")) {%> selected="selected" <%}%>>Afghanistan</option>
                                        <option value="Albania" <%if (country.equals("Albania")) {%> selected="selected" <%}%> >Albania</option>
                                        <option value="Algeria" <%if (country.equals("Algeria")) {%> selected="selected" <%}%> >Algeria</option>
                                        <option value="American Samoa" <%if (country.equals("American Samoa")) {%> selected="selected" <%}%> >American Samoa</option>
                                        <option value="Andorra" <%if (country.equals("Andorra")) {%> selected="selected" <%}%> >Andorra</option>
                                        <option value="Angola" <%if (country.equals("Angola")) {%> selected="selected" <%}%> >Angola</option>
                                        <option value="Anguilla" <%if (country.equals("Anguilla")) {%> selected="selected" <%}%> >Anguilla</option>
                                        <option value="Antigua &amp; Barbuda" <%if (country.equals("Antigua &amp; Barbuda")) {%> selected="selected" <%}%> >Antigua &amp; Barbuda</option>
                                        <option value="Argentina" <%if (country.equals("Argentina")) {%> selected="selected" <%}%> >Argentina</option>
                                        <option value="Armenia" <%if (country.equals("Armenia")) {%> selected="selected" <%}%> >Armenia</option>
                                        <option value="Aruba" <%if (country.equals("Aruba")) {%> selected="selected" <%}%> >Aruba</option>
                                        <option value="Australia" <%if (country.equals("Australia")) {%> selected="selected" <%}%> >Australia</option>
                                        <option value="Austria" <%if (country.equals("Austria")) {%> selected="selected" <%}%> >Austria</option>
                                        <option value="Azerbaijan" <%if (country.equals("Azerbaijan")) {%> selected="selected" <%}%> >Azerbaijan</option>
                                        <option value="Bahamas" <%if (country.equals("Bahamas")) {%> selected="selected" <%}%> >Bahamas</option>
                                        <option value="Bahrain" <%if (country.equals("Bahrain")) {%> selected="selected" <%}%> >Bahrain</option>
                                        <option value="Bangladesh" <%if (country.equals("Bangladesh")) {%> selected="selected" <%}%> >Bangladesh</option>
                                        <option value="Barbados" <%if (country.equals("Barbados")) {%> selected="selected" <%}%> >Barbados</option>
                                        <option value="Belarus" <%if (country.equals("Belarus")) {%> selected="selected" <%}%> >Belarus</option>
                                        <option value="Belgium" <%if (country.equals("Belgium")) {%> selected="selected" <%}%> >Belgium</option>
                                        <option value="Belize" <%if (country.equals("Belize")) {%> selected="selected" <%}%> >Belize</option>
                                        <option value="Benin" <%if (country.equals("Benin")) {%> selected="selected" <%}%> >Benin</option>
                                        <option value="Bermuda" <%if (country.equals("Bermuda")) {%> selected="selected" <%}%> >Bermuda</option>
                                        <option value="Bhutan" <%if (country.equals("Bhutan")) {%> selected="selected" <%}%> >Bhutan</option>
                                        <option value="Bolivia" <%if (country.equals("Bolivia")) {%> selected="selected" <%}%> >Bolivia</option>
                                        <option value="Bonaire" <%if (country.equals("Bonaire")) {%> selected="selected" <%}%> >Bonaire</option>
                                        <option value="Bosnia &amp; Herzegovina" <%if (country.equals("Bosnia &amp; Herzegovina")) {%> selected="selected" <%}%> >Bosnia &amp; Herzegovina</option>
                                        <option value="Botswana" <%if (country.equals("Botswana")) {%> selected="selected" <%}%> >Botswana</option>
                                        <option value="Brazil" <%if (country.equals("Brazil")) {%> selected="selected" <%}%> >Brazil</option>
                                        <option value="British Indian Ocean Ter" <%if (country.equals("British Indian Ocean Ter")) {%> selected="selected" <%}%> >British Indian Ocean Ter</option>
                                        <option value="Brunei" <%if (country.equals("Brunei")) {%> selected="selected" <%}%> >Brunei</option>
                                        <option value="Bulgaria" <%if (country.equals("Bulgaria")) {%> selected="selected" <%}%> >Bulgaria</option>
                                        <option value="Burkina Faso" <%if (country.equals("Burkina Faso")) {%> selected="selected" <%}%> >Burkina Faso</option>
                                        <option value="Burundi" <%if (country.equals("Burundi")) {%> selected="selected" <%}%> >Burundi</option>
                                        <option value="Cambodia" <%if (country.equals("Cambodia")) {%> selected="selected" <%}%> >Cambodia</option>
                                        <option value="Cameroon" <%if (country.equals("Cameroon")) {%> selected="selected" <%}%> >Cameroon</option>
                                        <option value="Canada" <%if (country.equals("Canada")) {%> selected="selected" <%}%> >Canada</option>
                                        <option value="Canary Islands" <%if (country.equals("Canary Islands")) {%> selected="selected" <%}%> >Canary Islands</option>
                                        <option value="Cape Verde" <%if (country.equals("Cape Verde")) {%> selected="selected" <%}%> >Cape Verde</option>
                                        <option value="Cayman Islands" <%if (country.equals("Cayman Islands")) {%> selected="selected" <%}%> >Cayman Islands</option>
                                        <option value="Central African Republic" <%if (country.equals("Central African Republic")) {%> selected="selected" <%}%> >Central African Republic</option>
                                        <option value="Chad" <%if (country.equals("Chad")) {%> selected="selected" <%}%> >Chad</option>
                                        <option value="Channel Islands" <%if (country.equals("Channel Islands")) {%> selected="selected" <%}%> >Channel Islands</option>
                                        <option value="Chile" <%if (country.equals("Chile")) {%> selected="selected" <%}%> >Chile</option>
                                        <option value="China" <%if (country.equals("China")) {%> selected="selected" <%}%> >China</option>
                                        <option value="Christmas Island" <%if (country.equals("Christmas Island")) {%> selected="selected" <%}%> >Christmas Island</option>
                                        <option value="Cocos Island" <%if (country.equals("Cocos Island")) {%> selected="selected" <%}%> >Cocos Island</option>
                                        <option value="Colombia" <%if (country.equals("Colombia")) {%> selected="selected" <%}%> >Colombia</option>
                                        <option value="Comoros" <%if (country.equals("Comoros")) {%> selected="selected" <%}%> >Comoros</option>
                                        <option value="Congo" <%if (country.equals("Congo")) {%> selected="selected" <%}%> >Congo</option>
                                        <option value="Cook Islands" <%if (country.equals("Cook Islands")) {%> selected="selected" <%}%> >Cook Islands</option>
                                        <option value="Costa Rica" <%if (country.equals("Costa Rica")) {%> selected="selected" <%}%> >Costa Rica</option>
                                        <option value="Cote DIvoire" <%if (country.equals("Cote DIvoire")) {%> selected="selected" <%}%> >Cote D'Ivoire</option>
                                        <option value="Croatia" <%if (country.equals("Croatia")) {%> selected="selected" <%}%> >Croatia</option>
                                        <option value="Cuba" <%if (country.equals("Cuba")) {%> selected="selected" <%}%> >Cuba</option>
                                        <option value="Curaco" <%if (country.equals("Curaco")) {%> selected="selected" <%}%> >Curacao</option>
                                        <option value="Cyprus" <%if (country.equals("Cyprus")) {%> selected="selected" <%}%> >Cyprus</option>
                                        <option value="Czech Republic" <%if (country.equals("Czech Republic")) {%> selected="selected" <%}%> >Czech Republic</option>
                                        <option value="Denmark" <%if (country.equals("Denmark")) {%> selected="selected" <%}%> >Denmark</option>
                                        <option value="Djibouti" <%if (country.equals("Djibouti")) {%> selected="selected" <%}%> >Djibouti</option>
                                        <option value="Dominica" <%if (country.equals("Dominica")) {%> selected="selected" <%}%> >Dominica</option>
                                        <option value="Dominican Republic" <%if (country.equals("Dominican Republic")) {%> selected="selected" <%}%> >Dominican Republic</option>
                                        <option value="East Timor" <%if (country.equals("East Timor")) {%> selected="selected" <%}%> >East Timor</option>
                                        <option value="Ecuador" <%if (country.equals("Ecuador")) {%> selected="selected" <%}%> >Ecuador</option>
                                        <option value="Egypt" <%if (country.equals("Egypt")) {%> selected="selected" <%}%> >Egypt</option>
                                        <option value="El Salvador" <%if (country.equals("El Salvador")) {%> selected="selected" <%}%> >El Salvador</option>
                                        <option value="Equatorial Guinea" <%if (country.equals("Equatorial Guinea")) {%> selected="selected" <%}%> >Equatorial Guinea</option>
                                        <option value="Eritrea" <%if (country.equals("Eritrea")) {%> selected="selected" <%}%> >Eritrea</option>
                                        <option value="Estonia" <%if (country.equals("Estonia")) {%> selected="selected" <%}%> >Estonia</option>
                                        <option value="Ethiopia" <%if (country.equals("Ethiopia")) {%> selected="selected" <%}%> >Ethiopia</option>
                                        <option value="Falkland Islands" <%if (country.equals("Falkland Islands")) {%> selected="selected" <%}%> >Falkland Islands</option>
                                        <option value="Faroe Islands" <%if (country.equals("Faroe Islands")) {%> selected="selected" <%}%> >Faroe Islands</option>
                                        <option value="Fiji" <%if (country.equals("Fiji")) {%> selected="selected" <%}%> >Fiji</option>
                                        <option value="Finland" <%if (country.equals("Finland")) {%> selected="selected" <%}%> >Finland</option>
                                        <option value="France" <%if (country.equals("France")) {%> selected="selected" <%}%> >France</option>
                                        <option value="French Guiana" <%if (country.equals("French Guiana")) {%> selected="selected" <%}%> >French Guiana</option>
                                        <option value="French Polynesia" <%if (country.equals("French Polynesia")) {%> selected="selected" <%}%> >French Polynesia</option>
                                        <option value="French Southern Ter" <%if (country.equals("French Southern Ter")) {%> selected="selected" <%}%> >French Southern Ter</option>
                                        <option value="Gabon" <%if (country.equals("Gabon")) {%> selected="selected" <%}%> >Gabon</option>
                                        <option value="Gambia" <%if (country.equals("Gambia")) {%> selected="selected" <%}%> >Gambia</option>
                                        <option value="Georgia" <%if (country.equals("Georgia")) {%> selected="selected" <%}%> >Georgia</option>
                                        <option value="Germany" <%if (country.equals("Germany")) {%> selected="selected" <%}%> >Germany</option>
                                        <option value="Ghana" <%if (country.equals("Ghana")) {%> selected="selected" <%}%> >Ghana</option>
                                        <option value="Gibraltar" <%if (country.equals("Gibraltar")) {%> selected="selected" <%}%> >Gibraltar</option>
                                        <option value="Great Britain" <%if (country.equals("Great Britain")) {%> selected="selected" <%}%> >Great Britain</option>
                                        <option value="Greece" <%if (country.equals("Greece")) {%> selected="selected" <%}%> >Greece</option>
                                        <option value="Greenland" <%if (country.equals("Greenland")) {%> selected="selected" <%}%> >Greenland</option>
                                        <option value="Grenada" <%if (country.equals("Grenada")) {%> selected="selected" <%}%> >Grenada</option>
                                        <option value="Guadeloupe" <%if (country.equals("Guadeloupe")) {%> selected="selected" <%}%> >Guadeloupe</option>
                                        <option value="Guam" <%if (country.equals("Guam")) {%> selected="selected" <%}%> >Guam</option>
                                        <option value="Guatemala" <%if (country.equals("Guatemala")) {%> selected="selected" <%}%> >Guatemala</option>
                                        <option value="Guinea" <%if (country.equals("Guinea")) {%> selected="selected" <%}%> >Guinea</option>
                                        <option value="Guyana" <%if (country.equals("Guyana")) {%> selected="selected" <%}%> >Guyana</option>
                                        <option value="Haiti" <%if (country.equals("Haiti")) {%> selected="selected" <%}%> >Haiti</option>
                                        <option value="Hawaii" <%if (country.equals("Hawaii")) {%> selected="selected" <%}%> >Hawaii</option>
                                        <option value="Honduras" <%if (country.equals("Honduras")) {%> selected="selected" <%}%> >Honduras</option>
                                        <option value="Hong Kong" <%if (country.equals("Hong Kong")) {%> selected="selected" <%}%> >Hong Kong</option>
                                        <option value="Hungary" <%if (country.equals("Hungary")) {%> selected="selected" <%}%> >Hungary</option>
                                        <option value="Iceland" <%if (country.equals("Iceland")) {%> selected="selected" <%}%> >Iceland</option>
                                        <option value="India" <%if (country.equals("India")) {%> selected="selected" <%}%> >India</option>
                                        <option value="Indonesia" <%if (country.equals("Indonesia")) {%> selected="selected" <%}%> >Indonesia</option>
                                        <option value="Iran" <%if (country.equals("Iran")) {%> selected="selected" <%}%> >Iran</option>
                                        <option value="Iraq" <%if (country.equals("Iraq")) {%> selected="selected" <%}%> >Iraq</option>
                                        <option value="Ireland" <%if (country.equals("Ireland")) {%> selected="selected" <%}%> >Ireland</option>
                                        <option value="Isle of Man" <%if (country.equals("Isle of Man")) {%> selected="selected" <%}%> >Isle of Man</option>
                                        <option value="Israel" <%if (country.equals("Israel")) {%> selected="selected" <%}%> >Israel</option>
                                        <option value="Italy" <%if (country.equals("Italy")) {%> selected="selected" <%}%> >Italy</option>
                                        <option value="Jamaica" <%if (country.equals("Jamaica")) {%> selected="selected" <%}%> >Jamaica</option>
                                        <option value="Japan" <%if (country.equals("Japan")) {%> selected="selected" <%}%> >Japan</option>
                                        <option value="Jordan" <%if (country.equals("Jordan")) {%> selected="selected" <%}%> >Jordan</option>
                                        <option value="Kazakhstan" <%if (country.equals("Kazakhstan")) {%> selected="selected" <%}%> >Kazakhstan</option>
                                        <option value="Kenya" <%if (country.equals("Kenya")) {%> selected="selected" <%}%> >Kenya</option>
                                        <option value="Kiribati" <%if (country.equals("Kiribati")) {%> selected="selected" <%}%> >Kiribati</option>
                                        <option value="Korea North" <%if (country.equals("Korea North")) {%> selected="selected" <%}%> >Korea North</option>
                                        <option value="Korea Sout" <%if (country.equals("Korea Sout")) {%> selected="selected" <%}%> >Korea South</option>
                                        <option value="Kuwait" <%if (country.equals("Kuwait")) {%> selected="selected" <%}%> >Kuwait</option>
                                        <option value="Kyrgyzstan" <%if (country.equals("Kyrgyzstan")) {%> selected="selected" <%}%> >Kyrgyzstan</option>
                                        <option value="Laos" <%if (country.equals("Laos")) {%> selected="selected" <%}%> >Laos</option>
                                        <option value="Latvia" <%if (country.equals("Latvia")) {%> selected="selected" <%}%> >Latvia</option>
                                        <option value="Lebanon" <%if (country.equals("Lebanon")) {%> selected="selected" <%}%> >Lebanon</option>
                                        <option value="Lesotho" <%if (country.equals("Lesotho")) {%> selected="selected" <%}%> >Lesotho</option>
                                        <option value="Liberia" <%if (country.equals("Liberia")) {%> selected="selected" <%}%> >Liberia</option>
                                        <option value="Libya" <%if (country.equals("Libya")) {%> selected="selected" <%}%> >Libya</option>
                                        <option value="Liechtenstein" <%if (country.equals("Liechtenstein")) {%> selected="selected" <%}%> >Liechtenstein</option>
                                        <option value="Lithuania" <%if (country.equals("Lithuania")) {%> selected="selected" <%}%> >Lithuania</option>
                                        <option value="Luxembourg" <%if (country.equals("Luxembourg")) {%> selected="selected" <%}%> >Luxembourg</option>
                                        <option value="Macau" <%if (country.equals("Macau")) {%> selected="selected" <%}%> >Macau</option>
                                        <option value="Macedonia" <%if (country.equals("Macedonia")) {%> selected="selected" <%}%> >Macedonia</option>
                                        <option value="Madagascar" <%if (country.equals("Madagascar")) {%> selected="selected" <%}%> >Madagascar</option>
                                        <option value="Malaysia" <%if (country.equals("Malaysia")) {%> selected="selected" <%}%> >Malaysia</option>
                                        <option value="Malawi" <%if (country.equals("Malawi")) {%> selected="selected" <%}%> >Malawi</option>
                                        <option value="Maldives" <%if (country.equals("Maldives")) {%> selected="selected" <%}%> >Maldives</option>
                                        <option value="Mali" <%if (country.equals("Mali")) {%> selected="selected" <%}%> >Mali</option>
                                        <option value="Malta" <%if (country.equals("Malta")) {%> selected="selected" <%}%> >Malta</option>
                                        <option value="Marshall Islands" <%if (country.equals("Marshall Islands")) {%> selected="selected" <%}%> >Marshall Islands</option>
                                        <option value="Martinique" <%if (country.equals("Martinique")) {%> selected="selected" <%}%> >Martinique</option>
                                        <option value="Mauritania" <%if (country.equals("Mauritania")) {%> selected="selected" <%}%> >Mauritania</option>
                                        <option value="Mauritius" <%if (country.equals("Mauritius")) {%> selected="selected" <%}%> >Mauritius</option>
                                        <option value="Mayotte" <%if (country.equals("Mayotte")) {%> selected="selected" <%}%> >Mayotte</option>
                                        <option value="Mexico" <%if (country.equals("Mexico")) {%> selected="selected" <%}%> >Mexico</option>
                                        <option value="Midway Islands" <%if (country.equals("Midway Islands")) {%> selected="selected" <%}%> >Midway Islands</option>
                                        <option value="Moldova" <%if (country.equals("Moldova")) {%> selected="selected" <%}%> >Moldova</option>
                                        <option value="Monaco" <%if (country.equals("Monaco")) {%> selected="selected" <%}%> >Monaco</option>
                                        <option value="Mongolia" <%if (country.equals("Mongolia")) {%> selected="selected" <%}%> >Mongolia</option>
                                        <option value="Montserrat" <%if (country.equals("Montserrat")) {%> selected="selected" <%}%> >Montserrat</option>
                                        <option value="Morocco" <%if (country.equals("Morocco")) {%> selected="selected" <%}%> >Morocco</option>
                                        <option value="Mozambique" <%if (country.equals("Mozambique")) {%> selected="selected" <%}%> >Mozambique</option>
                                        <option value="Myanmar" <%if (country.equals("Myanmar")) {%> selected="selected" <%}%> >Myanmar</option>
                                        <option value="Nambia" <%if (country.equals("Nambia")) {%> selected="selected" <%}%> >Nambia</option>
                                        <option value="Nauru" <%if (country.equals("Nauru")) {%> selected="selected" <%}%> >Nauru</option>
                                        <option value="Nepal" <%if (country.equals("Nepal")) {%> selected="selected" <%}%> >Nepal</option>
                                        <option value="Netherland Antilles" <%if (country.equals("Netherland Antilles")) {%> selected="selected" <%}%> >Netherland Antilles</option>
                                        <option value="Netherlands" <%if (country.equals("Netherlands")) {%> selected="selected" <%}%> >Netherlands (Holland, Europe)</option>
                                        <option value="Nevis" <%if (country.equals("Nevis")) {%> selected="selected" <%}%> >Nevis</option>
                                        <option value="New Caledonia" <%if (country.equals("New Caledonia")) {%> selected="selected" <%}%> >New Caledonia</option>
                                        <option value="New Zealand" <%if (country.equals("New Zealand")) {%> selected="selected" <%}%> >New Zealand</option>
                                        <option value="Nicaragua" <%if (country.equals("Nicaragua")) {%> selected="selected" <%}%> >Nicaragua</option>
                                        <option value="Niger" <%if (country.equals("Niger")) {%> selected="selected" <%}%> >Niger</option>
                                        <option value="Nigeria" <%if (country.equals("Nigeria")) {%> selected="selected" <%}%> >Nigeria</option>
                                        <option value="Niue" <%if (country.equals("Niue")) {%> selected="selected" <%}%> >Niue</option>
                                        <option value="Norfolk Island" <%if (country.equals("Norfolk Island")) {%> selected="selected" <%}%> >Norfolk Island</option>
                                        <option value="Norway" <%if (country.equals("Norway")) {%> selected="selected" <%}%> >Norway</option>
                                        <option value="Oman" <%if (country.equals("Oman")) {%> selected="selected" <%}%> >Oman</option>
                                        <option value="Pakistan" <%if (country.equals("Pakistan")) {%> selected="selected" <%}%> >Pakistan</option>
                                        <option value="Palau Island" <%if (country.equals("Palau Island")) {%> selected="selected" <%}%> >Palau Island</option>
                                        <option value="Palestine" <%if (country.equals("Palestine")) {%> selected="selected" <%}%> >Palestine</option>
                                        <option value="Panama" <%if (country.equals("Panama")) {%> selected="selected" <%}%> >Panama</option>
                                        <option value="Papua New Guinea" <%if (country.equals("Papua New Guinea")) {%> selected="selected" <%}%> >Papua New Guinea</option>
                                        <option value="Paraguay" <%if (country.equals("Paraguay")) {%> selected="selected" <%}%> >Paraguay</option>
                                        <option value="Peru" <%if (country.equals("Peru")) {%> selected="selected" <%}%> >Peru</option>
                                        <option value="Phillipines" <%if (country.equals("Phillipines")) {%> selected="selected" <%}%> >Philippines</option>
                                        <option value="Pitcairn Island" <%if (country.equals("Pitcairn Island")) {%> selected="selected" <%}%> >Pitcairn Island</option>
                                        <option value="Poland" <%if (country.equals("Poland")) {%> selected="selected" <%}%> >Poland</option>
                                        <option value="Portugal" <%if (country.equals("Portugal")) {%> selected="selected" <%}%> >Portugal</option>
                                        <option value="Puerto Rico" <%if (country.equals("Puerto Rico")) {%> selected="selected" <%}%> >Puerto Rico</option>
                                        <option value="Qatar" <%if (country.equals("Qatar")) {%> selected="selected" <%}%> >Qatar</option>
                                        <option value="Republic of Montenegro" <%if (country.equals("Republic of Montenegro")) {%> selected="selected" <%}%> >Republic of Montenegro</option>
                                        <option value="Republic of Serbia" <%if (country.equals("Republic of Serbia")) {%> selected="selected" <%}%> >Republic of Serbia</option>
                                        <option value="Reunion" <%if (country.equals("Reunion")) {%> selected="selected" <%}%> >Reunion</option>
                                        <option value="Romania" <%if (country.equals("Romania")) {%> selected="selected" <%}%> >Romania</option>
                                        <option value="Russia" <%if (country.equals("Russia")) {%> selected="selected" <%}%> >Russia</option>
                                        <option value="Rwanda" <%if (country.equals("Rwanda")) {%> selected="selected" <%}%> >Rwanda</option>
                                        <option value="St Barthelemy" <%if (country.equals("St Barthelemy")) {%> selected="selected" <%}%> >St Barthelemy</option>
                                        <option value="St Eustatius" <%if (country.equals("St Eustatius")) {%> selected="selected" <%}%> >St Eustatius</option>
                                        <option value="St Helena" <%if (country.equals("St Helena")) {%> selected="selected" <%}%> >St Helena</option>
                                        <option value="St Kitts-Nevis" <%if (country.equals("St Kitts-Nevis")) {%> selected="selected" <%}%> >St Kitts-Nevis</option>
                                        <option value="St Lucia" <%if (country.equals("St Lucia")) {%> selected="selected" <%}%> >St Lucia</option>
                                        <option value="St Maarten" <%if (country.equals("St Maarten")) {%> selected="selected" <%}%> >St Maarten</option>
                                        <option value="St Pierre &amp; Miquelon" <%if (country.equals("St Pierre &amp; Miquelon")) {%> selected="selected" <%}%> >St Pierre &amp; Miquelon</option>
                                        <option value="St Vincent &amp; Grenadines" <%if (country.equals("St Vincent &amp; Grenadines")) {%> selected="selected" <%}%> >St Vincent &amp; Grenadines</option>
                                        <option value="Saipan" <%if (country.equals("Saipan")) {%> selected="selected" <%}%> >Saipan</option>
                                        <option value="Samoa" <%if (country.equals("Samoa")) {%> selected="selected" <%}%> >Samoa</option>
                                        <option value="Samoa American" <%if (country.equals("Samoa American")) {%> selected="selected" <%}%> >Samoa American</option>
                                        <option value="San Marino" <%if (country.equals("San Marino")) {%> selected="selected" <%}%> >San Marino</option>
                                        <option value="Sao Tome &amp; Principe" <%if (country.equals("Sao Tome &amp; Principe")) {%> selected="selected" <%}%> >Sao Tome &amp; Principe</option>
                                        <option value="Saudi Arabia" <%if (country.equals("Saudi Arabia")) {%> selected="selected" <%}%> >Saudi Arabia</option>
                                        <option value="Senegal" <%if (country.equals("Senegal")) {%> selected="selected" <%}%> >Senegal</option>
                                        <option value="Serbia" <%if (country.equals("Serbia")) {%> selected="selected" <%}%> >Serbia</option>
                                        <option value="Seychelles" <%if (country.equals("Seychelles")) {%> selected="selected" <%}%> >Seychelles</option>
                                        <option value="Sierra Leone" <%if (country.equals("Sierra Leone")) {%> selected="selected" <%}%> >Sierra Leone</option>
                                        <option value="Singapore" <%if (country.equals("Singapore")) {%> selected="selected" <%}%> >Singapore</option>
                                        <option value="Slovakia" <%if (country.equals("Slovakia")) {%> selected="selected" <%}%> >Slovakia</option>
                                        <option value="Slovenia" <%if (country.equals("Slovenia")) {%> selected="selected" <%}%> >Slovenia</option>
                                        <option value="Solomon Islands" <%if (country.equals("Solomon Islands")) {%> selected="selected" <%}%> >Solomon Islands</option>
                                        <option value="Somalia" <%if (country.equals("Somalia")) {%> selected="selected" <%}%> >Somalia</option>
                                        <option value="South Africa" <%if (country.equals("South Africa")) {%> selected="selected" <%}%> >South Africa</option>
                                        <option value="Spain" <%if (country.equals("Spain")) {%> selected="selected" <%}%> >Spain</option>
                                        <option value="Sri Lanka" <%if (country.equals("Sri Lanka")) {%> selected="selected" <%}%> >Sri Lanka</option>
                                        <option value="Sudan" <%if (country.equals("Sudan")) {%> selected="selected" <%}%> >Sudan</option>
                                        <option value="Suriname" <%if (country.equals("Suriname")) {%> selected="selected" <%}%> >Suriname</option>
                                        <option value="Swaziland" <%if (country.equals("Sweden")) {%> selected="selected" <%}%> >Swaziland</option>
                                        <option value="Sweden" <%if (country.equals("Sweden")) {%> selected="selected" <%}%> >Sweden</option>
                                        <option value="Switzerland" <%if (country.equals("Switzerland")) {%> selected="selected" <%}%> >Switzerland</option>
                                        <option value="Syria" <%if (country.equals("Syria")) {%> selected="selected" <%}%> >Syria</option>
                                        <option value="Tahiti" <%if (country.equals("Tahiti")) {%> selected="selected" <%}%> >Tahiti</option>
                                        <option value="Taiwan" <%if (country.equals("Taiwan")) {%> selected="selected" <%}%> >Taiwan</option>
                                        <option value="Tajikistan" <%if (country.equals("Tajikistan")) {%> selected="selected" <%}%> >Tajikistan</option>
                                        <option value="Tanzania" <%if (country.equals("Tanzania")) {%> selected="selected" <%}%> >Tanzania</option>
                                        <option value="Thailand" <%if (country.equals("Thailand")) {%> selected="selected" <%}%> >Thailand</option>
                                        <option value="Togo" <%if (country.equals("Togo")) {%> selected="selected" <%}%> >Togo</option>
                                        <option value="Tokelau" <%if (country.equals("Tokelau")) {%> selected="selected" <%}%> >Tokelau</option>
                                        <option value="Tonga" <%if (country.equals("Tonga")) {%> selected="selected" <%}%> >Tonga</option>
                                        <option value="Trinidad &amp; Tobago" <%if (country.equals("Trinidad &amp; Tobago")) {%> selected="selected" <%}%> >Trinidad &amp; Tobago</option>
                                        <option value="Tunisia" <%if (country.equals("Tunisia")) {%> selected="selected" <%}%> >Tunisia</option>
                                        <option value="Turkey" <%if (country.equals("Turkey")) {%> selected="selected" <%}%> >Turkey</option>
                                        <option value="Turkmenistan" <%if (country.equals("Turkmenistan")) {%> selected="selected" <%}%> >Turkmenistan</option>
                                        <option value="Turks &amp; Caicos Is" <%if (country.equals("Turks &amp; Caicos Is")) {%> selected="selected" <%}%> >Turks &amp; Caicos Is</option>
                                        <option value="Tuvalu" <%if (country.equals("Tuvalu")) {%> selected="selected" <%}%> >Tuvalu</option>
                                        <option value="Uganda" <%if (country.equals("Uganda")) {%> selected="selected" <%}%> >Uganda</option>
                                        <option value="Ukraine" <%if (country.equals("Ukraine")) {%> selected="selected" <%}%> >Ukraine</option>
                                        <option value="United Arab Erimates" <%if (country.equals("United Arab Erimates")) {%> selected="selected" <%}%> >United Arab Emirates</option>
                                        <option value="United Kingdom" <%if (country.equals("United Kingdom")) {%> selected="selected" <%}%> >United Kingdom</option>
                                        <option value="United States of America" <%if (country.equals("United States of America")) {%> selected="selected" <%}%> >United States of America</option>
                                        <option value="Uraguay" <%if (country.equals("Uraguay")) {%> selected="selected" <%}%> >Uruguay</option>
                                        <option value="Uzbekistan" <%if (country.equals("Uzbekistan")) {%> selected="selected" <%}%> >Uzbekistan</option>
                                        <option value="Vanuatu" <%if (country.equals("Vanuatu")) {%> selected="selected" <%}%> >Vanuatu</option>
                                        <option value="Vatican City State" <%if (country.equals("Vatican City State")) {%> selected="selected" <%}%> >Vatican City State</option>
                                        <option value="Venezuela" <%if (country.equals("Venezuela")) {%> selected="selected" <%}%> >Venezuela</option>
                                        <option value="Vietnam" <%if (country.equals("Vietnam")) {%> selected="selected" <%}%> >Vietnam</option>
                                        <option value="Virgin Islands (Brit)" <%if (country.equals("Virgin Islands (Brit)")) {%> selected="selected" <%}%> >Virgin Islands (Brit)</option>
                                        <option value="Virgin Islands (USA)" <%if (country.equals("Virgin Islands (USA)")) {%> selected="selected" <%}%> >Virgin Islands (USA)</option>
                                        <option value="Wake Island" <%if (country.equals("Wake Island")) {%> selected="selected" <%}%> >Wake Island</option>
                                        <option value="Wallis &amp; Futana Is" <%if (country.equals("Wallis &amp; Futana Is")) {%> selected="selected" <%}%> >Wallis &amp; Futana Is</option>
                                        <option value="Yemen" <%if (country.equals("Yemen")) {%> selected="selected" <%}%> >Yemen</option>
                                        <option value="Zaire" <%if (country.equals("Zaire")) {%> selected="selected" <%}%> >Zaire</option>
                                        <option value="Zambia" <%if (country.equals("Zambia")) {%> selected="selected" <%}%> >Zambia</option>
                                        <option value="Zimbabwe" <%if (country.equals("Zimbabwe")) {%> selected="selected" <%}%> >Zimbabwe</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-lg-3 control-label">المدينة</label>
                                <div class="col-lg-8">
                                    <input class="form-control" value= "<%=city%>" type="text" name='city' id="city">
                                </div>
                            </div>




                            <div class="form-group">
                                <label class="col-md-3 control-label">كلمة المرور<span style="color: red">*</span></label>
                                <div class="col-md-8">
                                    <input class="form-control" value="<%=password%>" type="password"  name= 'password' id="password" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">تاكيد كلمة المرور<span style="color: red">*</span></label>
                                <div class="col-md-8">
                                    <input class="form-control" value="<%=password%>" type="password"  name= 'confirm_password' id="confirm_password" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">النوع</label>
                                <div class="col-md-8">
                                    <label class="control-label"> 
                                        <input type="radio" name= 'gender'  id='m' value='male' <%if (gender.equals("male")) {%> checked="checked" <%}%>> انثي 
                                        <input type="radio" name= 'gender'  id='f' value='female' <%if (gender.equals("female")) {%> checked="checked" <%}%> > ذكر
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label">الوصف</label>
                                <div class="col-md-8">
                                    <textarea class="form-control"  rows="5"  name='description' id="description"> <%=user_desc%> </textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 control-label"></label>
                                <div class="col-md-8">
                                    <input class="btn btn-success" onclick="return validateUpdateAccount()" value="حفظ التعديلات" type="submit">
                                </div>
                            </div>

                        </form>
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

    </body>
</html>