var tabla;

function init(){

}

$(document).ready(function(){

    $('#rol_id').select2({
        dropdownParent: $('#modal_nuevo_registro')
    });

    tabla=$('#usuario_data').dataTable({
        "aProcessing": true,
        "aServerSide": true,
        dom: 'Bfrtip',
        "searching": true,
        lengthChange: false,
        colReorder: true,
        buttons: [
                'copyHtml5',
                'excelHtml5',
                'csvHtml5',
                'pdfHtml5'
                ],
        "ajax":{
            url: '../../controller/usuario.php?op=listar',
            type : "post",
            dataType : "json",
            error: function(e){
                console.log(e.responseText);
            }
        },
        "ordering": false,
        "bDestroy": true,
        "responsive": true,
        "bInfo":true,
        "iDisplayLength": 10,
        "autoWidth": false,
        "language": {
            "sProcessing":     "Procesando...",
            "sLengthMenu":     "Mostrar _MENU_ registros",
            "sZeroRecords":    "No se encontraron resultados",
            "sEmptyTable":     "Ningún dato disponible en esta tabla",
            "sInfo":           "Mostrando un total de _TOTAL_ registros",
            "sInfoEmpty":      "Mostrando un total de 0 registros",
            "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix":    "",
            "sSearch":         "Buscar:",
            "sUrl":            "",
            "sInfoThousands":  ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst":    "Primero",
                "sLast":     "Último",
                "sNext":     "Siguiente",
                "sPrevious": "Anterior"
            },
            "oAria": {
                "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }
        }     
    }).DataTable();     

});

function editar(usu_id){
    // $('#mdltitulo').html('Nuevo Registro');
    // $('#modal_nuevo_registro').modal('show');
}

function eliminar(usu_id){
    swal({
        title: "Advertencia",
        text: "Esta seguro de Eliminar la Cuenta?",
        type: "error",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Si",
        cancelButtonText: "No",
        closeOnConfirm: false,
        closeOnCancel: false
    },
    function(isConfirm) {
        if (isConfirm) {
            $.post("../../controller/usuario.php?op=eliminar", { usu_id : usu_id  }, function (data) {
                   
            });

            $('#usuario_data').DataTable().ajax.reload();

            swal({
                title: "Cuenta Eliminada",
                text: "La Cuenta ha sido cerrado correctamente.",
                type: "success",
                confirmButtonClass: "btn-success"
            });
        } else {
            swal({
                title: "Cancelado",
                text: "La Cuenta sigue abierta :)",
                type: "error",
                confirmButtonClass: "btn-danger"
            });
        }
    });
}

$(document).on("click","#btnnuevo",function(){
    $('#mdltitulo').html('Nuevo Registro');
    $('#modal_nuevo_registro').modal('show');
});

init();