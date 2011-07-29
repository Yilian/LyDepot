# See how all your routes lay out with "rake routes"
Depot::Application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    # get "store/index"
    resources :products do
      get :who_bought, :on => :member
    end 
    root :to => "store#index", :as => "store"
  end
end
