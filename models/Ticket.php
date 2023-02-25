<?php
    class Ticket extends Conectar{
        public function insert_ticket($usu_id,$cat_id,$tick_titulo,$tick_descrip){
            $conectar= parent::conexion();
            parent::set_names();
            $sql="INSERT INTO tm_ticket (tick_id, usu_id, cat_id, tick_titulo, tick_descrip, est) VALUES (NULL, ?, ?, ?, ?, '1');";
            $sql=$conectar->prepare($sql);
            $sql->bindValue(1,$usu_id);
            $sql->bindValue(2,$cat_id);
            $sql->bindValue(3,$tick_titulo);
            $sql->bindValue(4,$tick_descrip);
            $sql->execute();
            return $resultado=$sql->fetchAll();
        }
    }
?>