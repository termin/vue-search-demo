#!/usr/bin/env ruby
# coding: utf-8

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/cross_origin'
require 'json'
enable :cross_origin
enable :reloader

get '/genres' do
  cross_origin
  ['Classical', 'Jazz'].to_json
end

get '/artists' do
  cross_origin
  if (!params.key?(:genre)) then
    return [].to_json
  end

  genre = params[:genre].to_sym
  artists = {
    'Classical': ['Sachio Fujioka', 'Josep Pons'],
    'Jazz': ['Hiromi Uehara', 'Chihiro Yamanaka'],
  }

  if (!artists.key?(genre)) then
    return [].to_json
  end
  artists[genre].to_json
end

get '/albums' do
  cross_origin
  if (!params.key?(:artist)) then
    return [].to_json
  end

  artist = params[:artist].to_sym
  albums = {
    'Sachio Fujioka': ['Yoshimatsu: Symfony No.4', 'Yoshimatsu: Symfony No.5'],
    'Josep Pons': ['Piazzolla: Concerto pourBandoneon'],
    'Hiromi Uehara': ['Spark', 'Move'],
    'Chihiro Yamanaka': ['Monk Studies', 'Guilty Pleasure'],
  }

  if (!albums.key?(artist)) then
    return [].to_json
  end
  albums[artist].to_json
end

