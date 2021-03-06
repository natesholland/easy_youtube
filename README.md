# Easy YouTube

[![Gem Version](https://badge.fury.io/rb/easy_youtube.svg)](https://badge.fury.io/rb/easy_youtube)
[![Build Status](https://travis-ci.org/natesholland/easy_youtube.svg?branch=master)](https://travis-ci.org/natesholland/easy_youtube)
[![Code Climate](https://codeclimate.com/github/natesholland/easy_youtube/badges/gpa.svg)](https://codeclimate.com/github/natesholland/easy_youtube)

## Description

Easy YouTube is a gem designed to simplify some common methods surrounding parsing youtube urls and id's.

## Installation

### Gem Installation

Add in your `gemfile`

    gem 'easy_youtube'

or download and install Easy YouTube with the following.

    gem install easy_youtube

## Usage

Easy Youtube is a relatively simple gem which can be easily understood by reading the source code but here are some useful examples:

**You can feed in any youtube url and extract the video id**

`EasyYouTube.extract_video_id("http://www.youtube.com/watch?v=L57s0Q2qgYg")
=> "L57s0Q2qgYg"`

`EasyYouTube.extract_video_id("http://youtu.be/L57s0Q2qgYg") => "L57s0Q2qgYg"`

**Check if a video id or a url is valid**

`EasyYouTube.valid_youtube_url?("http://www.youtube.com/watch?v=L57s02qgYg") => true`

`EasyYouTube.valid_youtube_url?("http://www.youtube.com/watch?v=L57s0#2qgYg") => false`

`EasyYouTube.EasyYouTube.valid_id?('L57s0Q2qgYg') => true`

`EasyYouTube.EasyYouTube.valid_id?('notvalid') => false`

**Return thumb video**

`EasyYouTube.thumb_video("https://youtu.be/cD4TAgdS_Xw") => "https://i.ytimg.com/vi/cD4TAgdS_Xw/hqdefault.jpg"`

**And convert urls and video ids into different types of videos**

`EasyYouTube.youtube_shortened_url("http://www.youtube.com/watch?v=L57s0Q2qgYg") => "http://youtu.be/L57s0Q2qgYg"`

`EasyYouTube.create_regular_url("L57s0Q2qgYg") => "http://www.youtube.com/watch?v=L57s0Q2qgYg"`

## License

(The MIT License)

Copyright (c) 2014:

 - {Nate Holland}[https://github.com/natesholland]

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
