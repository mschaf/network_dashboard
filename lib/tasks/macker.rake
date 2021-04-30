namespace :macker do

  desc "Update MAC Vendor DB"
  task :update do
    require "#{Rails.root}/config/initializers/macker.rb"

    Macker.update
  end

end