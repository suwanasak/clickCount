<?php
require ('connected.php');
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
date_default_timezone_set("Asia/Bangkok");

$_POST['isAdd'] = 'true';
if (isset($_POST)){
	if($_POST['isAdd'] == 'true'){
	/*
		$user_ = isset($_POST["txtUser"]) ? $_POST["txtUser"] : '';
		$group_ = isset($_POST["txtGroup"]) ? $_POST["txtGroup"] : '';
		$style_ = isset($_POST["txtStyle"]) ? $_POST["txtStyle"] : '';
		$code_ = isset($_POST["txtCode"]) ? $_POST["txtCode"] : '';
		$qty_ = isset($_POST["txtQty"]) ? $_POST["txtQty"] : '';
	*/
		$style_='STYLE_TFRC_100/XL';
		$code_='6501100005';
		$group_='5';
		$qty_='5';
		$user_='222222';
		
		$sql = "INSERT INTO count_fix(fix_style,fix_code,fix_group,fix_qty,fix_name) VALUES (?,?,?,?,?)";
		$params = array($style_,$code_,$group_,$qty_,$user_);
		$stmt = $conn->prepare($sql);
		$stmt->execute($params);
		if($stmt->rowCount()){
			$return["success"] = true;
            $return["message"] = "Database Insert Success";
		}else{
			$return["error"] = true;
            $return["message"] = "Database error";
		}
	
		header('Content-Type: application/json');
		echo json_encode($return);
				
	}
}
?>

