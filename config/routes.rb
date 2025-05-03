# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#main'

  post 'urls', to: 'urls#create'
  get 'urls/:id/success', to: 'urls#success',  as: :success
  get 'urls/:slug',       to: 'urls#redirect', as: :redirect

  get 'up' => 'rails/health#show', as: :rails_health_check
end
