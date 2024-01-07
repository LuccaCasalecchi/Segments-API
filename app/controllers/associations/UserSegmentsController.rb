class UserSegmentsController < ApplicationController
  # POST /users/:user_id/segments
  def create
    user = User.find(params[:user_id])
    segment = Segment.find(segment_params[:segment_id])
    if user.segments << segment
      head :created
    else
      render json: { error: 'Não foi possível adicionar o segmento ao usuário' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  # DELETE /users/:user_id/segments/:id
  def destroy
    user = User.find(params[:user_id])
    user_segment = user.user_segments.find_by!(segment_id: params[:id])
    user_segment.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  # GET /users/:user_id/segments
  def index
    user = User.find(params[:user_id])
    render json: user.segments
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  private

  def segment_params
    params.permit(:segment_id)
  end
end
