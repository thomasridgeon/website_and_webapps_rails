class TdeeResult < Phlex::HTML
  def initialize(tdee:)
    @tdee = tdee
  end
  def view_template
    # the div carries the result message and carries the ID required for replacement with Turbo Frames
    div(id: "tdee-result") do
      if @tdee
        p(class: "text-xl font-semibold text-center text-slate-800 mt-6") do
          "Your Total Daily Energy Expenditure is #{@tdee} kcal/day"
        end
      end
    end
  end
end
