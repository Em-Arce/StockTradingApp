class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :set_user, only: %i[show edit update destroy ]

  def index
    @users_pending = User.where(status: "Pending")
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.broker? && @user.status == "Approved"
          UserMailer.broker_approved(@user).deliver_later
        end
        format.html { redirect_to @user, notice: "#{@user.email} details successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "#{@user.email} successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def admin_user
      unless current_user.admin?
        redirect_to static_pages_welcome_path, notice: "Unauthorized access."
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :broker, :buyer, :status, :cash)
    end
end
