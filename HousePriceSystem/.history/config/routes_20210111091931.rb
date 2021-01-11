Rails.application.routes.draw do
  get 'articles/show'
  get 'tests/mytest'
  get 'booktest/show'
  get 'houseinfo/houseType'
  get 'housedetail/houseDirection'
  get 'housedetail/houseDecoration'
  get 'housedetail/houseTagList'
  get 'housedetail/communityAttention'
  get 'correlation/getCorrelation'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
