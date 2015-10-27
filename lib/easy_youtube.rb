require "net/http"
class EasyYouTube
  URL_FORMATS = {
    :regular => /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=(?<id>[^&]+)/,
    :shortened => /^(https?:\/\/)?(www\.)?youtu.be\/(?<id>[^&]+)/,
    :embed => /^(https?:\/\/)?(www\.)?youtube.com\/embed\/(?<id>[^&]+)/,
    :embed_as3 => /^(https?:\/\/)?(www\.)?youtube.com\/v\/(?<id>[^?]+)/,
    :chromeless_as3 => /^(https?:\/\/)?(www\.)?youtube.com\/apiplayer\?video_id=(?<id>[^&]+)/
  }
        
  INVALID_CHARS = /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/

  def self.extract_video_id(youtube_url)
    return nil if has_invalid_chars?(youtube_url)
    URL_FORMATS.values.each do |format_regex|
      match = format_regex.match(youtube_url)
      return match[:id] if match
    end
    return nil
  end

  def self.has_invalid_chars?(youtube_url)
    !INVALID_CHARS.match(youtube_url).nil?
  end

  def self.youtube_embed_url(youtube_url, width = 420, height = 315)
    create_embeded_url(extract_video_id(youtube_url), width, height)
  end

  def self.create_embeded_url(video_id, width = 420, height = 315)
    %(<iframe width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{video_id}" frameborder="0" allowfullscreen></iframe>)
  end

  def self.youtube_regular_url(youtube_url)
    create_regular_url(extract_video_id(youtube_url))
  end

  def self.create_regular_url(video_id)
    "http://www.youtube.com/watch?v=#{video_id}"
  end

  def self.youtube_shortened_url(youtube_url)
    create_shortened_url(extract_video_id(youtube_url))
  end

  def self.create_shortened_url(video_id)
    "http://youtu.be/#{ video_id }"      
  end

  def self.valid_id?(id)
    if id
      response = Net::HTTP.get("gdata.youtube.com", "/feeds/api/videos/#{id}")
      if ["Invalid id", "Video not found"].include? response
        false
      else
        true
      end
    else
      false
    end
  end        

  def self.valid_youtube_url?(youtube_url)
    if has_invalid_chars?(youtube_url)
      false
    else
      valid_id?(extract_video_id(youtube_url))
    end
  end
  
  def self.thumb_video(video_id)
    "https://i.ytimg.com/vi/#{ video_id }/hqdefault.jpg"
  end
end
