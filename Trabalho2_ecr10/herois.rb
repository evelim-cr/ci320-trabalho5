# -*- coding: utf-8 -*-
require 'active_record'
require 'active_support/core_ext/string'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Herois.sqlite3" 

#------------------------Classes--------------------------------------------------------#                                     
class Hero < ActiveRecord::Base
	has_and_belongs_to_many :comics #pertence ao comic
	has_one :secretIdentity, dependent: :destroy
	has_many :enemies, dependent: :destroy

	def inserir
		puts 'Digite o nome do Heroi que deseja inserir'
		self.name = gets.chomp.downcase
		newhero = Hero.where(:name => self.name)
		if (newhero.length != 0)
			puts "Esse Heroi já existe em nosso banco de dados"
		else
			puts 'Digite as habilidades que o heroi possui'
			self.skills = gets.chomp.downcase
			puts 'Digite a Cidade que o Heroi vive '
			self.city = gets.chomp.downcase
			self.save()
			puts "Seu Heroi foi criado"
		end
	end
	
	def remover
		puts "Digite o nome do Heroi que deseja remover"
		nome = gets.chomp.downcase
		heroi = Hero.where(:name => nome)
		if (heroi[0] == nil)
			puts("Heroi nao encontrado")
		else	
		heroi.destroy_all
		puts "O Heroi foi removido"
		end
	end
	
	def alterar
		puts "Voce sabe a Id do Heroi que precisa alterar as informacoes. Digite s (sim) ou n (nao)"
		op = gets.chomp.downcase
		if (op == 'n')
			puts"Pesquise o ID do Heroi" 
			self.pesquisar
		end
		
		puts "Digite a ID do Heroi das informacoes que pretende alterar"
		id = gets.chomp.downcase
		heroi = Hero.find(id)		
		menuAlterarHeroi
		op = gets.to_i
		case op
		when 1
			puts "Digite o novo nome do Heroi"	
			heroi.name = gets.chomp.downcase
			heroi.save()
			puts "Voce alterou o nome do heroi para #{heroi.name.split.map(&:capitalize).join(' ')}"
			puts
		when 2
			puts "Digite a habilidades do heroi"
			heroi.skills = gets.chomp.downcase
			heroi.save()
			puts "Voce alterou as habilidades do heroi para #{heroi.skills}"
			puts
		when 3
			puts "Digite a nova Cidade"
			heroi.city = gets.chomp.downcase
			heroi.save()
			puts "Voce alterou a Cidade para #{heroi.city.split.map(&:capitalize).join(' ')}"
			puts
		when 4
			puts "Digite o novo nome do Heroi"	
			heroi.name = gets.chomp.downcase
			puts "Digite a habilidades do heroi"
			heroi.skills = gets.chomp.downcase
			puts "Digite a nova Cidade"
			heroi.city = gets.chomp.downcase
			heroi.save()
			puts "Voce alterou o perfil do heroi para:"
			puts " Nome: #{heroi.name.split.map(&:capitalize).join(' ')}"
			puts " Habilidades: #{heroi.skills.split.map(&:capitalize).join(' ')}"
			puts " Cidade: #{heroi.city.split.map(&:capitalize).join(' ')}"
			puts
		else
			puts "Opcao incorreta"
		end

	end
	
	def listar
		heroi = Hero.all;
		puts " ______________________________________________________"
		heroi.each do |h|
			puts " ID: #{h.id}"
			puts " Nome: #{h.name.split.map(&:capitalize).join(' ')}"
			puts " Habilidades: #{h.skills}"
			puts " Cidade: #{h.city.split.map(&:capitalize).join(' ')} "
		puts "|______________________________________________________|"
		end
	end
	
	def pesquisar
		menuPesquisa
		op = gets.to_i
		case op
		when 1
			puts "Digite o nome do Heroi que deseja pesquisar"
			nome = gets.chomp.downcase
			heroi = Hero.where(:name => nome)
			if (heroi[0] == nil)
			puts("Heroi nome nao encontrado")
			end
			heroi.each do |h| 
				puts " ID: #{h.id}"
				puts " Nome: #{h.name.split.map(&:capitalize).join(' ')}"
				puts " Endereço: #{h.skills.split.map(&:capitalize).join(' ')}"
				puts " Ocupação: #{h.city.split.map(&:capitalize).join(' ')}"
				puts 
			end
		when 2
			puts "Digite o nome da cidade que deseja pesquisar os herois"
			city = gets.chomp.downcase
			heroi = Hero.find_all_by_city(city)
			heroi.each do |h| 
				puts " ID: #{h.id}"
				puts " Nome: #{h.name.split.map(&:capitalize).join(' ')}"
				puts " Endereço: #{h.skills.split.map(&:capitalize).join(' ')}"
				puts " Ocupação: #{h.city.split.map(&:capitalize).join(' ')}"
				puts 
			end
		else
			puts"Opcao invalida, tente novamente com alguma opcao do menu"
		end
	end
