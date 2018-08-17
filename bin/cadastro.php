<?php
header("Content-Type: text/html; charset=utf-8",true); 
require("conecta.php");


include("upload.php");


$nome = $_POST['nome'];
$email = $_POST['email'];
$user = $_POST['username']; 
$pass = $_POST['pass'];
$ano = $_POST['ano'];
$titulo = $_POST['titulo'];
$subtitulo = $_POST['subtitulo'];
$desc = $_POST['descricao'];
$link = $_POST['link'];




$sql = "INSERT INTO projetos ( 
						nome, 
						email, 
						user, 
						pass, 
						ano, 
						titulo, 
						subtitulo, 
						descricao, 
						link,
						large,
						thumb
					) VALUES (
						'$nome', 
						'$email', 
						'$user', 
						'$pass', 
						'$ano', 
						'$titulo', 
						'$subtitulo', 
						'$desc', 
						'$link',
						'gallery/$nome_large',
						'gallery/$nome_thumb'
						 );";

mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 

		
												
$to = "dekwilde@gmail.com, "; 
$to .= "bauruhaus@yahoo.com.br"; 
$subject = "pipol projeto enviado";
$body = "Um projeto foi enviado: $titulo";
mail($to, $subject, $body);

?>