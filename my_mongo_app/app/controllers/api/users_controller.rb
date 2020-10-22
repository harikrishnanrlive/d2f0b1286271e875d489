class Api::UsersController < ApplicationController
  before_action:find_user, except: %[create index]

  def index
    @users = User.all
    render json: @users, status: ok
  end

  def show
    render json: @user, status: ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: created
    else
      render json: {erros, @user.erros.full_messgaes},
        status: :unprocessable_entity
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
  def user_params
    params.permit(:email, :firstName, :lastName)
  end
end
