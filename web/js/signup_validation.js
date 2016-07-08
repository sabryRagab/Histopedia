/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validateEmail(email) {
    var re = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    //   /^(([^<>()[]\.,;:s@"]+(.[^<>()[]\.,;:s@"]+)*)|())@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateSignup()
{
    var name = document.forms["signup"]["name"].value;
    var email = document.forms["signup"]["email"].value;
    var password = document.forms["signup"]["password"].value;
    var confirm_password = document.forms["signup"]["confirm_password"].value;

    if ((name === "") || (name === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Name is Required!</div> ";
        return false;
    }
    if ((email === "") || (email === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Email is Required!</div> ";
        return false;
    }
    if ((password === "") || (password === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Password is Required!</div> ";

        return false;
    }
    if ((confirm_password === "") || (confirm_password === null)) {
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>Confirm Password is Required!</div> ";
        return false;
    }
    if (!validateEmail(email)) {
        document.forms["signup"]["email"].value = "";
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> Invalid email!</div> ";
        return false;
    }
    if (!(password === confirm_password)) {
        document.forms["signup"]["confirm_password"].value = "";
        document.getElementById("js_output").innerHTML = "<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> Unmatched password!</div> ";
        return false;
    }

    return true;
}
