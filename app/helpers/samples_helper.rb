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

  def double_linebreak_simple_format(text)
    return if text.blank?

    doubled_text = text.gsub(/\n/, "\n\n")

    simple_format(doubled_text)
  end
end
