class Check < ActiveRecord::Base
  belongs_to :worker

  Essrate  = 0.062
  Wssrate  = 0.062
  Emedrate = 0.0145
  Wmedrate = 0.0145

  before_save do
    self.gross    = monetarize(self.hours * self.rate)
    self.soctax   = monetarize(self.gross * Wssrate)
    self.medtax   = monetarize(self.gross * Wmedrate)
    self.emsoctax = monetarize(self.gross * Essrate)
    self.emmedtax = monetarize(self.gross * Emedrate)
    stat = Worker.find(self.worker_id)
    if stat.married
      self.net = 1
    else
      self.net = 0
    end
  end

  protected
    def monetarize(raw)
      BigDecimal.new(raw).round(2)
    end
end
