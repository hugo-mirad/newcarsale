<%@ page language="C#" autoeventwireup="true"  CodeFile="QCDataEdit.aspx.cs" Inherits="QCDataEdit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>..:: Car Sales System ::..</title>
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
    <link href="css/core.css" rel="stylesheet" type="text/css" />
    <link href="css/core.theme.css" rel="stylesheet" type="text/css" />
    <link href="css/styleNew.css" rel="stylesheet" type="text/css" />
    <link href="css/menu1.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="js/jquery-1.7.min.js"></script>

    <script src="Static/JS/CarsJScript.js" type="text/javascript"></script>

    <script type="text/javascript" src="js/emulatetab.joelpurra.js"></script>

    <script type="text/javascript" src="js/plusastab.joelpurra.js"></script>

    <script type='text/javascript' language="javascript" src='js/jquery.alphanumeric.pack.js'></script>

    <script src="js/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="js/ddsmoothmenu.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">window.history.forward(1);</script>

    <script type="text/javascript">
   function pageLoad()
   { 
 
      //InitializeTimer();   
      
      //date = new Date(parseInt(arr[2]), parseInt(arr[0])-1, parseInt(arr[1]) + 1);
        
        $('.arrowRight').click(function(){
             var arr = $('#txtStartDate').val().split('/')
            var date = new Date(parseInt(arr[2]), parseInt(arr[0])-1, parseInt(arr[1]) - 1);
            $('#txtStartDate').val((date.getMonth()+1)+'/'+date.getDate()+'/'+date.getFullYear()); 
        });
        
        $('.arrowLeft').click(function(){
            var arr = $('#txtStartDate').val().split('/')
            var date = new Date(parseInt(arr[2]), parseInt(arr[0])-1, parseInt(arr[1]) + 1);
            $('#txtStartDate').val((date.getMonth()+1)+'/'+date.getDate()+'/'+date.getFullYear());            
            
        });
        
        $('#GridUserUpdateList tr:last-child').remove();
        
     
}
         

   
    var ssTime,TimerID;
   function  InitializeTimer()
   {  
     WebService.sessionGet(onsuccessGet,onError);      
   }
     function onsuccessGet(result)
     {
      ssTime=result; 
      ssTime=parseInt(ssTime)*60000;
     
      TimerDec(ssTime);
     }
   
  
   
   function  TimerDec(ssTime)
   {
   
     ssTime=ssTime-1000;
   
    TimerID=setTimeout(function(){TimerDec(ssTime);},1000);
      
    if(ssTime==60000)
    {      
     SessionInc();     
    }
     
   }
  
      function poptastic(url)
    {
	newwindow=window.open(url,'name','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,height=420,width=385');
	    if (window.focus) {newwindow.focus()}
    }
    function SessionInc()//Increase the session time
    {
     debugger    
      ssTime=parseInt("<%= Session.Timeout %>");     
      WebService.sessionSet(ssTime,onsuccessInc,onError);//call webservice to set the session variable
       ssTime=(parseInt(ssTime)-2)*60000;       
       TimerDec(ssTime);     
    }
    
    function onsuccessInc(result)
    {
     
    }    

     function onError(exception, userContext, methodName)
     {
       try 
       {
        //window.location.href='error.aspx';
        strMessage = strMessage + 'ErrorType: ' + exception._exceptionType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Message: ' + exception._message + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Stack Trace: ' + exception._stackTrace + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Status Code: ' + exception._statusCode + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Timed Out: ' + exception._timedOut;
        ///alert(strMessage);
      } catch (ex) {}
     return false;
   }  

    </script>

    <script type="text/javascript" language="javascript">

	var currentID = 0;	
	var currentActiveIndex = 0;
	
	$(function(){
		currentID = $('.mainUL li.active').index();
		//sub1Act = $('.mainUL li.active li.act').index();
		sub2Act = $('.mainUL li.active li.act li.act').index();
		
		
		$('.mainUL .parent ul').hide(); // hide All Submenus
		$('.mainUL .parent a').click(function(){
			
			$('.mainUL .parent ul').hide(); // hide All Submenus
			
			
			$('.mainUL .parent a').each(function(){  // remove highlight for all anchor tags
				$(this).removeClass('act');
			});	
		    
		    
		    
		    
			
			$(this).closest('ul').closest('ul').show();		
			
			
			$(this).addClass('act'); //  highlight current clicked anchor tags
			
			$('.mainUL li').each(function(){ // remove active class for all list tags
				$(this).removeClass('active');
			});
			
			
			$(this).closest('li.parent').addClass('active'); //   highlight current clicked anchor tags parent list tag
			
			if($(this).next('ul')){ // if current clicked anchor tag has submenu it will show it
				$(this).next().show();
			}
			
			$('.mainUL li.parent:eq('+currentID+') li.act li:eq('+sub2Act+')').addClass('act');
			
		});
		
		
		$('.mainUL li.active a:eq(0)').click();
		
		$(document).mouseup(function(e) {  // on mouse click on the document exept menu, automatically all submenus will hide and reset
			var container = $('.mainUL');
			if (container.has(e.target).length === 0) {
				$('.mainUL .parent ul ').hide();
			
				$('.mainUL .parent a').each(function(){
					$(this).removeClass('act');
				});
				
				$('.mainUL').find('li.parent.active').removeClass('active');
				$('.mainUL li.parent:eq('+currentID+')').addClass('active');
				
				$('.mainUL li.active a:eq(0)').click();
				
			}
		});
			
			
		$('#vF input').live('change',function(){
		    if($(this).is(':checked')){
		        $(this).closest('label').addClass('act');
		    }else{
		        $(this).closest('label').removeClass('act');
		    }
		});
		
		
		
	});
    </script>

    <script type="text/javascript" language="javascript">
//<![CDATA[

	JoelPurra.PlusAsTab.setOptions({
		// Use enter instead of plus
		// Number 13 found through demo at
		// http://api.jquery.com/event.which/
		
		key: 13
	});
        /*
	$("form")
			.submit(simulateSubmitting);

	function simulateSubmitting(event)
	{
		event.preventDefault();

		if (confirm("Simulating that the form has been submitted.\n\nWould you like to reload the page?"))
		{
			location.reload();
		}

		return false;
	}
	*/
//]]>
    </script>

    <script type="text/javascript" language="javascript">
        //-------------------------- Agents Centers Info END ------------------------------------------
