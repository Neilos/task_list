$(document).ready(function() {
  
  function add_task_to_view(description, due){
    $( "#sortable").append( "<li class=\"ui-state-default\"><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>" + description+ " " + due + "<button type=\"button\">Edit</button></li>");
  }

// Sortable script
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();

// Datepicker script
  $( ".datepicker" ).datepicker();
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
        $("#description").val("");
        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
        // TODO needs to clear the form
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
