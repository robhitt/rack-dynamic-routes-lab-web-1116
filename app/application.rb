class Application

    @@items = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # req.path == "/items/apple"

    if req.get? && req.path.include?("/items/")

      item_input = req.path.split("/items/").last

      item = @@items.find do |item|
        item_input == item.name
      end

      if item != nil
        resp.write(item.price)
      else
        resp.write("Item not found")
        resp.status = 400
      end
    else
      resp.write("Route not found")
      resp.status = 404
    end

    resp.finish
  end
end
