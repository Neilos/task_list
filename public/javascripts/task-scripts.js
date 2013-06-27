
function clear_task_data_from_form() {
    task_no: $('#task_no').val('');
    description: $('#description').val('');
    due: $('#due').val('');
    completed: $('#completed').prop('checked', false);
}

// CREATE TASK FUNCTIONS

function task_display_value(json_data){
  return json_data.description + " | " + json_data.due + " | Completed? " + json_data.completed
}

function add_task_to_view(data){
  var json_data = jQuery.parseJSON(data)
  var new_task = $('#template_task').clone()
  new_task.attr('id', json_data.task_id)
  new_task.attr('class', "ui-state-default")
  $( new_task ).append(' ' + task_display_value(json_data))
  new_task.appendTo("#sortable")
}

function get_task_data_from_form() {
  var form_data = {
    task_no: $('#task_no').val(),
    description: $('#description').val(),
    due: $('#due').val(),
    completed: $('#completed').is(':checked')
  }
  return form_data;
}

function send_task_data() {
  var data_to_be_posted = get_task_data_from_form()
  $.post("/create_task", data_to_be_posted)
    .done(function(data) { add_task_to_view(data); })
    .fail(function() { alert("Error: Task not added"); })
}


// DELETE TASK FUNCTIONS

function remove_task_from_view(data) {
  var json_data = jQuery.parseJSON(data) // {task_id: "4654654546545gfdgdf"}
  var task_id = json_data.task_id  //"4654654546545gfdgdf"
  var existing_task = $( '#' + task_id )
  $( existing_task ).remove();
}

function get_task_id_of_html_task(id_of_task_to_be_deleted) {
  return { id: id_of_task_to_be_deleted }
}

function delete_task(id_of_task_to_be_deleted) {
  $.post("/delete_task", get_task_id_of_html_task(id_of_task_to_be_deleted) )
    .done(function(data) { remove_task_from_view(data); })
    .fail(function() { alert("Error: Task not deleted"); })
}

// UPDATE TASK FUNCTIONS

// function edit_task_in_view(data){
//   var parent_task = $("#update-task").parent()
//   $( parent_task ).text(' ' + task_display_value(data))
// }

// function task_display_value(json_data){
//   return json_data.description + " | " + json_data.due + " | Completed? " + json_data.completed
//  }

// function send_update_task_data() {
//   // TODO remove newly created task from view if response from server was a failure
//   var data = get_task_data_from_form()
//   $.post("/update_task", data)
//     .done(function() { edit_task_in_view(data); })
//     .fail(function() { alert("Error: Task not updated"); })
// }

// JAVASCRIPT EXECUTION

$(document).ready(function() {

// Sortable script
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();

// Datepicker script
  $( ".datepicker" ).datepicker({ dateFormat: "dd-mm-yy" });
// });

// Create task modal
  var description = $( "#description" ),
    due = $( "#due" );

// Create task button for modal
  $( "#create_task" )
    .button()
    .click(function() {
      $("#due").datepicker('setDate', new Date());
      $( "#dialog_form" ).dialog( "open" );
  });

  $( "#dialog_form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 800,
    modal: true,
    buttons: {
      "Create Task": function() {
        send_task_data();
        $( this ).dialog( "close" );
        clear_task_data_from_form();
      },
      Cancel: function() {
        $( this ).dialog( "close" );
        clear_task_data_from_form();
      }
    }
  });

// Delete task click handler
$("#maincontent").on('click', '.delete_task_button', function() {
  delete_task( $(this).parent().attr('id') );
});

// Create task button for modal
  $( "#maincontent .update_task" )
    .button()
    .click(function() {
      $( "#update_form" ).dialog( "open" );
  });

// Update task click handler and dialog handler
  $( "#update_form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 800,
    modal: true,
    buttons: {
      "Update Task": function() {
        send_update_task_data();
        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    }
  });

});
