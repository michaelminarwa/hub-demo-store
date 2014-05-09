Spree::Order.hub_serializer = "DemoOrderSerializer"

Spree::Order.push_when = -> order { order.complete? && order.shipments.any?(&:ready?) }
