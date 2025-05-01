# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#main'

  post 'urls', to: 'urls#create'
  get 'urls/:id/success', to: 'urls#success', as: :success

  get 'up' => 'rails/health#show', as: :rails_health_check
end
