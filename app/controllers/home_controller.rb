class HomeController < ApplicationController
  def index
    #primeira requisição para carregar o BD e redireciona para tela da fabricante assim evitando
    # o delay de post e comparação com o BD, quando o usuário realizar um f5 

    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Itera no resultado e grava as marcas que ainda não estão persistidas
    Api.post(uri).each do |factory|      
      Make.create(name: factory["Nome"], webmotors_id: factory["Id"]) if Make.where(:id => factory["Id"]).blank?
    end

    redirect_to :factory_index
  end
end
