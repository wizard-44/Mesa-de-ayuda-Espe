<?php
    require_once("../../config/conexion.php");
    /* TODO: Destruir Session */
    session_destroy();
    /* TODO: Luego de cerrar session enviar a la pantalla de login */
    header("Location:".Conectar::ruta()."index.php");
    exit();
?>