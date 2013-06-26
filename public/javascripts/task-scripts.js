$(document).ready(function() {
  
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
        $( "#sortable").append( "<li class=\"ui-state-default\"><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>" + description.val() + " " + due.val() + "<button type=\"button\">Edit</button></li>");
        $("#description").val("");
        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
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
