class SegmentsController < ApplicationController
  before_action :set_segment, only: [:show, :update, :destroy]

  # GET /segments
  def index
    @segments = Segment.all
    render json: @segments
  end

  # GET /segments/:id
  def show
    begin
      @segment = Segment.find(params[:id])
      render json: @segment
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Segment not found" }, status: :not_found
    end
  end


  # POST /segments
  def create
    @segment = Segment.new(segment_params)
    if @segment.save
      render json: @segment, status: :created, location: @segment
    else
      render json: @segment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /segments/:id
  def update
    if @segment.update(segment_params)
      render json: @segment
    else
      render json: @segment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /segments/:id
  def destroy
    @segment.destroy
    head :no_content
  end

  private

  def set_segment
    @segment = Segment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Segment not found' }, status: :not_found
  end

  def segment_params
    params.require(:segment).permit(:name, :description)
  end
end
