class ModelsController < ApplicationController
  def index
    unless params[:webmotors_make_id].blank?
      #search the models
      uri = URI("http://www.webmotors.com.br/carro/modelos")

      id = params[:webmotors_make_id]

      # Make request for Webmotors site
      make = Make.where(:webmotors_id => id).first

      response = Net::HTTP.post_form(uri, { marca: id })

      models_json = JSON.parse response.body

      #pega todos os modelos
      @models = models_json.map{|model| model['Nome'] }

      # Itera no resultado e grava os modelos que ainda não estão persistidas
      @models.each do |m|
        Model.create(make_id: make.id, name: m) if Model.where(name: m, make_id: make.id).blank?
      end
    end
  end
end
