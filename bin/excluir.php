<?php

session_start();
require( 'conecta.php' );

if ( !isset( $_SESSION['is_logado'] ) ) {
    header( 'location: login.php' );
    die;
}


$id = isset( $_GET['id'] ) ? $_GET['id'] : '';
$db = isset( $_GET['db'] ) ? $_GET['db'] : '';

    
$sql = "DELETE FROM " . $db . " WHERE id = '" . $id . "'";
        
mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 

echo "excluido com sucesso. <a href='user_login.php'> VOLTAR</a>";
die;

