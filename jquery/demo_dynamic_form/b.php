<?php
header("Content-type:text/html;charset=utf-8"); 


echo "<br>";
print_r($_POST);
echo "<br>";



//用户名
$rx_name = $_POST["name"];

//手机
$rx_phone = $_POST["phone"];

//邮箱
$rx_email = $_POST["email"];


//总人数
$name_total = count($rx_name);


if(empty($rx_name[0])){
    Header("Location: index.html"); 
}



echo "<br>总人数: ".$name_total."<br>";

$n = 0;
for($i=0; $i<=($name_total - 1); $i++){
    $n = $n + 1;
    echo "<br>";
    echo  "第".$n."个 ";
    echo "\t用户:".$rx_name[$i];
    echo "\t手机:".$rx_phone[$i];
    echo "\t邮箱:".$rx_email[$i];
    echo "<br>";
  
}


?>
