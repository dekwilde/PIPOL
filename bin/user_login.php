<style type="text/css">
.fff {
	width: 200px;
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
    <form class="login_user_form" id="login" name="login" method="post" action="user_check.php">
		<h3>Login user PIPOL</h3>
	  <br /><br />
		email<input name="email" id="email" type="text" /><br/><br />
		pass<input name="pass" id="pass" type="password"/><br/><br />
		<input name="submit" type="submit" value=" enviar " style="width:50px" /><br/><br />
        <a href="user_pass.php">recuperar senha </a>
	</form>
</div>