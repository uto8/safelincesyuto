import "bootstrap"

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require('jquery')
require("@nathanvda/cocoon") 

Rails.start()
Turbolinks.start()
ActiveStorage.start()
