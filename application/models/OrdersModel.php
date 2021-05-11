<?php
defined('BASEPATH') or exit('No direct script access allowed');
class OrdersModel extends CI_Model
{
    public function saveNewOrder($userId, $paymentId, $paymentStatus, $cartItems)
    {

        $this->db->query("INSERT INTO orders SET user_id=?,payment_id=?,payment_status=?", array($userId, $paymentId, $paymentStatus));
        $order_id = $this->db->insert_id();
        if ($order_id) {
            $this->db->trans_start();

            foreach ($cartItems as $item) {
                $this->db->query(
                    "INSERT INTO order_lines SET order_id=?,user_id=?,product_id=?,product_title=?,product_size=?,product_count=?,product_price=?",
                    array(
                        $order_id, $userId, $item->itemId, $item->itemTitle, $item->selectedSize, $item->itemCount, $item->itemPrice
                    )
                );
            }

            $this->db->trans_complete();
            if ($this->db->trans_status() === FALSE) {
                return false;
            }
            return true;
        }
    }
    public function getOrdersByUser($id)
    {
        $query = $this->db->query("SELECT * FROM orders WHERE user_id=? ORDER BY created_at DESC", array($id));
        $orderResults = $query->result();
        foreach ($orderResults as $orderResult) {

            $query = $this->db->query("SELECT * from order_lines WHERE order_id=?", array($orderResult->id));
            $orderResult->lines = $query->result();
        }
        return $orderResults;
    }
}
