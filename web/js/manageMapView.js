$(document).ready(function () {

    $(".view_event_anchor").click(function () {
        revealMe(this);
    });

    function revealMe(element) {
        $(".hideme").show("slow");
        $(".hideme").not("#" + element.id).hide("slow");
        $(element).show();
    }

});