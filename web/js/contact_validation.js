/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validatePhoneNumber(inputtxt) {  
   var phoneno = /^\d{13}$/;  
   return phoneno.test(inputtxt);
}

function validateEmail(email) {
    var re = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
     //       /^(([^<>()[]\.,;:s@"]+(.[^<>()[]\.,;:s@"]+)*)|())@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateContact()
{
    var name=document.forms["contact_form"]["name"].value;
    var email=document.forms["contact_form"]["email"].value;
    var phone=document.forms["contact_form"]["phone"].value;
    var message=document.forms["contact_form"]["message"].value;
    if( ( name === "" )||( name === null ) ){
         alert("Who are you?");
         return false;
    }
    if( ( message === "" )||( message === null ) ){
         alert("What do you want?");
         return false;
    }
    if(  (( email === "" )||( email === null ) ) &&
         (( phone === "" )||( phone === null ) )) {
         alert("Email or Phone at least one is Required! ");
         return false;
    }
    if( (!validateEmail(email))&& 
        (( phone === "" )||( phone === null ) ) ){
        document.forms["contact_form"]["email"].value="";
        alert("Email is wrong!");
        return false;
    }
    if( (!validatePhoneNumber(phone))&&
         (!(( phone === "" )||( phone === null ) ))) {
        document.forms["contact_form"]["phone"].value="";
        alert("Phone is wrong!");
        return false;
    }
    
    return true;
}
