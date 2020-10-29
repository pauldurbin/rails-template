copy_file "bin/setup", force: true
copy_file "bin/run_migrations"
copy_file "bin/update", force: true
chmod "bin/setup", "+x"
chmod "bin/run_migrations", "+x"
chmod "bin/update", "+x"
