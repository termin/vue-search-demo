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

get '/tracks' do
  cross_origin
  if (!params.key?(:album)) then
    return [].to_json
  end

  album = params[:album].to_sym
  tracks = {
    'Yoshimatsu: Symfony No.4': [
      'Symfony No.4 I. Allegro moderato - Moderato - Allegro molto - Allegro - Tempo I',
      'Symfony No.4 II. Waltz: Allegro moderato - Allegro - Tempo I',
      'Symfony No.4 III. Adagietto - Moderato - Andante - Tempo I - Moderato',
      'Symfony No.4  IV. Finale: Allegro molto - Presto',
      'Trombone Concerto "Orion Machine" I. Betelgeuse: Largo —',
      'Trombone Concerto "Orion Machine" II. Bellatrix: Presto —',
      'Trombone Concerto "Orion Machine" III. Trapezium: Lento - Tempo di Waltz - Lento —',
      'Trombone Concerto "Orion Machine" IV. Saiph: [ - ] - Moderato [Swing!] - Solo Cadenza - Fanfare: Allegro —',
      'Trombone Concerto "Orion Machine" V. Rigel: Finale: Moderato - Andante - Adagio - Largo',
      'Atom Hearts Club Suite No. 1 I. Allegro molto - Coda',
      'Atom Hearts Club Suite No. 1 II. Andante',
      'Atom Hearts Club Suite No. 1 III. Scherzo: Allegro scherzando - Coda',
      'Atom Hearts Club Suite No. 1 IV. Finale: Allegro molto - Andante - Coda presto',
    ],
    'Yoshimatsu: Symfony No.5': [
      'Symphony No. 5 I. Andante pesante - Allegro molto',
      'Symphony No. 5 II. Allegretto - Allegro molto',
      'Symphony No. 5 III. Andante lamentoso',
      'Symphony No. 5 IV. Andante maestoso - Allegro molto',
      'Atom Hearts Club Suite No. 2 I. Pizzicato Steps',
      'Atom Hearts Club Suite No. 2 II. Aggressive Rock',
      'Atom Hearts Club Suite No. 2 III. Brothers Blues',
      'Atom Hearts Club Suite No. 2 IV. Rag Super Light',
      'Atom Hearts Club Suite No. 2 V. Mr. G. Returns',
      'Atom Hearts Club Suite No. 2 VI. Atomic Boogie',
      'Prelude to the Celebration of Birds',
    ],
  }

  if (!tracks.key?(album)) then
    return [].to_json
  end
  tracks[album].to_json
end
