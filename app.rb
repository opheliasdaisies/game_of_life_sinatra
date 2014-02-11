require "bundler"
Bundler.require
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application
  
  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, "public"
  end

  get "/" do
    File.read("public/app/index.html")
  end

	end
end