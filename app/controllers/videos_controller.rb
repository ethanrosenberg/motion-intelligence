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

    #frames = process_video(search_url)
    response = HTTParty.get('http://flask-env.4mnkx6hkeu.us-east-2.elasticbeanstalk.com/process?video_url=https://motion-snapshots.s3.us-east-2.amazonaws.com/sample_video.mp4',
    {
      :headers => { 'Content-Type' => 'application/json' }
    })

    data = ["https://storage.cloud.google.com/snapshots-storage/image-nfqkbrodno", "https://storage.cloud.google.com/snapshots-storage/image-klqgbrxggv", "https://storage.cloud.google.com/snapshots-storage/image-hcjpzyplfu", "https://storage.cloud.google.com/snapshots-storage/image-zzhhuuvfbw", "https://storage.cloud.google.com/snapshots-storage/image-qvztudibtd", "https://storage.cloud.google.com/snapshots-storage/image-xcpqdmmhxh", "https://storage.cloud.google.com/snapshots-storage/image-fnjmurlafh", "https://storage.cloud.google.com/snapshots-storage/image-tagybklbab", "https://storage.cloud.google.com/snapshots-storage/image-omnhjgsvnp", "https://storage.cloud.google.com/snapshots-storage/image-itxpfieywc", "https://storage.cloud.google.com/snapshots-storage/image-aeywlqruwg", "https://storage.cloud.google.com/snapshots-storage/image-xjdzeomsgw", "https://storage.cloud.google.com/snapshots-storage/image-thvzoqdcgh", "https://storage.cloud.google.com/snapshots-storage/image-fzzuzhpftr", "https://storage.cloud.google.com/snapshots-storage/image-wgfldgksbg", "https://storage.cloud.google.com/snapshots-storage/image-cvyehwoymb", "https://storage.cloud.google.com/snapshots-storage/image-pcblhlainp", "https://storage.cloud.google.com/snapshots-storage/image-nmbgxatpkf", "https://storage.cloud.google.com/snapshots-storage/image-binwhsqbfr", "https://storage.cloud.google.com/snapshots-storage/image-ucatbyxush", "https://storage.cloud.google.com/snapshots-storage/image-lcijiuqvar", "https://storage.cloud.google.com/snapshots-storage/image-bhtepuuprz", "https://storage.cloud.google.com/snapshots-storage/image-dzzzofezqs", "https://storage.cloud.google.com/snapshots-storage/image-qdgmnxfpwv", "https://storage.cloud.google.com/snapshots-storage/image-cbwkxxdxqi", "https://storage.cloud.google.com/snapshots-storage/image-xbbyrnwjvd", "https://storage.cloud.google.com/snapshots-storage/image-vkglrfyhqa", "https://storage.cloud.google.com/snapshots-storage/image-donwtbyzbc", "https://storage.cloud.google.com/snapshots-storage/image-qurpstrzup", "https://storage.cloud.google.com/snapshots-storage/image-qfmhvfyikc"]

    sleep 3

    render json: response.parsed_response
    #render json: response.parsed_response








    #test_frames = ["https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:05.640.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:07.320.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:09.760.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:11.840.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:15.800.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:18.960.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:21.640.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:27.240.png", "https://algorithmia.com/v1/data/ethanrosenberg/scenegrabs/00:00:30.520.png"]
    #render json: {results: frames}

  end

end
