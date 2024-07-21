<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JqueryWithDatatable.aspx.cs" Inherits="ProjectABCD.JqueryWithDatatable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <script src="jquery.js"></script>
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
  <script type="text/javascript" >
      $(document).ready(function () {
          // DataTable initialization
          $('#example').DataTable({
              "ajax": {
                  "url": 'JqueryWithDatatable.aspx/GetDataTableData',
                  "type": "POST",
                  "dataType": "json",
                  "contentType": "application/json",
                  "dataSrc": function (json) {
                      return json.d;
                  }
              },
              "columns": [
                  { "data": "Name" },
                  { "data": "Age" },
                  { "data": "City" },
                  {
                      "render": function (data, type, row) {
                          return '<button type="button" class="btn btn-primary btn-edit" data-id="' + row.Id + '">Edit</button>';
                      }
                  }
              ]
          });

          // Handle edit button click
          $('#example').on('click', '.btn-edit', function () {
              var id = $(this).data('id');
              console.log('Edit button clicked for ID: ' + id);
              // Implement your edit logic here, e.g., open a modal with form fields filled with data for the selected row
          });

          // Handle save button click
          $('#btnSave').on('click', function () {
              INSERT();
          });

          // Function to handle insertion via AJAX
          function INSERT() {
              $.ajax({
                  url: 'JqueryWithDatatable.aspx/Save',
                  type: 'POST',
                  contentType: 'application/json; charset=utf-8',
                  dataType: 'json',
                  data: JSON.stringify({
                      Name: $('#txtname').val(),
                      Age: $('#txtage').val(),
                      City: $('#txtcity').val()
                  }),
                  success: function (data) {
                      alert('Record Saved Successfully !!!');
                      $('#example').DataTable().ajax.reload(); // Reload DataTable after saving record
                      clearFields(); // Clear input fields after successful save
                  },
                  error: function () {
                      alert('Record Not Saved !!!');
                  }
              });
          }

          // Function to clear input fields
          function clearFields() {
              $('#txtname').val('');
              $('#txtage').val('');
              $('#txtcity').val('');
          }
      });
  </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>Name</td>
                    <td><input type="text" id="txtname" /></td>
                </tr>
                <tr>
                    <td>Age</td>
                    <td><input type="text" id="txtage" /></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><input type="text" id="txtcity" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="button" id="btnSave" value="Submit" /></td>
                </tr>
            </table>
        </div>
    </form>

    <!-- DataTables Example Table -->
    <table id="example" class="display" border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Age</th>
                <th>City</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- DataTable rows will be dynamically added -->
        </tbody>
    </table>
</body>
</html>
