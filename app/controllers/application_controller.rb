class ApplicationController < ActionController::Base
  # This will ensure that the authenticate_user! method is defined before it is used as a callback.
  before_action :authenticate_user!
end
