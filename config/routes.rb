  Rails.application.routes.draw do
    devise_for :users
    scope "/admin" do
      namespace :api do
        namespace :v1 do
          resources :contacts, :users
        end
      end
    end
   
    # constraints subdomain: 'api' do
    #   scope module: 'api' do
    #     namespace :v1 do
    #       resources :contacts
    #     end
    #   end
    # end
  end

 