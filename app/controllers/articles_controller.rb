class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  before_action :set_article, only: %i[ new edit update destroy ]
  #before_action :set_search_ransack

  # GET /articles or /articles.json
  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: false).order(updated_at: :desc)
    if params[:q].blank?
      @articles = Article.all.with_rich_text_content.order(updated_at: :desc)
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.friendly.find(params[:id])
    add_breadcrumb "#{@article.title}", @article, class: " text-blue-400"
  end

  # GET /articles/new
  def new
    @article = Article.new
    add_breadcrumb "Create new article", new_article_path
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    p article_params
    @article.user_id = 1
    # @article.category_id = 1

    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      # @q = Article.ransack(params[:q])
      # @articles = @q.result(distinct: true)
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :category_id, :content)
    end
end
