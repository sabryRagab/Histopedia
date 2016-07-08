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

function validateSignin()
{
    var email = document.forms["signin"]["email"].value;
    var password = document.forms["signin"]["password"].value;
    if ((email === "") || (email === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Email is Required!</div> ";
        return false;
    }
    if ((password === "") || (password === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Password is Required!</div> ";
        return false;
    }
    if (!validateEmail(email)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Not a valid email format!</div> ";
        document.forms["signin"]["email"].value = "";
        return false;
    }

    return true;
}
