class ArticlesController < ApplicationController

  before_action :set_articles, only: [:edit, :update, :destroy, :show]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # List All Articles
  def index
    @articles = Article.all.order(updated_at: :desc)
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end


  # Render new Article Form
  def new
    @article = Article.new
  end


  # Show the Single Article
  def show
  end

  # Add New Article
  def create
    @article = Article.create(article_params)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
      flash[:success] = "Article was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end


  # Edit Form Article
  def edit
  end

  # Update the Request Article
  def update
    if @article.update(article_params)
      redirect_to articles_path
      flash[:success] = "Article was successfully Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end




  # Delete the Req
  def destroy
    @article.destroy
    redirect_to articles_path
    flash[:danger] = "Article was successfully Deleted"
  end


  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_articles
    @article = Article.find(params[:id])
  end


  private
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      redirect_to current_user
      flash[:danger] = "Permission Denied, Please Edit your own Articles"
    end
  end
end
