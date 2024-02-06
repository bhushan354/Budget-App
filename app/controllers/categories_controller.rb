class CategoriesController < ApplicationController
    def index 
        @categories = current_user.categories
    end

    def show

    end

    def create
        @category = current_user.categories.new(category_params)
        if @category.save
            flash[:success] = "category saved sucessfully"
            redirect_to categories_path
        else
            flash.now[:error] = @category.errors.full_messages.to_sentence
            render :new
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update 
        @category = Category.find(params[:id])
        if @categorys.update(category_params)
            flash[:success] = 'category updated successfully'
            redirect_to categories_path
        else
            flash.now[:error] = @category.errors.full_messages.to_sentence
            render :edit
        end
    end

    def destroy
        @category = Category.find(params[:id])
        if @category.destroy
            flash[:success] = "category deleted successfully"
            redirect_to categories_path
        else
            flash[:error] = @category.errors.full_messages.to_sentence
            render :index
        end
    end

    private

    def category_params
        params.require(:category).permit(:name, icon)
    end

end
