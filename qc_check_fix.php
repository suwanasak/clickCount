<?php
require ('connected.php');
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
date_default_timezone_set("Asia/Bangkok");

$_POST['isCheck'] = 'true';
if (isset($_POST)){
	if($_POST['isCheck'] == 'true'){
		
		$_POST["txtUser"] = '222222';
		
		$user_ = isset($_POST["txtUser"]) ? $_POST["txtUser"] : '';
		$date_now = date("Y-m-d 00:00:01");	
		$start_date = date("Y-m-d 00:00:01" ,strtotime($date_now." -1 day")); $end_date = date("Y-m-d 23:59:59");
		
		$strSQL = "SELECT fix_code, sum(`fix_qty`) as count_fix, `fix_name`, `fix_date` 
		FROM `count_fix` 
		WHERE fix_name='$user_' AND fix_date between '$start_date' AND '$end_date' ";
		$check_1 = $conn->query($strSQL)or die ("ERROR".$strSQL.'<br>'. print_r($conn->errorInfo(),true));
		$row1 = $check_1->fetch();
		$check_fix = isset($row1["count_fix"]) ? $row1["count_fix"] : ''; 
		$check_code = $row1["fix_code"];
		
		$sum_check = "SSELECT `style_code`, sum(`style_amount`) AS qty  FROM `style_order` WHERE  style_code ='$check_code' ";
		$check_2 = $conn->query($sum_check)or die ("ERROR".$sum_check.'<br>'. print_r($conn->errorInfo(),true));
		$row2 = $check_2->fetch();
		$check_amount = isset($row2["qty"]) ? $row2["qty"] : ''; 
		
		$check_balance = ($check_amount - $check_fix);
		
		$output[] = array("fix" => $check_fix,"amount" => $check_amount,"qty" => $check_balance);	
		
		echo json_encode($output);	
	}
}
?>

