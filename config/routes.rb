Rails.application.routes.draw do
  root to: "static_pages#home", as: "root"

  get "static_pages/help", as: "help"
  get "static_pages/about", as: "about"
  get "static_pages/contact", as: "contact"

end
