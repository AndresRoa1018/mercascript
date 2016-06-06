class SourceConfigsController < ApplicationController
  before_action :set_source_config, only: [:show, :edit, :update, :destroy]

  # GET /source_configs
  # GET /source_configs.json
  def index
    @source_configs = SourceConfig.all
  end

  # GET /source_configs/1
  # GET /source_configs/1.json
  def show
  end

  # GET /source_configs/new
  def new
    @source_config = SourceConfig.new
  end

  # GET /source_configs/1/edit
  def edit
  end

  # POST /source_configs
  # POST /source_configs.json
  def create
    @source_config = SourceConfig.new(source_config_params)

    respond_to do |format|
      if @source_config.save
        format.html { redirect_to @source_config, notice: 'Source config was successfully created.' }
        format.json { render :show, status: :created, location: @source_config }
      else
        format.html { render :new }
        format.json { render json: @source_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_configs/1
  # PATCH/PUT /source_configs/1.json
  def update
    respond_to do |format|
      if @source_config.update(source_config_params)
        format.html { redirect_to @source_config, notice: 'Source config was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_config }
      else
        format.html { render :edit }
        format.json { render json: @source_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_configs/1
  # DELETE /source_configs/1.json
  def destroy
    @source_config.destroy
    respond_to do |format|
      format.html { redirect_to source_configs_url, notice: 'Source config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_config
      @source_config = SourceConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_config_params
      params.require(:source_config).permit(:datasource, :login, :password, :domain, :active, :data)
    end
end
