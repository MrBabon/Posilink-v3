import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="current-year"
export default class extends Controller {
  static targets = ["year"]

  connect() {
    this.yearTarget.textContent = new Date().getFullYear();
  }
}
