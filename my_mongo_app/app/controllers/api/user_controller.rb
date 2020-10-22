class Api::UserController < ApplicationController
  before_action :find_user, only: %[show update destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id].to_i)
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    if @user.present?
      @user.update(user_params)
      render json: {message: 'success', data: @user}
    else
      render json: { errors: 'User not found'}, status: :not_found
    end
  end

  def destroy
    @user = User.find(params[:id].to_i)
    if @user.present?
      @user.destroy(user_params)
      render json: {message: 'success', data: @user}
    else
      render json: {errors: "user not found"}, status: :not_found
    end
  end

  def typehead
    @users = User.any_of({firstName => /. *#{params[:input]}}). */},
    {:lastName => /. *#{params[:input]}}). */},
    {:email => /. *#{params[:input]}}). */})
    render json: {message: 'success', data: @users}
  end

  private 

  def find_user
    @user = User.find(params[:id].to_i)
  end

  def user_params
    params.permit(:email, :firstName, :lastName)
  end
end
