apply "config/application.rb"
gsub_file "config/application.rb", /require "rails\/all"/ do
  'require "rails"'
  '# Pick the frameworks you want:'
  'require "active_model/railtie"'
  'require "active_job/railtie"'
  'require "active_record/railtie"'
  'require "active_storage/engine"'
  'require "action_controller/railtie"'
  'require "action_mailer/railtie"'
  'require "action_view/railtie"'
  'require "action_cable/engine"'
  'require "sprockets/railtie"'
  '# require "rails/test_unit/railtie"'
end

template "config/database.example.yml.tt"
remove_file "config/database.yml"
copy_file "config/puma.rb", force: true
remove_file "config/secrets.yml"
copy_file "config/sidekiq.yml"

gsub_file "config/routes.rb", /  # root 'welcome#index'/ do
  '  root "home#index"'
end

copy_file "config/initializers/generators.rb"
copy_file "config/initializers/new_google_recaptcha.rb"
copy_file "config/initializers/rotate_log.rb"
copy_file "config/initializers/secret_token.rb"
copy_file "config/initializers/version.rb"
template "config/initializers/sidekiq.rb.tt"
copy_file "config/initializers/simple_form_bootstrap.rb"
copy_file "config/initializers/simple_form.rb"

gsub_file "config/initializers/filter_parameter_logging.rb", /\[:password\]/ do
  "%w[password secret session cookie csrf]"
end

file "config/initializers/assets.rb", <<-CODE
  Rails.application.config.assets.precompile += %w( admin.js admin.css authentication.css pdf.css )
CODE

apply "config/environments/development.rb"
apply "config/environments/production.rb"
apply "config/environments/test.rb"
template "config/environments/staging.rb.tt"

route 'root "pages#index"'
route %Q(mount Sidekiq::Web => "/sidekiq" # monitoring console\n)
