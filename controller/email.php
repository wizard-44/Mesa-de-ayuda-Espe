<?php
    /* llamada a las clases necesarias */
    require_once("../config/conexion.php");
    require_once("../models/Email.php");
    $email = new Email();

    /* opciones del controlador */
    switch ($_GET["op"]) {
        /* enviar ticket abierto segun el ID */
        case "ticket_abierto":
            $email->ticket_abierto($_POST["tick_id"]);
            break;

        /* enviar ticket Cerrado segun el ID */
        case "ticket_cerrado":
            $email->ticket_cerrado($_POST["tick_id"]);
            break;

        /* enviar ticket asignado segun el ID */
        case "ticket_asignado":
            $email->ticket_asignado($_POST["tick_id"]);
            break;
    }
?>