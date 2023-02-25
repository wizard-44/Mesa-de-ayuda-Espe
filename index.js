function init(){
    
}

$(document).ready(function() {
    
});

$(document).on("click", "#btnsoporte", function () {
    if ($('#rol_id').val()==1){
        $('#lbltitulo').html("Soporte");
        $('#btnsoporte').html("Acceso Usuario");
        $('#rol_id').val(2);
        $("#imgtipo").attr("src","public/2.jpg");
    }else{
        $('#lbltitulo').html("Usuario");
        $('#btnsoporte').html("Acceso Soporte");
        $('#rol_id').val(1);
        $("#imgtipo").attr("src","public/1.jpg");
    }
});

init();