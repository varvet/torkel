class BridgeStomplet < TorqueBox::Stomp::JmsStomplet
  def configure(stomplet_config)
    super

    @destination_type = stomplet_config['type']
    @destination_name = stomplet_config['destination']
  end

  def on_message(stomp_message, session)
    send_to( destination_for( @destination_name, @destination_type ), stomp_message )
  end

  def on_subscribe(subscriber)
    subscribe_to( subscriber, destination_for( @destination_name, @destination_type ) )
  end

end
