class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # get '/' do
  #   { message: "Hello world" }.to_json
  # end
  get '/games' do 
    # games = Game.all
    # games = Game.all.order(:title)
    games = Game.all.order(:title).limit(5)
    games.to_json
  end

  get '/games/:id' do 
    id = params[:id]
    game = Game.find(id)
    # game.to_json

    #include only reviews
    # game.to_json(include: :reviews)

    #also user associated with each review
    game.to_json(include: {reviews: {include: :user}})

    #select what attr to return using only
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: {only: [:name]}
      }}})

  end

end
