var tabla;

function init(){
    $("#usuario_form").on("submit",function(e){
        guardaryeditar(e);	
    });
}

/*  Guardar datos de los input */
function guardaryeditar(e){
    e.preventDefault();
	var formData = new FormData($("#usuario_form")[0]);
    $.ajax({
        url: "../../controller/prioridad.php?op=guardaryeditar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(datos){    
            console.log(datos);
            $('#usuario_form')[0].reset();
            /* Ocultar Modal */
            $("#modalmantenimiento").modal('hide');
            $('#usuario_data').DataTable().ajax.reload();

             /* Mensaje de Confirmacion */
            swal({
                title: "HelpDesk Prioridad!",
                text: "Operacion realizada con exito.",
                type: "success",
                confirmButtonClass: "btn-success"
            });
        }
    }); 
}

$(document).ready(function(){
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
            url: '../../controller/prioridad.php?op=listar',
            type : "post",
            dataType : "json",						
            error: function(e){
                console.log(e.responseText);	
            }
        },
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

/*  Mostrar informacion segun ID en los inputs */
function editar(prio_id){
    $('#mdltitulo').html('Editar Prioridad');

    /*  Mostrar Informacion en los inputs */
    $.post("../../controller/prioridad.php?op=mostrar", {prio_id : prio_id}, function (data) {
        data = JSON.parse(data);
        $('#prio_id').val(data.prio_id);
        $('#prio_nom').val(data.prio_nom);
    }); 

    /*  Mostrar Modal */
    $('#modalmantenimiento').modal('show');
}

/* Cambiar estado a eliminado en caso de confirmar mensaje */
function eliminar(prio_id){
    swal({
        title: "Eliminar Prioridad",
        text: "Esta seguro de Eliminar la Prioridad?",
        type: "error",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Si",
        cancelButtonText: "No",
        closeOnConfirm: false
    },
    function(isConfirm) {
        if (isConfirm) {
            $.post("../../controller/prioridad.php?op=eliminar", {prio_id : prio_id}, function (data) {

            }); 

            $('#usuario_data').DataTable().ajax.reload();	

            swal({
                title: "Eliminar Prioridad!",
                text: "El ticket Eliminado.",
                type: "success",
                confirmButtonClass: "btn-success"
            });
        }
    });
}

/* Limpiar Inputs */
$(document).on("click","#btnnuevo", function(){
    $('#prio_id').val('');
    $('#mdltitulo').html('Nueva Prioridad');
    $('#usuario_form')[0].reset();
    /* Mostrar Modal */
    $('#modalmantenimiento').modal('show');
});

init();