<?php
    /* TODO:Cadena de Conexion */
    require_once("../config/conexion.php");
    /* TODO:Modelo Categoria */
    require_once("../models/Ticket.php");
    $ticket = new Ticket();

    switch($_GET["op"]){
        case "insert":
            $ticket->insert_ticket($_POST["usu_id"],$_POST["cat_id"],$_POST["tick_titulo"],$_POST["tick_descrip"]);
        break;
    }
?>