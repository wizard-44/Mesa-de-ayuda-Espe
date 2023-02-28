function init(){

}

$(document).ready(function(){ 
    var tick_id = getUrlParameter('ID');

    listardetalle(tick_id);

    $.post("../../controller/ticket.php?op=mostrar", { tick_id : tick_id }, function (data) {
        data = JSON.parse(data);
        $('#lblestado').html(data.tick_estado);
        $('#lblnomusuario').html(data.usu_nom+' '+data.usu_ape);
        $('#lblfechcrea').html(data.fech_crea);
        $('#lblnomidticket').html("Detalle Ticket - "+data.tick_id);
        $('#tick_titulo').val(data.tick_titulo);
        $('#cat_nom').val(data.cat_nom);
        $('#tickd_descripusu').summernote('code',data.tick_descrip);   
    });
    
    $('#tickd_descrip').summernote({
        height: 400,
        lang: "es-ES",
        callbacks: {
            onImageUpload: function(image){
                console.log("Image detect...");
                myimagestreat(image[0]);
            },
            onPaste: function (e){
                console.log("Text destect...");
            }
        }
    });

    $('#tickd_descripusu').summernote({
        height: 400,
        lang: "es-ES"
    });

    $('#tickd_descripusu').summernote('disable');

});

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

$(document).on("click","#btnenviar",function(){
    var tick_id = getUrlParameter('ID');
    var usu_id = $('#user_idx').val();
    var tickd_descrip = $('#tickd_descrip').val();
    if ($('#tickd_descrip').summernote('isEmpty')){
        swal("Advertencia!", "Campo de Descripción Vacio", "warning");
    }else{
        $.post("../../controller/ticket.php?op=insertdetalle", { tick_id : tick_id, usu_id : usu_id, tickd_descrip : tickd_descrip }, function (data) {
            listardetalle(tick_id);
            $('#tickd_descrip').summernote("reset");
            swal("Correcto!", "Registrado Correctamente: ","success");
        });
    }
});

$(document).on("click","#btncerrarticket",function(){
    swal({
        title: "Advertencia",
        text: "Esta seguro de Cerrar el Ticket?",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-warning",
        confirmButtonText: "Si",
        cancelButtonText: "No",
        closeOnConfirm: false,
        closeOnCancel: false
    },
    function(isConfirm) {
        if (isConfirm) {
            var tick_id = getUrlParameter('ID');
            $.post("../../controller/ticket.php?op=update", { tick_id : tick_id }, function (data) {
                data = JSON.parse(data);    
            });
            swal({
                title: "Ticket Cerrado",
                text: "El ticket ha sido cerrado correctamente.",
                type: "success",
                confirmButtonClass: "btn-success"
            });
        } else {
            swal({
                title: "Cancelado",
                text: "El ticket sigue abierto :)",
                type: "error",
                confirmButtonClass: "btn-danger"
            });
        }
    });
});

function listardetalle(tick_id){
    $.post("../../controller/ticket.php?op=listardetalle", { tick_id : tick_id }, function (data) {
        $('#lbldetalle').html(data);
    });
}

init();