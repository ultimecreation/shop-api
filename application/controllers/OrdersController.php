<?php

use Firebase\JWT\JWT;

defined('BASEPATH') or exit('No direct script access allowed');

class OrdersController extends CI_Controller
{
    // GET REQUEST
    public function list()
    {
        $products = $this->ProductsModel->getAllProducts();
        //$base_url = base_url();
        return $this->output
            ->set_content_type('application/json')
            ->set_status_header(200)
            ->set_output(json_encode($products));
    }

    // POST REQUEST
    public function create()
    {
        $incomingData = json_decode($this->input->raw_input_stream);

        // get authorization token,remove Bearer,and decode jwt
        $token = $incomingData->token;
        $authToken = str_replace('Bearer ', '', $token);
        $userData =  JWT::decode($authToken, JWT_SECRET, array('HS256'));


        // get and sanitize user email
        $userEmail = htmlspecialchars(strip_tags($userData->user->email));

        if (empty($userEmail)) {
            $error['email'] = "L'email est absent";
        }
        if (!filter_var($userEmail, FILTER_VALIDATE_EMAIL)) {
            $error['email'] = "L'email n'est pas valide";
        }
        if (!empty($error)) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(500)
                ->set_output(json_encode(array("error" => $error)));
        }

        $user = $this->AccessModel->isEmailInDb($userData->user->email);
        if ($user) {
            $userId = $user->id;
        }


        // assign incoming data to variables

        $paymentStatus = $incomingData->paymentStatus;
        $paymentId = $incomingData->paymentId;
        $cartItems = $incomingData->validatedCart;
        $errors = [];
        if (!filter_var($paymentStatus, FILTER_VALIDATE_INT) || $paymentStatus === 0) {
            $errors['paymentStatus'] = "Le status de paiement n'est pas valide";
        }
        if (!filter_var($paymentId, FILTER_SANITIZE_STRING)) {
            $errors['paymentStatus'] = "Le status de paiement n'est pas valide";
        }

        foreach ($cartItems as $item) {
            if (!filter_var($item->itemId, FILTER_VALIDATE_INT)) {
                $errors['itemId'] = "L' Id de l'article n'est pas valide";
            }
            if (!filter_var($item->itemTitle, FILTER_SANITIZE_STRING)) {
                $errors['itemTitle'] = "Le nom de l'article n'est pas valide";
            }
            if (!filter_var($item->selectedSize, FILTER_SANITIZE_STRING)) {
                $errors['selectedSize'] = "La taille de l'article n'est pas valide";
            }
            if (!filter_var($item->itemCount, FILTER_VALIDATE_INT)) {
                $errors['itemCount'] = "Le NOMBRE d'article n'est pas valide";
            }
            if (!filter_var($item->itemPrice, FILTER_VALIDATE_FLOAT)) {
                $errors['itemPrice'] = "Le prix de l'article n'est pas valide";
            }
        }
        if (!empty($errors)) {
            $this->output
                ->set_content_type('application/json')
                ->set_status_header(400)
                ->set_output(json_encode($errors));
        }

        if (empty($errors)) {

            $done = $this->OrdersModel->saveNewOrder($userId, $paymentId, $paymentStatus, $cartItems);

            if ($done === true) {

                $response = new stdClass();
                $response->status = "success";
                $response->userId = $userId;
                $response->paymentStatus = $paymentStatus;
                $response->paymentId = $paymentId;
                $response->cartItems = $cartItems;

                return $this->output
                    ->set_content_type('application/json')
                    ->set_status_header(201)
                    ->set_output(json_encode($response));
            }
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(500)
                ->set_output(json_encode(array("erreur" => "Une erreur est survenue durant l'enregistrement")));
        }
    }
    public function userOrders()
    {

        $incomingData = json_decode($this->input->raw_input_stream);
        // sanitize email
        $email = htmlspecialchars(strip_tags($incomingData->email));
        $error = null;
        // validate email
        if (empty($email)) {
            $error['email'] = "L'email n'est pas défini";
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $error['email'] = "L'email n'est pas valide";
        }
        if (!empty($error)) {
            return $this->output
                ->set_content_type('application/json')
                ->set_status_header(100)
                ->set_output(json_encode(array('error' => $error)));
            exit;
        }

        if ($error === null) {

            // no error,process the data
            $user = $this->AccessModel->isEmailInDb($email);
            if ($user) {
                $ordersByUser = $this->OrdersModel->getOrdersByUser($user->id);

                return $this->output->set_content_type("application/json")
                    ->set_status_header(200)
                    ->set_output(json_encode($ordersByUser));
            }
        }
    }
}
