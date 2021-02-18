<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page language="java" import="commons.Crud" %>
<%
	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "knygos";
	String userId = "root";
	String password = "";
	String[] lent_knygos = {"id", "pav","zhanr_knigi","author_knigi","ISBN","god_vipuska_knigi" };
	String[] lauk_knygos = new String [ lent_knygos.length ];		
	Crud knygos = new Crud ( "knygos", lent_knygos );
	String errormsg= "";
	String id_knygos = "0";
%>
<html>
<%
	Connection connection = null;
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;
%>
	<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toDelete_' + id_rec );
				pav =  mygtukasEdit.dataset.pav;
				var r = confirm( "Ar norite pašalinti keliones knygos ?" );
				
				if ( r == true ) {
					
					document.getElementById ( "m_del" ).value = id_rec;
					forma_del = document.getElementById ( "del_rec" );
					forma_del.submit();
				}
			}	
  $( function() {
    var dialog, form,
 
      nazvanie_knigi = $( "#nazvanie_knigi" ),
      zanr = $( "#zanr" ),
      author = $( "#author" ),
	  isbn = $( "#isbn" ),
	  god_vipuska = $( "#god_vipuska" ),
      allFields = $( [] ).add( nazvanie_knigi ).add( zanr ).add( author ).add( isbn ).add( god_vipuska ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( "Length of " + n + " must be between " +
          min + " and " + max + "." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addBook() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
      if ( valid ) {
        $( "#users tbody" ).append( "<tr>" +
          "<td>" + nazvanie_knigi.val() + "</td>" +
          "<td>" + zanr.val() + "</td>" +
          "<td>" + author.val() + "</td>" +
		  "<td>" + isbn.val() + "</td>" +
		  "<td>" + god_vipuska.val() + "</td>" +
        "</tr>" );
        dialog.dialog( "close" );
      }
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 800,
      width: 500,
      modal: true,
      buttons: {
        "add book": addBook,
        Cancel: function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
      }
    });
 
    form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addBook();
    });
 
    $( "#create-book" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });
  } );
  </script>
<%	
	String salis = "Lietuva";
	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}
%>	
		<meta charset="utf-8">
		  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  		  <link rel="stylesheet" href="/resources/demos/style.css">
		<style>
			.table {
		background-color: #bec5cf;
		opacity: 0.8;
		}
        .header {
		background-color: #858b94;
		opacity: 0.9;
	}
		label, input { display:block; }
		input.text { margin-bottom:12px; width:95%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 1.2em; margin: .6em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
		</style>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<%
	try { 
	
		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		 String del;
		String where_salyga;
	
		if ( ( ( del = request.getParameter("del")  ) != null ) && del.equals ( "del1rec" ) ) {
			id_knygos= request.getParameter("m_del");
			String sql_delete = knygos.delete (id_knygos);
			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_delete);

		} 
	}  catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>		 
	</head>
<body>
<div id="dialog-form" title="Create new user">
  <p class="validateTips">All form fields are required.</p>
 
  <form>
    <fieldset>
      <label for="nazvanie_knigi">nazvanie knigi</label>
      <input type="text" name="nazvanie_knigi" id="nazvanie_knigi" value="" class="text ui-widget-content ui-corner-all">
      <label for="zanr">zanr</label>
      <input type="text" name="zanr" id="zanr" value="" class="text ui-widget-content ui-corner-all">
      <label for="author">author</label>
      <input type="text" name="author" id="author" value="" class="text ui-widget-content ui-corner-all">
	  <label for="ISBN">ISBN</label>
      <input type="text" name="ISBN" id="ISBN" value="" class="text ui-widget-content ui-corner-all">
	  <label for="god_vipuska">god vipuska</label>
      <input type="text" name="god_vipuska" id="god_vipuska" value="" class="text ui-widget-content ui-corner-all">
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
<button id="create-book">add book</button>
<form id="del_rec" method="post" action="">
	<input type="hidden" name="del" value="del1rec">
	<input type="hidden" id="m_del" name="m_del" value="0">
</form>
<table class = "table" cellpadding="5" cellspacing="5" border="1">
<tr>
<tr>
	<th>nazvanie_knigi</th>
	<th>zanr</th>
	<th>author</th>
	<th>ISBN</th>
	<th>god_vipuska</th>
</tr>
</tr>
<%
	try {
		statement_take = connection.createStatement();		
		String sql = knygos.select ();
		resultSet = statement_take.executeQuery(sql);

		while( resultSet.next() ){

			String id_rec = resultSet.getString (  "id"  );
%>
<tr>
<%
		for ( int i = 1; i < lauk_knygos.length; i++ ) {		
%>
	<td><%= resultSet.getString (  lent_knygos [ i ]  ) %></td>
<%
		}
%>
<td><input type="button" class="delete"  id="toDelete_<%= id_rec  %>" data-id_miesto="<%= id_rec %>" value="&#10007;" onClick="iTrinima( <%= id_rec %> )"></td>
</tr>
<% 
		}
	}
	 catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>
</table>
</body>
</html>
