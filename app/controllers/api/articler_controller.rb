class Api::ArticlerController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles, status: 200
  end

  def show
    @article = Article.find([params[:id]])
    if @article
      render json: @article, status: 200
    else
      render json: { error:"article not found" }, status: 400
    end
  end

  def create
    @article = Article.new(title: article_params[:title], body:article_params[:body], author:article_params[:author])
    if @article.save
      render status: :created
    else
      render json: { msg: "article not uploaded", error: true }, status: 422
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      render status: 200
    else
      render json: { msg: "article #{params[:id]} not updated", error: true } , status: :unprocesssable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article
      @article.destroy
    end

    render json: { msg: "article #{params[:id]} deleted" }
  end

  private
  def article_params
    params.require(:articler).permit(:title, :body, :author)
  end
end
