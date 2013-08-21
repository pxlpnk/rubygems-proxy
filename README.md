rubygems-proxy
==============

[![Build Status](https://travis-ci.org/pxlpnk/rubygems-proxy.png?branch=master)](https://travis-ci.org/pxlpnk/rubygems-proxy)
[![Code Climate](https://codeclimate.com/github/pxlpnk/rubygems-proxy.png)](https://codeclimate.com/github/pxlpnk/rubygems-proxy)
[![Dependency Status](https://gemnasium.com/pxlpnk/rubygems-proxy.png)](https://gemnasium.com/pxlpnk/rubygems-proxy)


Usage
=====
<pre>
git clone https://github.com/pxlpnk/rubygems-proxy.git

cd rubygems-proxy

bundle install --without development test

rackup</pre>

In your Gemfile let the source point to: ```source 'http://gems.example.com'```

The proxy will bypass redirect to rubygems.org to resolve the dependencies. 
The gems and gemspecs that are then requestes are downloaded to ```cache/``` and served from there.
