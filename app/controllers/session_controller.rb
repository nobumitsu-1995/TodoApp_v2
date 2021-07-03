class SessionController < ApplicationController
  skip_before_action :authenticate

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to todos_path, notice: "ログインしました。"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
