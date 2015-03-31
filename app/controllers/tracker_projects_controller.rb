class TrackerProjectsController < PrivateController

  def show
    tracker_api = TrackerAPI.new
    if current_user.pivotal_tracker_token
      @tracker_project = params[:project_name]
      @tracker_stories = tracker_api.stories(current_user.pivotal_tracker_token, params[:id])
    end
  end
end
