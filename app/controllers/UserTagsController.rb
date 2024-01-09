class UserTagsController < ApplicationController
  # POST /users/:user_id/tags/:tag_id
  def assign
    user = User.find(params[:id])
    tag = Tag.find(params[:tag_id])
    user.tags << tag unless user.tags.include?(tag)
    head :created
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  # DELETE /users/:user_id/tags/:tag_id
  def remove
    user = User.find(params[:id])
    tag = user.tags.find(params[:tag_id])
    user.tags.delete(tag)
    head :no_content
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  # GET /users/:user_id/tags
  def index
    user = User.find(params[:id])
    render json: user.tags
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