//    $(window).load(function(){
//        TransfersInfoBinding();
//    })
  function TransfersInfoBinding(){
     // youfunction()
        $(window).load(function(){
            //alert('Ok')
            youfunction()
        });            
  }
  
    
    function youfunction(){
        //alert('ok')
          $('#feat input[type=radio]').each(function(){
            if($(this).is(':checked')){
                $(this).parent().next('span').addClass('featAct')  
            }    
            
        });
        
        
         $('#infoV input[type=radio]').each(function(){
            if($(this).is(':checked')){
                $(this).parent().next('span').addClass('featAct')  
            }  
        });
        
        $('#feat input[type=checkbox]').each(function(){
                if($(this).is(':checked')){
                $(this).parent().next('span').addClass('featAct')  
                }  
        });
        	
    }
    
    // Generating Unique Array 
    function unique1(list) {
      var result = [];
      $.each(list, function(i, e) {
        if ($.inArray(e, result) == -1) result.push(e);
      });
      return result;
    }
 //-------------------------- Agents Centers Info END ------------------------------------------
    </script>

    <script type="text/javascript" language="javascript">
	
	$(function(){	
		
		if($('#Vinfo .barControl span').hasClass('bar0') ){
				var str = '';
				if($('#ddlMake option:selected').val() != 0){
					str += $('#ddlMake option:selected').text()+"-";				
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#ddlModel option:selected').val() != 0){
					str += $('#ddlModel option:selected').text()+"-";				
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#ddlYear option:selected').val() != 0){
					str += $('#ddlYear option:selected').text()+"-";
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#txtAskingPrice').val().length>0){
					str += "<span class='price11'>"+$('#txtAskingPrice').val()+"</span>-";
				}
				else
				{
				    str += "Unspecified"+"-";
				}				
				if($('#txtMileage').val().length>1){
					str += $('#txtMileage').val()+' mi';
				}
				else
				{
				   str += "Unspecified";
				}	
				if(($('#ddlMake option:selected').val() == 0) &&($('#ddlModel option:selected').val() == 0)&&($('#ddlYear option:selected').val() == 0)&&($('#txtAskingPrice').val().length<1)&&($('#txtMileage').val().length<1))			
				{
				   str = "";
				}				
						
				$('#selected').html(str);	
				$('.price11').formatCurrency();				
				
				
				
			}else{
				$('#selected').empty()
			}
		
		
		   // barControl
      $('.boxBlue .hed1').each(function(){
            var $this = $(this);
            $this.next('div.inn').hide();     
            $obj = $(this).children('div.barControl').children('span');        
            $obj.removeAttr('class').addClass('bar'+$('#hdns1').val());    
            if($obj.hasClass('bar0')){
                $this.next('div.inn').hide();
            }else{
                $this.next('div.inn').show();
            }
                    
      });
      
      $('.boxBlue .hed1 .barControl span').click(function(){
            
            
            if($(this).closest('.hed1').attr('id') == 'Vinfo' && $(this).hasClass('bar1') ){
				var str = '';
				if($('#ddlMake option:selected').val() != 0){
					str += $('#ddlMake option:selected').text()+"-";				
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#ddlModel option:selected').val() != 0){
					str += $('#ddlModel option:selected').text()+"-";				
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#ddlYear option:selected').val() != 0){
					str += $('#ddlYear option:selected').text()+"-";
				}
				else
				{
				    str += "Unspecified"+"-";
				}
				if($('#txtAskingPrice').val().length>0){
					str += "<span class='price11'>"+$('#txtAskingPrice').val()+"</span>-";
				}
				else
				{
				    str += "Unspecified"+"-";
				}				
				if($('#txtMileage').val().length>1){
					str += $('#txtMileage').val();
				}
				else
				{
				   str += "Unspecified";
				}	
				if(($('#ddlMake option:selected').val() == 0) &&($('#ddlModel option:selected').val() == 0)&&($('#ddlYear option:selected').val() == 0)&&($('#txtAskingPrice').val().length<1)&&($('#txtMileage').val().length<1))			
				{
				   str = "";
				}				
						
				$('#selected').html(str);	
				$('.price11').formatCurrency();				
				
				
				
			}else{
				$('#selected').empty()
			}
            
           
            
            
            if($(this).hasClass('bar0')){
                $(this).removeAttr('class').addClass('bar1'); 
                $(this).closest('.hed1').next().show();
                
                var indx = ($(this).closest('.boxBlue').index()) + 1;                
                $('#hdns'+indx).val(1);
            }else{
                $(this).removeAttr('class').addClass('bar0'); 
                $(this).closest('.hed1').next().hide();
                
                var indx = ($(this).closest('.boxBlue').index()) + 1;                
                $('#hdns'+indx).val(1);
            }
            
            
            
            
            
            
            
            
      })
		
				
		$('.sample4').numeric();	
		
		if($('#txtAskingPrice').val().length >2){
		         $('#txtAskingPrice').formatCurrency({ symbol: '' });
		    } 
		    
		 if($('#txtMileage').val().length >0){
		         $('#txtMileage').formatCurrency({ symbol: '' });
		         $('#txtMileage').val($('#txtMileage').val()+' mi')
		   } 
			
	})	
	
	
    </script>

    <script type="text/javascript" language="javascript">
	
	
	$(function(){	
	    	
		
		
		$('.sample4').numeric();	
		
		
		$('#txtAskingPrice').live('blur',function(){
		    if($('#txtAskingPrice').val().length >0){      
                 if($('#txtAskingPrice').val() == 0)
                 {
                    alert('Enter valid price');
                    $('#txtAskingPrice').focus();
                     return false;
                 }
              }
		    if($('#txtAskingPrice').val().length >2){
		         $('#txtAskingPrice').formatCurrency({ symbol: '' });
		    } 
		});
		
		$('#txtAskingPrice').live('focus',function(){
		    if($('#txtAskingPrice').val().length >2){
		        var text = $('#txtAskingPrice').val();
		         //text = text.substring(1);
		         text = text.replace(',','');
		         $('#txtAskingPrice').val(text);
		           //alert(text)
		    }  
		    
		});
		
		$('#txtMileage').live('blur',function(){
		     if($('#txtMileage').val().length >0){
		         if($('#txtMileage').val()< 1000){ 
		         alert('Mileage must be greater than 1000')
		         $('#txtMileage').focus();
		         return false;
		         }   		    
		         $('#txtMileage').formatCurrency({ symbol: '' });
		         $('#txtMileage').val($('#txtMileage').val()+' mi')
		    } 
		});
		
		$('#txtMileage').live('focus',function(){
		    if($('#txtMileage').val().length >0){
		        var text = $('#txtMileage').val();
		         //text = text.substring(1);
		         text = text.replace(' mi','');
		         text = text.replace(',','');
		         $('#txtMileage').val(text);
		           //alert(text)
		    }  
		    
		});
		
		
		
		
		
			
	})	
    </script>

    <script type="text/javascript" language="javascript">
    function CopySellerInfo()
        {
         
            var valid=true;   
                if (document.getElementById('<%= txtFirstName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtFirstName.ClientID%>').focus();
                alert("Enter customer first name");
                document.getElementById('<%=txtFirstName.ClientID%>').value = ""
                document.getElementById('<%=txtFirstName.ClientID%>').focus()                
                valid = false;
                 return valid;     
              }           
             else if (document.getElementById('<%= txtAddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtAddress.ClientID%>').focus();
                alert("Enter customer address");
                document.getElementById('<%=txtAddress.ClientID%>').value = ""
                document.getElementById('<%=txtAddress.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }    
             else if (document.getElementById('<%= txtCity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCity.ClientID%>').focus();
                alert("Enter customer city");
                document.getElementById('<%=txtCity.ClientID%>').value = ""
                document.getElementById('<%=txtCity.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }   
            else if(document.getElementById('<%=ddlLocationState.ClientID%>').value =="0")
            {
                alert("Please select customer state"); 
                valid=false;
                document.getElementById('ddlLocationState').focus();  
                return valid;               
            } 
            else if (document.getElementById('<%= txtZip.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtZip.ClientID%>').focus();
                alert("Enter zip");
                document.getElementById('<%=txtZip.ClientID%>').value = ""
                document.getElementById('<%=txtZip.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }  
            else if((document.getElementById('<%=txtZip.ClientID%>').value.trim().length > 0) && (document.getElementById('<%=txtZip.ClientID%>').value.trim().length < 5))
             {          

                    document.getElementById('<%= txtZip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                    document.getElementById('<%=txtZip.ClientID%>').value = ""
                    document.getElementById('<%=txtZip.ClientID%>').focus()
                    valid = false;  
                    return valid;      
                                                     
             }   
              else
              {
                
                 document.getElementById('<%= txtCardholderName.ClientID%>').value =  document.getElementById('<%= txtFirstName.ClientID%>').value;                
                 document.getElementById('<%= txtCardholderLastName.ClientID%>').value =  document.getElementById('<%= txtLastName.ClientID%>').value;
                 document.getElementById('<%= txtbillingaddress.ClientID%>').value =  document.getElementById('<%= txtAddress.ClientID%>').value;
                 document.getElementById('<%= txtbillingcity.ClientID%>').value =  document.getElementById('<%= txtCity.ClientID%>').value;
                 document.getElementById('<%= ddlbillingstate.ClientID%>').value =  document.getElementById('<%= ddlLocationState.ClientID%>').value;                 
                 document.getElementById('<%= txtbillingzip.ClientID%>').value =  document.getElementById('<%= txtZip.ClientID%>').value;
              }             
              return valid;      
        } 
          
         function CopySellerInfoForCheck()
        {
         
            var valid=true;   
                if (document.getElementById('<%= txtFirstName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtFirstName.ClientID%>').focus();
                alert("Enter customer first name");
                document.getElementById('<%=txtFirstName.ClientID%>').value = ""
                document.getElementById('<%=txtFirstName.ClientID%>').focus()                
                valid = false;
                 return valid;     
              }   
              else
              {
                
                 document.getElementById('<%= txtCustNameForCheck.ClientID%>').value =  document.getElementById('<%= txtFirstName.ClientID%>').value;                            
                           
              }             
              return valid;      
        } 
            
          
    </script>

    <script type="text/javascript" language="javascript">
     function ValidateAbandonData()
      {
         var valid = true;        
               
              if (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                alert("Enter customer phone number");
                document.getElementById('<%=txtPhone.ClientID%>').value = ""
                document.getElementById('<%=txtPhone.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }    
             if((document.getElementById('<%= txtPhone.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 10)) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                document.getElementById('<%=txtPhone.ClientID%>').value = "";
                alert("Enter valid phone number");
                valid = false; 
                 return valid;                
            
              }  
             if ((document.getElementById('<%=txtEmail.ClientID%>').value.trim().length > 0) && (echeck(document.getElementById('<%=txtEmail.ClientID%>').value.trim()) == false) )
             {               
                document.getElementById('<%=txtEmail.ClientID%>').value = ""
                document.getElementById('<%=txtEmail.ClientID%>').focus()
                valid = false;               
                return valid;     
             }        
            
             if(document.getElementById('<%=txtZip.ClientID%>').value.trim().length > 0)
             {
                  var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtZip.ClientID%>').value);             
                   if (isValid == false)
                   {
                         document.getElementById('<%= txtZip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                     document.getElementById('<%=txtZip.ClientID%>').value = ""
                    document.getElementById('<%=txtZip.ClientID%>').focus()
                    valid = false;  
                     return valid;      
                   }                                   
             } 
               
             return valid;
      }
    </script>

    <script type="text/javascript" language="javascript">
     function ValidateDraftData()
      {
         var valid = true;        
               
              if (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                alert("Phone number is mandatory to save the draft");
                document.getElementById('<%=txtPhone.ClientID%>').value = ""
                document.getElementById('<%=txtPhone.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }    
             if((document.getElementById('<%= txtPhone.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 10)) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                document.getElementById('<%=txtPhone.ClientID%>').value = "";
                alert("Enter valid phone number");
                valid = false; 
                 return valid;                
            
              }  
             if ((document.getElementById('<%=txtEmail.ClientID%>').value.trim().length > 0) && (echeck(document.getElementById('<%=txtEmail.ClientID%>').value.trim()) == false) )
             {               
                document.getElementById('<%=txtEmail.ClientID%>').value = ""
                document.getElementById('<%=txtEmail.ClientID%>').focus()
                valid = false;               
                return valid;     
             }        
            
             if(document.getElementById('<%=txtZip.ClientID%>').value.trim().length > 0)
             {
                  var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtZip.ClientID%>').value);             
                   if (isValid == false)
                   {
                         document.getElementById('<%= txtZip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                     document.getElementById('<%=txtZip.ClientID%>').value = ""
                    document.getElementById('<%=txtZip.ClientID%>').focus()
                    valid = false;  
                     return valid;      
                   }                                   
             } 
               
             return valid;
      }
    </script>

    <script type="text/javascript" language="javascript">
    
      function ValidateSavedData()
      {
         var valid = true;         
               
                if(document.getElementById('<%= ddlPackage.ClientID%>').value == "0") {
                document.getElementById('<%= ddlPackage.ClientID%>').focus();
                alert("Select package");                 
                document.getElementById('<%=ddlPackage.ClientID%>').focus()
                valid = false;            
                 return valid;     
               }  
                   if (document.getElementById('<%= txtFirstName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtFirstName.ClientID%>').focus();
                alert("Enter customer first name");
                document.getElementById('<%=txtFirstName.ClientID%>').value = ""
                document.getElementById('<%=txtFirstName.ClientID%>').focus()                
                valid = false;
                 return valid;     
              } 
                if (document.getElementById('<%= txtLastName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtLastName.ClientID%>').focus();
                alert("Enter customer last name");
                document.getElementById('<%=txtLastName.ClientID%>').value = ""
                document.getElementById('<%=txtLastName.ClientID%>').focus()                
                valid = false;
                 return valid;     
              }   
               
              if (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                alert("Enter customer phone number");
                document.getElementById('<%=txtPhone.ClientID%>').value = ""
                document.getElementById('<%=txtPhone.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }    
             if((document.getElementById('<%= txtPhone.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 10)) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();
                document.getElementById('<%=txtPhone.ClientID%>').value = "";
                alert("Enter valid phone number");
                valid = false; 
                 return valid;                
            
              }   
           
                if(document.getElementById('<%=chkbxEMailNA.ClientID%>').checked == false)
                {
                      if (document.getElementById('<%= txtEmail.ClientID%>').value.trim().length < 1) {
                        document.getElementById('<%= txtEmail.ClientID%>').focus();
                        alert("Enter customer email");
                        document.getElementById('<%=txtEmail.ClientID%>').value = ""
                        document.getElementById('<%=txtEmail.ClientID%>').focus()                
                        valid = false;
                         return valid;     
                     }    
               }
              if ((document.getElementById('<%=txtEmail.ClientID%>').value.trim().length > 0) && (echeck(document.getElementById('<%=txtEmail.ClientID%>').value.trim()) == false) )
             {               
                document.getElementById('<%=txtEmail.ClientID%>').value = ""
                document.getElementById('<%=txtEmail.ClientID%>').focus()
                valid = false;               
                return valid;     
             }         
              if (document.getElementById('<%= txtAddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtAddress.ClientID%>').focus();
                alert("Enter customer address");
                document.getElementById('<%=txtAddress.ClientID%>').value = ""
                document.getElementById('<%=txtAddress.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }    
                if (document.getElementById('<%= txtCity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCity.ClientID%>').focus();
                alert("Enter customer city");
                document.getElementById('<%=txtCity.ClientID%>').value = ""
                document.getElementById('<%=txtCity.ClientID%>').focus()                
                valid = false;
                 return valid;     
             }   
            if(document.getElementById('<%=ddlLocationState.ClientID%>').value =="0")
            {
                alert("Please select customer state"); 
                valid=false;
                document.getElementById('ddlLocationState').focus();  
                return valid;               
            } 
        if (document.getElementById('<%= txtZip.ClientID%>').value.trim().length < 1) {
            document.getElementById('<%= txtZip.ClientID%>').focus();
            alert("Enter zipcode");
            document.getElementById('<%=txtZip.ClientID%>').value = ""
            document.getElementById('<%=txtZip.ClientID%>').focus()                
            valid = false;
            return valid;     
            }   
             if(document.getElementById('<%=txtZip.ClientID%>').value.trim().length > 0)
             {
                  var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtZip.ClientID%>').value);             
                   if (isValid == false)
                   {
                         document.getElementById('<%= txtZip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                     document.getElementById('<%=txtZip.ClientID%>').value = ""
                    document.getElementById('<%=txtZip.ClientID%>').focus()
                    valid = false;  
                     return valid;      
                   }                                   
             }  
             if(document.getElementById('<%=ddlMake.ClientID%>').value =="0")
            {
                alert("Please select make"); 
                valid=false;
                document.getElementById('ddlMake').focus();  
                return valid;               
            }             
             if(document.getElementById('<%=ddlModel.ClientID%>').value =="0")
            {
                alert("Please select model"); 
                valid=false;
                document.getElementById('ddlModel').focus();
                return valid;               
            } 
            if (document.getElementById('<%=ddlYear.ClientID%>').value =="0")
            {
                alert('Please select year')
                valid=false;
                document.getElementById('ddlYear').focus();  
                return valid;
            }  
               if (document.getElementById('<%= txtAskingPrice.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtAskingPrice.ClientID%>').focus();
                alert("Enter price");
                document.getElementById('<%=txtAskingPrice.ClientID%>').value = ""
                document.getElementById('<%=txtAskingPrice.ClientID%>').focus()                
                valid = false;
                 return valid;     
            } 
            var string = $('#ddlPackage option:selected').text();
            var p =string.split('$');
            var pp = p[1].split(')');
            //alert(pp[0]);
            //pp[0] = parseInt(pp[0]);
            pp[0] = parseFloat(pp[0]);
            var selectedPack = pp[0].toFixed(2);
            if($('#ddldiscount option:selected').val()!='undefined')
            var string1 = $('#ddldiscount option:selected').val();
            else
             var string1="0";
                  var curr1 ;
                if(string1==0)curr1="0";
                else  if(string1==1)curr1="25"; 
                else  if(string1==2)curr1="50";

            var EnterAmt = parseFloat($('#txtPDAmountNow').val());

            if(document.getElementById('<%= txtPDAmountNow.ClientID%>').value.trim().length < 1) {
            document.getElementById('<%= txtPDAmountNow.ClientID%>').focus();
            alert("Enter amount being paid now");
            document.getElementById('<%=txtPDAmountNow.ClientID%>').value = ""
            document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
            valid = false;            
            return valid;     
            }    

            if(EnterAmt > selectedPack){
            document.getElementById('<%= txtPDAmountNow.ClientID%>').focus();
            alert("Amount more than selected package price");
            document.getElementById('<%=txtPDAmountNow.ClientID%>').value = ""
            document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
            valid = false; 
            return valid;     
            } 
            if(document.getElementById('<%= chkboxlstPDsale.ClientID%>').checked == false)
            { 
                 if(EnterAmt < selectedPack-curr1){
                document.getElementById('<%= txtPDAmountNow.ClientID%>').focus();
                alert("Amount less than selected package price");
                document.getElementById('<%=txtPDAmountNow.ClientID%>').value = ""
                document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
                valid = false; 
                return valid;     
                } 
            }  

              if(document.getElementById('<%= chkboxlstPDsale.ClientID%>').checked == true)
            {                
                      if(document.getElementById('<%=ddlPDDate.ClientID%>').value =="0")
                    {
                    alert("Please select PD date"); 
                    valid=false;
                    document.getElementById('ddlPDDate').focus();  
                    return valid;               
                    }  
                    
                     var string = $('#ddlPackage option:selected').text();
                    var p =string.split('$');
                    var pp = p[1].split(')');
                    //alert(pp[0]);
                    //pp[0] = parseInt(pp[0]);
                    pp[0] = parseFloat(pp[0]);
                    var selectedPack = pp[0].toFixed(2);


                    var EnterAmt = parseFloat($('#txtPDAmountNow').val());

                    if(document.getElementById('<%= txtPDAmountNow.ClientID%>').value.trim().length < 1) {
                    document.getElementById('<%= txtPDAmountNow.ClientID%>').focus();
                    alert("Enter amount being paid now");
                    document.getElementById('<%=txtPDAmountNow.ClientID%>').value = ""
                    document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }    

                    if(EnterAmt > selectedPack){
                    document.getElementById('<%= txtPDAmountNow.ClientID%>').focus();
                    alert("Amount more than selected package price");
                    document.getElementById('<%=txtPDAmountNow.ClientID%>').value = ""
                    document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
                    valid = false; 
                    return valid;     
                    }    
                    
            }   
            
              
           if(document.getElementById('<%= ddlpayme.ClientID%>').value == "3")
            {
                if (document.getElementById('<%= txtCardholderName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderName.ClientID%>').focus();
                alert("Enter card holder first name");
                document.getElementById('<%=txtCardholderName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }  
                 if (document.getElementById('<%= txtCardholderLastName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderLastName.ClientID%>').focus();
                alert("Enter card holder last name");
                document.getElementById('<%=txtCardholderLastName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderLastName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }  
                if (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();
                alert("Enter card number");
                document.getElementById('<%=CardNumber.ClientID%>').value = ""
                document.getElementById('<%=CardNumber.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 15)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                return valid;              

                }           
                var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
                if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
                {
                CCNum = CCNum.charAt(0);
                if(CCNum != "3")
                {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("This is not a Amex card number");
                valid = false; 
                return valid;  
                }
                }               
                if(document.getElementById('<%=ExpMon.ClientID%>').value =="0")
                {
                alert("Please select the expiration month"); 
                valid=false;
                document.getElementById('ExpMon').focus();  
                return valid;               
                }
                if(document.getElementById('<%=CCExpiresYear.ClientID%>').value =="0")
                {
                alert("Please select the expiration year"); 
                valid=false;
                document.getElementById('CCExpiresYear').focus();  
                return valid;               
                }  
                if (document.getElementById('<%= cvv.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= cvv.ClientID%>').focus();
                alert("Enter cvv number");
                document.getElementById('<%=cvv.ClientID%>').value = ""
                document.getElementById('<%=cvv.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 4)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                return valid;              

                }   
               
                if (document.getElementById('<%= txtbillingaddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingaddress.ClientID%>').focus();
                alert("Enter billing address");
                document.getElementById('<%=txtbillingaddress.ClientID%>').value = ""
                document.getElementById('<%=txtbillingaddress.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= txtbillingcity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingcity.ClientID%>').focus();
                alert("Enter city");
                document.getElementById('<%=txtbillingcity.ClientID%>').value = ""
                document.getElementById('<%=txtbillingcity.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=ddlbillingstate.ClientID%>').value =="0")
                {
                alert("Please select state"); 
                valid=false;
                document.getElementById('ddlbillingstate').focus();  
                return valid;               
                } 
                if (document.getElementById('<%= txtbillingzip.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Enter zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=txtbillingzip.ClientID%>').value.trim().length > 0)
                {
                var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtbillingzip.ClientID%>').value);             
                if (isValid == false)
                {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Please enter valid zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()
                valid = false;  
                return valid;      
                }                                   
                }  

           }
         if(document.getElementById('<%= ddlpayme.ClientID%>').value == "0")
            {
                if (document.getElementById('<%= txtCardholderName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderName.ClientID%>').focus();
                alert("Enter card holder name");
                document.getElementById('<%=txtCardholderName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderName.ClientID%>').focus()                
                valid = false;
                return valid;     
                } 
                  if (document.getElementById('<%= txtCardholderLastName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderLastName.ClientID%>').focus();
                alert("Enter card holder last name");
                document.getElementById('<%=txtCardholderLastName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderLastName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();
                alert("Enter card number");
                document.getElementById('<%=CardNumber.ClientID%>').value = ""
                document.getElementById('<%=CardNumber.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                return valid;              

                }           
                var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
                if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
                {
                CCNum = CCNum.charAt(0);
                if(CCNum != "4")
                {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("This is not a Visa card number");
                valid = false; 
                return valid;  
                }
                }               
                if(document.getElementById('<%=ExpMon.ClientID%>').value =="0")
                {
                alert("Please select the expiration month"); 
                valid=false;
                document.getElementById('ExpMon').focus();  
                return valid;               
                }
                if(document.getElementById('<%=CCExpiresYear.ClientID%>').value =="0")
                {
                alert("Please select the expiration year"); 
                valid=false;
                document.getElementById('CCExpiresYear').focus();  
                return valid;               
                }  
                if (document.getElementById('<%= cvv.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= cvv.ClientID%>').focus();
                alert("Enter cvv number");
                document.getElementById('<%=cvv.ClientID%>').value = ""
                document.getElementById('<%=cvv.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                return valid;              

                }   
                
                if (document.getElementById('<%= txtbillingaddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingaddress.ClientID%>').focus();
                alert("Enter billing address");
                document.getElementById('<%=txtbillingaddress.ClientID%>').value = ""
                document.getElementById('<%=txtbillingaddress.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= txtbillingcity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingcity.ClientID%>').focus();
                alert("Enter city");
                document.getElementById('<%=txtbillingcity.ClientID%>').value = ""
                document.getElementById('<%=txtbillingcity.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=ddlbillingstate.ClientID%>').value =="0")
                {
                alert("Please select state"); 
                valid=false;
                document.getElementById('ddlbillingstate').focus();  
                return valid;               
                } 
                if (document.getElementById('<%= txtbillingzip.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Enter zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=txtbillingzip.ClientID%>').value.trim().length > 0)
                {
                var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtbillingzip.ClientID%>').value);             
                if (isValid == false)
                {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Please enter valid zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()
                valid = false;  
                return valid;      
                }                                   
                }  

           }    
            
             if(document.getElementById('<%= ddlpayme.ClientID%>').value == "1")
            {
                if (document.getElementById('<%= txtCardholderName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderName.ClientID%>').focus();
                alert("Enter card holder name");
                document.getElementById('<%=txtCardholderName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                  if (document.getElementById('<%= txtCardholderLastName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderLastName.ClientID%>').focus();
                alert("Enter card holder last name");
                document.getElementById('<%=txtCardholderLastName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderLastName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }  
                if (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();
                alert("Enter card number");
                document.getElementById('<%=CardNumber.ClientID%>').value = ""
                document.getElementById('<%=CardNumber.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                return valid;              

                }           
                var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
                if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
                {
                CCNum = CCNum.charAt(0);
                if(CCNum != "5")
                {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("This is not a Master card number");
                valid = false; 
                return valid;  
                }
                }               
                if(document.getElementById('<%=ExpMon.ClientID%>').value =="0")
                {
                alert("Please select the expiration month"); 
                valid=false;
                document.getElementById('ExpMon').focus();  
                return valid;               
                }
                if(document.getElementById('<%=CCExpiresYear.ClientID%>').value =="0")
                {
                alert("Please select the expiration year"); 
                valid=false;
                document.getElementById('CCExpiresYear').focus();  
                return valid;               
                }  
                if (document.getElementById('<%= cvv.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= cvv.ClientID%>').focus();
                alert("Enter cvv number");
                document.getElementById('<%=cvv.ClientID%>').value = ""
                document.getElementById('<%=cvv.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                return valid;              

                }   
             

                if (document.getElementById('<%= txtbillingaddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingaddress.ClientID%>').focus();
                alert("Enter billing address");
                document.getElementById('<%=txtbillingaddress.ClientID%>').value = ""
                document.getElementById('<%=txtbillingaddress.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= txtbillingcity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingcity.ClientID%>').focus();
                alert("Enter city");
                document.getElementById('<%=txtbillingcity.ClientID%>').value = ""
                document.getElementById('<%=txtbillingcity.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=ddlbillingstate.ClientID%>').value =="0")
                {
                alert("Please select state"); 
                valid=false;
                document.getElementById('ddlbillingstate').focus();  
                return valid;               
                } 
                if (document.getElementById('<%= txtbillingzip.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Enter zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=txtbillingzip.ClientID%>').value.trim().length > 0)
                {
                var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtbillingzip.ClientID%>').value);             
                if (isValid == false)
                {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Please enter valid zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()
                valid = false;  
                return valid;      
                }                                   
                }  

           }       
            if(document.getElementById('<%= ddlpayme.ClientID%>').value == "2")
            {
                if (document.getElementById('<%= txtCardholderName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderName.ClientID%>').focus();
                alert("Enter card holder name");
                document.getElementById('<%=txtCardholderName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderName.ClientID%>').focus()                
                valid = false;
                return valid;     
                } 
                  if (document.getElementById('<%= txtCardholderLastName.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtCardholderLastName.ClientID%>').focus();
                alert("Enter card holder last name");
                document.getElementById('<%=txtCardholderLastName.ClientID%>').value = ""
                document.getElementById('<%=txtCardholderLastName.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();
                alert("Enter card number");
                document.getElementById('<%=CardNumber.ClientID%>').value = ""
                document.getElementById('<%=CardNumber.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                return valid;              

                }           
                var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
                if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
                {
                CCNum = CCNum.charAt(0);
                if(CCNum != "6")
                {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("This is not a Discover card number");
                valid = false; 
                return valid;  
                }
                }               
                if(document.getElementById('<%=ExpMon.ClientID%>').value =="0")
                {
                alert("Please select the expiration month"); 
                valid=false;
                document.getElementById('ExpMon').focus();  
                return valid;               
                }
                if(document.getElementById('<%=CCExpiresYear.ClientID%>').value =="0")
                {
                alert("Please select the expiration year"); 
                valid=false;
                document.getElementById('CCExpiresYear').focus();  
                return valid;               
                }  
                if (document.getElementById('<%= cvv.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= cvv.ClientID%>').focus();
                alert("Enter cvv number");
                document.getElementById('<%=cvv.ClientID%>').value = ""
                document.getElementById('<%=cvv.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                return valid;              

                } 
                

                if (document.getElementById('<%= txtbillingaddress.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingaddress.ClientID%>').focus();
                alert("Enter billing address");
                document.getElementById('<%=txtbillingaddress.ClientID%>').value = ""
                document.getElementById('<%=txtbillingaddress.ClientID%>').focus()                
                valid = false;
                return valid;     
                }    
                if (document.getElementById('<%= txtbillingcity.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingcity.ClientID%>').focus();
                alert("Enter city");
                document.getElementById('<%=txtbillingcity.ClientID%>').value = ""
                document.getElementById('<%=txtbillingcity.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=ddlbillingstate.ClientID%>').value =="0")
                {
                alert("Please select state"); 
                valid=false;
                document.getElementById('ddlbillingstate').focus();  
                return valid;               
                } 
                if (document.getElementById('<%= txtbillingzip.ClientID%>').value.trim().length < 1) {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Enter zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()                
                valid = false;
                return valid;     
                }   
                if(document.getElementById('<%=txtbillingzip.ClientID%>').value.trim().length > 0)
                {
                var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtbillingzip.ClientID%>').value);             
                if (isValid == false)
                {
                document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                alert("Please enter valid zipcode");
                document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                document.getElementById('<%=txtbillingzip.ClientID%>').focus()
                valid = false;  
                return valid;      
                }                                   
                }  

           }     
           if(document.getElementById('<%= ddlpayme.ClientID%>').value == "4")  
           
            {                   
                    if(document.getElementById('<%= txtPaytransID.ClientID%>').value.length < 1) {
                    document.getElementById('<%= txtPaytransID.ClientID%>').focus();
                    alert("Enter Payment Trans ID");
                    document.getElementById('<%=txtPaytransID.ClientID%>').value = ""
                    document.getElementById('<%=txtPaytransID.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }    

                    if(document.getElementById('<%= txtpayPalEmailAccount.ClientID%>').value.length < 1) {
                    document.getElementById('<%= txtpayPalEmailAccount.ClientID%>').focus();
                    alert("Enter paypal account email");
                    document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value = ""
                    document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }            
                    if ((document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value.length > 0) && (echeck(document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value) == false) )
                    {               
                    document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value = ""
                    document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').focus()
                    valid = false;               
                    return valid;     
                    }          
            }    
            
            if(document.getElementById('<%= ddlpayme.ClientID%>').value == "5")
            {
                   if(document.getElementById('<%= txtAccNumberForCheck.ClientID%>').value.length < 1) {
                    document.getElementById('<%= txtAccNumberForCheck.ClientID%>').focus();
                    alert("Enter account number");
                    document.getElementById('<%=txtAccNumberForCheck.ClientID%>').value = ""
                    document.getElementById('<%=txtAccNumberForCheck.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }  
                      if((document.getElementById('<%= txtAccNumberForCheck.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtAccNumberForCheck.ClientID%>').value.trim().length < 4)) {
                    document.getElementById('<%= txtAccNumberForCheck.ClientID%>').focus();
                    document.getElementById('<%=txtAccNumberForCheck.ClientID%>').value = "";
                    alert("Enter valid account number");
                    valid = false; 
                    return valid; 
                    } 
                     if(document.getElementById('<%=ddlAccType.ClientID%>').value =="0")
                    {
                    alert("Please select account type"); 
                    valid=false;
                    document.getElementById('ddlAccType').focus();  
                    return valid;               
                    }   
                    if(document.getElementById('<%= txtRoutingNumberForCheck.ClientID%>').value.length < 1) {
                    document.getElementById('<%= txtRoutingNumberForCheck.ClientID%>').focus();
                    alert("Enter routing number");
                    document.getElementById('<%=txtRoutingNumberForCheck.ClientID%>').value = ""
                    document.getElementById('<%=txtRoutingNumberForCheck.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }  
                      if((document.getElementById('<%= txtRoutingNumberForCheck.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtRoutingNumberForCheck.ClientID%>').value.trim().length < 9)) {
                    document.getElementById('<%= txtRoutingNumberForCheck.ClientID%>').focus();
                    document.getElementById('<%=txtRoutingNumberForCheck.ClientID%>').value = "";
                    alert("Enter valid routing number");
                    valid = false; 
                    return valid; 
                    } 
                     if(document.getElementById('<%= txtCustNameForCheck.ClientID%>').value.length < 1) {
                    document.getElementById('<%= txtCustNameForCheck.ClientID%>').focus();
                    alert("Enter account holder name");
                    document.getElementById('<%=txtCustNameForCheck.ClientID%>').value = ""
                    document.getElementById('<%=txtCustNameForCheck.ClientID%>').focus()
                    valid = false;            
                    return valid;     
                    }  
                                          
            }
           
            if(document.getElementById('<%= txtVoicefileConfirmNo.ClientID%>').value.length < 1) {
            document.getElementById('<%= txtVoicefileConfirmNo.ClientID%>').focus();
            alert("Enter voice file confirmation #");
            document.getElementById('<%=txtVoicefileConfirmNo.ClientID%>').value = ""
            document.getElementById('<%=txtVoicefileConfirmNo.ClientID%>').focus()
            valid = false;            
            return valid;     
            }  
            if(document.getElementById('<%=ddlVoiceFileLocation.ClientID%>').value =="0")
            {
            alert("Please select voice file location"); 
            valid=false;
            document.getElementById('ddlVoiceFileLocation').focus();  
            return valid;               
            }                 
             return valid;
      }
     
     function PhoneOnblur()
     {
           if((document.getElementById('<%= txtPhone.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length < 10)) {
                document.getElementById('<%= txtPhone.ClientID%>').focus();             
                alert("Enter valid phone number");
                valid = false; 
                 return valid;              
            
            } 
          
           if((document.getElementById('<%= txtPhone.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= txtPhone.ClientID%>').value.trim().length == 10)) {
              var phone = document.getElementById('<%= txtPhone.ClientID%>').value;
               formatted = phone.substr(0, 3) + '-' + phone.substr(3, 3) + '-' + phone.substr(6,4);                
                document.getElementById('<%=txtPhone.ClientID%>').value = formatted;               
                valid = true; 
                 return valid;                
            
            }   
                      
     }
     function CreditCardOnblur()
     {
        if(document.getElementById('<%= ddlpayme.ClientID%>').value == "3")
         {
           if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 15)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                 return valid;              
            
            }           
            var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
            if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
            {
                CCNum = CCNum.charAt(0);
                if(CCNum != "3")
                {
                 document.getElementById('<%= CardNumber.ClientID%>').focus();             
                 alert("This is not a Amex card number");
                 valid = false; 
                 return valid;  
                }
            }
         }
         
        if(document.getElementById('<%= ddlpayme.ClientID%>').value == "0")
         {
           if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                 return valid;              
            
            }           
            var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
            if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
            {
                CCNum = CCNum.charAt(0);
                if(CCNum != "4")
                {
                 document.getElementById('<%= CardNumber.ClientID%>').focus();             
                 alert("This is not a Visa card number");
                 valid = false; 
                 return valid;  
                }
            }
         }
        if(document.getElementById('<%= ddlpayme.ClientID%>').value == "1")
         {
           if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                 return valid;              
            
            }           
            var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
            if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
            {
                CCNum = CCNum.charAt(0);
                if(CCNum != "5")
                {
                 document.getElementById('<%= CardNumber.ClientID%>').focus();             
                 alert("This is not a Master card number");
                 valid = false; 
                 return valid;  
                }
            }
         }
       if(document.getElementById('<%= ddlpayme.ClientID%>').value == "2")
         {
           if((document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= CardNumber.ClientID%>').value.trim().length != 16)) {
                document.getElementById('<%= CardNumber.ClientID%>').focus();             
                alert("Enter valid card number");
                valid = false; 
                 return valid;              
            
            }           
            var CCNum = document.getElementById('<%= CardNumber.ClientID%>').value.trim();
            if(document.getElementById('<%= CardNumber.ClientID%>').value.trim().length > 0) 
            {
                CCNum = CCNum.charAt(0);
                if(CCNum != "6")
                {
                 document.getElementById('<%= CardNumber.ClientID%>').focus();             
                 alert("This is not a Discover card number");
                 valid = false; 
                 return valid;  
                }
            }
         }
         
                      
     }
     
     function CVVOnblur()
     {
        if(document.getElementById('<%= ddlpayme.ClientID%>').value == "3")
         {
           if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 4)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                 return valid;              
            
            }                      
         }
         
        if(document.getElementById('<%= ddlpayme.ClientID%>').value == "0")
         {
           if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                 return valid;              
            
            }     
         }
         if(document.getElementById('<%= ddlpayme.ClientID%>').value == "1")
         {
            if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                 return valid;              
            
            }  
         }
     if(document.getElementById('<%= ddlpayme.ClientID%>').value == "2")
         {
            if((document.getElementById('<%= cvv.ClientID%>').value.trim().length > 0) && (document.getElementById('<%= cvv.ClientID%>').value.trim().length != 3)) {
                document.getElementById('<%= cvv.ClientID%>').focus();             
                alert("Enter valid cvv number");
                valid = false; 
                 return valid;              
            
            }  
         }
         
                      
     }
     
     function ZipOnblur()
     {
          if(document.getElementById('<%=txtZip.ClientID%>').value.trim().length > 0)
             {
                  var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtZip.ClientID%>').value);             
                   if (isValid == false)
                   {
                         document.getElementById('<%= txtZip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                     document.getElementById('<%=txtZip.ClientID%>').value = ""
                    document.getElementById('<%=txtZip.ClientID%>').focus()
                    valid = false;  
                     return valid;      
                   }                                   
             }  
                      
     }
     function billingZipOnblur()
     {
          if(document.getElementById('<%=txtbillingzip.ClientID%>').value.trim().length > 0)
             {
                  var isValid = /^[0-9]{5}(?:-[0-9]{4})?$/.test(document.getElementById('<%=txtbillingzip.ClientID%>').value);             
                   if (isValid == false)
                   {
                         document.getElementById('<%= txtbillingzip.ClientID%>').focus();
                    alert("Please enter valid zipcode");
                     document.getElementById('<%=txtbillingzip.ClientID%>').value = ""
                    document.getElementById('<%=txtbillingzip.ClientID%>').focus()
                    valid = false;  
                     return valid;      
                   }                                   
             }  
                      
     }
     
      function PhoneOnfocus()
     {           
              var phone = document.getElementById('<%= txtPhone.ClientID%>').value;
               formatted =phone.replace("-","");
               formatted =formatted.replace("-","");
                document.getElementById('<%=txtPhone.ClientID%>').value = formatted;            
                       
     }
   
        function EmailOnblur()
     {           
               if ((document.getElementById('<%=txtEmail.ClientID%>').value.trim().length > 0) && (echeck(document.getElementById('<%=txtEmail.ClientID%>').value.trim()) == false) )
             {                           
                document.getElementById('<%=txtEmail.ClientID%>').focus()
                valid = false;               
                return valid;     
            }     
                       
     }
        function PaypalEmailblur()
     {           
               if ((document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value.trim().length > 0) && (echeck(document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').value.trim()) == false) )
             {                           
                document.getElementById('<%=txtpayPalEmailAccount.ClientID%>').focus()
                valid = false;               
                return valid;     
            }     
                       
     }
              
    </script>

    <script type="text/javascript" language="javascript">
     function echeck(str) {
            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)
            if (str.indexOf(at) == -1) {
                alert("Enter valid email")
                return false
            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
                alert("Enter valid email")
                return false
            }

            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
                alert("Enter valid email")
                return false
            }

            if (str.indexOf(at, (lat + 1)) != -1) {
                alert("Enter valid email")
                return false
            }

            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
                alert("Enter valid email")
                return false
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
                alert("Enter valid email")
                return false
            }

            if (str.indexOf(" ") != -1) {
                alert("Enter valid email")
                return false
            }

            return true
        }
 function ChangeValuesHidden()
      {
       document.getElementById("<%=hdnChange.ClientID%>").value ="1";
      } 
       function ChangeValues()
       {
         var hidden = document.getElementById("<%=hdnChange.ClientID%>").value ;
         if( hidden == '1')
         {
           var answer = confirm("If you move out of this page, changes will be permanently lost. Are you sure you want to move out of this page?")
           if (answer)
           {
              return true;
//              window.location.href = "CustomerView.aspx ";  
           }
           else           
           {
              return false;
           }
         }
       }    
    </script>

    <script type="text/javascript" language="javascript">
       function isNumberKey(evt)
         {
         debugger
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        function isNumberKeyWithDot(evt)
         {
         debugger
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;

            return true;
        }
         function isNumberKeyWithDashForZip(evt)
         {
         debugger
         
            var charCode = (evt.which) ? evt.which : event.keyCode         
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 45)
                return false;

            return true;
        }
         function isNumberKeyForDt(evt)
              {	
	    
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)&& charCode != 47)
                return false;
            return true;
        }
          function isKeyNotAcceptSpace(evt)
          {		    
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode == 32)
                return false;
            return true;
        }
        function EmailNAClick(){
        var checkbox = document.getElementById("chkbxEMailNA");
        if(checkbox.checked){            
            document.getElementById('<%= txtEmail.ClientID%>').disabled  = true;            
        }
        else
        {
            document.getElementById('<%= txtEmail.ClientID%>').disabled  = false;
        }
        }        
        
    </script>

    <script type="text/javascript" language="javascript">   
        
      var dtCh = "/";
        var Chktoday = new Date();
        var minYear = Chktoday.getFullYear() - 1;
        var maxYear = Chktoday.getFullYear();

        function isInteger(s) {
            var i;
            for (i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag) {
            var i;
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            return returnString;
        }

        function daysInFebruary(year) {
            // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
        }
        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }
            return this
        }

        function isDate(dtStr) {
            var daysInMonth = DaysArray(12)
            var pos1 = dtStr.indexOf(dtCh)
            var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
            var strMonth = dtStr.substring(0, pos1)
            var strDay = dtStr.substring(pos1 + 1, pos2)
            var strYear = dtStr.substring(pos2 + 1)
            strYr = strYear
            if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
            if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
            for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
            }
            month = parseInt(strMonth)
            day = parseInt(strDay)
            year = parseInt(strYr)
            if (pos1 == -1 || pos2 == -1) {
                alert("The date format should be : mm/dd/yyyy")
                return false
            }
            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }
            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }

            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                //alert("Enter only these years "+minYear+" "+maxYear+" to get data");		
                alert("Please enter a valid year");
                return false
            }
            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }
            return true
        }
    
    
    
    
    
    
    $('#txtPDAmountNow').live('focus',function(){
        if($('#ddlPackage option:selected').text() == 'Select'){ 
            $('#ddlPackage').focus();
            alert('Select package');
        }
    });
     function OnchangeDropdown(){    
         
           if($('#ddlPackage option:selected').text() == 'Gold Deluxe ($199.99)')
           {
           $('#discountchk').show();
           }
           else
           {
              $('#ddldiscount').val(0);
              $('#discountchk').hide();
         
         }
            if($('#ddlPackage option:selected').text() != 'Select'){  
               var string = $('#ddlPackage option:selected').text();
                var p =string.split('$');
                var pp = p[1].split(')');
                //alert(pp[0]);
                //pp[0] = parseInt(pp[0]);
                pp[0] = parseFloat(pp[0]);
                var selectedPack = pp[0].toFixed(2);
                selectedPack = parseFloat(selectedPack); 
           
              if( $('#ddldiscount option:selected').val()!='undefined')
                var string1 = $('#ddldiscount option:selected').val();
               else
               var string1 ="0";
             
               
                var curr1 ;
                if(string1==0)curr1="0";
                else  if(string1==1)curr1="25"; 
                else  if(string1==2)curr1="50"; 
                  
                curr1=parseFloat(curr1);
                 var curr2=selectedPack-curr1;
                 curr2=curr2.toFixed(2) 
                $('#txtPDAmountNow').val(curr2);
                 $('#txtTotalAmount').val(curr2);
                  if(document.getElementById('<%= chkboxlstPDsale.ClientID%>').checked == true)
                  {
                    $('#txtPDAmountLater').val('0.00');
                  }
                  else
                  {
                     $('#txtPDAmountLater').val('');
                  }
                }else{
                 $('#txtPDAmountNow').val('');
                 $('#txtTotalAmount').val('');
                  if(document.getElementById('<%= chkboxlstPDsale.ClientID%>').checked == true)
                  {
                    $('#txtPDAmountLater').val('');
                  }
                   else
                  {
                     $('#txtPDAmountLater').val('');
                  }
                }                            
                      
            }           
    /*
    $('#txtPDAmountNow').live('keydown', function(){
        //console.log($(this).val())
        $(this).val($(this).val().toString().replace(/^[0-9]\./g, ',').replace(/\./g, ''));
    });
    */
    
    
             
    $('#txtPDAmountNow').live('blur', function(){
            $('#txtPDAmountLater').val('');
            if($('#txtPDAmountNow').val().length>0 && ($('#ddlPackage option:selected').text() != 'Select')){   
                var curr = parseFloat($('#txtPDAmountNow').val());
                curr = curr.toFixed(2)         
                var string = $('#ddlPackage option:selected').text();
                var p =string.split('$');
                var pp = p[1].split(')');
                //alert(pp[0]);
                //pp[0] = parseInt(pp[0]);
                pp[0] = parseFloat(pp[0]);
                var selectedPack = pp[0].toFixed(2);
                selectedPack = parseFloat(selectedPack); 
                
                //for selected discount amount
                if( $('#ddldiscount option:selected').val()!='undefined')
                  var string1 = $('#ddldiscount option:selected').val();
                  else
                  var string1="0";
             
                  var curr1 ;
                if(string1==0)curr1="0";
                else  if(string1==1)curr1="25"; 
                else  if(string1==2)curr1="50"; 
                
                if(selectedPack-curr1 < curr){
                    alert('Entered amount can not be graterthen selected package..')
                     document.getElementById('<%=txtPDAmountNow.ClientID%>').focus()
                }else{
                
                console.log(curr1);
                    var value = parseFloat(selectedPack-curr-curr1);
                    value = value.toFixed(2); 
                    $('#txtPDAmountLater').val(value);
                    $('#txtTotalAmount').val(selectedPack- parseFloat(curr1));
                }                            
                      
            }            
    });
    
    
    
    $(function(){
    
        $('#feat input[type=radio]').each(function(){
            if($(this).is(':checked')){
                $(this).parent().next('span').addClass('featAct')  
            }    
            
        });
        
        
         $('#infoV input[type=radio]').each(function(){
            if($(this).is(':checked')){
                $(this).parent().next('span').addClass('featAct')  
            }  
        });
       
       
    
        $('#feat input[type=checkbox]').each(function(){
            $(this).click(function(){
                if($(this).parent().hasClass('noLM')){
                    $(this).parent().next('span').toggleClass('featAct')
                }else{
                    $(this).next('span').toggleClass('featAct')
                }
            })
        });
       
        
        
         $('#feat input[type=radio]').each(function(){
            $(this).click(function(){
              // var name = $(this).attr('name');
               $('#feat input[type=radio]').each(function(){
                    //if(name != $(this).attr('name')){
                        $(this).parent().next('span').removeClass('featAct')
                    //}
               });
               $(this).parent().next('span').addClass('featAct')             
               
            })
        });
        
        
         $('#infoV input[type=radio]').each(function(){
            $(this).click(function(){
               var name = $(this).attr('name');
               $('#infoV input[type=radio]').each(function(){
                    if(name == $(this).attr('name')){
                        $(this).parent().next('span').removeClass('featAct')
                    }
               })  
               $(this).parent().next('span').addClass('featAct')           
               
            })
        });
        
        
        
        
        
    });
    
     function ChangeValues()
       {
         var answer = confirm("If you move out of this page, changes will be permanently lost. Are you sure you want to move out of this page?")
           if (answer)
           {
              return true;
//              window.location.href = "CustomerView.aspx ";  
           }
           else           
           {
              return false;
           }         
       }    
          
   
    </script>

    <script type="text/javascript">
 function pageLoad()
   { 
      //InitializeTimer();      
   }
   
    var ssTime,TimerID;
   function  InitializeTimer()
   {  
     WebService.sessionGet(onsuccessGet,onError);      
   }
     function onsuccessGet(result)
     {
      ssTime=result; 
      ssTime=parseInt(ssTime)*60000;
     
      TimerDec(ssTime);
     }
   
  
   
   function  TimerDec(ssTime)
   {
   
     ssTime=ssTime-1000;
   
    TimerID=setTimeout(function(){TimerDec(ssTime);},1000);
      
    if(ssTime==60000)
    {      
     SessionInc();     
    }
     
   }
  
    
    function SessionInc()//Increase the session time
    {
     debugger    
      ssTime=parseInt("<%= Session.Timeout %>");     
      WebService.sessionSet(ssTime,onsuccessInc,onError);//call webservice to set the session variable
       ssTime=(parseInt(ssTime)-2)*60000;       
       TimerDec(ssTime);     
    }
    
    function onsuccessInc(result)
    {
     
    }    

     function onError(exception, userContext, methodName)
     {
       try 
       {
        //window.location.href='error.aspx';
        strMessage = strMessage + 'ErrorType: ' + exception._exceptionType + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Message: ' + exception._message + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Stack Trace: ' + exception._stackTrace + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Status Code: ' + exception._statusCode + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
        strMessage = strMessage + 'Timed Out: ' + exception._timedOut;
        ///alert(strMessage);
      } catch (ex) {}
     return false;
   }



    </script>

</head>
<body class="newBody">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrptmgr" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:HiddenField runat="server" ID="hdns1" Value="0" />
    <asp:HiddenField runat="server" ID="hdns2" Value="0" />
    <asp:HiddenField runat="server" ID="hdns3" Value="0" />
    <asp:HiddenField runat="server" ID="hdns4" Value="0" />
    <asp:HiddenField runat="server" ID="hdns5" Value="0" />
    <asp:HiddenField runat="server" ID="hdns6" Value="0" />
    <asp:UpdateProgress ID="Progress" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div id="spinner">
                <h4>
                    <div>
                        Processing
                        <img src="images/loading.gif" />
                    </div>
                </h4>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="updtpnlSave"
        DisplayAfter="0">
        <ProgressTemplate>
            <div id="spinner">
                <h4>
                    <div>
                        Processing
                        <img src="images/loading.gif" />
                    </div>
                </h4>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnChange" runat="server" Value="0" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Main Wrapper Start  -->
    <div class="wrapper">
        <!-- Headder Start  -->
        <div class="head wid100p">
            <a href="#" class="logo"></a>
            <div class="headding">
                <h1>
                    Car Sales System<span></span></h1>
            </div>
            <div class="headright">
                <div class="loginDet">
                    &nbsp;<asp:Label ID="lblUserName" runat="server" CssClass="loginStat"></asp:Label>&nbsp;
                    |&nbsp;
                    <asp:LinkButton ID="lnkBtnLogout" runat="server" Text="Logout" OnClick="lnkBtnLogout_Click"
                        CssClass="loginStat"></asp:LinkButton>
                </div>
                <asp:LinkButton ID="lnkTicker" runat="server" CssClass="btn btn-xs btn-info floarR"
                    Text="Sales Ticker"></asp:LinkButton>
                <div class="menu1">
                    <ul class="mainUL">
                        <li class="parent"><a href="#">Leads <span class="cert"></span></a>
                            <ul class="sub1">
                                <li>
                                    <asp:LinkButton ID="LeadsUpload" runat="server" Text="Upload" Enabled="false" PostBackUrl="~/LeadsUpload.aspx"></asp:LinkButton></li><li>
                                        <li>
                                            <asp:LinkButton ID="LeadsDownLoad" runat="server" Text="Download" Enabled="false"
                                                PostBackUrl="~/LeadDownLoad.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="Abondoned" runat="server" Text="Abondon" Enabled="false" PostBackUrl="~/Abonded.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="FreePackage" runat="server" Text="Free Pkg" Enabled="false" PostBackUrl="~/FreePackages.aspx"></asp:LinkButton></li>
                            </ul>
                        </li>
                        <li class="parent "><a href="#">Sales <span class="cert"></span></a>
                            <ul class="sub1">
                                <li>
                                    <asp:LinkButton ID="IntroMail" runat="server" Text="Intro Mial" Enabled="false" PostBackUrl="~/IntroMails.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="NewEntry" runat="server" Text="New Entry" Enabled="false" PostBackUrl="~/NewEntrys.aspx"></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="Transferin" runat="server" Text="Transfer In" Enabled="false"
                                        PostBackUrl="~/LiveTransfers.aspx"></asp:LinkButton></li>
                                <li><a href="#">Reports <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="AllCentersReport" runat="server" Text="All Centers Report" Enabled="true"
                                                PostBackUrl="~/AllCentersReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="Centersreport" runat="server" Text="Central Report" Enabled="true"
                                                PostBackUrl="~/CentralReport.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li>
                                    <asp:LinkButton ID="lnkSetGrup" runat="server" Text="SetGroup" Enabled="false"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="lnkGroupreport" runat="server" Text="Group Report" Enabled="false"></asp:LinkButton></li>
                            </ul>
                        </li>
                        <li class="parent active"><a href="#">Process <span class="cert"></span></a>
                            <ul class="sub1">
                                <li class="act">
                                    <asp:LinkButton ID="QC" runat="server" Text="QC" Enabled="false" PostBackUrl="~/QCReport.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Payments" runat="server" Text="Payments" Enabled="false" PostBackUrl="~/LiveTransfers.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Publish" runat="server" Text="Publish" Enabled="false"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="lnkMmyRep" runat="server" Text="My Report" Enabled="false"></asp:LinkButton></li>
                            </ul>
                        </li>
                        <li class="parent "><a href="#">Reports <span class="cert"></span></a>
                            <ul class="sub1">
                                <li class=""><a href="#">Leads <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="LeadsPerStaus" runat="server" Text="Per. Leads Daily" Enabled="true"
                                                PostBackUrl="~/LeadsdailyPerformance.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="leadsPerweekly" runat="server" Text="Per. Leads Weekly" Enabled="true"
                                                PostBackUrl="~/LeadsWeekly.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="leadspermonth" runat="server" Text="Per. Leads Monthly" Enabled="true"
                                                PostBackUrl="~/LeadsMonthly.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="dailleads" runat="server" Text="Daily Leads Graph" Enabled="true"
                                                PostBackUrl="~/DailyLeadsGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="weeklyleads" runat="server" Text="Weekly Leads Graphs" Enabled="true"
                                                PostBackUrl="~/WeeklyLeadsGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="monthlyleads" runat="server" Text="Monthly Leads Graph" Enabled="true"
                                                PostBackUrl="~/MonthlyLeadsGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LeadsCenterWise" runat="server" Text="Detailed Status" Enabled="true"
                                                PostBackUrl="~/LeadsDeatilsMonthly.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Sales" Enabled="true" PostBackUrl="~/CarSalesReportNew.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li class="act"><a href="#">Sales<span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="PerfStatusDaily" runat="server" Text="Per. Sales Daily" Enabled="true"
                                                PostBackUrl="~/SalesdailyPerformance.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="PerfStatusweekly" runat="server" Text="Per. Sales Weekly" Enabled="true"
                                                PostBackUrl="~/SalesWeekly.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="PerfStatusMonthly" runat="server" Text="Per. Sales Monthly" Enabled="true"
                                                PostBackUrl="~/SalesMonthly.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="DailySalesGraphs" runat="server" Text="Daily Sales Graph" Enabled="true"
                                                PostBackUrl="~/DailySalesGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="WeeklySalesGraphs" runat="server" Text="Weekly Sales Graphs"
                                                Enabled="true" PostBackUrl="~/WeeklysalesGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="MonthlySalesGraphs" runat="server" Text="Monthly Sales Graph"
                                                Enabled="true" PostBackUrl="~/MonthlysalesGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="DetaStat" runat="server" Text="Detailed Status" Enabled="true"
                                                PostBackUrl="~/DailyAgentSalesReport.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="Salesreport" runat="server" Text="Sales" Enabled="true" PostBackUrl="~/CarSalesReportNew.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li>
                                    <asp:LinkButton ID="Process" runat="server" Text="Process" Enabled="false" PostBackUrl="~/DailyAgentSalesReport.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Executive" runat="server" Text="Exceutive" Enabled="false"></asp:LinkButton></li>
                            </ul>
                        </li>
                        <li class="parent "><a href="#">Admin <span class="cert"></span></a>
                            <ul class="sub1">
                                <li><a href="#">Leads <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="leadsRights" runat="server" Text="Leads User Rights" PostBackUrl="~/LeadsUserRights.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LeadsList" runat="server" Text="Leads Stats zone" PostBackUrl="~/StatewiseLeads.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LeadsSatus" runat="server" Text="Leads Stats State Wise" PostBackUrl="~/StateWiseLeadsStatus.aspx"></asp:LinkButton></li>
                                        <li class="last">
                                            <asp:LinkButton ID="LeadsAssign" runat="server" Text="Leads Assign" PostBackUrl="~/LeadAssign.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li><a href="#">Sales <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="SalesAdmin" runat="server" Text="User Rights" PostBackUrl="~/SalesUserRights.aspx"
                                                Enabled="false"></asp:LinkButton></li>
                                        <li class="last">
                                            <asp:LinkButton ID="lnkDefaRights" runat="server" Text="Default Rights" PostBackUrl="~/DefaultRights.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li>
                                    <asp:LinkButton ID="ProcessAdmin" runat="server" Text="Process" PostBackUrl="~/ProcessRights.aspx"
                                        Enabled="false"></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="ExecutiveAdmin" runat="server" Text="Executive" Enabled="false"
                                        PostBackUrl="~/Executives.aspx"></asp:LinkButton></li>
                                <li><a href="#">Brands <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="BrandsAdmin" runat="server" Text="Brands" PostBackUrl="~/Brands.aspx"
                                                Enabled="false"></asp:LinkButton></li>
                                        <li class="last">
                                            <li>
                                                <asp:LinkButton ID="BrnadsProducts" runat="server" Text="Products" PostBackUrl="~/Products.aspx"
                                                    Enabled="true"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li>
                                    <asp:LinkButton ID="CentersAdmin" runat="server" Text="Locations" PostBackUrl="~/Locations.aspx"
                                        Enabled="false"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="UsersLog" runat="server" Text="User Log" PostBackUrl="~/UserLog.aspx"
                                        Enabled="false"></asp:LinkButton></li>
                                <li class="last">
                                    <asp:LinkButton ID="EditLog" runat="server" Text="Edit Log" PostBackUrl="~/EditLogs.aspx"
                                        Enabled="false"></asp:LinkButton></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Headder End  -->
        <!-- Content Start  -->
        <!-- Content Start  -->
        <div class="content wid1000">
            <div class="clear">
                &nbsp;</div>
            <div class="box1">
                <div class="inn readonly">
                    <table width="100%">
                        <tr>
                            <td style="width: 32%">
                                <h4 class="field">
                                    <label class="left">
                                        Sale ID:</label>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <span class="left2">
                                        <asp:Label ID="lblSaleID" runat="server"></asp:Label>
                                </h4>
                            </td>
                            <td style="width: 2%;">
                                &nbsp;
                            </td>
                            <td style="width: 32%">
                                <h4 class="field">
                                    <label class="left">
                                        Sale Date:</span> <span class="left2">
                                    </label>
                                    <span class="left2">
                                        <asp:Label ID="lblSaleDate" runat="server"></asp:Label></span>
                                </h4>
                            </td>
                            <td style="width: 2%px;">
                                &nbsp;
                            </td>
                            <td style="width: 32%">
                                <h4 class="field">
                                    <label class="left">
                                        Location:</label>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <span class="left2">
                                        <asp:Label ID="lblLocation" runat="server"></asp:Label></span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Agent:</label>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <span class="left2">
                                        <asp:Label ID="lblSaleAgent" runat="server"></asp:Label>&nbsp;<asp:DropDownList ID="ddlUpAgenU"
                                            runat="server" Height="22px" Width="150px">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                            </td>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Verifier:</label>
                                    <span class="left2">
                                        <asp:Label ID="lblVerifierName" runat="server"></asp:Label>&nbsp;<asp:DropDownList
                                            ID="ddlVerfNamU" runat="server" Height="22px" Width="150px">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Verifier:</label>
                                    <span class="left2">
                                        <asp:Label ID="lblVerifierLocation" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Package:</label>
                                    <span class="left2">
                                        <asp:DropDownList ID="ddlPackage" runat="server" onchange="return OnchangeDropdown()">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Payment Status:</label>
                                    <span class="left2">
                                        <asp:Label ID="lblPaymentStatusView" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                            <td>
                            </td>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        QC Status</label>
                                    <span class="left2">
                                        <asp:Label ID="lblQCStatus" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <label class="left" id="discountchk" runat="server" style="display: block;">
                                        Discount:</label>
                                    <span class="left2">
                                        <asp:DropDownList CssClass="left2" ID="ddldiscount" onchange="return OnchangeDropdown()"
                                            runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                            </td>
                            <td style="text-align: right" colspan="4">
                                <asp:UpdatePanel ID="updtpnlSave" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnQCUpdate" runat="server" CssClass="btn btn-warning btn-sm" Text="Update"
                                            OnClick="btnQCUpdate_Click" OnClientClick="return ValidateSavedData();" />
                                        &nbsp;
                                        <asp:Button ID="btnQCBack" runat="server" CssClass="btn btn-warning btn-sm" Text="Close"
                                            OnClick="BtnClsUpdated_Click" OnClientClick="return ChangeValues();" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="clear">
                &nbsp;</div>
            <!-- SELLER INFORMATION Start -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2">
                    SELLER INFORMATION
                   <%-- <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>--%>
                </h1>
                <div class="inn">
                    <asp:UpdatePanel ID="updtpnl" runat="server">
                        <ContentTemplate>
                            <!-- Start  -->
                            <table class="table2">
                                <tr>
                                    <td style="width: 49%;">
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>First name:</span> <span class="left2">
                                                <asp:TextBox ID="txtFirstName" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                        </h4>
                                    </td>
                                    <td style="width: 40px;">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>Last name:</span> <span class="left2">
                                                <asp:TextBox ID="txtLastName" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>Phone #:</span> <span class="left2">
                                                <asp:TextBox ID="txtPhone" runat="server" MaxLength="10" onkeypress="return isNumberKey(event)"
                                                    onblur="return PhoneOnblur();" onfocus="return PhoneOnfocus();"></asp:TextBox>
                                        </h4>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>Email:</span> <span class="left2">
                                                <asp:TextBox ID="txtEmail" runat="server" MaxLength="60" onblur="return EmailOnblur();"
                                                    Style="width: 336px;"></asp:TextBox>
                                                <asp:CheckBox ID="chkbxEMailNA" runat="server" Text="NA" Font-Bold="true" Enabled="false" />
                                            </span>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>Address:</span> <span class="left2">
                                                <asp:TextBox ID="txtAddress" runat="server" MaxLength="40"></asp:TextBox></span>
                                        </h4>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>City:</span> <span class="left2">
                                                <asp:TextBox ID="txtCity" runat="server" MaxLength="40" Style="width: 110px;"></asp:TextBox>
                                                &nbsp;
                                                <label>
                                                    <span class="star">*</span>State:</label>
                                                <asp:DropDownList ID="ddlLocationState" runat="server" Style="width: 100px">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <label>
                                                    <span class="star">*</span>ZIP:</label>
                                                <asp:TextBox ID="txtZip" runat="server" Style="width: 74px" MaxLength="5" class="sample4"
                                                    onkeypress="return isNumberKey(event)" onblur="return ZipOnblur();"></asp:TextBox>
                                            </span>
                                        </h4>
                                    </td>
                                </tr>
                            </table>
                            <!-- End  -->
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="clear">
                    &nbsp;</div>
            </div>
            <!-- SELLER INFORMATION End -->
            <div class="clear">
                &nbsp;</div>
            <!-- VEHICLE INFORMATION Start -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2 hid" id="Vinfo">
                    VEHICLE INFORMATION
                    <label class="selected" id="selected">
                    </label>
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn" id="feat">
                    <!-- Start  -->
                    <table class="table2">
                        <tr>
                            <td style="width: 31%">
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Make:</span> <span class="left2">
                                        <asp:UpdatePanel ID="updtMake" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlMake" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMake_SelectedIndexChanged"
                                                    onchange="ChangeValuesHidden()">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 3%;">
                                &nbsp;
                            </td>
                            <td style="width: 31%">
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Model:</span> <span class="left2">
                                        <asp:UpdatePanel ID="updtpnlModel" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlModel" runat="server" onchange="ChangeValuesHidden()">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 3%;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Year:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlYear" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Price:</span> <span class="left2">
                                        <asp:TextBox ID="txtAskingPrice" runat="server" MaxLength="6" class="sample4" onkeypress="return isNumberKey(event);"></asp:TextBox></span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Mileage:</span> <span class="left2">
                                        <asp:TextBox ID="txtMileage" runat="server" MaxLength="6" class="sample4" onkeypress="return isNumberKey(event);"></asp:TextBox></span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Cylinders:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlcylindars" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">3</asp:ListItem>
                                            <asp:ListItem Value="2">4</asp:ListItem>
                                            <asp:ListItem Value="3">5</asp:ListItem>
                                            <asp:ListItem Value="4">6</asp:ListItem>
                                            <asp:ListItem Value="5">7</asp:ListItem>
                                            <asp:ListItem Value="6">8</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Body style:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlBodyStyle" runat="server" onchange="ChangeValuesHidden()">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Exterior color:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlExteriorColor" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Interior color:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlInteriorColor" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Transmission:</span> <span class="left2">
                                        <asp:DropDownList ID="ddltransm" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">Auto</asp:ListItem>
                                            <asp:ListItem Value="2">Manual</asp:ListItem>
                                            <asp:ListItem Value="3">Tiptronic</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Doors:</span> <span class="left2">
                                        <asp:DropDownList ID="ddldoors" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">2</asp:ListItem>
                                            <asp:ListItem Value="2">3</asp:ListItem>
                                            <asp:ListItem Value="3">4</asp:ListItem>
                                            <asp:ListItem Value="4">5</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Drive train:</span> <span class="left2">
                                        <asp:DropDownList ID="ddldrivetrain" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">2WD</asp:ListItem>
                                            <asp:ListItem Value="2">FWD</asp:ListItem>
                                            <asp:ListItem Value="3">AWD</asp:ListItem>
                                            <asp:ListItem Value="4">RWD</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Fuel type:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlfueltype" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">Diesel</asp:ListItem>
                                            <asp:ListItem Value="2">Petrol</asp:ListItem>
                                            <asp:ListItem Value="3">Hybrid</asp:ListItem>
                                            <asp:ListItem Value="4">Electric</asp:ListItem>
                                            <asp:ListItem Value="5">Gasoline</asp:ListItem>
                                            <asp:ListItem Value="6">E-85</asp:ListItem>
                                            <asp:ListItem Value="7">Gasoline-Hybrid</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Condition:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlcondition" runat="server">
                                            <asp:ListItem Value="0">Unspecified</asp:ListItem>
                                            <asp:ListItem Value="1">Excellent</asp:ListItem>
                                            <asp:ListItem Value="2">Very good</asp:ListItem>
                                            <asp:ListItem Value="3">Good</asp:ListItem>
                                            <asp:ListItem Value="4">Fair</asp:ListItem>
                                            <asp:ListItem Value="5">Poor</asp:ListItem>
                                            <asp:ListItem Value="6">Parts or salvage</asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">VIN #:</span> <span class="left2">
                                        <asp:TextBox ID="txtVin" runat="server" Style="width: 409px" MaxLength="20"></asp:TextBox></span>
                                </h4>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- VEHICLE INFORMATION End  -->
            <div class="clear">
                &nbsp;</div>
            <!-- VEHICLE FEATURES Start  -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2 ">
                    VEHICLE FEATURES
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn " id="feat">
                    <!-- Start  -->
                    <table class="table3" id='vF'>
                        <tr>
                            <td style="width: 120px;">
                                <label class="hed2">
                                    <span class="featNon">Comfort:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures51" runat="server" class="noLM" />
                                   <span class="featNon"> A/C</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures1" runat="server" class="noLM" />
                                    <span class="featNon">A/C: Front</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures2" runat="server" class="noLM" />
                                    <span class="featNon">A/C: Rear</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures3" runat="server" class="noLM" />
                                   <span class="featNon"> Cruise control</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures4" runat="server" class="noLM" />
                                   <span class="featNon"> Navigation system</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures5" runat="server" class="noLM" />
                                   <span class="featNon"> Power locks</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures6" runat="server" class="noLM" />
                                   <span class="featNon"> Power steering</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures7" runat="server" class="noLM" />
                                    <span class="featNon">Remote keyless entry</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures8" runat="server" class="noLM" />
                                   <span class="featNon"> TV/VCR
                                </label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures31" runat="server" class="noLM" /><span class="featNon">Remote start</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures33" runat="server" class="noLM" /><span class="featNon">Tilt
                                </label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures35" runat="server" class="noLM" /><span class="featNon">Rearview camera</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures36" runat="server" class="noLM" /><span class="featNon">Power mirrors</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Seats:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures9" runat="server" CssClass="noLM" /><span class="featNon">Bucket seats</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures11" runat="server" CssClass="noLM" /><span class="featNon">Memory seats</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures12" runat="server" CssClass="noLM" /><span class="featNon">Power seats</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures32" runat="server" CssClass="noLM" /><span class="featNon">Heated seats
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Interior:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:RadioButton ID="rdbtnLeather" runat="server" CssClass="noLM" GroupName="Seats"
                                        Text="" /><span class="featNon">Leather</span></label>
                                <label>
                                    <asp:RadioButton ID="rdbtnVinyl" runat="server" CssClass="noLM" GroupName="Seats"
                                        Text="" /><span class="featNon">Vinyl</span></label>
                                <label>
                                    <asp:RadioButton ID="rdbtnCloth" runat="server" CssClass="noLM" GroupName="Seats"
                                        Text="" /><span class="featNon">Cloth</span></label>
                                <label>
                                    <asp:RadioButton ID="rdbtnInteriorNA" runat="server" CssClass="noLM" GroupName="Seats"
                                        Text="" Checked="true" /><span class="featNon">NA</span></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Safety:</label>
                            </td>
                            <td class="chkLabel">
                                <label id="i1" runat="server">
                                    <asp:CheckBox ID="chkFeatures13" runat="server" class="noLM" /><span class="featNon">Airbag:</span>
                                    Driver</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures14" runat="server" class="noLM" /><span class="featNon">Airbag:</span>
                                    Passenger</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures15" runat="server" class="noLM" /><span class="featNon">Airbag: Side</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures16" runat="server" class="noLM" /><span class="featNon">Alarm</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures17" runat="server" class="noLM" /><span class="featNon">Anti-lock brakes</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures18" runat="server" class="noLM" /><span class="featNon">Fog lights</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures39" runat="server" class="noLM" /><span class="featNon">Power brakes</span></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Sound System:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures19" runat="server" class="noLM" /><span class="featNon">Cassette radio</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures20" runat="server" class="noLM" /><span class="featNon">CD changer</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures21" runat="server" class="noLM" /><span class="featNon">CD player</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures22" runat="server" class="noLM" /><span class="featNon">Premium sound</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures34" runat="server" class="noLM" /><span class="featNon">AM/FM</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures40" runat="server" class="noLM" /><span class="featNon">DVD</span></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    New:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures44" runat="server" class="noLM" /><span class="featNon">Batter</span>y</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures45" runat="server" class="noLM" /><span class="featNon">Tires</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures52" runat="server" class="noLM" /><span class="featNon">Rotors</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures53" runat="server" class="noLM" /><span class="featNon">Brakes</span></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Windows:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures23" runat="server" class="noLM" /><span class="featNon">Power windows</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures24" runat="server" class="noLM" /><span class="featNon">Rear window defroster</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures25" runat="server" class="noLM" /><span class="featNon">Rear window wiper</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures26" runat="server" class="noLM" /><span class="featNon">Tinted glass</span></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Others:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures27" runat="server" class="noLM" /><span class="featNon">Alloy wheels</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures28" runat="server" class="noLM" /><span class="featNon">Sunroof</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures41" runat="server" class="noLM" /><span class="featNon">Panoramic roof</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures42" runat="server" class="noLM" /><span class="featNon">Moonroof</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures29" runat="server" class="noLM" /><span class="featNon">Third row seats</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures30" runat="server" class="noLM" /><span class="featNon">Tow package</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures43" runat="server" class="noLM" /><span class="featNon">Dashboard wood frame</span></label>
                            </td>
                        </tr>
                        <tr class="last">
                            <td>
                                <label class="hed2">
                                    Specials:</label>
                            </td>
                            <td class="chkLabel">
                                <label>
                                    <asp:CheckBox ID="chkFeatures46" runat="server" class="noLM" /><span class="featNon">Garage kept</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures47" runat="server" class="noLM" /><span class="featNon">Non smoking</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures48" runat="server" class="noLM" /><span class="featNon">Records/Receipts</span>
                                    kept</label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures49" runat="server" class="noLM" /><span class="featNon">Well maintained</span></label>
                                <label>
                                    <asp:CheckBox ID="chkFeatures50" runat="server" class="noLM" /><span class="featNon">Regular oil changes</span></label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- VEHICLE FEATURES End  -->
            <div class="clear">
                &nbsp;</div>
            <!-- VEHICLE DESCRIPTION Start  -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2">
                    VEHICLE Description
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn">
                    <h4 class="field">
                        <span class="left2 noMrg">
                            <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000" Style="width: 99%;
                                height: 75px; resize: none;" TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false"></asp:TextBox></span>
                    </h4>
                </div>
            </div>
            <!-- VEHICLE DESCRIPTION End  -->
            <!-- SALE NOTES Start  -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2">
                    SALE NOTES
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn">
                    <table>
                        <tr>
                            <td style="vertical-align: top;">
                                <h4 class="field">
                                    <span class="left2 noMrg">
                                        <asp:TextBox ID="txtSaleNotes" runat="server" TextMode="MultiLine" MaxLength="1000"
                                            Style="width: 99%; height: 105px; resize: none;" CssClass="textAr" data-plus-as-tab="false"> </asp:TextBox></span>
                                </h4>
                            </td>
                            <td style="width: 40px;">
                                &nbsp;
                            </td>
                            <td style="width: 350px; vertical-align: text-bottom;">
                                <h4 class="field">
                                    <span class="left">Source of photos:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlPhotosSource" runat="server" onchange="ChangeValuesHidden()">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                                <h4 class="field">
                                    <span class="left">Source of description:</span> <span class="left2">
                                        <asp:DropDownList ID="ddlDescriptionSource" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- SALE NOTES End  -->
            <!-- PAYMENT DETAILS Start  -->
            <div class=" box1 boxBlue">
                <h1 class="hed1 hed2">
                    PAYMENT DETAILS
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn">
                    <table style="width: 350px;">
                        <tr>
                            <td>
                                <h4 class="field">
                                    <label class="left">
                                        Pay method:</label>
                                    <span class="left2">
                                        <asp:UpdatePanel ID="updtpnlPaymentDetails" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlpayme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlpayme_SelectedIndex">
                                                    <asp:ListItem Value="0">Visa</asp:ListItem>
                                                    <asp:ListItem Value="1">Mastercard</asp:ListItem>
                                                    <asp:ListItem Value="2">Discover</asp:ListItem>
                                                    <asp:ListItem Value="3">Amex</asp:ListItem>
                                                    <asp:ListItem Value="4">Paypal</asp:ListItem>
                                                    <asp:ListItem Value="5">Check</asp:ListItem>
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                            </td>
                            <%--<asp:RadioButton ID="rdbtnPayVisa" CssClass="noLM" Text="Visa" Checked="true" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayVisa_CheckedChanged" AutoPostBack="true" />
                                        <asp:RadioButton ID="rdbtnPayMasterCard" CssClass="noLM" Text="Mastercard" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayMasterCard_CheckedChanged" AutoPostBack="true" />
                                        <asp:RadioButton ID="rdbtnPayDiscover" CssClass="noLM" Text="Discover" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayDiscover_CheckedChanged" AutoPostBack="true" />
                                        <asp:RadioButton ID="rdbtnPayAmex" CssClass="noLM" Text="Amex" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayAmex_CheckedChanged" AutoPostBack="true" />
                                        <asp:RadioButton ID="rdbtnPayPaypal" CssClass="noLM" Text="Paypal" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayPaypal_CheckedChanged" AutoPostBack="true" />
                                        <asp:RadioButton ID="rdbtnPayCheck" CssClass="noLM" Text="Check" GroupName="PayType"
                                            runat="server" OnCheckedChanged="rdbtnPayCheck_CheckedChanged" AutoPostBack="true" /></span>--%>
                            </h4>
                        </tr>
                    </table>
                    <div class="clear">
                        &nbsp;</div>
                    <br />
                    <!-- Card Details Start -->
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="divcard" runat="server">
                                <fieldset class="filedSet">
                                    <legend>Card Details <span>
                                        <asp:LinkButton ID="lnkbtnCopySellerInfo" runat="server" Text="Copy name & address from Seller Information"
                                            OnClientClick="return CopySellerInfo();" Style="color: Blue; text-decoration: underline;"></asp:LinkButton>
                                    </legend>
                                    <div class="inn">
                                        <table>
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>Card Holder First Name:</label>
                                                        <span class="left2">
                                                            <asp:HiddenField ID="CardType" runat="server" />
                                                            <asp:TextBox ID="txtCardholderName" runat="server" MaxLength="25" Style="width: 170px;" />
                                                            <label>
                                                                <span class="star">*</span>Last Name:</label>
                                                            <asp:TextBox ID="txtCardholderLastName" runat="server" MaxLength="25" Style="width: 110px" />
                                                        </span>
                                                    </h4>
                                                </td>
                                                <td style="width: 40px;">
                                                    &nbsp;
                                                </td>
                                                <td style="width: 350px;">
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>Address:</label>
                                                        <span class="left2">
                                                            <asp:TextBox ID="txtbillingaddress" runat="server" MaxLength="40"></asp:TextBox></span>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>Credit Card:</label>
                                                        <span class="left2">
                                                            <asp:TextBox runat="server" ID="CardNumber" MaxLength="16" onkeypress="return isNumberKey(event)"
                                                                onblur="return CreditCardOnblur();" /></span>
                                                    </h4>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>City:</label>
                                                        <span class="left2">
                                                            <asp:TextBox ID="txtbillingcity" runat="server" MaxLength="40"></asp:TextBox></span>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>Expiry Date:</label>
                                                        <span class="left2">
                                                            <asp:DropDownList ID="ExpMon" Style="width: 130px;" runat="server">
                                                                <asp:ListItem Value="0" Text="Select Month"></asp:ListItem>
                                                                <asp:ListItem Value="01" Text="01"></asp:ListItem>
                                                                <asp:ListItem Value="02" Text="02"></asp:ListItem>
                                                                <asp:ListItem Value="03" Text="03"></asp:ListItem>
                                                                <asp:ListItem Value="04" Text="04"></asp:ListItem>
                                                                <asp:ListItem Value="05" Text="05"></asp:ListItem>
                                                                <asp:ListItem Value="06" Text="06"></asp:ListItem>
                                                                <asp:ListItem Value="07" Text="07"></asp:ListItem>
                                                                <asp:ListItem Value="08" Text="08"></asp:ListItem>
                                                                <asp:ListItem Value="09" Text="09"></asp:ListItem>
                                                                <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                                                <asp:ListItem Value="11" Text="11"></asp:ListItem>
                                                                <asp:ListItem Value="12" Text="12"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            /
                                                            <asp:DropDownList ID="CCExpiresYear" Style="width: 120px" runat="server">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </h4>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>State:</label>
                                                        <span class="left2">
                                                            <asp:DropDownList ID="ddlbillingstate" runat="server" Style="width: 120px">
                                                            </asp:DropDownList>
                                                            <label style="margin-bottom: 0">
                                                                <span class="star">*</span>ZIP:</label>&nbsp;
                                                            <asp:TextBox ID="txtbillingzip" runat="server" Style="width: 74px" MaxLength="5"
                                                                onkeypress="return isNumberKey(event)" onblur="return billingZipOnblur();"></asp:TextBox>
                                                        </span>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star" style="color: Red">*</span><strong style="width: 40px">CVV#</strong>
                                                        </label>
                                                        <span class="left2">
                                                            <asp:TextBox ID="cvv" MaxLength="4" Style="width: 60px; margin-left: 5px;" runat="server"
                                                                onkeypress="return isNumberKey(event)" onblur="return CVVOnblur(); " />
                                                        </span>
                                                    </h4>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </fieldset>
                            </div>
                            <!-- Credit Card End  -->
                            <div class="clear">
                                &nbsp;</div>
                            <!-- check Start  -->
                            <div id="divcheck" runat="server" style="display: none;">
                                <table border="0" cellpadding="4" cellspacing="4" style="width: 98%; margin: 0;">
                                    <tr>
                                        <td>
                                            <h5 style="display: inline-block; margin: 0; font-size: 15px;">
                                                Check Details</h5>
                                            <h5 style="font-size: 12px; font-weight: normal; margin: 0; display: inline-block">
                                                <asp:LinkButton ID="lnkbtnCopyCheckName" runat="server" Text="Copy name from Seller Information"
                                                    OnClientClick="return CopySellerInfoForCheck();" Style="color: Blue; text-decoration: underline;"></asp:LinkButton>
                                            </h5>
                                            <table style="width: 80%; margin-bottom: 25px;">
                                                <tr>
                                                    <td>
                                                        <h4 class="field">
                                                            <label class="left">
                                                                <span class="star" style="color: Red">*</span><strong style="width: 125px"></strong>
                                                                Account holder name</label>
                                                            <span class="left2">
                                                                <asp:TextBox ID="txtCustNameForCheck" runat="server" MaxLength="50"></asp:TextBox>
                                                            </span>
                                                        </h4>
                                                    </td>
                                                    <td style="width: 15px;">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <h4 class="field">
                                                            <label class="left">
                                                                <span class="star" style="color: Red">*</span><strong style="width: 125px"></strong>Account
                                                                #</label>
                                                            <span class="left2">
                                                                <asp:TextBox ID="txtAccNumberForCheck" runat="server" MaxLength="20"></asp:TextBox></span>
                                                        </h4>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <h4 class="field">
                                                            <label class="left">
                                                                <span class="star" style="color: Red">*</span><strong style="width: 125px"></strong>Bank
                                                                name:</label>
                                                            <span class="left2">
                                                                <asp:TextBox ID="txtBankNameForCheck" runat="server" MaxLength="50"></asp:TextBox></span>
                                                        </h4>
                                                    </td>
                                                    <td style="width: 15px;">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <h4 class="field">
                                                            <label class="left">
                                                                <span class="star" style="color: Red">*</span><strong style="width: 125px"></strong>Routing
                                                                #</label>
                                                            <span class="left2">
                                                                <asp:TextBox ID="txtRoutingNumberForCheck" runat="server" MaxLength="9"></asp:TextBox></span>
                                                        </h4>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <h4 class="field">
                                                            <label class="left">
                                                                <span class="star" style="color: Red">*</span><strong style="width: 125px"></strong>Account
                                                                type</label>
                                                            <span class="left2">
                                                                <asp:DropDownList ID="ddlAccType" runat="server">
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="1">CHECKING</asp:ListItem>
                                                                    <asp:ListItem Value="2">SAVINGS</asp:ListItem>
                                                                    <asp:ListItem Value="3">BUSINESSCHECKING</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </span>
                                                        </h4>
                                                    </td>
                                                    <td colspan="2">
                                                    </td>
                                                </tr>
                                            </table>
                                            <div style="width: 45%; display: inline-block; float: left; margin-right: 10px;">
                                            </div>
                                            <div style="width: 45%; display: inline-block; float: left">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- check End  -->
                            <div class="clear">
                                &nbsp;</div>
                            <!-- paypal Start  -->
                            <div id="divpaypal" runat="server" style="display: none;">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <fieldset class="filedSet">
                                                <legend>Paypal Details</legend>
                                                <div id="Div1" class="inn" runat="server" style="width: 80%;">
                                                    <table>
                                                        <%-- <tr>
                                                                            <td>
                                                                                <h4 class="h4">
                                                                                    <span class="star" style="color: Red">*</span><strong style="width: 90px">Payment date:</strong>
                                                                                  
                                                                                    <asp:DropDownList ID="ddlPaymentdate" runat="server" onchange="ChangeValuesHidden()"
                                                                                        Width="195px">
                                                                                    </asp:DropDownList>
                                                                                </h4>
                                                                            </td>
                                                                            <td>
                                                                                <h4 class="h4">
                                                                                    <span class="star" style="color: Red">*</span><strong style="width: 40px">Amount:</strong>
                                                                                  
                                                                                    <asp:TextBox ID="txtPayAmount" runat="server" MaxLength="6" onkeypress="return isNumberKeyWithDot(event)"
                                                                                        onkeyup="return ChangeValuesHidden()"></asp:TextBox>
                                                                                </h4>
                                                                            </td>
                                                                        </tr>--%>
                                                        <tr>
                                                            <td>
                                                                <h4 class="h4">
                                                                    <span class="star" style="color: Red">*</span><strong style="width: 100px">Payment trans
                                                                        ID:</strong>
                                                                    <%-- <input type="text" style="width: 245px" />--%>
                                                                    <asp:TextBox ID="txtPaytransID" runat="server" MaxLength="30" Style="width: 76%;"></asp:TextBox>
                                                                </h4>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <h4 class="h4">
                                                                    <span class="star" style="color: Red">*</span><strong style="width: 140px">Paypal account
                                                                        email:</strong>
                                                                    <%-- <input type="text" style="width: 245px" />--%>
                                                                    <asp:TextBox ID="txtpayPalEmailAccount" runat="server" onblur="return PaypalEmailblur();"
                                                                        Style="width: 72%;"></asp:TextBox>
                                                                </h4>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="clear">
                                                    &nbsp;</div>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- paypal End  -->
                            <div class="clear">
                                &nbsp;</div>
                            <!-- Post Date End  -->
                            <!-- Post Date End  -->
                            <div class="clear">
                                &nbsp;</div>
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <!-- Card Details End -->
                    <!-- Payment Schedule Start  -->
                    <fieldset class="filedSet">
                        <legend>Payment Schedule</legend>
                        <div class="inn">
                            <table style="width: 71%">
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 175px">
                                                Today's Payment Date:</label>
                                            <span class="left2" style="padding-left: 47px;">
                                                <asp:TextBox ID="txtPaymentDate" runat="server" Style="width: 120px;" ReadOnly="true"></asp:TextBox>
                                                <img src="images/Calender.gif" />
                                            </span>
                                        </h4>
                                    </td>
                                    <td style="width: 15px;">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 86px">
                                                <span class="star">*</span> <strong style="width: 55px">Amount $</strong></label>
                                            <span class="left2">
                                                <asp:TextBox ID="txtPDAmountNow" runat="server" MaxLength="6" onkeypress="return isNumberKeyWithDot(event)"
                                                    onkeyup="return ChangeValuesHidden()" Style="width: 72%;"></asp:TextBox>
                                            </span>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 175px">
                                                PD Payment Date:</label>
                                            <span class="left2"><span class="star" style="color: Red">*</span>
                                                <asp:CheckBox ID="chkboxlstPDsale" runat="server" CssClass="noLM" />
                                                <asp:DropDownList ID="ddlPDDate" runat="server" onchange="ChangeValuesHidden()" Width="120px"
                                                    ForeColor="Red">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <img src="images/Calender.gif" />
                                            </span>
                                        </h4>
                                    </td>
                                    <td style="width: 15px;">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 86px; padding-left: 13px;">
                                                <strong style="width: 55px">Amount $</strong></label>
                                            <span class="left2 noMrg">
                                                <asp:TextBox ID="txtPDAmountLater" runat="server" MaxLength="6" onkeypress="return isNumberKeyWithDot(event)"
                                                    onkeyup="return ChangeValuesHidden()" Enabled="false" Style="width: 75%; float: "></asp:TextBox>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td style="width: 15px;">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 86px; padding-left: 13px;">
                                                <strong style="width: 55px">Total $</strong></label>
                                            <span class="left2 noMrg">
                                                <asp:TextBox ID="txtTotalAmount" ReadOnly="true" runat="server"></asp:TextBox>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                    <!-- Payment Schedule End  -->
                    <div class="clear">
                    </div>
                    <!-- Voice file confirmation Start  -->
                    <table>
                        <tr>
                            <td style="width: 36%">
                                <h4 class="field">
                                    <label class="left">
                                        <span class="star">*</span>Voice file confirmation #:</label>
                                    <span class="left2">
                                        <asp:TextBox ID="txtVoicefileConfirmNo" runat="server" MaxLength="30"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 3%;">
                                &nbsp;
                            </td>
                            <td style="width: 36%">
                                <h4 class="field">
                                    <label class="left">
                                        <span class="star">*</span>Voice file Location :</label>
                                    <span class="left2">
                                        <asp:DropDownList ID="ddlVoiceFileLocation" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 3%;">
                                &nbsp;
                            </td>
                            <td style="padding-top: 14px;">
                                <asp:Button ID="btnProcess" runat="server" Text="Process" class="btn btn-sm btn-success"
                                    Visible="true" Enabled="false" />
                            </td>
                        </tr>
                    </table>
                    <!-- Voice file confirmation Emd -->
                    <div class="clear">
                        &nbsp;</div>
                    <br />
                </div>
            </div>
            <!-- PAYMENT DETAILS End  -->
        </div>
    </div>
    <!-- Main Wrapper Emd  -->
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    <cc1:ModalPopupExtender ID="mpealteruserUpdated" runat="server" PopupControlID="AlertUserUpdated"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAlertuserUpdated">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAlertuserUpdated" runat="server" />
    <div id="AlertUserUpdated" class="popup" style="display: none">
        <h2>
            Alert
            <asp:Button ID="BtnClsUpdated" class="cls" runat="server" Text="" BorderWidth="0"
                OnClick="BtnClsUpdated_Click" />
            <!-- <div class="cls">
            </div> -->
        </h2>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErrUpdated" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnYesUpdated" class="btn" runat="server" Text="Ok" OnClick="BtnClsUpdated_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mdepAlertExists" runat="server" PopupControlID="divExists"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnExists" OkControlID="btnExustCls"
        CancelControlID="btnOk">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnExists" runat="server" />
    <div id="divExists" class="popup" style="display: none">
        <h2>
            Alert
            <asp:Button ID="btnExustCls" class="cls" runat="server" Text="" BorderWidth="0" />
            <!-- <div class="cls">
            </div> -->
        </h2>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErrorExists" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnOk" class="btn" runat="server" Text="Ok" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mdepDraftExistsShow" runat="server" PopupControlID="divDraftExistsShow"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnDraftExistsShow" OkControlID="btnDraftExistsShowNo">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnDraftExistsShow" runat="server" />
    <div id="divDraftExistsShow" class="popup" style="display: none">
        <h2>
            Alert
            <!-- <div class="cls">
            </div> -->
        </h2>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblDraftExistsShow" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnDraftExistsShowNo" class="btn" runat="server" Text="No" />&nbsp;
            <asp:Button ID="btnDraftExistsShowYes" class="btn" runat="server" Text="Yes" OnClick="btnDraftExistsShowYes_Click" />
        </div>
    </div>
    </form>
</body>
</html>
