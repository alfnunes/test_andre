class ModelsController < ApplicationController
  def index    
    unless params[:webmotors_make_id].blank?
      #search the models
      uri = URI("http://www.webmotors.com.br/carro/modelos")
      id = params[:webmotors_make_id]      

      #pega todos os modelos
      @models = Api.post(uri,id).map{|model| model['Nome'] }

      # Itera no resultado e grava os modelos que ainda não estão persistidas
      @models.each do |m|
        Model.create(make_id: id, name: m) if Model.where(name: m, make_id: id).blank?
      end    
    else
      @models = nil
    end
  end
end
