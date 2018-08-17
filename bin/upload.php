<?php

        
		// Pasta para onde vao as fotos
        $destino = "gallery/";
        // Tamanho maximo (em kb) das fotos enviadas
        $MaxTam = 8024; 
        // Extensoes permitidas para as fotos
        $aExtensoes = array("jpg");
        
		//Dimensoes da imagem e thumbs. Largura e Altura.
        $largura_final_H_large = 240;
        $altura_final_H_large = 240;
		
		$largura_final_H_thumb = 120;
        $altura_final_H_thumb = 120;
		
		
		$largura_final_V_large = 240;
        $altura_final_V_large = 240;
		
		$largura_final_V_thumb = 120;
        $altura_final_V_thumb = 120;



        $MaxTam = 1024 * $MaxTam; 
        $imagens_form = $_FILES['Filedata'];
        
		$nome_foto = $_FILES['Filedata']['name'];
		$nome_foto = str_replace("\\","",$nome_foto);
		$nome_foto = str_replace("'","",$nome_foto);
		              
                        // Se possui uma extensÀ£o vÀ¡lida
                        if (in_array(strtolower(substr($nome_foto, strrpos($nome_foto, ".") + 1)), $aExtensoes)) {
                                // InformaÀ§Àµes do arquivo
								
								$latin_data = array("ó", "á", "é", "í", "ú", "ç", "ã", "õ", "ô", " ", "Á", "É", "Ó", "Í", "Ú", "Ç", "Ã", "Õ", "Ô");
								$latin_replace = array("o", "a", "e", "i", "u", "c", "a", "o", "o", "_", "A", "E", "O", "I", "U", "C", "A", "O", "O");
								$nome = str_replace($latin_data, $latin_replace, $nome_foto);
								
								$tamanho = $imagens_form['size'];
                                $tmp = $imagens_form['tmp_name'];
                                $type = $imagens_form['type'];

                                // Se o arquivo existir
                                if (!file_exists($destino.$nome)) {
                                        
                                        // Verificando o tamanho do arquivo
                                        if ($tamanho <= $MaxTam) {
                                                
                                                // faz de fato o upload, move para a pasta correta
                                                if (move_uploaded_file($tmp, $destino.$nome)) {

                                                        //Trabalhando as imagens para criar thumb
                                                        $tamanho = getimagesize($destino.$nome);

                                                        //Tamanhos iniciais - valores pegos automaticamente
                                                        $largura_fonte = $tamanho[0];
                                                        $altura_fonte = $tamanho[1];

                                                        //Nome para os arquivos
														$dia = date("Ymd");
														$hora = time();
														$id_pipol = $dia . $hora;
													
														
                                                        $nome_thumb = substr($nome,0,strpos($nome,".")). $id_pipol . "_thumb".substr($nome,strpos($nome,"."));
														$nome_large = substr($nome,0,strpos($nome,".")). $id_pipol . "_large".substr($nome,strpos($nome,"."));
                                                       	
														// se a imagem for vertical cria thumbs e large sem distorcer imagem
														if ($altura_fonte <= $largura_fonte) {
															$thumb_destino = imagecreatetruecolor($largura_final_H_thumb, $altura_final_H_thumb);
                                                        	$large_destino = imagecreatetruecolor($largura_final_H_large, $altura_final_H_large);
															$imagem_fonte = imagecreatefromjpeg($destino.$nome);
                                                        	imagecopyresampled($thumb_destino, $imagem_fonte, 0, 0, 0, 0, $largura_final_H_thumb, $altura_final_H_thumb, $largura_fonte, $altura_fonte);
															imagecopyresampled($large_destino, $imagem_fonte, 0, 0, 0, 0, $largura_final_H_large, $altura_final_H_large, $largura_fonte, $altura_fonte);
														} else {
															$thumb_destino = imagecreatetruecolor($largura_final_V_thumb, $altura_final_V_thumb);
                                                        	$large_destino = imagecreatetruecolor($largura_final_V_large, $altura_final_V_large);
															$imagem_fonte = imagecreatefromjpeg($destino.$nome);
                                                        	imagecopyresampled($thumb_destino, $imagem_fonte, 0, 0, 0, 0, $largura_final_V_thumb, $altura_final_V_thumb, $largura_fonte, $altura_fonte);
															imagecopyresampled($large_destino, $imagem_fonte, 0, 0, 0, 0, $largura_final_V_large, $altura_final_V_large, $largura_fonte, $altura_fonte);
														}
                                                        //Finaliza a criacao da nova thumbs e imagem
                                                        imagejpeg($thumb_destino, $destino.$nome_thumb, 70);
														imagejpeg($large_destino, $destino.$nome_large, 80);
    													// Apaga foto grande
														unlink($destino.$nome);
																												
														
                                                }
                                                else { 
                                                        echo "&returnflash= Erro ao enviar a imagem <b>".$nome."</b><br />";
														
                                                }
                                        }
                                        else {
                                                echo "&returnflash= Imagem com tamanho superior ao permitido (".floor($MaxTam/1024)."kb) -> <b>".$nome."</b> possui <b>".floor($tamanho/1024)."kb</b><br />";
												
                                        }
                                }
                                else {
										echo "&returnflash= Imagem já existente (<b>{$nome}</b>)<br />";
										
                                }
                        }
                        else {
                                echo "&returnflash= Extensão inválida da imagem (<b>{$nome_foto}</b>)!<br />";
								
                        }
						
?>