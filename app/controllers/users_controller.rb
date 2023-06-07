class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only:[:edit, :update]
  before_action :require_same_user, only:[:edit, :update]
  def index
    @users = User.all.order(created_at: :desc)
    @users = User.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
  end
  def new
    @user = User.new
  end

  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to articles_path
      flash[:success] = "Welcome, #{@user.username}. To the blog, write stories and share them to the world"

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end


  def show
    @articles = @user.articles.order(created_at: 'desc')
    @articles = @user.articles.order(created_at: :desc).paginate(page: params[:page], per_page: 5)

  end


  def update
    if @user.update(user_params)
      redirect_to articles_path
      flash[:success] = "Account Updated Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:success] = "All the Articles, Including User Account has been deleted"
    redirect_to articles_path
  end



  private


  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
end
