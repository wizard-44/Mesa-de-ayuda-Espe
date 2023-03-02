<?php
    /* Cadena de Conexion */
    require_once("../config/conexion.php");
    /* Modelo Subcategoria */
    require_once("../models/Subcategoria.php");
    $subcategoria = new Subcategoria();

    /*opciones del controlador Subcategoria*/
    switch($_GET["op"]){
        // /* Guardar y editar, guardar si el campo cats_id esta vacio */
        // case "guardaryeditar":
        //     if(empty($_POST["cats_id"])){
        //         $subcategoria->insert_subcategoria($_POST["cat_id"],$_POST["cats_nom"]);     
        //     }else {
        //         $subcategoria->update_subcategoria($_POST["cats_id"],$_POST["cat_id"],$_POST["cats_nom"]);
        //     }
        //     break;
        // /* Listado de prioridad segun formato json para el datatable */
        // case "listar":
        //     $datos=$subcategoria->get_subcategoria_all();
        //     $data= Array();
        //     foreach($datos as $row){
        //         $sub_array = array();
        //         $sub_array[] = $row["cat_nom"];
        //         $sub_array[] = $row["cats_nom"];
        //         $sub_array[] = '<button type="button" onClick="editar('.$row["cats_id"].');"  id="'.$row["cats_id"].'" class="btn btn-inline btn-warning btn-sm ladda-button"><i class="fa fa-edit"></i></button>';
        //         $sub_array[] = '<button type="button" onClick="eliminar('.$row["cats_id"].');"  id="'.$row["cats_id"].'" class="btn btn-inline btn-danger btn-sm ladda-button"><i class="fa fa-trash"></i></button>';
        //         $data[] = $sub_array;
        //     }

        //     $results = array(
        //         "sEcho"=>1,
        //         "iTotalRecords"=>count($data),
        //         "iTotalDisplayRecords"=>count($data),
        //         "aaData"=>$data);
        //     echo json_encode($results);
        //     break;
        // /* Actualizar estado a 0 segun id de prioridad */
        // case "eliminar":
        //     $subcategoria->delete_subcategoria($_POST["cats_id"]);
        //     break;
        // /* Mostrar en formato JSON segun prio_id */
        // case "mostrar";
        //     $datos=$subcategoria->get_subcategoria_x_id($_POST["cats_id"]);  
        //     if(is_array($datos)==true and count($datos)>0){
        //         foreach($datos as $row)
        //         {
        //             $output["cats_id"] = $row["cats_id"];
        //             $output["cat_id"] = $row["cat_id"];
        //             $output["cats_nom"] = $row["cats_nom"];
        //         }
        //         echo json_encode($output);
        //     }
        //     break;
        /* Formato para llenar combo en formato HTML */
        case "combo":
            $datos = $subcategoria->get_subcategoria($_POST["cat_id"]);
            $html="";
            $html.="<option label='Seleccionar'></option>";
            // $html.="<option label='Seleccionar'></option>";
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $html.= "<option value='".$row['cats_id']."'>".$row['cats_nom']."</option>";
                }
                echo $html;
            }
            break;
    }
?>