class HomeController < ApplicationController
  def index
    @foo = "form the controller"
  end

  def add_session
    session[:foo] = params[:foo]
    render :text => "added #{session[:foo]} to session"
  end

  def random
    time = Time.now
    rand = 5.times.map { Post.background.randomize }.map(&:result).to_sentence
    diff = Time.now - time
    rand << " took #{diff} secs"
    render :text => rand
  end
end
