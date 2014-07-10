class ComicsHerosController < ApplicationController
  before_action :set_comics_hero, only: [:show, :edit, :update, :destroy]

  # GET /comics_heros
  # GET /comics_heros.json
  def index
    @comics_heros = ComicsHero.all
  end

  # GET /comics_heros/1
  # GET /comics_heros/1.json
  def show
  end

  # GET /comics_heros/new
  def new
    @comics_hero = ComicsHero.new
  end

  # GET /comics_heros/1/edit
  def edit
  end

  # POST /comics_heros
  # POST /comics_heros.json
  def create
    @comics_hero = ComicsHero.new(comics_hero_params)

    respond_to do |format|
      if @comics_hero.save
        format.html { redirect_to @comics_hero, notice: 'Comics hero was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comics_hero }
      else
        format.html { render action: 'new' }
        format.json { render json: @comics_hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comics_heros/1
  # PATCH/PUT /comics_heros/1.json
  def update
    respond_to do |format|
      if @comics_hero.update(comics_hero_params)
        format.html { redirect_to @comics_hero, notice: 'Comics hero was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comics_hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comics_heros/1
  # DELETE /comics_heros/1.json
  def destroy
    @comics_hero.destroy
    respond_to do |format|
      format.html { redirect_to comics_heros_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comics_hero
      @comics_hero = ComicsHero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comics_hero_params
      params.require(:comics_hero).permit(:hero_id, :comic_id)
    end
end
