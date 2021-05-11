<?php
defined('BASEPATH') or exit('No direct script access allowed');

use \Firebase\JWT\JWT;

class AccessController extends CI_Controller
{

    public function register()
    {
        // check if incoming data else return error
        if (!$this->input->raw_input_stream) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(400)
                ->set_output(json_encode(array('errors' => 'pas de données à traiter')));
        }

        // get and decode incoming data
        $incomingData = json_decode($this->input->raw_input_stream);
        $errors = [];

        // sanitize incoming data
        $name = htmlspecialchars(strip_tags($incomingData->name));
        $email = htmlspecialchars(strip_tags($incomingData->email));
        $password = htmlspecialchars(strip_tags($incomingData->password));
        $password_confirm = htmlspecialchars(strip_tags($incomingData->password_confirm));

        // run data validation
        if (empty($name)) {
            $errors['name'] = "Le nom est requis";
        }
        if (empty($email)) {
            $errors['email'] = "L'email est requis";
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = "L'email n'est pas valide";
        }
        if ($this->AccessModel->isEmailInDb($email)) {
            $errors['email'] = "L'email est déjà prit";
        }
        if (empty($password)) {
            $errors['password'] = "Le mot de passe est requis";
        }
        if (empty($password_confirm)) {
            $errors['password_confirm'] = "La confirmation du mot de passe est requise";
        }
        if ($password !== $password_confirm) {
            $errors['password'] = "Les mots de passe ne correspondent pas";
        }

        // if there are errors ,return errors
        if (!empty($errors)) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(400)
                ->set_output(json_encode(array('errors' => $errors)));
        }
        // no errors, process the data
        else {

            // encrypt password
            $password = password_hash($password_confirm, PASSWORD_BCRYPT, array('cost' => 13));


            $userSaved =  $this->AccessModel->saveNewUser($name, $email, $password);
            if ($userSaved) {

                return $this->output
                    ->set_content_type('application/json')
                    ->set_status_header(201)
                    ->set_output(json_encode(array('success' => $userSaved)));
            }
        }
    }

    public function login()
    {
        // check if incoming data else return error
        if (!$this->input->raw_input_stream) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(400)
                ->set_output(json_encode(array('errors' => 'pas de données à traiter')));
        }

        // get and decode incoming data
        $incomingData = json_decode($this->input->raw_input_stream);
        $errors = [];

        // sanitize incoming data

        $email = htmlspecialchars(strip_tags($incomingData->email));
        $password = htmlspecialchars(strip_tags($incomingData->password));

        // run data validation
        if (empty($email)) {
            $errors['email'] = "L'email est requis";
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = "L'email n'est pas valide";
        }
        if (empty($password)) {
            $errors['password'] = "Le mot de passe est requis";
        }

        // if there are errors ,return errors
        if (!empty($errors)) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(400)
                ->set_output(json_encode(array('errors' => $errors)));
        }
        // no errors, process the data
        else {

            $userFound = $this->AccessModel->isEmailInDb($email);
            if (!$userFound) {
                return $this->output
                    ->set_content_type('application/json')
                    ->set_status_header(400)
                    ->set_output(json_encode(array('errors' => "L'utilisateur n'existe pas")));
            }

            // verify password
            if (password_verify($password, $userFound->password)) {
                // set user data to send back
                unset($userFound->id, $userFound->password, $userFound->created_at);

                $key = JWT_SECRET;
                $payload = array(
                    "user" => $userFound,
                    "iss" => base_url(),
                    "aud" => base_url(),
                    "iat" => time(),
                    "nbf" => time(),
                    "exp" => time() + (3600 * 12)
                );

                $jwt = JWT::encode($payload, $key);


                return $this->output
                    ->set_content_type('application/json')
                    ->set_status_header(200)
                    ->set_output(json_encode(array('token' => "Bearer $jwt")));
            } else {
                return $this->output
                    ->set_content_type('application/json')
                    ->set_status_header(400)
                    ->set_output(json_encode(array('errors' => "L'utilisateur n'existe pas")));
            }
        }
    }
}
