// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import ButtonPhoneController from "./button_phone_controller"
application.register("button-phone", ButtonPhoneController)

import MapController from "./map_controller"
application.register("map", MapController)

import ScrollController from "./scroll_controller"
application.register("scroll", ScrollController)

import ReadMoreController from "./read_more_controller"
application.register("read-more", ReadMoreController)

import CurrentYearController from "./current_year_controller"
application.register("current-year", CurrentYearController)
// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
