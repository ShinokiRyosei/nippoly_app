class ArticlesController < ApplicationController

  before_action :required_user_logged_in
  # TODO: 同じチームのユーザーのみ閲覧可
  before_action :required_current_user_post, only: [:destroy, :new, :create]

  def index
    user = User.find_by(name: params[:user_id])
    @articles = user.articles
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to user_article_path(current_user, @article)
    else
      # TODO: render :new
      redirect_to :new
    end

  end

  def show
    user = User.find_by(name: params[:user_id])
    @article = user.articles.find_by(params[:article_id])

    @comments = @article.comments
  end

  def edit
    @article = Article.find_by(params[:article_id])
  end

  def update
    @article = Article.find_by(params[:article_id])

    if @article.update(article_params)
      redirect_to user_article_path(current_user, @article)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy

    redirect_to action: :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def required_current_user_post
    user = User.find_by(name: params[:user_id])
    unless user == current_user
      redirect_to root_url
    end
  end
end
