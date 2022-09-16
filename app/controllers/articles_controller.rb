class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id]) unless session[:user_id].nil?
    logger.debug "Article user: #{@article.user}"
    logger.debug "New article: #{@article.attributes.inspect}"
    logger.debug "Article should be valid: #{@article.valid?}"
    if @article.save
      logger.debug 'The article was saved and now the user is going to be redirected...'
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    logger.debug "Article should be destroyed: #{@article.attributes.inspect}"
    @article.destroy
    logger.debug 'The article was destroyed'
    flash[:success] = 'Article was deleted'
    logger.debug 'Notification about destroy'
    redirect_to articles_path, status: :see_other
  end

  def show
    @article = Article.find_by(id: params[:id].to_i)
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was updated'
      redirect_to article_path(@article)
    else
      flash[:success] = 'Article was not updated'
      render 'edit'
    end
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
