require 'algorithmia'


class VideosController < ApplicationController

 API_KEY = 'simT1luO+gWfSZxNgCEslhTYg8A1'

  def process_video(url)

    #sample video - https://vimeo.com/292559022

    input = {
      video: url,
      detector: "content",
      output_collection_frames: "scenegrabs"
    }

    #api_key = 'simT1luO+gWfSZxNgCEslhTYg8A1'

    puts 'Processing video: ' + url + ' || timeout: 20 min'

    response = HTTParty.post("https://api.algorithmia.com/v1/algo/media/SceneDetection/0.1.6",
              {
                :body => input.to_json,
                :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json', 'Authorization' => API_KEY},
                :timeout => 1200
              })

    puts 'Finished processing video!. '

    frames = response.parsed_response["result"]["output_collection_frames"]

    return normalize_frame_urls(frames)


  end

  def normalize_frame_urls(frames)
    #frames = ["data://.my/scenegrabs/00:00:05.640.png", "data://.my/scenegrabs/00:00:07.320.png", "data://.my/scenegrabs/00:00:09.760.png", "data://.my/scenegrabs/00:00:11.840.png", "data://.my/scenegrabs/00:00:15.800.png", "data://.my/scenegrabs/00:00:18.960.png", "data://.my/scenegrabs/00:00:21.640.png", "data://.my/scenegrabs/00:00:27.240.png", "data://.my/scenegrabs/00:00:30.520.png"]
    cleaned_frames = frames.map {|frame| frame.gsub('data://.my/scenegrabs/', 'https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/') }
    return cleaned_frames
  end

  def index

    search_url = params[:url]

    frames = process_video(search_url)

    test_frames = ["https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:05.640.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:07.320.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:09.760.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:11.840.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:15.800.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:18.960.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:21.640.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:27.240.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:30.520.png"]
    render json: {results: frames}

  end

end