end

class ComicsHero < ActiveRecord::Base
	belongs_to :comics
	belongs_to :heros
	def listar
		
		comicsH = ComicsHero.all;
		comicsH.each do |i|
			puts i.inspect
		end
	end
end
class Enemy < ActiveRecord::Base
	belongs_to :hero #pertence ao heroi
	def inserir
		puts 'O inimigo tem um adversário criado no banco de dados? Digite s(sim) ou n(não)'
		op = gets.chomp.downcase
		if(op == 's')
			puts "Você sabe o Id do adversário (Heroi). Digite s(sim) ou n(não)"
			op = gets.chomp.downcase
			if (op == 'n')
				heroi = Hero.new()
				puts"Pesquise o ID do Heroi" 
				heroi.pesquisar
			end
		
			puts "Digite a ID do Heroi"
			id = gets.to_i
			heroi = Hero.find(id)
			
			if(heroi.id == nil)
				puts "Heroi não encontrado"
			else
				self.hero_id = heroi.id
				puts 'Digite o nome do Inimigo que deseja inserir'
				self.name = gets.chomp.downcase
				self.save()
				puts "Agora o Heroi #{heroi.name.split.map(&:capitalize).join(' ')} tem um Inimigo"
			end
		else 
			puts("Não podemos criar seu inimigo, pois ele ainda não tem um adversário em nosso banco de dados")
		end
	end

	def remover
		puts "Digite o nome do Inimigo que deseja remover"
		nome = gets.chomp.downcase
		enemy = Enemy.where(:name => nome)
		if (enemy[0] == nil)
			puts("Inimigo não foi encontrado")
		else	
		enemy.destroy_all
		puts "O Inimigo foi removido"
		end
	end

	def listar
		enemy = Enemy.all;
		puts " ___________________________________________________________________"
		enemy.each do |i|
			puts " ID: #{i.id}"
			puts " Nome: #{i.name.split.map(&:capitalize).join(' ')}"
			heroi = Hero.find(i.hero_id)
			puts " ID do Heroi associado: #{i.hero_id}"
			puts " Nome do Inimigo #{heroi.name.split.map(&:capitalize).join(' ')}"
		puts "|___________________________________________________________________|"
		end
	end

	def alterar
		puts "Voc sabe a Id do Inimigo que precisa alterar as informações. Digite s (sim) ou n (nao)"
		op = gets.chomp.downcase
		if (op == 'n')
			puts"Pesquise o ID do Inimigo" 
			self.pesquisar
		end
		
		puts "Digite a ID do Inimigo das informações que pretende alterar"
		id = gets.to_i
		enemy = Enemy.find(id)		
		puts "Digite o novo nome do Inimigo"	
		enemy.name = gets.chomp.downcase
		enemy.save()
		puts "Você alterou o nome do Inimigo para #{enemy.name.split.map(&:capitalize).join(' ')}"
	end

	def pesquisar
		puts "Digite o nome do Inimigo que deseja pesquisar"
		nome = gets.chomp.downcase
		enemy = Enemy.where(:name => nome)
		enemy.each do |i| 
			puts " ID: #{i.id}"
			puts " Nome: #{i.name.split.map(&:capitalize).join(' ')}"
			puts " ID do heroi: #{i.hero_id}"
		end
	end	
end

