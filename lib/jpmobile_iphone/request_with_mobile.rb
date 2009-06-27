module Jpmobile
  module RequestWithMobile
    def iphone?
      !(user_agent =~ /(Mobile\/.+Safari)/).nil?
    end
  end
end

