<?php

	$to = "dekwilde@gmail.com"; 
	$subject = "pipol contato";
	$name_field = $_POST['name'];
	$email_field = $_POST['mail'];
	$message = $_POST['message'];
	
	$body = "From: $name_field\n E-Mail: $email_field\n Message:\n $message\n";
	
	mail($to, $subject, $body);

?>