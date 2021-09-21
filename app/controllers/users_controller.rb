class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index   
    # pagination code, items: 'record count per page'
    @pagy, @users = pagy(get_users, items: 2)

    respond_to do |format|
      format.html{}
      format.csv { send_data get_users.generate_csv(csv_attr), filename: "users-#{Time.now}.csv" }
      format.json { render json: @users, status: :ok }
    end
  end

  # GET /users/1/edit
  def edit
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

  # DELETE /users/import
  def import
    current_user_count = user_count
    begin
      @user_cnt = User.import(params[:my_csv_file])
      current_user_count = user_count - current_user_count
    rescue Exception => e
      redirect_to root_url, alert: "Import user failed, #{e.message}"
    else
      redirect_to root_url, notice: "#{current_user_count} Users imported."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Get users list based on Role
    def get_users
      objUser = User
      users_filter = objUser.all if current_user.admin? || current_user.id == 1
      users_filter = objUser.where("role = ? or id = ?", :user, current_user.id) if current_user.manager?
      users_filter = objUser.where(id: current_user.id)  if current_user.user?
      return users_filter
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname,:lastname,:contatno,:address, :role, :email)
    end

    def user_count
      User.count
    end

    def csv_attr
      ['email','firstname', 'lastname', 'address', 'role']
    end
end

