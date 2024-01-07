class SegmentUserController < ApplicationController
  # GET /segments/:id/users
  def index
    segment = Segment.find(params[:id])
    @users = apply_segment(segment)
    render json: @users
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  private

  def apply_segment(segment)
    users = User.all
    segment.segment_rules.each do |rule|
      users = filter_users(users, rule)
    end

    segment.segment_tag_rules.each do |tag_rule|
      users = users.joins(:tags).where(tags: { id: tag_rule.tag_id })
    end

    users
  end

  def filter_users(users, rule)
    case rule.field
    when 'first_name'
      users.where(first_name: rule.value)
    when 'last_name'
      users.where(last_name: rule.value)
    when 'email'
      users.where(email: rule.value)
    when 'birth_date'
      apply_date_filter(users, rule)
    when 'admission_date'
      apply_date_filter(users, rule)
    when 'is_active'
      users.where(is_active: rule.value == 'true')
    when 'sex'
      users.where(sex: rule.value)
    when 'last_sign_in_at'
      apply_date_filter(users, rule)
    else
      users
    end
  end

  def apply_date_filter(users, rule)
    case rule.operation
    when 'equals'
      users.where("#{rule.field}": rule.value)
    when 'before'
      users.where("#{rule.field} < ?", rule.value)
    when 'after'
      users.where("#{rule.field} > ?", rule.value)
    when 'between'
      date_range = rule.value.split('..')
      users.where("#{rule.field}": date_range[0]..date_range[1])
    else
      users
    end
  end
end
