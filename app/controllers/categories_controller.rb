class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  def index
    @categories = Category.all.includes(:user).order(created_at: :desc).filter { |catego| catego.user_id == current_user.id }
    respond_to do |format|
      format.html
      format.json { render json: @categories, status: 200 }
    end
  end

  # GET /categories/1 or /categories/1.json
  def show; end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit; end

  def create
    if params[:category][:icon].present?
      uploaded_file = params[:category][:icon].tempfile
      cloudinary_response = Cloudinary::Uploader.upload(uploaded_file.path, folder: 'budgeat')
      @category = current_user.categories.new(category_params.merge(user_id: current_user.id, icon: cloudinary_response['secure_url']))
    end

    if @category.save
      redirect_to categories_url, notice: 'Categories created successfully'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    # params.require(:category).permit(:name, :icon, :total, :user_id)
    params.require(:category).permit(:name, :icon, :user_id)
  end
end