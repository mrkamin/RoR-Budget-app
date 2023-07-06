class TransactionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions/1 or /transactions/1.json
  def index
    @category = Category.find(params[:category_id])
    @transactions = @category.transactions.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @transactions, status: 200 }
    end
  end

  def show
    @transaction = transaction.find_by(id: params[:id])
  end

  # GET /transactions/new
  def new
    @transaction = current_user.transactions.new
    @category = Category.find(params[:category_id])
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.new(transaction_params.merge(user_id: current_user.id).except(:categories))
    params[:categories].each do |key|
      @transaction.categories << Category.find_by(id: key)
    end
    puts params[:categories]
    if @transaction.save
      # Go back to route
      redirect_to category_transactions_path(params[:category_id]), notice: 'transaction successful.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: 'transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_id, categories: [])
  end
end
