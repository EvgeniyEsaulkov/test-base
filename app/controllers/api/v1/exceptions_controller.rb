class Api::V1::ExceptionsController < ApiApplicationController
  before_filter :load_project

  def index
    @exceptions = if can_read_all_exceptions?
      @project.exceptions
    else
      @project.exceptions.for_user(current_user)
    end
  end

  private

  def can_read_all_exceptions?
    current_user.admin?
  end

  def load_project
    # ...
  end
end
