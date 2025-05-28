module QuizzesHelper
  def formatted_explanation(text)
    return "" if text.blank?

    keywords = ["正解：","他の選択肢の解説：", "解説："]
    safe_text = h(text)

    keywords.each do |keyword|
      safe_text = safe_text.gsub(keyword, "<strong>#{keyword}</strong>")
    end

    safe_text = safe_text.gsub(/「.+?」/) do |match|
      "<strong>#{match}</strong>"
    end

    safe_text = safe_text.gsub(/\r\n|\r|\n/, "<br>")

    safe_text.html_safe
  end
end