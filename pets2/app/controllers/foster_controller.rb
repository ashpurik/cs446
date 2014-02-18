class FosterController < ApplicationController
  def index
    @pets = Pet.all
  end

  def agreement
    @pet = Pet.find(params[:pet_id])
  end

end
