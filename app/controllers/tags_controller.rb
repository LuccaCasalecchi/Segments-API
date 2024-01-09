class TagsController < ApplicationController

  # GET /tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /tags/:id
  def show
    begin
      @tag = Tag.find(params[:id])
      render json: @tag
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/:id
  def update
    set_tag
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/:id
  def destroy
    set_tag
    @tag.destroy
    head :no_content
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Tag not found' }, status: :not_found
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
