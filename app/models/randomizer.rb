class Randomizer < TorqueBox::Messaging::MessageProcessor
  def on_message(body)
    rand(100)
  end
end