class SecretIdentity < ActiveRecord::Base
	belongs_to :hero #pertence ao heroi 
	belongs_to :comic #pertence aos comic

	def inserir
		puts 'Existe um heroi criado em nosso banco de dados para usar essa identidade Secreta ? Digite s(sim) ou n(não)'
		op = gets.chomp.downcase
		if(op == 's')
			puts "Você sabe o Id do Heroi que vai usar a Identidade Secreta. Digite s(sim) ou n(não)"
			op = gets.chomp.downcase
			if (op == 'n')
				heroi = Hero.new()
				puts"Pesquise o ID do Heroi" 
				heroi.pesquisar
			end
		
			puts "Digite a ID do Heroi"
			id = gets.to_i
			heroi = Hero.find(id)

			if(heroi.id == nil)
				puts "Heroi não encontrado"
			else
				self.hero_id = heroi.id
				puts 'Digite o nome da pessoa que deseja inserir'
				self.name = gets.chomp.downcase
				puts 'Digite o endereco da pessoa'
				self.address = gets.chomp.downcase
				puts 'Digite a ocupacao que ele exerce nas horas que ele nao esta salvando o mundo '
				self.occupation = gets.chomp.downcase
				self.save()
				puts 'Identidade Secreta Inserida com sucesso =)'
			end
		else 
			puts("Não podemos criar a Identidade Secreta, pois ainda não tem um Heroi para usa-la")
		end
	end

	def remover
		puts "Digite o nome da Identidade Secreta que deseja remover"
		nome = gets.chomp.downcase
		idSecret = SecretIdentity.where(:name => nome)
		if (idSecret[0] == nil)
			puts("Identidade Secreta não encontrada")
		else
		idSecret.destroy_all
		puts "A identidade Secreta foi removida"
		end
	end

	def alterar
		puts "Você sabe a Id da Identidade Secreta que precisa alterar as informacoes. Digite s (sim) ou n (nao)"
		op = gets.chomp.downcase
		if (op == 'n')
			self.pesquisar
		end
		
		puts "Digite a ID da Identidade Secreta das informações que pretende alterar"
		id = gets.to_i
		identSecret = SecretIdentity.find(id)		
		menuAlterarIdSecret
		op = gets.to_i
		case op
			when 1
				puts "Digite o novo nome da Identidade Secreta"	
				identSecret.name = gets.chomp.downcase
				identSecret.save()
				puts "Você alterou o nome da Identidade Secreta para #{identSecret.name.split.map(&:capitalize).join(' ')}"
			when 2
				puts "Digite o novo endereço"
				identSecret.address = gets.chomp.downcase
				identSecret.save()
				puts "Você alterou o endereco para #{identSecret.address.split.map(&:capitalize).join(' ')}"
			when 3
				puts "Digite a nova Ocupação"
				identSecret.occupation = gets.chomp.downcase
				identSecret.save()
				puts "Você alterou a Ocupação para #{identSecret.occupation.split.map(&:capitalize).join(' ')}"
			when 4
				puts "Digite o novo nome da Identidade Secreta"	
				identSecret.name = gets.chomp.downcase
				puts "Digite o novo endereço"
				identSecret.address = gets.chomp.downcase
				puts "Digite a nova Ocupação"
				identSecret.occupation = gets.chomp.downcase
				identSecret.save()
				puts
				puts " Você alterou o perfil do heroi para:"
				puts " Nome: #{identSecret.name.split.map(&:capitalize).join(' ')}"
				puts " Habilidades: #{identSecret.address.split.map(&:capitalize).join(' ')}"
				puts " Cidade: #{identSecret.occupation.split.map(&:capitalize).join(' ')}"
			else
				puts " Opção incorreta"
			end
	end

	def listar
		idSecret = SecretIdentity.all;
		if(idSecret[0] ==nil)
			puts("Não existe Identidades Secretas cadastradas")
		end	
		puts " ______________________________________________________"
		idSecret.each do |i|
			puts " ID: #{i.id}"
			puts " Nome: #{i.name.split.map(&:capitalize).join(' ')}"
			puts " Endereço: #{i.address.split.map(&:capitalize).join(' ')}"
			puts " Ocupação: #{i.occupation.split.map(&:capitalize).join(' ')} "
			puts " ID do heroi: #{i.hero_id}"
		puts "|______________________________________________________|"
		end
	end

	def pesquisar
		puts " Digite o nome da pessoa que deseja pesquisar"
		nome = gets.chomp.downcase
		idSecret = SecretIdentity.where(:name => nome)
		idSecret.each do |i| 
			puts " ID: #{i.id}"
			puts " Nome: #{i.name.split.map(&:capitalize).join(' ')}"
			puts " Endereço: #{i.address.split.map(&:capitalize).join(' ')}"
			puts " Ocupação: #{i.occupation.split.map(&:capitalize).join(' ')}"
			puts 
		end
	end
end

