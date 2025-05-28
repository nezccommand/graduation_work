function toggleExplanation(button) {
  const targetId = button.getAttribute('aria-controls');
  const content = document.getElementById(targetId);
  const arrow = button.querySelector("svg");

  if (content.classList.contains("max-h-0")) {
    content.classList.remove("max-h-0");
    content.classList.add("max-h-[1000px]");
    content.classList.add("open");
    button.setAttribute("aria-expanded", "true");
    button.querySelector("span").textContent = "解説を非表示";
    arrow.classList.add("rotate-90");
  } else {
    content.classList.remove("max-h-[1000px]");
    content.classList.add("max-h-0");
    content.classList.remove("open");
    button.setAttribute("aria-expanded", "false");
    button.querySelector("span").textContent = "解説を表示";
    arrow.classList.remove("rotate-90");
  }
}

window.toggleExplanation = toggleExplanation;