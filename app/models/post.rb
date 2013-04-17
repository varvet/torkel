class Post
  class << self
    include TorqueBox::Messaging::Backgroundable

    def randomize
      sleep 1
      rand(100)
    end
  end
end
