module SamplesHelper
  def split_sample_text_boxes(text)
    return if text.blank?

    parts = text.split("---SPLIT---")
    parts.map do |part|
      content_tag(:div, class: "mb-4") do
        content_tag(:pre, part.lstrip, class: "bg-gray-100 p-4 rounded text-sm text-gray-800 overflow-auto font-mono whitespace-pre-wrap")
      end
    end.join.html_safe
  end
end
