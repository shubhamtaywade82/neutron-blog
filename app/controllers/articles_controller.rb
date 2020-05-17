# frozen_string_literal: true

# Articcles copntrol;er
class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
end
