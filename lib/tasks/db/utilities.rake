namespace :db do
  desc "Dumps the database to data/liebruri-TIMESTAMP.sql"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      host ||= "localhost"
      user ||= "liebruri"
      cmd = "pg_dump --host #{host} --username #{user} --verbose --clean --no-owner --no-acl --format=c #{db} > #{Rails.root}/data/liebruri-#{DateTime.now.to_i}.sql"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    filename = ARGV[1] || "lol.sql"
    with_config do |app, host, db, user|
      host ||= "localhost"
      user ||= "liebruri"
      cmd = "pg_restore --verbose --host #{host} --username #{user} --clean --no-owner --no-acl --dbname #{db} #{Rails.root}/data/#{filename}"
    end
    Rake::Task["db:drop"].invoke rescue nil
    Rake::Task["db:create"].invoke rescue nil
    puts cmd
    exec cmd
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username]
  end
end
