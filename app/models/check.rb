class Check < ActiveRecord::Base
  belongs_to :worker

  monthAllowance = 325
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

    taxed1 = self.gross - self.soctax - self.medtax
    taxed2 = taxed1 - (monthAllowance * self.worker.withhold)

    self.fedtax = self.worker.married ? marriedFedTax(taxed2) : singleFedTax(taxed2)
    self.net = self.gross - self.soctax - self.medtax - self.fedtax
  end

  protected
    def monetarize(raw)
      BigDecimal.new(raw, 12).round(2)
    end

    def fedTax(lump, taxed2, threshhold, excessrate)
      raw = lump + (taxed2 - threshhold) * excessrate
      monetarize raw
    end

    def marriedFedTax(taxed2)
      if taxed2 < 692
        monetarize(0)
      elsif taxed2 < 2179
        fedTax(0, taxed2, 692, 0.1)
      else
        fedTax(148.7, taxed2, 2179, 0.15)
      end
    end

    def singleFedTax(taxed2)
      if taxed2 < 183
        monetarize(0)
      elsif taxed2 < 927
        fedTax(0, taxed2, 183, 0.1)
      elsif taxed2 < 3204
        fedTax(74.4, taxed2, 927, 0.15)
      else
        fedTax(415.95, taxed2, 3204, 0.25)
      end
    end
end
