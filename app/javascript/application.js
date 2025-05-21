// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

function toggleMenu() {
  const menu = document.getElementById('dropdown-menu');
  menu.classList.toggle('hidden');
}