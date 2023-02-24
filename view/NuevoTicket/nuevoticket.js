$(document).ready(function() {
    $('#tick_descrip').summernote({
        height: 150
    });

    $.post("../../controller/categoria.php?op=combo",function(data,status){
        $('#cat_id').html(data);
    });
});