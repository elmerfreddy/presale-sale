class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  def index
    @stores = Store.all
  end

  # GET /stores/1
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  def create
    @store = Store.new(store_params)

    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /stores/1
  def destroy
    @store.destroy
    redirect_to stores_url, notice: 'Store was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_params
      params.require(:store).permit(:name, :owner, :address, :latitude, :longitude)
    end
end
