function toggleAnswerAndExplanation(button) {
  const targetId = button.getAttribute('aria-controls');
  const content = document.getElementById(targetId);
  const arrow = button.querySelector("svg");
  const label = button.querySelector("span");
  const isHidden = content.classList.contains("open");

  if (isHidden) {
    content.style.maxHeight = null;
    content.classList.remove("open");
    button.setAttribute("aria-expanded", "false");
    label.textContent = button.dataset.showLabel || "解答・解説を表示";
    arrow?.classList.remove("rotate-90");
  } else {
    content.style.maxHeight = content.scrollHeight + "px";
    content.classList.add("open");
    button.setAttribute("aria-expanded", "true");
    label.textContent = button.dataset.hideLabel || "解答・解説を非表示";
    arrow?.classList.add("rotate-90");
  }
}

window.toggleAnswerAndExplanation = toggleAnswerAndExplanation;
