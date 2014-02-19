class LinePetsController < ApplicationController
  include CurrentConsider
  before_action :set_consider, only: [:create]
  before_action :set_line_pet, only: [:show, :edit, :update, :destroy]

  # GET /line_pets
  # GET /line_pets.json
  def index
    @line_pets = LinePet.all
  end

  # GET /line_pets/1
  # GET /line_pets/1.json
  def show
  end

  # GET /line_pets/new
  def new
    @line_pet = LinePet.new
  end

  # GET /line_pets/1/edit
  def edit
  end

  # POST /line_pets
  # POST /line_pets.json
  def create
    pet = Pet.find(params[:pet_id])
    @line_pet = @consider.line_pets.build(pet: pet)

    respond_to do |format|
      if @line_pet.save
        format.html { redirect_to foster_url }
	format.js
        format.json { render action: 'show', status: :created, location: @line_pet }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_pets/1
  # PATCH/PUT /line_pets/1.json
  def update
    respond_to do |format|
      if @line_pet.update(line_pet_params)
        format.html { redirect_to @line_pet, notice: 'Line pet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_pets/1
  # DELETE /line_pets/1.json
  def destroy
    @line_pet.destroy
    respond_to do |format|
      format.html { redirect_to line_pets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_pet
      @line_pet = LinePet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_pet_params
      params.require(:line_pet).permit(:pet_id)
    end
end
