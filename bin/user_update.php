<?php
		

session_start();
header("Content-Type: text/html; charset=uft-8",true); 
require( 'conecta.php' );

if ( !isset( $_SESSION['is_logado'] ) ) {
    header( 'location: user_login.php' );
    die;
}

$id = $_SESSION['id_user'];

$sql ="SELECT * FROM projetos WHERE id ='" . $id . "'";
$rs = mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro:'); 
$row = mysql_fetch_assoc( $rs );
		

$nome =  $_POST['nome'];
$email =  $_POST['email'];
$user =  $_POST['user'];
$pass = $_POST['pass'];
$pass_ok = $_POST['pass_ok'];
$ano =  $_POST['ano'];
$titulo =  $_POST['titulo'];
$subtitulo =  $_POST['subtitulo'];
$desc =  $_POST['desc'];
$link =  $_POST['link'];


$foto = $_FILES['Filedata']['name'];
	

	if (empty($email)) {
		echo "<script>
				window.history.back();
				alert( 'preencha o campo de email' );
			</script>";

	} else {
		if ($pass != $pass_ok) {
			echo "<script>
				window.history.back();
				alert( 'senha nao confere' );
			</script>";
		} else {
			if (!isset($foto)) {


				$sql = "UPDATE projetos SET
							nome= 		'$nome',
							email= 		'$email',
							user= 		'$user',
							pass= 		'$pass',
							ano= 		'$ano',
							titulo= 	'$titulo',
							subtitulo= 	'$subtitulo',
							descricao=	'$desc',
							link= 		'$link'

						WHERE id= $id";					

			} else {
				
									echo "<script>
				
				alert( 'foto enviada' );
			</script>";
				include("upload.php");
				
				
				
				$sql = "UPDATE projetos SET
							nome= 		'$nome',
							email= 		'$email',
							user= 		'$user',
							pass= 		'$pass',
							ano= 		'$ano',
							titulo= 	'$titulo',
							subtitulo= 	'$subtitulo',
							descricao=	'$desc',
							link= 		'$link',
							large= 		'gallery/$nome_large',
							thumb= 		'gallery/$nome_thumb'
	
						WHERE id= $id";
				
				
		
		}
					
		mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 
		
		die("<script>
				window.location='user_id.php';
				confirm( 'dados atualizados com sucesso' );
			</script> " );
	}
}


?>










