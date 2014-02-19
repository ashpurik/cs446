class FosterController < ApplicationController
  include CurrentConsider
  before_action :set_consider
  def index
    @pets = Pet.where(status: 'Available').order(:name).all
  end

  def agreement
    @pet = Pet.find(params[:pet_id])
  end

end
