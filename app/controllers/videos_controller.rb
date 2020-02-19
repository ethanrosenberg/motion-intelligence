require 'algorithmia'


class VideosController < ApplicationController


  def process_video(url)

    input = {
      video: url,
      detector: "content",
      output_collection_frames: "scenegrabs"
    }

    api_key = 'simT1luO+gWfSZxNgCEslhTYg8A1'

    puts 'Processing video: ' + url + ' || timeout: 20 min'

    response = HTTParty.post("https://api.algorithmia.com/v1/algo/media/SceneDetection/0.1.6",
              {
                :body => input.to_json,
                :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Authorization' => api_key},
                :timeout => 1200
              })

    puts 'Finished processing video!. '

    frames = response.parsed_response["result"]["output_collection_frames"]

    frame_snapshots = []

    frames.map {|frame| frame_snapshots << frame.gsub('data://.my/scenegrabs/', 'https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/') }



  end

  def index

    frames = ["data://.my/scenegrabs/00:00:05.640.png", "data://.my/scenegrabs/00:00:07.320.png", "data://.my/scenegrabs/00:00:09.760.png", "data://.my/scenegrabs/00:00:11.840.png", "data://.my/scenegrabs/00:00:15.800.png", "data://.my/scenegrabs/00:00:18.960.png", "data://.my/scenegrabs/00:00:21.640.png", "data://.my/scenegrabs/00:00:27.240.png", "data://.my/scenegrabs/00:00:30.520.png"]













    api_response = process_video('https://vimeo.com/292559022')
#response = HTTParty.post("https://api.algorithmia.com/v1/algo/media/SceneDetection/0.1.6?timeout=300", :headers => auth, body: input)



    byebug
    # Authenticate with your API key
    #apiKey = ENV['ALGORITHMIA_API']



    client = Algorithmia.client('simT1luO+gWfSZxNgCEslhTYg8A1')
    algo = client.algo('media/SceneDetection/0.1.6')
    algo.set('timeout':300) # optional
    puts algo.pipe(input).result



    #algo = client.algo('media/SceneDetection/0.1.6')
    #algo.set('timeout':300) # optional

    #puts algo.pipe(input).result




  end

end
