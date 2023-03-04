<?php
    /* Cadena de Conexion */
    require_once("../config/conexion.php");
    /* Modelo Categoria */
    require_once("../models/Categoria.php");
    $categoria = new Categoria();

    /*opciones del controlador Categoria*/
    switch($_GET["op"]){
        /* Guardar y editar, guardar si el campo cat_id esta vacio */
        case "guardaryeditar":
            /* Actualizar si el campo cat_id tiene informacion */
            if(empty($_POST["cat_id"])){       
                $categoria->insert_categoria($_POST["cat_nom"]);     
            }
            else {
                $categoria->update_categoria($_POST["cat_id"],$_POST["cat_nom"]);
            }
            break;

        /* Listado de categoria segun formato json para el datatable */
        case "listar":
            $datos=$categoria->get_categoria();
            $data= Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["cat_nom"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["cat_id"].');"  id="'.$row["cat_id"].'" class="btn btn-inline btn-warning btn-sm ladda-button"><i class="fa fa-edit"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["cat_id"].');"  id="'.$row["cat_id"].'" class="btn btn-inline btn-danger btn-sm ladda-button"><i class="fa fa-trash"></i></button>';
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;

        /* Actualizar estado a 0 segun id de categoria */
        case "eliminar":
            $categoria->delete_categoria($_POST["cat_id"]);
            break;

        /* Mostrar en formato JSON segun cat_id */
        case "mostrar";
            $datos=$categoria->get_categoria_x_id($_POST["cat_id"]);  
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $output["cat_id"] = $row["cat_id"];
                    $output["cat_nom"] = $row["cat_nom"];
                }
                echo json_encode($output);
            }
            break;

        /* Formato para llenar combo en formato HTML */
        case "combo":
            $datos = $categoria->get_categoria();
            $html="";
            $html.="<option label='Seleccionar'></option>";
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $html.= "<option value='".$row['cat_id']."'>".$row['cat_nom']."</option>";
                }
                echo $html;
            }
            break;
    }
?>