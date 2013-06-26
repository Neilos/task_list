function add_task_to_view(description, due){
  var new_task = $('#template_task').clone()
  new_task.attr('id', "new")
  new_task.attr('class', "ui-state-default")
  $( new_task ).append(' ' + task_display_value(description, due))
  new_task.appendTo("#sortable")
}

function task_display_value(description, due){
  return description+ " " + due
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
  $.post("/create_task", get_task_data_from_form()).done(
    function(data){}
  )
}

$(document).ready(function() {

// Sortable script
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();

// Datepicker script
  $( ".datepicker" ).datepicker({ dateFormat: "dd-mm-yy" });
// });

// Create task modal
// $(document).ready(function() {
  var description = $( "#description" ),
    due = $( "#due" );

  $( "#dialog-form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 800,
    modal: true,
    buttons: {
      "Create Task": function() {
        add_task_to_view(description.val(), due.val());
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

});
