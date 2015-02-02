Rails.application.routes.draw do
  get "static_pages/home", as: "home"
  get "static_pages/help", as: "help"
  get "static_pages/about", as: "about"

end
