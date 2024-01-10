class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: @user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(create_user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /users/:id
  def update
    @user = User.find_by_id(params[:id])
    if @user.nil?
      render json: { error: "User not found" }, status: :not_found
    elsif @user.update(update_user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end



  # DELETE /users/:id
  def destroy
    @user = User.find_by_id(params[:id])
    if @user
      @user.destroy
      head :no_content
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :admission_date, :is_active, :sex, :last_sign_in_at)
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :sex)
  end
end
