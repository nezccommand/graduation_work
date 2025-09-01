function toggleAnswerAndExplanation(button) {
  const targetId = button.getAttribute('aria-controls');
  const content = document.getElementById(targetId);
  const arrow = button.querySelector("svg");
  const label = button.querySelector("span");
  const isOpen = content.classList.contains("open");

  if (isOpen) {
    content.style.maxHeight = content.scrollHeight + "px";

    requestAnimationFrame(() => {
      content.style.maxHeight = "0px";
    });

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

    content.addEventListener("transitionend", function handler(e) {
      if (e.propertyName === "max-height") {
        content.style.maxHeight = "none";
        content.removeEventListener("transitionend", handler);
      }
    });
  }
}

window.toggleAnswerAndExplanation = toggleAnswerAndExplanation;
