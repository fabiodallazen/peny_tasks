# frozen_string_literal: true

# app/services/task_status_updater.rb
class TaskStatusUpdater
  PERMITTED = %w[pending completed].freeze

  def initialize(task, new_status)
    @task = task
    @new_status = new_status
  end

  def call
    return false unless PERMITTED.include?(@new_status)

    @task.update(status: @new_status)
  end
end
