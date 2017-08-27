# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
run Rails.application
