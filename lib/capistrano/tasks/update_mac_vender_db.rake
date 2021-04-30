namespace :deploy do
  after :migrating, :update_mac_vendor_db do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'macker:update'
        end
      end
    end
  end
end