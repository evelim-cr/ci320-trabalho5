class SecretIdentitiesController < ApplicationController
  before_action :set_secret_identity, only: [:show, :edit, :update, :destroy]

  # GET /secret_identities
  # GET /secret_identities.json
  def index
    @secret_identities = SecretIdentity.all
  end

  # GET /secret_identities/1
  # GET /secret_identities/1.json
  def show
  end

  # GET /secret_identities/new
  def new
    @secret_identity = SecretIdentity.new
  end

  # GET /secret_identities/1/edit
  def edit
  end

  # POST /secret_identities
  # POST /secret_identities.json
  def create
    @secret_identity = SecretIdentity.new(secret_identity_params)

    respond_to do |format|
      if @secret_identity.save
        format.html { redirect_to @secret_identity, notice: 'Secret identity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @secret_identity }
      else
        format.html { render action: 'new' }
        format.json { render json: @secret_identity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secret_identities/1
  # PATCH/PUT /secret_identities/1.json
  def update
    respond_to do |format|
      if @secret_identity.update(secret_identity_params)
        format.html { redirect_to @secret_identity, notice: 'Secret identity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @secret_identity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secret_identities/1
  # DELETE /secret_identities/1.json
  def destroy
    @secret_identity.destroy
    respond_to do |format|
      format.html { redirect_to secret_identities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_identity
      @secret_identity = SecretIdentity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secret_identity_params
      params.require(:secret_identity).permit(:name, :address, :occupation, :hero_id)
    end
end
