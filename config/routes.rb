Ittest::Application.routes.draw do
  resources :questionwise_marks_distributions


  resources :options
  resources :questions
  resources :test_details
  resources :test_results
  resources :chapters
  resources :progress_report_users
  devise_for :users

  #match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  devise_scope :user do
    match '/users/sign_out', to: 'Devise::sessions#destroy', as: 'signout'
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get '/create_guest' => "welcome#create_guest", :as => :create_guest
  get '/contact_us' => "welcome#contact_us", :as => :contact_us
  get '/pricing' => "welcome#pricing", :as => :pricing

  get '/import_questions' => "welcome#import_questions", :as => :import_questions
  post '/importing_questions' => "questions#import", :as => :importing_questions

  get '/import_chapters' => "welcome#import_chapters", :as => :import_chapters
  post '/importing_chapters' => "chapters#import", :as => :importing_chapters

  get '/import_users' => "welcome#import_users", :as => :import_users
  post '/importing_users' => "welcome#importing_users", :as => :importing_users

  match '/test' => 'welcome#test', as: :test
  match '/test_submit' => 'test_details#test_submit', as: :test_submit
  match '/submit' => 'test_details#submit', as: :test_submit
  match '/show_results/:test_id' => 'test_details#show_details', as: :show_test_result

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
