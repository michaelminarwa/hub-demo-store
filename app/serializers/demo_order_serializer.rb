#hack for values needed for demo
class DemoOrderSerializer < Spree::Wombat::OrderSerializer
  attributes :shipping_method, :shipping_carrier

  def shipping_method
    "UPS Ground"
  end

  def shipping_carrier
    "UPS"
  end
end
