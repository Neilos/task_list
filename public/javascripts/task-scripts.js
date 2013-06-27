function add_task_to_view(data){
  var json_data = jQuery.parseJSON(data)
  var new_task = $('#template_task').clone()
  new_task.attr('id', json_data.task_id)
  new_task.attr('class', "ui-state-default")
  $( new_task ).append(' ' + task_display_value(json_data))
  new_task.appendTo("#sortable")
}

function task_display_value(json_data){
  return json_data.description + " | " + json_data.due + " | Completed? " + json_data.completed
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

function clear_task_data_from_form() {
    task_no: $('#task_no').val('');
    description: $('#description').val('');
    due: $('#due').val('');
    completed: $('#completed').prop('checked', false);
}

function send_task_data() {
  var data_to_be_posted = get_task_data_from_form()
  $.post("/create_task", data_to_be_posted)
    .done(function(data) { add_task_to_view(data); })
    .fail(function() { alert("Error: Task not added"); })
}

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
  $( "#create-task" )
    .button()
    .click(function() {
      $("#due").datepicker('setDate', new Date());
      $( "#dialog-form" ).dialog( "open" );
  });

  $( "#dialog-form" ).dialog({
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


// Create task button for modal
  $( "#maincontent #update-task" )
    .button()
    .click(function() {
      $( "#update-form" ).dialog( "open" );
  });

  $( "#update-form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 800,
    modal: true,
    buttons: {
      "Update Task": function() {
        add_task_to_view(description.val(), due.val());
        send_task_data();
        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    }
  });



});
