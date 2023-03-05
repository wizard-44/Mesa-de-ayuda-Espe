<?php

    require_once("../Models/Ticket.php");

    class Chatgpt extends Conectar{

        public function get_respuestaia($tick_id){
            $ticket = new Ticket();
            $datos = $ticket->listar_ticket_x_id($tick_id);
            foreach ($datos as $row){
                $tick_descrip = $row["tick_descrip"];
            }

            $apikey = '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';

            $data = [
                'model' => 'text-davinci-002',
                'prompt' => 'Responde como un tecnico de soporte ti: '.$tick_descrip,
                'temperature' => 0.7,
                'max_tokens' => 300,
                'n' => 1,
                'stop' => ['\n']
            ];

            $ch = curl_init('https://api.openai.com/v1/completions');
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Authorization: Bearer ' . $apikey
            ));

            $response = curl_exec($ch);
            $responseArr = json_decode($response,true);
            $responseText = $responseArr['choices'][0]['text'];
            return $responseText;

        }

    }
?>