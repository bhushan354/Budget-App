class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

  def show; end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:success] = 'category saved sucessfully'
      redirect_to categories_path
    else
      flash.now[:error] = @category.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    CategoryPayment.where(category_id: @category.id).destroy_all
    if @category.destroy
      flash[:success] = 'category deleted successfully'
      redirect_to categories_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
