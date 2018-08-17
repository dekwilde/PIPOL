<?php

header("Content-Type: text/html; charset=utf-8",true);

$to = $_POST['email'];

require( 'conecta.php' );

$sql ="SELECT * FROM projetos WHERE email ='" . $to . "'";

$rs = mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 

$row = mysql_fetch_assoc( $rs );


$senha = $row['pass'];
$user = $row['user'];

$subject = "PIPOL - recuparaçao de senha"; // error caracter latino

$headers = "Content-type: text/html; charset=utf-8\r\n";
$headers .= "From: <no-reply@pipol.com.br>\r\n";
$headers .= "Reply-To: no-reply@pipol.com.br\r\n";
$headers .= "Return-path: no-reply@pipol.com.br";

$message = "<p>Obrigado.</p>
        	<p>Sua senha foi recuperada!</p>
            <p>Email: $to</p>
			<p>User: $user</p>
            <p>Senha: $senha</p>";

mail($to, $subject, $message, $headers);

echo" <script>confirm( 'Um email foi enviado' );</script>";
//header( 'location: user_login.php' );

//echo "Sua senha é 3:";
//echo $senha;

?>
