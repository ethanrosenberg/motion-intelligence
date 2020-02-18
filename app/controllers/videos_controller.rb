require 'algorithmia'


class VideosController < ApplicationController

  def index


    input = "ethanrosenberg"
    client = Algorithmia.client('simT1luO+gWfSZxNgCEslhTYg8A1')
    algo = client.algo('ethanrosenberg/Hello/0.1.0')
    algo.set('timeout':300) # optional
    puts algo.pipe(input).result

    byebug
    # Authenticate with your API key
    #apiKey = ENV['ALGORITHMIA_API']


    input = {
      video: "https://www.youtube.com/watch?v=OMgIPnCnlbQ",
      detector: "content"
    }
    client = Algorithmia.client('simT1luO+gWfSZxNgCEslhTYg8A1')
    algo = client.algo('media/SceneDetection/0.1.6')
    algo.set('timeout':300) # optional
    puts algo.pipe(input).result



    #algo = client.algo('media/SceneDetection/0.1.6')
    #algo.set('timeout':300) # optional

    #puts algo.pipe(input).result




  end

end
