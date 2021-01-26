class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 
    owner = Owner.create(name: params['owner']['name'])
    new_pet_name = params['pet']['name']
    Pet.create(name: new_pet_name, owner_id: owner.id) if new_pet_name
    params['owner']['pet_ids'].each{|pet_id| 
      pet = Pet.find(pet_id)
      pet.owner_id = owner.id
      pet.save
    }
    redirect "/owners/#{owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    owner = Owner.find(params[:id])
    owner.name = params['owner']['name']
    owner.save

    new_pet_name = params['pet']['name']
    Pet.create(name: new_pet_name, owner_id: owner.id) if new_pet_name.length > 0

    params['owner']['pet_ids'].each{ |pet_id| 
      pet = Pet.find(pet_id)
      pet.owner_id = owner.id
      pet.save
    }

  end
end