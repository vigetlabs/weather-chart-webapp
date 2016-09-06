class ParticleCaller
  def initialize(device)
    @device = device
  end

  def variable(param)
    Particle.device("#{@device}").variable(param)
    rescue
  end

  def function(function, param)
    ## pass ParticleRB the deivce ID as a string -- this doesn't work otherwise!
    request = Particle.device("#{@device}").function(function,param)

    #for testing without bugging eli
    # return true

    rescue
  end
end

#access token configured in config/initalizers/particle.rb
