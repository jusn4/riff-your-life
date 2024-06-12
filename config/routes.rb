Rails.application.routes.draw do
  namespace :admin do
    get 'users/show'
    get 'users/index'
  end
  root to: 'homes#top'
  scope module: :public do
    #urlからpublicを消したいためscope moduleを使用
    get '/mypage' => 'users#mypage'
  end

  namespace :admin do
    resources :users, only: [:index, :show]
  end
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
    post "user/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
end
