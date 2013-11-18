# Gossip

Gossip fetches social share counts for any URL from major social networks,
quickly.

**Supported networks include:**

  - Facebook
  - Twitter
  - Google Plus
  - LinkedIn
  - Pinterest

## How To Use It

```ruby
url = 'http://github.com/'

# Default usage; get shares from all available networks.
Gossip.shares_for(url) #=> { facbeook: 123, twitter: 321, google_plus: 99 }

# Get shares from specific networks only:
Gossip.shares_for(url, sources: [:facebook, :twitter]) #=> { twitter: 123, facebook: 321 }

# If preferred, you can also get shares for a single network with this syntax:
Gossip.shares_from(:facebook, url) #=> 123

# And if you are only going to need shares from specific sources, you can change
# the default networks that are used when calling `shares_for`:
Gossip.default_sources = [:linkedin]
```

## Why It's Fast

We use a Typhoeus Hydra which executes requests in parallel and can do
response parsing while IO still happens in the background.

## Adding a Source

Adding a new source is relatively simple and straightforward. Any object that takes a URL in it's
initializer, responds to `#name` with a string, responds to `#request` with a `Typhoeus::Request`, and
has a `#parse_response` method that can parse a `Typhoeus::Response` object and return an integer is
valid. For convenience, `Gossip::Source` handles much of this behavior for you.

To lean on `Gossip::Source` an object needs only to define a few methods:

  - `base_url` (protected or private) — this will be used in conjunction with query parameters to create
    the final URL that will be requested.
  - `query_params` (protected or private) — if needed, a hash of parameters to be used in the request
  - `parse_response` (public) — takes a Typhoeus::Response object and should return an integer
    representing the share count.

### Example:

```ruby
module Gossip
  class Myspace # hahaha
    include Source

    def parse_response(response)
      response.body
    end
  protected
    def base_url
      'http://myspace.com/fake_shares_endpoint.json'
    end

    def query_params
      { url: url }
    end
  end
end
```

You can also override request parameters or get an escaped URL using the methods
available in `Gossip::Source`. The code is straightforward and easy to override.


## Questions?

Feel free to email me at corey.atx@gmail.com with any questions or for help. Cheers!
