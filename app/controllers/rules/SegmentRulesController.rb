class SegmentRulesController < ApplicationController
  before_action :set_segment
  before_action :set_rule, only: [:destroy]

  def create
    rule = @segment.segment_rules.new(rule_params)
    if rule.save
      render json: rule, status: :created
    else
      render json: rule.errors, status: :unprocessable_entity
    end
  end

  def index
    rules = @segment.segment_rules
    render json: rules
  end

  def destroy
    if @rule.destroy
      head :no_content
    else
      render json: @rule.errors, status: :unprocessable_entity
    end
  end

  private

  def set_segment
    @segment = Segment.find(params[:segment_id])
  end

  def set_rule
    @rule = @segment.segment_rules.find(params[:id])
  end

  def rule_params
    params.require(:rule).permit(:field, :operation, :value)
  end
end
