class ApplicationController < ActionController::Base
  skip_befor_action :verify_authenticity_token
end
