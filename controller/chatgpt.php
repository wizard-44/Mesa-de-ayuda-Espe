<?php

    require_once("../config/conexion.php");
    require_once("../models/Chatgpt.php");
    $chatgpt = new Chatgpt();

    switch ($_GET["op"]) {

        case "respuestaia":
            $datos=$chatgpt->get_respuestaia($_POST["tick_id"]);
            echo $datos;
            break;
    }
?>