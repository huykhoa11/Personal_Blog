class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show ]

  def show
    @articlesFilteredByCategory = Article.where(category_id: @category.id)
    add_breadcrumb "#{t @category.name}"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end


end
