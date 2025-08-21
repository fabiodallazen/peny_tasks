# frozen_string_literal: true

class TaskFilter
  def initialize(relation = Task.all, params = {})
    @relation = relation
    @params = params
  end

  def call
    filter_by_status
    filter_by_query
    @relation
  end

  private

  def filter_by_status
    return if @params[:status].blank?

    @relation = @relation.where(status: @params[:status])
  end

  def filter_by_query
    return if @params[:q].blank?

    @relation = @relation.search(@params[:q])
  end
end
