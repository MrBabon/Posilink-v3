import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-more"
export default class extends Controller {
  static targets = ["content", "button"]

  toggle() {
    this.contentTarget.classList.toggle("expanded");
    const button = this.buttonTarget;
    if (this.contentTarget.classList.contains("expanded")) {
      button.textContent = this.lessTextValue;
    } else {
      button.textContent = this.moreTextValue;
    }
  }

  get moreTextValue() {
    return this.data.get("read-more-more-text-value") || "Lire plus";
  }

  get lessTextValue() {
    return this.data.get("read-more-less-text-value") || "Lire moins";
  }
}
