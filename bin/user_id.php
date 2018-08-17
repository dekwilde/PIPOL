<?php 
session_start();
header("Content-Type: text/html; charset=utf-8",true); 


require( 'conecta.php' );


if ( !isset( $_SESSION['is_logado'] ) ) {
    header( 'location: user_login.php' );
    die;
}
session_start();
$id = $_SESSION['id_user'];

$sql ="SELECT * FROM projetos WHERE id = '$id'";
$rs = mysql_query( $sql, $conn ) or die( 'Ocorreu um erro. Erro: ' . mysql_error()  ); 
$row = mysql_fetch_assoc( $rs );

?>
 <script>
    function confirma_deletar() {
        return confirm( 'Tem certeza que deseja excluir este registro?' );
    }
</script>
<style type="text/css">
.fff {
	width: 500px;
	margin-right: auto;
	margin-left: auto;
	border: 1px solid #CCC;
	font-family:Arial, Helvetica, sans-serif;
	padding:10px;
}
input, textarea {
	width: 100%;
}
</style>

<div class="fff">
<form class="formulario" method="post" action="user_update.php">
   
<?php if ($row['thumb'] != "") { ?>
	<img src="<?php echo $row['thumb']; ?>" height="120" /><br />
<?php
	}
?>
	<br />
	Foto:<br/>
    <input type="file" name="Filedata" id="Filedata" /><br /><br />  
            
	Nome:<br/>
    <input type="text" name="nome" value="<?php echo $row['nome']; ?>" id="nome"><br/><br/>
                
    E-mail:<br/>
    <input type="text" name="email" value="<?php echo $row['email']; ?>" id="email"><br/><br/>

	User:<br/>
    <input type="text" name="user" value="<?php echo $row['user']; ?>" id="user"><br/><br/>
   	
    Pass:<br/>
    <input type="text" name="pass" value="<?php echo $row['pass']; ?>" id="pass"><br/><br/>
    <input type="text" name="pass_ok" value="<?php echo $row['pass']; ?>" id="pass_ok"><br/>

    Ano:<br/>
    <input type="text" name="ano" value="<?php echo $row['ano']; ?>" id="ano"><br/><br/>
     
    Titulo:<br/>
    <input type="text" name="titulo" value="<?php echo $row['titulo']; ?>" id="titulo"><br/><br/>
    
	Subtitulo:<br/>
    <input type="text" name="subtitulo" value="<?php echo $row['subtitulo']; ?>" id="subtitulo"><br/>	<br/>
   
    Descritivo:<br/>
  	<textarea name="desc" rows="7" id="desc"><?php echo $row['descricao']; ?></textarea>
  <br/><br/>  
   
    Link:<br/>
    <input type="text" name="link" value="<?php echo $row['link']; ?>" id="link"><br/><br/><br />


  <input type="submit" name="acao" value="Alterar" id="acao" style="width:70px"> ou 
    <a href="excluir.php?id=<?php echo $id; ?>&db=projetos" onclick="return confirma_deletar();" >Excluir</a><br/>
    <input type="hidden" name="id" value="<?php echo $id; ?>">
    
  </form>
</div>




