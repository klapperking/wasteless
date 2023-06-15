// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BarcodeHandlerController from "./barcode_handler_controller"
application.register("barcode-handler", BarcodeHandlerController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SelectionController from "./selection_controller"
application.register("selection", SelectionController)

import ShoppingListController from "./shopping_list_controller"
application.register("shopping-list", ShoppingListController)
