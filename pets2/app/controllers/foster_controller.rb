class FosterController < ApplicationController
  include CurrentConsider
  before_action :set_consider
  def index
    @pets = Pet.order(:name)
  end

  def agreement
    @pet = Pet.find(params[:pet_id])
  end

end
