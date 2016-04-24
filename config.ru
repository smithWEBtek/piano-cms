require './config/environment'
# require_relative './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
 
use Rack::MethodOverride
use StudentsController
use SongsController
run ApplicationController