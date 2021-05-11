<?php

class ProductsModel extends CI_Model
{
    public function getAllProducts()
    {
        $query = $this->db->get('products');
        $results = $query->result();
        foreach ($results as $result) {
            $query = $this->db->query("select name,url from product_images where product_id=?", array($result->id));
            $result->images = $query->result();
        }
        foreach ($results as $result) {
            $query = $this->db->query("
            select id,size from sizes
            join product_sizes
            on product_sizes.size_id = sizes.id
            where product_sizes.product_id= ?
            ", array($result->id));
            $result->availableSizes = $query->result();
        }

        // die('done');
        return $results;
    }
    public function getProductById($id)
    {
        // get product by Id
        $query = $this->db->query("select * from products where id=?", array($id));
        $result = $query->row();

        // get images for the product
        $query_images = $this->db->query("select name,url from product_images where product_id=?", array($result->id));
        $result->images = $query_images->result();

        // get available sizes for this product
        $query_availableSizes = $this->db->query("select id,size from sizes
        join product_sizes
        on product_sizes.size_id = sizes.id
        where product_sizes.product_id = ?", array($result->id));
        $result->availableSizes = $query_availableSizes->result();


        return $result;
        // echo "<pre>" . print_r($result, true) . "</pre>";
        // die();
    }
}
