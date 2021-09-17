class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    objUser = User
    @users = objUser.all  if current_user.admin?
    @users = objUser.where("role = ? or id = ?", :user,current_user.id)  if current_user.manager?  
    @users = objUser.where(id: current_user.id)  if current_user.user?

    respond_to do |format|
      format.html
      format.csv { send_data @users.generate_csv(csv_attr), filename: "users-#{Time.now}.csv" }
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def import
    User.import(params[:file])
    redirect_to root_url, notice: "Users imported."
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url , notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname,:lastname,:contatno,:address, :role, :email)
    end

    def csv_attr
      ['email','firstname', 'lastname', 'address', 'role']
    end
end

