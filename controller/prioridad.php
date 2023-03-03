<?php
    /* TODO:Cadena de Conexion */
    require_once("../config/conexion.php");
    /* TODO:Modelo Prioridad */
    require_once("../models/Prioridad.php");
    $prioridad = new Prioridad();

    /*TODO: opciones del controlador Prioridad*/
    switch($_GET["op"]){
        /* TODO: Guardar y editar, guardar si el campo prio_id esta vacio */
        case "guardaryeditar":
            if(empty($_POST["prio_id"])){       
                $prioridad->insert_prioridad($_POST["prio_nom"]);     
            }
            else {
                $prioridad->update_prioridad($_POST["prio_id"],$_POST["prio_nom"]);
            }
            break;

        /* TODO: Listado de prioridad segun formato json para el datatable */
        case "listar":
            $datos=$prioridad->get_prioridad();
            $data= Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["prio_nom"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["prio_id"].');"  id="'.$row["prio_id"].'" class="btn btn-inline btn-warning btn-sm ladda-button"><i class="fa fa-edit"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["prio_id"].');"  id="'.$row["prio_id"].'" class="btn btn-inline btn-danger btn-sm ladda-button"><i class="fa fa-trash"></i></button>';
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;
        /* TODO: Actualizar estado a 0 segun id de prioridad */
        case "eliminar":
            $prioridad->delete_prioridad($_POST["prio_id"]);
            break;
        
        /* TODO: Mostrar en formato JSON segun prio_id */
        case "mostrar";
            $datos=$prioridad->get_prioridad_x_id($_POST["prio_id"]);
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $output["prio_id"] = $row["prio_id"];
                    $output["prio_nom"] = $row["prio_nom"];
                }
                echo json_encode($output);
            }
            break;
        /* TODO: Formato para llenar combo en formato HTML */
        case "combo":
            $datos = $prioridad->get_prioridad();
            $html="";
            $html.="<option label='Seleccionar'></option>";
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $html.= "<option value='".$row['prio_id']."'>".$row['prio_nom']."</option>";
                }
                echo $html;
            }
            break;
    }
?>