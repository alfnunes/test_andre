class HomeController < ApplicationController
  def index
    #primeira requisição para carregar o BD e redireciona para tela da fabricante assim evitando
    # o delay de post e comparação com o BD, quando o usuário realizar um f5

    #search the make
    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Make request for Webmotors site
    response = Net::HTTP.post_form(uri, {})

    #parse para json
    json = JSON.parse response.body

    # Itera no resultado e grava as marcas que ainda não estão persistidas
    json.each do |make_params|      
      Make.create(name: make_params["Nome"], webmotors_id: make_params["Id"]) if Make.where(:id => make_params["Id"]).blank?
    end

    redirect_to :factory_index
  end
end
