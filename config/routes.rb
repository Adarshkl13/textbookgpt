Rails.application.routes.draw do
  devise_for :users
  
  root 'classrooms#index' 
  resources :classrooms

  resources :books do
    post :question, on: :member
  end
 
  resources :books, only: [:show]
  
  get '/_4th_standard_subjects' => 'classrooms#_4th_standard_subjects', as: '_4th_standard_subjects'
  get '/_5th_standard_subjects' => 'classrooms#_5th_standard_subjects', as: '_5th_standard_subjects'
  get '/_6th_standard_subjects' => 'classrooms#_6th_standard_subjects', as: '_6th_standard_subjects'
  get '/_7th_standard_subjects' => 'classrooms#_7th_standard_subjects', as: '_7th_standard_subjects'
  get '/_8th_standard_subjects' => 'classrooms#_8th_standard_subjects', as: '_8th_standard_subjects'
  get '/_9th_standard_subjects' => 'classrooms#_9th_standard_subjects', as: '_9th_standard_subjects'
  get '/_10th_standard_subjects' => 'classrooms#_10th_standard_subjects', as: '_10th_standard_subjects'
end
