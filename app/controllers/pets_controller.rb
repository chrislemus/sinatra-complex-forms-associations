class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    owner = params[:owner_name].length > 0 ? Owner.create(name: params[:owner_name]) : Owner.find(params[:owner])
    pet = Pet.create(name: params[:pet_name], owner_id: owner.id)
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    pet = Pet.find(params[:id])
    # binding.pry
    owner_id = !params[:owner_name].empty? ? Owner.create(name: params[:owner_name]).id : params[:owner][:name]
    pet.name = params[:pet_name] if !params[:pet_name].empty?
    pet.owner_id = owner_id
    pet.save
    redirect to "pets/#{pet.id}"
  end
end