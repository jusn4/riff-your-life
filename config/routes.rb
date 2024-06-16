Rails.application.routes.draw do
  
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    #skip以降の記述によりパスワード変更、管理者登録のルーティングの削除
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "admin/registrations",
    sessions: "admin/sessions",
    passwords: "admin/passwords",
    confirmations: "admin/confirmations"
  }

  devise_for :users, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords",
    confirmations: "public/confirmations"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  scope module: :public do
    #urlからpublicを消したいためscope moduleを使用
    get '/mypage' => 'users#mypage'
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :posts
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end
end
