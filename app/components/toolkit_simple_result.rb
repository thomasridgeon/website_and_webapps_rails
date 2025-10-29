class ToolkitSimpleResult < Phlex::HTML
  def initialize(calculator_type:, result:)
    @calculator_type = calculator_type
    @result = result
  end

  def view_template
    div(id: "result-#{@calculator_type.downcase}") do
      if @result.present?
        div(class: "mt-4 text-center") do
          h3(class: "text-lg font-bold mb-2 p-2 rounded-md bg-blue-50 text-blue-800 border border-blue-200") { @result }
        end
      end
    end
  end
end
