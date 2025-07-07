// app/javascript/controllers/autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete"
export default class extends Controller {
  static values = { url: String }
  static targets = ["results"]

connect() {
this._handleClickOutside = this.handleClickOutside.bind(this);
document.addEventListener("click", this._handleClickOutside);
}

disconnect() {
document.removeEventListener("click", this._handleClickOutside);
}

search(event) {
  const value = event.target.value.trim();
  if (value.length < 1) {
    this.resultsTarget.innerHTML = "";
    return;
  }

  const query = encodeURIComponent(value);
  const url = `${this.urlValue}?q=${query}`;

  fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log("✅ Response data:", data);
      this.updateResults(data);
    })
    .catch(error => {
      console.error("❌ Fetch error:", error);
    });
}

  updateResults(data) {
    this.resultsTarget.innerHTML = '';

    data.forEach(item => {
      const li = document.createElement('li');
      li.textContent = item.title;  
      li.classList.add("cursor-pointer");
      li.addEventListener('click', () => {
        this.selectResult(item);
      });
      this.resultsTarget.appendChild(li);
    });
  }

  selectResult(item) {
    this.element.querySelector('input').value = item.title;  

    this.resultsTarget.innerHTML = '';
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.innerHTML = "";
    }
  }
}
