copy_file "app/assets/javascripts/application.js"
copy_file "app/assets/javascripts/admin.js"

copy_file "app/assets/stylesheets/application.scss"
copy_file "app/assets/stylesheets/admin.scss"
copy_file "app/assets/stylesheets/authentication.scss"

directory "app/assets/stylesheets/admin", "app/assets/stylesheets/admin"
directory "app/assets/stylesheets/functions", "app/assets/stylesheets/functions"
directory "app/assets/stylesheets/website", "app/assets/stylesheets/website"

remove_file "app/assets/stylesheets/application.css"

copy_file "app/controllers/home_controller.rb"
directory "app/controllers/admin", "app/controllers/admin"

copy_file "app/helpers/application_helper.rb", force: true
copy_file "app/helpers/javascript_helper.rb"
copy_file "app/helpers/layout_helper.rb"
copy_file "app/helpers/pagination.rb"
copy_file "app/helpers/retina_image_helper.rb"

directory "app/views/admin", "app/views/admin"
directory "app/views/layouts/shared", "app/views/layouts/shared"

copy_file "app/views/layouts/application.html.erb", force: true
copy_file "app/views/layouts/admin.html.erb"
copy_file "app/views/layouts/devise.html.erb"
template "app/views/layouts/base.html.erb.tt"

directory "app/views/content_items", "app/views/content_items"
directory "app/views/devise", "app/views/devise"
directory "app/views/home", "app/views/home"
directory "app/views/pages", "app/views/pages"
directory "app/views/shared", "app/views/shared"

copy_file "app/views/shared/_flash.html.erb"
copy_file "app/views/home/index.html.erb"

remove_dir "app/jobs"
empty_directory_with_keep_file "app/workers"
