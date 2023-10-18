import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = ['scroll'];

  connect() {
    window.addEventListener('scroll', this.updateScroll.bind(this));
    this.updateScroll();
  }

  disconnect() {
    window.removeEventListener('scroll', this.updateScroll.bind(this));
  }

  updateScroll() {
    if (window.scrollY <= 0) {
      this.scrollTarget.classList.remove('scroll-top');
      this.scrollTarget.classList.add('transition-top');
    } else {
      this.scrollTarget.classList.remove('transition-top');
      this.scrollTarget.classList.add('scroll-top');
    }
  }
}
