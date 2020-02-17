require 'algorithmia'


class VideosController < ApplicationController

  def index



    # Authenticate with your API key
    apiKey = ENV['ALGORITHMIA_API']

    byebug
    # Create the Algorithmia client object
    client = Algorithmia.client(apiKey)

    input = {
      video: "https://www.youtube.com/watch?v=OMgIPnCnlbQ",
      detector: "content"
    }
    algo = client.algo('media/SceneDetection/0.1.6')
    algo.set('timeout':300) # optional
    puts algo.pipe(input).result




  end

end
