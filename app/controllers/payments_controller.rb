class PaymentsController < ApplicationController
  before_action :set_category, only: %i[index new create]

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

  private

  def set_category
    @category = Category.find_by(id: params[:category_id])
    return if @category

    flash[:error] = 'Category not found'
    redirect_to categories_path
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end