class Comic < ActiveRecord::Base
	has_and_belongs_to_many :heros #muitos herois 
	has_many :secretIdentity, :through => :heros #muitos para muitos

	def inserir
		puts 'Digite o nome do Quadrinho que deseja inserir'
		self.name = gets.chomp.downcase
		puts 'Digite a Editora que o Quadrinho foi publicado'
		self.publishing = gets.chomp.downcase
		puts 'Digite o ano de publicação '
		self.date = gets.chomp.downcase
		self.save()
	end

	
	def remover
		puts "Digite o nome do Quadrinho que deseja remover"
		nome = gets.chomp.downcase
		comic = Comic.where(:name => nome)
		if (comic[0] == nil)
			puts("Quadrinho não encontrado")
		else	
		comic.destroy_all
		puts "O Quadrinho foi removido"
		end
	end

	def listar
		comic = Comic.all;
		puts " ______________________________________________________"
		comic.each do |c|
			puts " ID: #{c.id}"		
			puts " Nome: #{c.name.split.map(&:capitalize).join(' ')}"
			puts " Editora: #{c.publishing.split.map(&:capitalize).join(' ')}"
			puts " Data:#{c.date} "
		puts "|______________________________________________________|"
		end
	end

	def alterar
		puts "Você sabe a Id do Quadrinho que precisa alterar as informações. Digite s (sim) ou n (não)"
		op = gets.chomp.downcase
		if (op == 'n')
			self.pesquisar
		end
		
		puts "Digite a ID do Quadrinho das informações que pretende alterar"
		id = gets.chomp.downcase
		comic = Comic.find(id)		
		menuAlterarQuadrinho
		op = gets.to_i
		case op
		when 1
			puts "Digite o novo nome do Quadrinho"	
			comic.name = gets.chomp.downcase
			comic.save()
			puts "Você alterou o nome do Quadrinho para #{comic.name.split.map(&:capitalize).join(' ')}"
		when 2
			puts "Digite a Editora que gostaria de alterar"
			comic.publishing = gets.chomp.downcase
			comic.save()
			puts "Você alterou a Editora para #{comic.publishing.split.map(&:capitalize).join(' ')}"
		when 3
			puts "Digite a nova Data"
			comic.date = gets.chomp.downcase
			comic.save()
			puts "Você alterou a Data para #{comic.date}"
		when 4
			puts "Digite o novo nome do Quadrinho"	
			comic.name = gets.chomp.downcase
			puts "Digite a Editora que gostaria de alterar"
			comic.publishing = gets.chomp.downcase
			puts "Digite a nova Data"
			comic.date = gets.chomp.downcase
			puts "Você alterou o Quadrinho para:"
			comic.save()
			puts "Nome: #{comic.name.split.map(&:capitalize).join(' ')}"
			puts "Editora: #{comic.publishing.split.map(&:capitalize).join(' ')}"
			puts "Data: #{comic.date}"
			
		else
			puts "Opção incorreta"
		end
	end	
	def pesquisar
		menuPesquisaComic
		op = gets.to_i
		case op
		when 1
			puts "Digite do quadrinho que deseja pesquisar"
			nome = gets.chomp.downcase
			comic = Comic.where(:name => nome)
			comic.each do |c| 
				puts " ID: #{c.id}"
				puts " Nome: #{c.name.split.map(&:capitalize).join(' ')}"
				puts " Endereço: #{c.publishing.split.map(&:capitalize).join(' ')}"
				puts " Data: #{c.date.split.map(&:capitalize).join(' ')}"
				puts 
			end
		when 2
			puts "Digite o nome da editora que publica os quadrinhos que deseja pesquisar"
			publishing = gets.chomp.downcase
			comic = Comic.find_all_by_publishing(publishing)
			comic.each do |c| 
				puts "ID: #{c.id}"
				puts " Nome: #{c.name.split.map(&:capitalize).join(' ')}"
				puts 
			end
		when 3
			puts "Digite a data de publicacao dos quadrinhos que deseja pesquisar"
			date = gets.chomp.downcase
			comic = Comic.find_all_by_date(date)
			comic.each do |c| 
				puts "ID: #{c.id}"
				puts " Nome: #{c.name.split.map(&:capitalize).join(' ')}"
			end
		else
			puts"Opção invalida, tente novamente com alguma opcao do menu"
		end
	end
