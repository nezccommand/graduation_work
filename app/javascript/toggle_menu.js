document.addEventListener("turbo:load", () => {
  const button = document.getElementById("menu-button");
  const menu = document.getElementById("dropdown-menu");

  if (button && menu) {
    button.addEventListener("click", () => {
      menu.classList.toggle("hidden");
    });

    document.addEventListener("click", (event) => {
      if (!menu.contains(event.target) && !button.contains(event.target)) {
        menu.classList.add("hidden");
      }
    });
  }
});