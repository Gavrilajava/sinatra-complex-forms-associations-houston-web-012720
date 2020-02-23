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
    owner = Owner.create(name: params[:owner][:name])

    if params[:owner][:pet_ids]
      params[:owner][:pet_ids].each { |pet_id|
        Pet.find(pet_id).update(owner_id: owner.id)
      }
    end
    if params[:pet][:name] != ""
      Pet.create(name: params[:pet][:name], owner_id: owner.id)
    end
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
    binding.pry
    owner = Owner.find(params[:id])
    owner.update(name: params[:owner][:name])
    if params[:owner][:pet_ids]
      params[:owner][:pet_ids].each { |pet_id|
        Pet.find(pet_id).update(owner_id: owner.id)
      }
    end
    if params[:pet][:name] != ""
      Pet.create(name: params[:pet][:name], owner_id: owner.id)
    end
    redirect "/owners/#{owner.id}"
  end
end