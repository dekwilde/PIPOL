<?php

$conn = mysql_connect('', 'tranz_pipol', 'pipolunesp') or die( 'Erro ao se conectar com o banco: ' . mysql_error() );

mysql_select_db('tranz_pipol', $conn) or die( 'Erro ao escolher database: ' . mysql_error() );

?>