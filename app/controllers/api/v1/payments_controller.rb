class Api::V1::PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments/1 or /payments/1.json
  def index
    @category = Category.find(params[:category_id])
    @payments = @category.payments.order(created_at: :desc)

    respond_to do |format|
      format.json { render json: [@payments, @category], status: 200 }
    end
  end

  def show
    @category = Category.find(params[:category_id])
    @payment = Payment.find_by(id: params[:id])

    respond_to do |format|
      format.json { render json: [@payment, @category], status: 200 }
    end
  end

  # GET /payments/new
  def new
    @payment = current_user.payments.new
    @category = Category.find(params[:category_id])
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments or /payments.json
  def create
    @payment = current_user.payments.new(payment_params.merge(user_id: current_user.id).except(:categories))
    params[:categories].each do |key|
      @payment.categories << Category.find_by(id: key)
    end
    puts params[:categories]
    if @payment.save
      respond_to do |format|
        format.json { render json: @payment, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
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

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:name, :amount, :user_id, categories: [])
  end
end
