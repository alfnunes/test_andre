class FactoryController < ApplicationController 
  def index
    #retorna as marcas
    @makes = Make.all.select(:webmotors_id, :name)

    respond_to do |format|
      format.html
    end
  end
end
