class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
      redirect_to project_task_path(@task.project_id, @task)
    end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :task_id, :description)
  end

end
