package
{
	import flash.events.*;
	import flash.net.*;
	
	public class Language
	{
		/*
		public var xml:XML;
		private var loader:Loader;
		private var xmlLoader:URLLoader;
		*/
		public var titleSite:String
		public var linkBack:String
		public var gotoLink:String
		public var viewMode:String
		
		public var subtitleNavegationYear:String
		public var subtitleNavegationViewMore:String
		public var subtitleNavegationBack:String
		public var subtitleNavegationOpen:String
		
		public var navegationClose:String
		public var navegationBack:String
		public var navegationOpen:String
		
		public var AdminLogin:String
		public var AdminPass:String
		public var AdminSubmit:String
		public var UserAdmin:String
		
		public var AdminReportWelcome:String
		public var AdminReportOK:String
		public var AdminReportError:String
		
		public var publishButton:String
		public var contactButton:String
		
		public var btFilterYear:String
		public var FilterYearName:String
		public var FilterYearSearch:String
		public var FilterYearSubmit:String
		
		
		public var ContactName:String
		public var ContactEmail:String
		public var ContactMessage:String
		public var ContactSend:String
		
		public var UserTitle:String
		public var UserSubTitle:String
		public var UserYear:String
		public var UserName:String
		public var UserEmail:String		
		public var UserInfo:String
		public var UserUrl:String
		public var UserFoto:String
		public var UserLogin:String
		public var UserPass:String
		public var UserSubmit:String
		public var UserBrowser:String
		
		
		public var UserError1:String
		public var UserError2:String
		public var UserError3:String
		public var UserError4:String
		public var UserError5:String
		public var UserSucess:String
		public var UserClose:String	
		
		public function Language()
		{
			LoadVariables();
			//loadConfig();
		}
		/*
		private function loadConfig():void
		{
			loader = new Loader();
			addChild(loader);
			xmlLoader = new URLLoader(new URLRequest("config.xml"));
			xmlLoader.addEventListener(Event.COMPLETE, listLang);
		}
		protected function listLang(event:Event):void 
		{
			xml = new XML(event.currentTarget.data);
			lastImg = xml.projeto.length() - 1;
			maxAlbums = xml.projeto.length();
			currentImg = 0;
			loadImg();
		}
		*/
		protected function LoadVariables():void {
			titleSite = "P.I.P.O.L"
			linkBack = "CLIQUE PARA CONTINUAR"
			gotoLink = "IR PARA O LINK"
			viewMode = "MODO DE VISUALIZAÇÃO:"
			
			subtitleNavegationYear = "CONCLUÍDO NO ANO DE:" 
			subtitleNavegationViewMore = "VER TODOS OS PROJETOS:"
			subtitleNavegationBack = "VOLTAR AOS PROJETOS:"
			subtitleNavegationOpen = "VER ESTE PROJETO:"
			
			navegationClose = "FECHAR"
			navegationBack = "CLIQUE PARA VOLTAR"
			navegationOpen = "CLIQUE PARA ABRIR"
			
			publishButton = "PUBLICAR"
			contactButton = "CONTATO"
			
			btFilterYear = "FILTRAR";
			FilterYearName = "Escreva o Ano:";
			FilterYearSearch = "FILTRAR ";
			FilterYearSubmit = "Procurando...";
			
			AdminLogin = "LOGIN"
			AdminPass = "senha"
			AdminSubmit = "ENTRAR"
			UserAdmin = "ALTERAR CADASTRO"
			
			AdminReportOK = "Todos os campos são Obrigatórios"
			AdminReportError = "a senha está incorreta, tente outra vez ou entre em contato com o Administrador"
			AdminReportWelcome = "Se você não tem os dados de acesso entre em contato com o Administrador"
			
			ContactName = "Nome"
			ContactEmail = "E-mail"
			ContactMessage = "Mensagem"
			ContactSend = "ENVIAR"
			
			
			UserTitle = "Título projeto"
			UserSubTitle = "Subtítulo projeto"
			UserYear = "Projeto realizado no ano de:"
			UserName = "Nome Completo"
			UserEmail = "Email"
			UserInfo = "Resumo do projeto"
			UserUrl = "link do projeto"
			UserFoto = "Selecione uma imagem"
			UserLogin = "LOGIN"
			UserPass = "senha"
			UserSubmit = "ENVIAR"
			UserBrowser = "BUSCAR"
			
			UserError1 = "É obrigatório preencher todos os campos"
			UserError2 = "Preencha os campos corretamente. Todos são obrigatorios!!!"
			UserError3 = "Erro. Tamanho máximo da imagem: "
			UserError4 = "Enviando..."
			UserError5 = "A imagem escolhida não é quadrada (proporção 1:1). Poderrá ficar distorcida."
			UserSucess = "Projeto enviado com sucesso. Clique para reiniciar a página e ver seu trabalho publicado. Caso não apareça esvazie o cache do seu browser. Obrigado."
			UserClose = "\nFECHAR"
		}

	}
}