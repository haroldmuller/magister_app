Rails.application.routes.draw do

  resources :registers
  resources :home
  devise_for :users
  resources :users
  resources :content_choices
  resources :ct_choices
  #resources :trees
  resources :ct_subhabilities
  resources :reports

  post '/courses/:course_id/trees/:id' => 'trees#edx_view'
  get 'trees/report_values', to: 'trees#set_report_values', as: 'set_report_values'

  resources :courses do
    resources :trees do
      resources :ct_questions do
        resources :ct_habilities
      end
      resources :content_questions
      resources :feedbacks
      resources :contents

    end
  end


  get 'homeworks/:id/answers/:id/generate_pdf', to:"answers#generate_pdf"
  post 'homeworks/:id/answers/:id/generate_pdf', to:"answers#generate_pdf", as:"generate_pdf"

  get 'homeworks/:id/studentanswer', to:"homeworks#answers"
  post 'courses/new' => 'courses#agregate'
  post 'courses/:id/edit' => 'courses#edit'
  patch 'courses/:id/edit'=> 'courses#edit'
  get 'courses/:id/users'=> 'courses#students'
  post 'courses/:id/eval_form', to:'courses#eval_form', as: "eval_form"
  get 'courses/:id/eval_form', to:'courses#eval_form'
  post 'courses/:id/reportes', to:'courses#reportes', as: "reportes"
  get 'courses/:id/reportes', to:'courses#reportes'
  post 'courses/:id/students_report', to:'courses#students_report', as: "students_report"
  get 'courses/:id/students_report', to:'courses#students_report'

  post 'courses/:id/trees/:tree_id/tree_performance', to:'trees#tree_performance', as: "tree_performance"
  get 'courses/:id/trees/:tree_id/tree_performance', to:'trees#tree_performance'

  post 'courses/:id/trees/:tree_id/tree_performance/:user_id', to:'trees#user_info', as: "user_tree_info"
  get 'courses/:id/trees/:tree_id/tree_performance/:user_id', to:'trees#user_info'

  post 'courses/:id/st_report/:st_id', to:'courses#st_report', as: "st_report"
  get 'courses/:id/st_report/:st_id', to:'courses#st_report'

  get 'homework/:id/asistencia', to:'homeworks#asistencia', as:"homework_asistencia"
  post 'homework/:id/asistencia',to:'homeworks#asistencia'
  post 'homework/:id/edit',to:'homeworks#edit'
  get 'homework/:id/edit',to:'homeworks#edit'
  resources :courses do
    resources :reports
    resources :users do
      resources :homeworks
    end
  end

  post  'homeworks/:id' => 'homeworks#change_phase'
  resources :homeworks do
    resources :answers
  end

  root 'home#home'

end
