# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  def index
    @highlights = Article.desc_order.first(3)

    current_page = (params[:page] || 1).to_i
    highlights_ids = @highlights.pluck(:id).join(',')

    @articles = Article.without_highlights(highlights_ids)
                       .desc_order
                       .page(current_page)
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @articles, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @articles }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @articles.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to @article, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end

  private

def article_params
  params.require(:article).permit(:title, :body, :category_id)
end

def set_article
  @article = Article.find(params[:id])
end
