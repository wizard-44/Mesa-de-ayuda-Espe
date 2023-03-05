$(document).ready(function(){

    mostrar_notificacion();

});

function mostrar_notificacion(){

    var formData = new FormData();
    formData.append('usu_id',$('#user_idx').val());

    $.ajax({
        url: "../../controller/notificacion.php?op=mostrar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(data){
            if (data==''){

            }else{
                data = JSON.parse(data);
                $.notify({
                    icon: 'glyphicon glyphicon-star',
                    message: data.not_mensaje,
                    url: "http://localhost/MESA-DE-AYUDA-ESPE/view/DetalleTicket/?ID="+data.tick_id
                });

                $.post("../../controller/notificacion.php?op=actualizar", {not_id : data.not_id}, function (data) {

                });
            }
        }
    });

}

setInterval(function(){
    mostrar_notificacion();
}, 5000);


