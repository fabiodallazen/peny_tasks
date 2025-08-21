# frozen_string_literal: true

pin 'application', preload: true
pin '@hotwired/turbo-rails', preload: true
pin '@hotwired/stimulus', preload: true
pin '@hotwired/stimulus-loading', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
