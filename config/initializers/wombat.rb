Spree::Wombat::Config.configure do |config|

  config.connection_token = ENV["HUB_TOKEN"]
  config.connection_id = ENV["HUB_STORE_ID"]

  config.push_objects = ["Spree::Order"]
  config.payload_builder = {
    "Spree::Order" => {:serializer => "DemoOrderSerializer", :root => "orders"}
  }
  config.last_pushed_timestamps = { "Spree::Order" => nil }

  #config.push_url = "https://push.wombat.co"

end
