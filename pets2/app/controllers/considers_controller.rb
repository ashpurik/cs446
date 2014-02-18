class ConsidersController < ApplicationController
  before_action :set_consider, only: [:show, :edit, :update, :destroy]

  # GET /considers
  # GET /considers.json
  def index
    @considers = Consider.all
  end

  # GET /considers/1
  # GET /considers/1.json
  def show
  end

  # GET /considers/new
  def new
    @consider = Consider.new
  end

  # GET /considers/1/edit
  def edit
  end

  # POST /considers
  # POST /considers.json
  def create
    @consider = Consider.new(consider_params)

    respond_to do |format|
      if @consider.save
        format.html { redirect_to @consider, notice: 'Consider was successfully created.' }
        format.json { render action: 'show', status: :created, location: @consider }
      else
        format.html { render action: 'new' }
        format.json { render json: @consider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /considers/1
  # PATCH/PUT /considers/1.json
  def update
    respond_to do |format|
      if @consider.update(consider_params)
        format.html { redirect_to @consider, notice: 'Consider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @consider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /considers/1
  # DELETE /considers/1.json
  def destroy
    @consider.destroy
    respond_to do |format|
      format.html { redirect_to considers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consider
      @consider = Consider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consider_params
      params[:consider]
    end
end
