<?php
defined('BASEPATH') or exit('No direct script access allowed');

class ProductsController extends CI_Controller
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

    // GET REQUEST
    public function getOneById()
    {
        $id = $this->uri->segment(4);
        $product = $this->ProductsModel->getProductById($id);

        return $this->output
            ->set_content_type('application/json')
            ->set_status_header(200)
            ->set_output(json_encode($product));
    }
}