end
#------------------------ Fim das Classes-----------------------------------------------# 
#------Funcao de associacao entre Heroi e Quadrinho-------------------------------------# 
def associaHeroiComic
	puts "Digite o nome do Heroi que deseja associar."
	nome = gets.chomp.downcase
	heroi = Hero.new()
	heroi = Hero.where(:name =>nome).first
	if (heroi == nil)
			puts("Heroi não encontrado")
	else
		puts "Digite o nome do Quadrinho"
		nome = gets.chomp.downcase
		comic = Comic.new()
		comic = Comic.where(:name =>nome)
		if (comic[0] == nil)
			puts("Quadrinho não encontrado")
		else
			heroi.comics << (comic)
			puts "o Quadrinho #{nome.split.map(&:capitalize).join(' ')} foi associado ao Heroi #{heroi.name.split.map(&:capitalize).join(' ')} com sucesso =)"
		end
	end
end
#---------------------------------------------------------------------------------------# 
#----Funções para imprimir associaçoes nxn----------------------------------------------# 
def imprimirHeroiQuadrinhos
	puts "Digite o nome do Heroi que deseja Imprimir os Quadrinhos"
	nome = gets.chomp.downcase
	heroi = Hero.new()
	heroi = Hero.where(:name =>nome).first
	comics = heroi.comics
	if (comics == nil)
		puts "O heroi #{nome.split.map(&:capitalize).join(' ')} não tem Quadrinhos"
	end	
	puts " Quadrinhos que o heroi #{nome.split.map(&:capitalize).join(' ')} aparece:"
	puts "---------------------------------"
	comics.each do |c|
		puts " #{c.name.split.map(&:capitalize).join(' ')}"
	end	
	puts "---------------------------------"
end	

def imprimirQuadrinhoHerois
	puts "Digite o nome do Quadrinho que deseja mostrar os Herois que pertencem a ele."
	nome = gets.chomp.downcase
	comic = Comic.new()
	comic = Comic.where(:name =>nome).first
	heros = comic.heros
	if (heros == nil)
		puts "O Quadrinho #{nome.split.map(&:capitalize).join(' ')} não tem Herois associados a ele"
	end	
	puts " Herois que aparecem no Quadrinho #{nome.split.map(&:capitalize).join(' ')}:"
	puts "---------------------------------"
	heros.each do |h|
		puts " #{h.name.split.map(&:capitalize).join(' ')}"
	end	
	puts "---------------------------------"
end	
#---------------------------------------------------------------------------------------# 
#------------------------MENUS----------------------------------------------------------# 
def menuPrincipal
	puts " ******************************************************"
	puts "|                        MENU                          |"
	puts " ******************************************************"
	puts "|   1 - Heroi                                          |"
	puts "|   2 - Inimigo                                        |"
	puts "|   3 - Identidade Secreta                             |"	
	puts "|   4 - Quadrinho                                      |"
	puts "|   5 - Associações entre Herois e Quadrinhos          |"
	puts "|   6 - Imprimir os Quadrinhos que pertencem ao Heroi  |"
	puts "|   7 - Imprimir os Herois que pertence ao Quadrinho   |"
	puts "|   8 - Sair                                           |"
	puts " ******************************************************"
end

def subMenu
	puts " ******************************************************"
	puts "|   Digite a opção que deseja                          |"
	puts " ******************************************************"
	puts "|   i - Inserir                                        |"
	puts "|   r - Remover                                        |"	
	puts "|   a - Alterar                                        |"
	puts "|   p - Pesquisar                                      |"
	puts "|   l - Listar                                         |"
	puts "|   q - Voltar ao Menu Anterior                        |"
	puts " ******************************************************"
end 

def menuAlterarHeroi
	system 'clear'
	puts " ******************************************************"
	puts "|  Digite a opção que deseja alterar                   |"
	puts " ******************************************************"
	puts "|   1 - Nome                                           |"
	puts "|   2 - Habilidades                                    |"
	puts "|   3 - Cidade                                         |"
	puts "|   4 - Todas as Informações                           |"	
	puts " ******************************************************"
end

def menuAlterarIdSecret
	system 'clear'
	puts " ******************************************************"
	puts "|  Digite a opção que deseja alterar                   |"
	puts " ******************************************************"
	puts "|   1 - Nome                                           |"
	puts "|   2 - Enderaço                                       |"
	puts "|   3 - Ocupação                                       |"
	puts "|   4 - Todas as Informacoes                           |"	
	puts " ******************************************************"
