class MediasController < ApplicationController
  MEDIA_EXTS = %w(.ogg .oga .ogv .mp3 .mp4 .m4a .m4v .aac .wma .wmv .flv)

  def index
    @title = "Media"
    base_folder = Dir.open(BASE_FOLDER)
    @folders = base_folder.collect{|e| e if File.directory?("#{base_folder.path}/#{e}") && e[0,1] != '.' }.compact.sort
    @files = base_folder.collect{|e| e if MEDIA_EXTS.include? File.extname(e).downcase }.compact.sort
  end
  
  def dive
    @title = params[:folder].last
    @back = case params[:folder].size
      when 1 : '/'
      when 2 : params[:folder][0]
      else  
        params[:folder][0..-2].join('/')
    end
    @subpath = params[:folder].join('/')
    base_folder = Dir.open("#{BASE_FOLDER}/#{@subpath}")
    @folders = base_folder.collect{|e| e if File.directory?("#{base_folder.path}/#{e}") && e[0,1] != '.' }.compact.sort
    @files = base_folder.collect{|e| e if MEDIA_EXTS.include? File.extname(e) }.compact.sort
  end

  def play
    @title = "Player"
    @back = case params[:file].size
      when 1 : '/'
      when 2 : params[:file][0]
      else  
        params[:file][0..-2].join('/')
    end
    @subpath = params[:file].join('/')
    spawn(:method => :thread) {
      #`vlc --fullscreen --video-on-top --no-video-title-show --play-and-exit --quiet \"#{BASE_FOLDER}/#{subpath}\"`
      `vlc --play-and-exit --quiet \"#{BASE_FOLDER}/#{@subpath}\"`
    }
  end
end
