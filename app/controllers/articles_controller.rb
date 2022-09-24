class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id]) unless session[:user_id].nil?
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = 'Article was deleted'
    redirect_to articles_path, status: :see_other
  end

  def show
    @article = Article.find_by(id: params[:id].to_i)
    respond_to do |format|
      format.html
      format.json{
        render show: @article
      }
      format.xml{
        render show: @article
      }
      format.pdf{
        render pdf: "Article #{params[:id]}", template: 'articles/show', formats: [:html], layout: 'pdf'
      }
    end
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
    respond_to do |format|
      format.html
      format.json{
        render index: @articles
      }
      format.xml{
        render index: @articles
      }
      format.pdf{
        render pdf: "Articles", template: 'articles/index', formats: [:html], layout: 'pdf'
      }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
