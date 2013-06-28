
function swapNodes(a, b) {
    var aparent = a.parentNode;
    var asibling = a.nextSibling === b ? a : a.nextSibling;
    b.parentNode.insertBefore(a, b);
    aparent.insertBefore(b, asibling);
}

function clear_task_data_from_form() {
    task_no: $('#task_no').val('');
    description: $('#description').val('');
    due: $('#due').val('');
    completed: $('#completed').prop('checked', false);
}

function convert_buttons_to_jquery_buttons(){
  $( "button" ).button();
}

function get_task_id_of_html_task(id_of_task) {
  return { id: id_of_task }
}
// CREATE TASK FUNCTIONS

function task_display_value(json_data){
  return json_data.description 
}

function add_task_to_page(json_data){
  var data = jQuery.parseJSON(json_data)
  var new_task = $('#template_task').clone()
  new_task.attr('id', data.task_id)
  new_task.attr('class', "ui-state-default")
  $( new_task ).children("#task_no").text(data.task_no)
  $( new_task ).children("#description").text(data.description)
  $( new_task ).children("#due").text(data.due)
  $( new_task ).children("#completed").text(data.completed)
  new_task.appendTo("#sortable")
}

function update_task_positions() {
  alert("updating task position");
  $.post("/update_task_positions", {"51cd739ea54d75b975000001": "6", "51cd73b4a54d753ba7000001": "5", "51cd958aa54d75e289000001": "4"})
    .done(function(data) { alert("success") })
    .fail(function() { alert("failure"); })
}

function get_task_data_from_form() {
  var form_data = {
    task_no: $('#create_task_no').val(),
    description: $('#create_description').val(),
    due: $('#create_due').val(),
    completed: $('#create_completed').is(':checked')
  }
  return form_data;
}

function send_new_task_data() {
  var data_to_be_posted = get_task_data_from_form()
  $.post("/create_task", data_to_be_posted)
    .done(function(data) { add_task_to_page(data); })
    .fail(function() { alert("Error: Task not added"); })
}


// DELETE TASK FUNCTIONS

function remove_task_from_view(json_data) {
  var data = jQuery.parseJSON(json_data) // {task_id: "4654654546545gfdgdf"}
  var task_id = data.task_id  //"4654654546545gfdgdf"
  var existing_task = $( '#' + task_id )
  $( existing_task ).remove();
}


function delete_task(id_of_task) {
  $.post("/delete_task", get_task_id_of_html_task(id_of_task) )
    .done(function(data) { remove_task_from_view(data); })
    .fail(function() { alert("Error: Task not deleted"); })
}


// UPDATE TASK FUNCTIONS

function amend_task_on_page(json_data){
  var data = jQuery.parseJSON(json_data) // {task_id: "4654654546545gfdgdf"}
  var task_id = data.task_id  //"4654654546545gfdgdf"
  var task_to_be_amended = $( '#' + task_id )
  $( task_to_be_amended ).children("#task_no").text(data.task_no)
  $( task_to_be_amended ).children("#description").text(data.description)
  $( task_to_be_amended ).children("#due").text(data.due)
  $( task_to_be_amended ).children("#completed").text(data.completed)
}

function get_updated_task_data_from_form(id_of_task) {
  var form_data = {
    id: id_of_task,
    task_no: $('#edit_task_no').val(),
    description: $('#edit_description').val(),
    due: $('#edit_due').val(),
    completed: $('#edit_completed').is(':checked')
  }
  return form_data;
}

function populate_form_with_task_data(data) {
  var data = jQuery.parseJSON(json_data)
  $('#edit_task_no').val(data.task_no)
  $('#edit_description').val(data.description)
  $('#edit_due').val(data.due)
  $('#edit_completed').prop('checked', data.completed);
}

function send_updated_task_data(id_of_task) {
  var data_to_be_posted = get_updated_task_data_from_form(id_of_task)
  $.post("/update_task", data_to_be_posted)
    .done(function(data) { amend_task_on_page(data); })
    .fail(function() { alert("Error: Task not updated"); })
}


// JAVASCRIPT EXECUTION

$(document).ready(function() {

  // Sortable script
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();

  // Datepicker script
  $( ".datepicker" ).datepicker({ dateFormat: "dd-mm-yy" });

  // Create task modal
  var description = $( "#description" ), due = $( "#due" );

  // Create task button for modal
  $( "#create_task" )
    .button()
    .click(function() {
      $( "#create_task_no" ).val('')
      $( "#create_description" ).val('')
      $("#create_due").datepicker('setDate', new Date());
      $( "#create_completed" ).val('')
      $( "#create_task_div" ).dialog( "open" );
  });

  // Delete task click handler
  $("#maincontent").on('click', '.delete_task_button', function() {
    delete_task( $(this).parent().attr('id') );
  });

  // Edit task click handler
  $("#maincontent").on('click', '.edit_task_button', function() {
    var id_of_task = $(this).parent().attr('id');
    var edit_task_no = $(this).parent().children('#task_no').text();
    var edit_description = $(this).parent().children('#description').text();
    var edit_due = $(this).parent().children('#due').text();
    var edit_completed = $(this).parent().children('#completed').text();

    get_updated_task_data_from_form(id_of_task)
    $( "#edit_task_no" ).val(edit_task_no)
    $( "#edit_description" ).val(edit_description)
    $( "#edit_due" ).datepicker('setDate', edit_due);
    $( "#edit_completed" ).val(edit_completed)
    $( "#edit_task_div" ).data('id_of_task', id_of_task).dialog( "open" );
  });

  $( "#create_task_div" ).dialog({
    autoOpen: false, height: 400, width: 800, modal: true,
    buttons: {
      "Create Task": function() {
        send_new_task_data();
        $( this ).dialog( "close" );
        clear_task_data_from_form();
      },
      Cancel: function() {
        $( this ).dialog( "close" );
        clear_task_data_from_form();
      }
    }
  });

  // Update task click handler and dialog handler
  $( "#edit_task_div" ).dialog({
    autoOpen: false, height: 400, width: 800, modal: true,
    buttons: {
      "Update Task": function() {
        var id_of_task = $(this).data('id_of_task');
        send_updated_task_data(id_of_task);
        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    }
  });

  convert_buttons_to_jquery_buttons();

});
