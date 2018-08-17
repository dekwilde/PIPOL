<?php
require( 'conecta.php' ); 

$sql ="SELECT * FROM projetos";

$rs = mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 

$xml = "<data>\n";
while ( $row = mysql_fetch_assoc( $rs ) ) {
    $xml .= "
	<projeto>
		<thumbs>" . $row['thumb'] . "</thumbs>
		<ano><![CDATA[" . $row['ano'] . "]]></ano>
		<titulo><![CDATA[" . $row['titulo'] . "]]></titulo>
		<subtitulo><![CDATA[" . $row['subtitulo'] . "]]></subtitulo>
		<nome><![CDATA[" . $row['nome'] . "]]></nome>
		<email>" . $row['email'] . "</email>
		<link>" . $row['link'] . "</link>
		<userlogin>" . $row['user'] . "</userlogin>
		<password>" . $row['pass'] . "</password>
		<desc><![CDATA[" . $row['descricao'] . "]]></desc>
		<large>" . $row['large'] . "</large>
	</projeto>\n";
}
$xml .= "</data>"; 
echo $xml;

?>

