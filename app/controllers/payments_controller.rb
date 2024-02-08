class PaymentsController < ApplicationController
  before_action :set_category, only: %i[index new create]
  before_action :set_payment, only: [:destroy]

  def index
    @payments = @category.payments.order(id: :desc)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build(payment_params)
    @categories = Category.where(id: payment_params[:category_ids])

    if @payment.save
      @categories.each { |category| category.payments << @payment unless category.payments.include?(@payment) }
      flash[:success] = 'Transaction was created!'
      redirect_to category_payments_path(@category)
    else
      flash.now[:error] = @payment.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @payment.destroy
      
      flash[:success] = 'trnaction was successfully deleted.'
    else
      flash[:error] = 'Failed to delete trnaction.'
    end
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find_by(id: params[:category_id])
    return if @category

    flash[:error] = 'Category not found'
    redirect_to categories_path
  end

  def set_payment
    @payment = Payment.find_by(id: params[:id])
    unless @payment
      flash[:error] = 'Payment not found'
      redirect_to categories_path and return
    end
  end
  
  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end
