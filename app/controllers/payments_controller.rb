class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_payment, only: %i[show edit update destroy]

  def index
    @category = Category.find(params[:category_id])
    @payments = @category.payments.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @payments, status: 200 }
    end
  end

  def create
    @payment = current_user.payments.new(payment_params.merge(user_id: current_user.id).except(:categories))
    params[:categories].each do |key|
      @payment.categories << Category.find_by(id: key)
    end
    puts params[:categories]
    if @payment.save

      redirect_to category_payments_path(params[:category_id]), notice: 'Payment successful created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @payment = current_user.payments.new
    @category = Category.find(params[:category_id])
  end

  def show
    @payment = Payment.find_by(id: params[:id])
  end

  def edit; end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, :user_id, categories: [])
  end
end
