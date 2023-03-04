$(document).on("click","#btnactualizar", function(){
    var pass = $("#txtpass").val();
    var newpass = $("#txtpassnew").val();
 
    /* validamos que los campos no esten vacios antes de guardar */
     if (pass.length == 0 || newpass.length == 0) {
        swal("Error!", "Campos Vacios", "error");
     }else{
         /* validamos que la contraseñas sean iguales */
         if (pass==newpass){
 
             /* Procedemos con la actualizacion */
             var usu_id = $('#user_idx').val();
             $.post("../../controller/usuario.php?op=password", {usu_id:usu_id,usu_pass:newpass}, function (data) {
                swal("Correcto!", "Contraseña Actualizada Correctamente", "success");
             });
 
         }else{
             /* Mensaje de alerta en caso de error */
             swal("Error!", "Las contraseñas no coinciden", "error");
         }
     }
 });