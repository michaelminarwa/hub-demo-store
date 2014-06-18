Spree::Wombat::Config.configure do |config|
  config.connection_token = ENV["HUB_TOKEN"]
  config.connection_id = ENV["HUB_STORE_ID"]

  config.push_objects = ["Spree::Order"]
  config.payload_builder = {
    "Spree::Order" => {:serializer => "DemoOrderSerializer", :root => "orders"}
  }
end
