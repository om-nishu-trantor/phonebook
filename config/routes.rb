Rails.application.routes.draw do
  resources :phone_lists do
    collection do
      delete :destroy_all
      get :download_text_file
      get :upload_text_file
      post :upload
    end
  end

  root "phone_lists#index"
end
