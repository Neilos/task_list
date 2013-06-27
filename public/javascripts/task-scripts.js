function add_task_to_view(data){
  var new_task = $('#template_task').clone()
  new_task.attr('id', "new")
  new_task.attr('class', "ui-state-default")
  $( new_task ).append(' ' + task_display_value(data))
  new_task.appendTo("#sortable")
}

function task_display_value(data){
  return data.description + " | " + data.due + " | Completed? " + data.completed
}

function get_task_data_from_form() {
  var data = {
    task_no: $('#task_no').val(),
    description: $('#description').val(),
    due: $('#due').val(),
    completed: $('#completed').is(':checked')
  }
  return data;
}

function clear_task_data_from_form() {
    task_no: $('#task_no').val('');
    description: $('#description').val('');
    due: $('#due').val('');
    completed: $('#completed').prop('checked', false);
}

function send_task_data() {
  // TODO remove newly created task from view if response from server was a failure
  var data = get_task_data_from_form()
  $.post("/create_task", data)
    .done(function() { add_task_to_view(data); })
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
  $( "#create-task" )
    .button()
    .click(function() {
      $("#due").datepicker('setDate', new Date());
      $( "#dialog-form" ).dialog( "open" );
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

// Create task button for modal
  $( "#update-task" )
    .button()
    .click(function() {
      $( "#update-form" ).dialog( "open" );
  });


});
