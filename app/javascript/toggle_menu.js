document.addEventListener("turbo:load", () => {
  const button = document.getElementById("menu-button");
  const menu = document.getElementById("dropdown-menu");

  if (button && menu) {
    let menuOpen = false;

    button.addEventListener("click", () => {
      menuOpen = !menuOpen;
      if (menuOpen) {
        menu.classList.remove("opacity-0", "scale-95", "pointer-events-none");
        menu.classList.add("opacity-100", "scale-100");
      } else {
        menu.classList.add("opacity-0", "scale-95", "pointer-events-none");
        menu.classList.remove("opacity-100", "scale-100");
      }
    });

    document.addEventListener("click", (event) => {
      if (
        !menu.contains(event.target) &&
        !button.contains(event.target) &&
        menuOpen
      ) {
        menu.classList.add("opacity-0", "scale-95", "pointer-events-none");
        menu.classList.remove("opacity-100", "scale-100");
        menuOpen = false;
      }
    });
  }
});