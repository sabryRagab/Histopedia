/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function validateEmail(email) {
    var re = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
     //       /^(([^<>()[]\.,;:s@"]+(.[^<>()[]\.,;:s@"]+)*)|())@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateUpdateAccount()
{
    var name=document.forms["editForm"]["name"].value;
    var email=document.forms["editForm"]["email"].value;
    var password=document.forms["editForm"]["password"].value;
    var confirm_password=document.forms["editForm"]["confirm_password"].value;
    
    if( ( name === "" )||( name === null ) ){
         document.getElementById("js_output").innerHTML = "Name is Required!";
         return false;
    }
     if( ( email === "" )||( email === null ) ){
         document.getElementById("js_output").innerHTML = "Email is Required!";
         return false;
    }
    if( ( password === "" )||( password === null ) ){
         document.getElementById("js_output").innerHTML = "Password is Required!";
         return false;
    }
    if( ( confirm_password === "" )||( confirm_password === null ) ){
         document.getElementById("js_output").innerHTML = "Confirm Password is Required!";
         return false;
    }
    if( !validateEmail(email) ){
        document.forms["editForm"]["email"].value="";
        document.getElementById("js_output").innerHTML = "Email is wrong!";
        return false;
    }
    if( !(password === confirm_password) ){
        document.forms["editForm"]["confirm_password"].value="";
        document.getElementById("js_output").innerHTML = "Confirm Password is wrong!";
        return false;
    }
    
    return true;
}