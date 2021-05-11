<?php
defined('BASEPATH') or exit('No direct script access allowed');

class AccessModel extends CI_Model
{
    public function isEmailInDb($email)
    {
        $query = $this->db->query("SELECT * FROM users WHERE email=?", array($email));
        return $query->row();
    }
    public function saveNewUser($name, $email, $password)
    {
        $this->db->query("INSERT INTO users SET name=?,email=?,password=?", array($name, $email, $password));

        return $this->db->insert_id();
    }
}