end

def menuAlterarQuadrinho
	system 'clear'
	puts " ******************************************************"
	puts "|  Digite a opção que deseja alterar do Quadrinho      |"
	puts " ******************************************************"
	puts "|   1 - Nome                                           |"
	puts "|   2 - Editora                                        |"
	puts "|   3 - Data                                           |"
	puts "|   4 - Todas as Informacoes                           |"	
	puts " ******************************************************"
end

def menuPesquisa
	system 'clear'
	puts " ******************************************************"
	puts "|  Digite a opção que deseja pesquisar                 |"
	puts " ******************************************************"
	puts "|   1 - Nome                                           |"
	puts "|   2 - Cidade                                         |"	
	puts " ******************************************************"
end

def menuPesquisaComic
	system 'clear'
	puts " ******************************************************"
	puts "|  Digite a opção que deseja pesquisar Quadrinhos      |"
	puts " ******************************************************"
	puts "|   1 - Nome                                           |"
	puts "|   2 - Editora                                        |"	
	puts "|   3 - Data de Publicação                             |"	
	puts " ******************************************************"
end
#------------------------FIM MENUS-------------------------------------------------------#
#----Funcao com as opcoes do Menu Principal----------------------------------------------# 
def selecionaOpcao(opcao)
	case opcao
	when 1 #escolhido o heroi 
		system 'clear'
		subMenu
		opcaoHeroi = gets.chomp.downcase
		while(opcaoHeroi != 'q')
			p = Hero.new()
			system 'clear'
			case opcaoHeroi
			when 'i'
				p.inserir
			when 'r'
				p.remover
			when 'a'
				p.alterar
			when 'p'
				p.pesquisar
			when 'l'
				p.listar
			else
				puts 'Você digitou uma opcao incorreta, tente novamente'
			end
			subMenu
			opcaoHeroi = gets.chomp.downcase
		end
	when 2 #escolhido o inimigo 
		system 'clear'
		subMenu
		opcaoInimigo = gets.chomp.downcase
		while(opcaoInimigo != 'q')
			system 'clear'
			p = Enemy.new()
			case opcaoInimigo
			when 'i'
				p.inserir
			when 'r'
				p.remover
			when 'a'
				p.alterar
			when 'p'
				system 'clear'
				p.pesquisar
			when 'l'
				p.listar
			else
				puts 'Você digitou uma opção incorreta, tente novamente'
			end
			subMenu
			opcaoInimigo = gets.chomp.downcase
		end
	when 3 #escolhido o Identidade Secreta 
		system 'clear'
		subMenu
		opcaoIdSecret = gets.chomp.downcase
		while(opcaoIdSecret != 'q')
			system 'clear'
			p = SecretIdentity.new()
			case opcaoIdSecret
			when 'i'
				p.inserir
			when 'r'
				p.remover
			when 'a'
				p.alterar
			when 'p'
				p.pesquisar
			when 'l'
				system 'clear'
				p.listar
			else
				puts 'Você digitou uma opcao incorreta, tente novamente'
			end
			subMenu
			opcaoIdSecret = gets.chomp.downcase
			system 'clear'
		end
	when 4 #escolhido o comic
		system 'clear' 
		subMenu
		opcaoComic = gets.chomp.downcase
		while(opcaoComic != 'q')
			system 'clear'
			c = Comic.new()
			case opcaoComic
			when 'i'
				c.inserir
			when 'r'
				c.remover
			when 'a'
				c.alterar
			when 'p'
				c.pesquisar
			when 'l'
				system 'clear'
				c.listar
			else
				puts 'Você digitou uma opção incorreta, tente novamente'
			end
			subMenu
			opcaoComic = gets.chomp.downcase
		end
	when 5 #escolhido associação
		system 'clear'
		associaHeroiComic
	when 6 #impressão das associações nXn
		system 'clear'
		imprimirHeroiQuadrinhos	
	when 7 #impressão das associações nXn
		system 'clear'
		imprimirQuadrinhoHerois
	else 
		puts'Você digitou uma opção incorreta, tente novamente'
	end
end
#----------------------------------------------------------------------------------------# 
#----------Main--------------------------------------------------------------------------#
	menuPrincipal
	opcao = gets.to_i
	while (opcao != 8)
		selecionaOpcao(opcao)
		menuPrincipal
		opcao = gets.to_i

	end
#----------------------------------------------------------------------------------------# 