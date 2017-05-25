<?php


header("Content-type=text/json;charset=UTF-8");

$conn = mysql_connect("localhost", "root", "www.linuxhub.org") or die("连接数据库的过程失败！");
mysql_query("set names utf-8");
mysql_select_db("demo");


$resultset = mysql_query("select name, age  from user_age", $conn) or die(mysql_error());

$data = array();

class User{
    public $username;
    public $age;
}

while($row = mysql_fetch_array($resultset, MYSQL_ASSOC)) {
    $user = new User();
    $user->username = $row['name'];
    $user->age = $row['age'];
    $data[] = $user;
}

mysql_free_result($resultset);
mysql_close($conn);

// 返回JSON类型的数据
echo json_encode($data);

?>
