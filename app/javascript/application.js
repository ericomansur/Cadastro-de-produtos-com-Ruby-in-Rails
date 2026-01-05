// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Rails UJS precisa ser carregado assim
import Rails from "@rails/ujs";
Rails.start();
