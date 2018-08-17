<?php

session_start();
$email = $_POST['email'];
$pass = $_POST['pass'];

//connect to database
if ($email && $pass){
	require( 'conecta.php' );


	$query = "SELECT * FROM projetos WHERE email = '$email' AND pass = '$pass'";
	$rs = mysql_query( $query ) or die ("didn't query");

	$num = mysql_num_rows( $rs );
	$row = mysql_fetch_assoc( $rs );
	
	if ($num == 1){
		echo "foi";
		$_SESSION['is_logado'] = 1;
		$_SESSION['id_user'] = $row['id'];
	   	echo " <script>window.location='user_id.php'</script> ";
		
		die;
	} else {
		echo "user not find.";
	}
} else {
	 header( 'location: user_login.php' );
}
?>
