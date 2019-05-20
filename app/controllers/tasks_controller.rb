class TasksController < ApplicationController
  before_action :find_task, only: %i(show)

  private

  def find_task
    @task = Task.find(params[:id])
  end
end
