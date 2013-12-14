ytdfed   = 0
ytdss    = 0
ytdmed   = 0
ytdgross = 0
ytdnet   = 0
ytdtaxes = 0

@worker.checks.each do |chk|
  if chk.created_at <= @check.created_at  && chk.created_at.strftime("%Y") == @check.created_at.strftime("%Y")
    ytdfed   += chk.fedtax
    ytdss    += chk.soctax
    ytdmed   += chk.medtax
    ytdgross += chk.gross
    ytdnet   += chk.net
  end
end

taxes = @check.fedtax + @check.medtax + @check.soctax
ytdtaxes = ytdfed + ytdss + ytdmed

  pdf.stroke_horizontal_rule
  pdf.move_down(10)
  pdf.text ENV['EMPLOYER']
  pdf.text ENV['ADDRESS1']
  pdf.text ENV['ADDRESS2']
  pdf.text "Pay Stub Detail", :align => :right
  pdf.text "PAY DATE:   #{@check.created_at.strftime("%b %d %Y")}", :align => :right
  pdf.text "NET PAY:  #{number_to_currency(@check.net)}", :align => :right
  pdf.text "#{@worker.fname} #{@worker.mname} #{@worker.lname}"
  pdf.text "#{@worker.address}"
  pdf.text "#{@worker.city}, #{@worker.state}  #{@worker.zipcode}"
  pdf.move_down(5)
  pdf.stroke_horizontal_rule

  pdf.bounding_box([0,520], :width => 260, :height => 120) do
    pdf.text "EMPLOYER", :size => 20, :style => :bold
    pdf.text ENV['EMPLOYER']
    pdf.text ENV['ADDRESS1']
    pdf.text ENV['ADDRESS2']
  end

  pdf.bounding_box([0,380], :width => 260, :height => 120) do
    pdf.text "EMPLOYEE", :size => 20, :style => :bold
    pdf.text "#{@worker.fname} #{@worker.mname} #{@worker.lname}"
    pdf.text "#{@worker.address}"
    pdf.text "#{@worker.city}, #{@worker.state}  #{@worker.zipcode}"
  end

  pdf.bounding_box([0,240], :width => 260, :height => 120) do
    pdf.table([["", "Regular Gross Pay"],
	["Hours", @check.hours],
	["Rate",  number_to_currency(@check.rate)],
	["Current", number_to_currency(@check.gross)],
	["YTD", number_to_currency(ytdgross)]
	]) do |table|
    end
  end

  pdf.bounding_box([0,100], :width => 260, :height => 100) do
    pdf.table([["", "CURRENT", "YTD"],
	["Federal Income Tax", number_to_currency(@check.fedtax), number_to_currency(ytdfed)],
	["Social Security",    number_to_currency(@check.soctax), number_to_currency(ytdss)],
	["Medicare",           number_to_currency(@check.medtax), number_to_currency(ytdmed)]
	]) do |table|
    end
  end

  pdf.bounding_box([280,520], :width => 130, :height => 120) do
    pdf.text "Pay Date:"
    pdf.text "Total Hours:"
  end

  pdf.bounding_box([410,520], :width => 130, :height => 120) do
    pdf.text @check.created_at.strftime("%b %d %Y")
    pdf.text "#{@check.hours}"
  end

  pdf.bounding_box([280,380], :width => 260, :height => 120) do
    pdf.text "NET PAY:  #{number_to_currency(@check.net)}", :size => 20, :style => :bold
  end

  pdf.bounding_box([280,240], :width => 260, :height => 120) do
    pdf.stroke_bounds
    pdf.move_down(10)
    pdf.text "DEDUCTIONS", :size => 20, :style => :bold
  end

  pdf.bounding_box([280,100], :width => 260, :height => 100) do
    pdf.table([["", "CURRENT", "YTD"],
	["Gross Pay", number_to_currency(@check.gross), number_to_currency(ytdgross)],
	["Taxes",     number_to_currency(taxes), number_to_currency(ytdtaxes)],
	["Net Pay",   number_to_currency(@check.net), number_to_currency(ytdnet)]
	]) do |table|
    end
  end 
