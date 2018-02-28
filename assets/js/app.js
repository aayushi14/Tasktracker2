// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons() {
  $('.time-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let time = $(bb).data('time');
    if (time != "") {
      $(bb).text("Start");
    }
    else {
      $(bb).text("End");
    }
  });
}

function set_button(user_id, value) {
  $('.time-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('time', value);
    }
  });
  update_buttons();
}

function time_click(ev) {
  let btn = $(ev.target);
  let task_id = btn.data('time');
  let user_id = btn.data('user-id');

  if (task_id != "") {
    end(user_id, task_id);
  }
  else {
    start(user_id);
  }
}

function init_time() {
  if (!$('.time-button')) {
    return;
  }

  $(".time-button").click(time_click);

  update_buttons();
}

$(init_time);