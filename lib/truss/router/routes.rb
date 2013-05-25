%w[get post put patch head options delete].each do |type|
    require "truss/router/routes/#{type}"
end

module Truss
    module Router
        module Routes
        end
    end
end
