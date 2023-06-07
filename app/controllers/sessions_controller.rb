class SessionsController < ApplicationController


  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      byebug
      redirect_to user
      flash[:success] = "Signed In successfully"
    else
      render :new, status: :unprocessable_entity
      flash[:danger] = "Credentials Not Found in our system. Try again :)"
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged Out successfully"
    redirect_to login_path
  end
end
