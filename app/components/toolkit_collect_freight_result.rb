class ToolkitCollectFreightResult < Phlex::HTML
  def initialize(result:)
    @result = result
  end

  def view_template
    div(id: "result-collectfreight") do
      if @result.is_a?(Hash)
        div(class: "mt-4 text-center space-y-2 p-2 rounded-md bg-blue-50 text-blue-800 border border-blue-200") do
          p(class: "text-lg font-semibold") { "Collect Freight: #{@result[:bbd_collect]}" }
          p(class: "text-lg font-semibold") { "FX Charge: #{@result[:fx_charge]}" }
        end
      elsif @result.present?
        div(class: "mt-4 text-center") do
          p(class: "text-lg font-semibold") { @result }
        end
      end
    end
  end
end
