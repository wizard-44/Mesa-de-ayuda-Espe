<?php
    class Documento extends Conectar{
        /* TODO: Insertar registro  */
        public function insert_documento($tick_id,$doc_nom){
            $conectar= parent::conexion();
            /* consulta sql */
            $sql="INSERT INTO td_documento (doc_id,tick_id,doc_nom,fech_crea,est) VALUES (null,?,?,now(),1);";
            $sql = $conectar->prepare($sql);
            $sql->bindParam(1,$tick_id);
            $sql->bindParam(2,$doc_nom);
            $sql->execute();
        }

        /* TODO: Obtener Documento por Ticket */
        public function get_documento_x_ticket($tick_id){
            $conectar= parent::conexion();
            /* consulta sql */
            $sql="SELECT * FROM td_documento WHERE tick_id=?";
            $sql = $conectar->prepare($sql);
            $sql->bindParam(1,$tick_id);
            $sql->execute();
            return $resultado = $sql->fetchAll(pdo::FETCH_ASSOC);
        }

        // /* TODO: insertar documento detalle */
        // public function insert_documento_detalle($tickd_id,$det_nom){
        //     $conectar= parent::conexion();
        //     /* consulta sql */
        //     $sql="INSERT INTO td_documento_detalle (det_id,tickd_id,det_nom,est) VALUES (null,?,?,1);";
        //     $sql = $conectar->prepare($sql);
        //     $sql->bindParam(1,$tickd_id);
        //     $sql->bindParam(2,$det_nom);
        //     $sql->execute();
        // }

        // /* TODO: Obtener Documento x detalle */
        // public function get_documento_detalle_x_ticketd($tickd_id){
        //     $conectar= parent::conexion();
        //     /* consulta sql */
        //     $sql="SELECT * FROM td_documento_detalle WHERE tickd_id=?";
        //     $sql = $conectar->prepare($sql);
        //     $sql->bindParam(1,$tickd_id);
        //     $sql->execute();
        //     return $resultado = $sql->fetchAll(pdo::FETCH_ASSOC);
        // }
    }
?>