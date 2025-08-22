# frozen_string_literal: false

class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy update_status]

  def index
    tasks = Task.order(created_at: :desc)
    @tasks = TaskFilter.new(tasks, params).call.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('notices.task.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notices.task.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notices.task.deleted')
  end

  def update_status
    success = TaskStatusUpdater.new(@task, params[:status]).call
    respond_to do |format|
      if success
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: t('notices.task.status_updated') }
      else
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to tasks_path, alert: t('notices.task.invalid_status') }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
