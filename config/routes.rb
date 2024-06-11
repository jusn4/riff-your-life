Rails.application.routes.draw do
  root to: 'homes#top'
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
end
