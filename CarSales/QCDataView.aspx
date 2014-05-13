<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QCDataView.aspx.cs" Inherits="QCDataView" %>

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

    function RejectQCValidation()
	{
        if (document.getElementById('<%= txtQCNotes.ClientID%>').value.trim().length < 1)
        {
        alert("Please enter qc notes"); 
        valid=false;
        document.getElementById('txtQCNotes').focus();  
        return valid;               
        }
	}
	 function QCValidation()
	{
	
        if(document.getElementById('<%=ddlQCStatus.ClientID%>').value =="0")
        {
        alert("Please select qc status"); 
        valid=false;
        document.getElementById('ddlQCStatus').focus();  
        return valid;               
        }
        if(document.getElementById('<%=ddlQCStatus.ClientID%>').value =="2")
        {
             if (document.getElementById('<%= txtQCNotes.ClientID%>').value.trim().length < 1)
            {
            alert("Please enter qc notes"); 
            valid=false;
            document.getElementById('txtQCNotes').focus();  
            return valid;               
            }   
        }
	}
        function PmntValidation()
	    {
    	    valid=true;
            if(document.getElementById('<%=ddlPmntStatus.ClientID%>').value =="0")
            {
            alert("Please select payment status"); 
            valid=false;
            document.getElementById('ddlPmntStatus').focus();  
            return valid;               
            }
            if(document.getElementById('<%=ddlPmntStatus.ClientID%>').value =="2")
            {
                if(document.getElementById('<%= ddlPayCancelReason.ClientID%>').value == "0") {
                        document.getElementById('<%= ddlPayCancelReason.ClientID%>').focus();
                        alert("Select payment reject reason");                 
                        document.getElementById('<%=ddlPayCancelReason.ClientID%>').focus()
                        valid = false;            
                         return valid;     
                    } 
                 if (document.getElementById('<%= txtPaymentNotesNew.ClientID%>').value.trim().length < 1)
                {
                alert("Please enter payment notes"); 
                valid=false;
                document.getElementById('txtPaymentNotesNew').focus();  
                return valid;               
                }   
            }
            return valid; 
	    }
         function PayInfoChanges() {
	     debugger;      
            if(document.getElementById('<%=ddlPmntStatus.ClientID%>').value =="2")
            {
                 document.getElementById('<%=divReason.ClientID%>').style.display = "block";
            }
            else
            {
                document.getElementById('<%=divReason.ClientID%>').style.display = "none";
            }
            return false;
        }
        function poptastic2(url)
      {var carid=$.trim($('#lblSaleID').text());
    var ur = url+carid
	newwindow=window.open(ur,'name','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,height=600,width=540');
	    if (window.focus) {newwindow.focus()}
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
		
		
	});
    </script>

    <script type="text/javascript" language="javascript">
   
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
         
   }
   
  function TransfersInfoBinding(){
        youfunction()
        $(window).load(function(){
            //alert('Ok')
            youfunction()
        });            
  }
  
    function ClosePopup9() {
            $find('<%= MdlPopAgentUpdate.ClientID%>').hide();
            return false;
        }
        
         function ClosePopup10() {
            $find('<%= MdlPopVerifier.ClientID%>').hide();
            return false;
        }
         function ClosePopup22() {
            $find('<%=  MdlPopLeadDetails.ClientID%>').hide();
            return false;
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
        /*
         $('.hid').click(function(){		
			if($(this).attr('id') == 'Vinfo'){
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
				if($('#Vinfo').next('div.hidden').is(':visible')){				
					$('#Vinfo label').empty().append(str);	
					$('.price11').formatCurrency();
				}else{
					$('#Vinfo label').empty()
				}	
			}
			$(this).next('div.hidden').slideToggle();
		});	
		
		*/	
       
       
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
		//$('.hid').next('div.hidden').hide();
		
		
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
		
		
		$('#txtAskingPrice').live('blur',function(){
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

    <!-- End -->
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
    <asp:UpdateProgress ID="Progress" runat="server" AssociatedUpdatePanelID="updtpnlSave"
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
                                <li class="act">
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
                        <li class="parent"><a href="#">Admin <span class="cert"></span></a>
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
                <div class="inn">
                    <table width="100%" class="tbl4">
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Sale ID:</span> <span class="left2">
                                        <asp:Label ID="lblSaleID" runat="server"></asp:Label></span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Sale Date:</span>
                                    <asp:Label ID="lblSaleDate" runat="server" CssClass="left2"></asp:Label>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Location:</span>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <asp:Label ID="lblLocation" runat="server" CssClass="left2"></asp:Label>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Agent:</span>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <span class="left2">
                                        <asp:Label ID="lblSaleAgent" runat="server"></asp:Label>
                                        <asp:LinkButton ID="lnkAgentUpdate" runat="server" Text="Agent" OnClick="lnkAgentUpdate_Click"></asp:LinkButton>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Verifier:</span>
                                    <%-- <input type="text" style="width: 245px" />--%>
                                    <span class="left2">
                                        <asp:Label ID="lblVerifierName" runat="server"></asp:Label>
                                        <asp:LinkButton ID="lnkVerifierName" runat="server" Text="Verifier" OnClick="lnkVerifierName_Click"></asp:LinkButton>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Verifier:</span> <span class="left2">
                                        <asp:Label ID="lblVerifierLocation" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">QC Status</span> <span class="left2">
                                        <asp:Label ID="lblQCStatus" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Payment Status:</span> <span class="left2">
                                        <asp:Label ID="lblPaymentStatusView" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td width="300px">
                                <h4 class="field">
                                    <span class="left">Package:</span> <span class="left2">
                                        <asp:Label ID="lblPackage" runat="server"></asp:Label>&nbsp;
                                        <asp:Label ID="lbldiscountpacka" runat="server" Text="Discount"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td width="300px">
                                <h4 class="field">
                                    <span class="left">Brand:</span><span class="left2">
                                        <asp:Label ID="lblbrand" runat="server"></asp:Label>
                                    </span>
                                </h4>
                            </td>
                            <td style="width: 15px;">
                                &nbsp;
                            </td>
                            <td style="text-align: right; padding-top: 10px;" colspan="3">
                                <asp:UpdatePanel ID="updtpnlSave" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlQCStatus" Visible="false" runat="server" Font-Size="14px"
                                            Font-Bold="true" ForeColor="#2B4BB1" Style="padding: 5px">
                                            <asp:ListItem Value="0">Select QC Status</asp:ListItem>
                                            <asp:ListItem Value="1">QC Approved</asp:ListItem>
                                            <asp:ListItem Value="2">QC Reject</asp:ListItem>
                                            <asp:ListItem Value="3">QC Pending</asp:ListItem>
                                            <asp:ListItem Value="4">QC Returned</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                        <%--  <asp:Button ID="btnQCUpdate" runat="server" CssClass="btn btn-warning btn-sm" Text="QC Update"
                                        OnClientClick="return QCValidation();" OnClick="btnQCUpdate_Click" />--%>
                                        <asp:Button ID="btnQCUpdate" runat="server" CssClass="btn btn-warning btn-sm" Text="QC Update"
                                            OnClientClick="poptastic2('QCCkeckList1.aspx?CarId=');" />
                                        &nbsp;
                                        <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-warning btn-sm" Text="Edit"
                                            OnClick="btnEdit_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnQCBack" runat="server" CssClass="btn btn-warning btn-sm" Text="Close"
                                            OnClick="BtnClsUpdated_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnMovedToSmartz" runat="server" CssClass="btn btn-warning btn-sm"
                                            Text="Move to Smartz" OnClick="MoveSmartz_Click" />
                                        <asp:Button ID="btnQcVeri" runat="server" CssClass="btn btn-warning btn-sm" Text="QC Verifier"
                                            Visible="false" OnClientClick="poptastic2('QCCkeckList1.aspx?CarId=');" />
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
                    <%--<div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>--%>
                </h1>
                <div class="inn">
                    <asp:UpdatePanel ID="updtpnl" runat="server">
                        <ContentTemplate>
                            <!-- Start  -->
                            <table class="table2 tbl4">
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
                                            </span>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>Phone #:</span> <span class="left2">
                                                <asp:ImageButton ID="PhoneMatch" runat="server" ImageUrl="images/icon-phone.png"
                                                    OnClick="PhoneMatch_Click" CommandName="GoogleAddressMatch" title="Google Search" />
                                                <asp:TextBox ID="txtPhone" runat="server" Style="width: auto" MaxLength="10" onkeypress="return isNumberKey(event)"
                                                    onblur="return PhoneOnblur();" onfocus="return PhoneOnfocus();" Enabled="false"></asp:TextBox>
                                            </span>
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
                                                <asp:TextBox ID="txtAddress" runat="server" MaxLength="40" Enabled="false"></asp:TextBox>
                                            </span>
                                        </h4>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <h4 class="field">
                                            <span class="left"><span class="star">*</span>City:</span> <span class="left2">
                                                <asp:TextBox ID="txtCity" runat="server" MaxLength="40" Style="width: 100px;"></asp:TextBox>
                                                &nbsp;
                                                <label>
                                                    <span class="star">*</span>State:</label>
                                                <asp:TextBox ID="lblLocationState" runat="server" MaxLength="40" Enabled="false"
                                                    Style="width: 120px"></asp:TextBox>
                                                &nbsp;
                                                <label>
                                                    <span class="star">*</span>ZIP:</label>
                                                <asp:TextBox ID="txtZip" runat="server" Style="width: 74px" MaxLength="5" class="sample4"
                                                    onkeypress="return isNumberKey(event)" Enabled="false" onblur="return ZipOnblur();"></asp:TextBox>
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
                <div class="inn">
                    <!-- Start  -->
                    <table class="table2  tbl4">
                        <tr>
                            <td style="width: 31%">
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Make:</span> <span class="left2">
                                        <asp:UpdatePanel ID="updtMake" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlMake" runat="server" AutoPostBack="true" Enabled="false"
                                                    OnSelectedIndexChanged="ddlMake_SelectedIndexChanged" onchange="ChangeValuesHidden()">
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
                                        <asp:DropDownList ID="ddlYear" runat="server" Enabled="false">
                                        </asp:DropDownList>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left"><span class="star">*</span>Price:</span> <span class="left2">
                                        <asp:TextBox ID="txtAskingPrice" runat="server" MaxLength="6" Enabled="false" class="sample4"
                                            onkeypress="return isNumberKey(event);"></asp:TextBox></span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Mileage:</span> <span class="left2">
                                        <asp:TextBox ID="txtMileage" runat="server" MaxLength="6" class="sample4" Enabled="false"
                                            onkeypress="return isNumberKey(event);"></asp:TextBox></span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Cylinders:</span> <span class="left2">
                                        <asp:TextBox ID="txtcylindars" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Body style:</span> <span class="left2">
                                        <asp:TextBox ID="txtBodyStyle" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Exterior color:</span> <span class="left2">
                                        <asp:TextBox ID="txtExteriorColor" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Interior color:</span> <span class="left2">
                                        <asp:TextBox ID="txtInteriorColor" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Transmission:</span> <span class="left2">
                                        <asp:TextBox ID="txttransm" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Doors:</span> <span class="left2">
                                        <asp:TextBox ID="txtdoors" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Drive train:</span> <span class="left2">
                                        <asp:TextBox ID="txtDrive" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h4 class="field">
                                    <span class="left">Fuel type:</span> <span class="left2">
                                        <asp:TextBox ID="txtFuelType" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">Condition:</span> <span class="left2">
                                        <asp:TextBox ID="txtCondition" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <h4 class="field">
                                    <span class="left">VIN #:</span> <span class="left2">
                                        <asp:TextBox ID="txtVin" runat="server" Enabled="false" Style="width: 409px" MaxLength="20"></asp:TextBox></span>
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
                <h1 class="hed1 hed2">
                    VEHICLE FEATURES
                    <div class="pull-right barControl">
                        <span class="bar0"></span>
                    </div>
                </h1>
                <div class="inn" class="hidden" id="feat">
                    <!-- Start  -->
                    <table class="table3">
                        <tr>
                            <td style="width: 120px;">
                                <label class="hed2">
                                    Comfort:</label>
                            </td>
                            <td style="font-weight: bold; color: #666;">
                                <asp:CheckBox ID="chkFeatures51" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">A/C</span>
                                <asp:CheckBox ID="chkFeatures1" runat="server" Enabled="false" class="noLM" />
                                <span class="featNon">A/C: Front</span>
                                <asp:CheckBox ID="chkFeatures2" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">A/C: Rear</span>
                                <asp:CheckBox ID="chkFeatures3" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Cruise control</span>
                                <asp:CheckBox ID="chkFeatures4" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Navigation system</span>
                                <asp:CheckBox ID="chkFeatures5" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Power locks</span>
                                <asp:CheckBox ID="chkFeatures6" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Power steering</span>
                                <br />
                                <asp:CheckBox ID="chkFeatures7" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Remote keyless entry</span>
                                <asp:CheckBox ID="chkFeatures8" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">TV/VCR</span>
                                <asp:CheckBox ID="chkFeatures31" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Remote start</span>
                                <asp:CheckBox ID="chkFeatures33" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Tilt</span>
                                <asp:CheckBox ID="chkFeatures35" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Rearview camera</span>
                                <asp:CheckBox ID="chkFeatures36" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Power mirrors</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Seats:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures9" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Bucket seats</span>
                                <asp:CheckBox ID="chkFeatures11" runat="server" Enabled="false" />
                                <span class="featNon">Memory seats</span>
                                <asp:CheckBox ID="chkFeatures12" runat="server" Enabled="false" />
                                <span class="featNon">Power seats</span>
                                <asp:CheckBox ID="chkFeatures32" runat="server" Enabled="false" />
                                <span class="featNon">Heated seats</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Interior:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:RadioButton ID="rdbtnLeather" runat="server" CssClass="noLM" GroupName="Seats"
                                    Text="" Enabled="false" /><span class="featNon">Leather</span>
                                <asp:RadioButton ID="rdbtnVinyl" runat="server" CssClass="noLM" GroupName="Seats"
                                    Text="" Enabled="false" /><span class="featNon">Vinyl</span>
                                <asp:RadioButton ID="rdbtnCloth" runat="server" CssClass="noLM" GroupName="Seats"
                                    Text="" Enabled="false" /><span class="featNon">Cloth</span>
                                <asp:RadioButton ID="rdbtnInteriorNA" runat="server" CssClass="noLM" GroupName="Seats"
                                    Text="" Checked="false" Enabled="false" /><span class="featNon">NA</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Safety:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures13" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Airbag: Driver</span>
                                <asp:CheckBox ID="chkFeatures14" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Airbag: Passenger</span>
                                <asp:CheckBox ID="chkFeatures15" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Airbag: Side</span>
                                <asp:CheckBox ID="chkFeatures16" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Alarm</span>
                                <asp:CheckBox ID="chkFeatures17" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Anti-lock brakes</span>
                                <asp:CheckBox ID="chkFeatures18" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Fog lights</span>
                                <asp:CheckBox ID="chkFeatures39" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Power brakes</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Sound System:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures19" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Cassette radio</span>
                                <asp:CheckBox ID="chkFeatures20" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">CD changer</span>
                                <asp:CheckBox ID="chkFeatures21" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">CD player</span>
                                <asp:CheckBox ID="chkFeatures22" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Premium sound</span>
                                <asp:CheckBox ID="chkFeatures34" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">AM/FM</span>
                                <asp:CheckBox ID="chkFeatures40" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">DVD</span>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    New:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures44" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Battery</span>
                                <asp:CheckBox ID="chkFeatures45" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Tires</span>
                                <asp:CheckBox ID="chkFeatures52" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Rotors</span>
                                <asp:CheckBox ID="chkFeatures53" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Brakes</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Windows:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures23" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Power windows</span>
                                <asp:CheckBox ID="chkFeatures24" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Rear window defroster</span>
                                <asp:CheckBox ID="chkFeatures25" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Rear window wiper</span>
                                <asp:CheckBox ID="chkFeatures26" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Tinted glass</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="hed2">
                                    Others:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures27" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Alloy wheels</span>
                                <asp:CheckBox ID="chkFeatures28" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Sunroof</span>
                                <asp:CheckBox ID="chkFeatures41" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Panoramic roof</span>
                                <asp:CheckBox ID="chkFeatures42" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Moonroof</span>
                                <asp:CheckBox ID="chkFeatures29" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Third row seats</span>
                                <asp:CheckBox ID="chkFeatures30" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Tow package</span>
                                <br />
                                <asp:CheckBox ID="chkFeatures43" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Dashboard wood frame</span>
                            </td>
                        </tr>
                        <tr class="last">
                            <td>
                                <label class="hed2">
                                    Specials:</label>
                            </td>
                            <td class="chkLabel">
                                <asp:CheckBox ID="chkFeatures46" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Garage kept</span>
                                <asp:CheckBox ID="chkFeatures47" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Non smoking</span>
                                <asp:CheckBox ID="chkFeatures48" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Records/Receipts kept</span>
                                <asp:CheckBox ID="chkFeatures49" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Well maintained</span>
                                <asp:CheckBox ID="chkFeatures50" runat="server" class="noLM" Enabled="false" />
                                <span class="featNon">Regular oil changes</span>
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
                    <h4 class="field tbl4">
                        <span class="left2 noMrg onlyRead">
                            <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000" Style="width: 99%;
                                height: 75px; resize: none;" TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false"
                                Enabled="false"></asp:TextBox></span>
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
                    <table class=" table2 tbl4">
                        <tr>
                            <td style="vertical-align: top;">
                                <h4 class="field">
                                    <span class="left2 noMrg onlyRead">
                                        <asp:TextBox ID="txtSaleNotes" runat="server" TextMode="MultiLine" MaxLength="1000"
                                            Style="width: 99%; height: 105px; resize: none;" CssClass="textAr" data-plus-as-tab="false"
                                            Enabled="false"> </asp:TextBox></span>
                                </h4>
                            </td>
                            <td style="width: 40px;">
                                &nbsp;
                            </td>
                            <td style="width: 350px; vertical-align: text-bottom;">
                                <h4 class="field">
                                    <span class="left">Source of photos:</span> <span class="left2">
                                        <asp:TextBox ID="txtPhotosSource" runat="server" Enabled="false"></asp:TextBox>
                                    </span>
                                </h4>
                                <h4 class="field">
                                    <span class="left">Source of description:</span> <span class="left2">
                                        <asp:TextBox ID="txtDescriptionSource" runat="server" Enabled="false"></asp:TextBox>
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
                    <table style="width: 350px;" class=" table2 tbl4">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="updtpnlPaymentDetails" runat="server">
                                    <ContentTemplate>
                                        <h4 class="field">
                                            <label class="left">
                                                Pay method:</label>
                                            <span class="left2">
                                                <asp:DropDownList ID="ddlpayme" runat="server" AutoPostBack="true" Enabled="false">
                                                    <asp:ListItem Value="0">Visa</asp:ListItem>
                                                    <asp:ListItem Value="1">Mastercard</asp:ListItem>
                                                    <asp:ListItem Value="2">Discover</asp:ListItem>
                                                    <asp:ListItem Value="3">Amex</asp:ListItem>
                                                    <asp:ListItem Value="4">Paypal</asp:ListItem>
                                                    <asp:ListItem Value="5">Check</asp:ListItem>
                                                </asp:DropDownList>
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
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <div class="clear">
                        &nbsp;</div>
                    <br />
                    <!-- Card Details Start -->
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="divcard" class="editInputStyle" runat="server">
                                <fieldset class="filedSet">
                                    <legend>Card Details <span>
                                        <asp:LinkButton ID="lnkbtnCopySellerInfo" runat="server" Text="Copy name & address from Seller Information"
                                            OnClientClick="return CopySellerInfo();" Style="color: Blue; text-decoration: underline;"></asp:LinkButton>
                                    </legend>
                                    <div class="inn">
                                        <table class=" table2 tbl4">
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span><strong>Card Holder First Name:</strong></label>
                                                        <span class="left2">
                                                            <asp:HiddenField ID="CardType" runat="server" />
                                                            <asp:TextBox ID="txtCardholderName" runat="server" MaxLength="25" Style="width: 170px;"
                                                                Enabled="false" />
                                                            <label>
                                                                <span class="star">*</span>Last Name:</label>
                                                            <asp:TextBox ID="txtCardholderLastName" runat="server" MaxLength="25" Style="width: 110px"
                                                                Enabled="false" />
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
                                                            <asp:TextBox ID="txtbillingaddress" runat="server" MaxLength="40" Enabled="false"></asp:TextBox></span>
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
                                                                onblur="return CreditCardOnblur();" Enabled="false" /></span>
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
                                                            <asp:TextBox ID="txtbillingcity" runat="server" MaxLength="40" Enabled="false"></asp:TextBox></span>
                                                    </h4>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h4 class="field">
                                                        <label class="left">
                                                            <span class="star">*</span>Expiry Date:</label>
                                                        <span class="left2">
                                                            <asp:TextBox ID="txtExpMon" runat="server" Enabled="false" Width="30px" />
                                                            /
                                                            <%--  <asp:DropDownList ID="CCExpiresYear" Style="width: 120px" runat="server" Enabled="false">
                                                                            </asp:DropDownList>--%>
                                                            <asp:TextBox ID="txtCCExpiresYear" runat="server" Enabled="false" Width="120px" />
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
                                                            <asp:TextBox ID="txtbillingstate" runat="server" Enabled="false" Width="120px"></asp:TextBox>
                                                            <label>
                                                                <span class="star">*</span>ZIP:</label>&nbsp;
                                                            <asp:TextBox ID="txtbillingzip" runat="server" Style="width: 74px" MaxLength="5"
                                                                Enabled="false" onkeypress="return isNumberKey(event)" onblur="return billingZipOnblur();"></asp:TextBox>
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
                                                    <h4 class="h4">
                                                        <span class="star" style="color: Red">*</span><strong style="width: 40px">CVV#</strong>
                                                        <asp:TextBox ID="cvv" MaxLength="4" Style="width: 87%; margin-left: 5px;" runat="server"
                                                            Enabled="false" onkeypress="return isNumberKey(event)" onblur="return CVVOnblur(); " />
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
                                <table border="0" cellpadding="4" cellspacing="4" style="width: 98%; margin: 0;"
                                    class=" table2 tbl4">
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
                                                                <asp:TextBox ID="txtCustNameForCheck" runat="server" MaxLength="50" Enabled="false"></asp:TextBox>
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
                                                                <asp:TextBox ID="txtAccNumberForCheck" runat="server" MaxLength="20" Enabled="false"></asp:TextBox></span>
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
                                                                <asp:TextBox ID="txtBankNameForCheck" runat="server" MaxLength="50" Enabled="false"></asp:TextBox></span>
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
                                                                <asp:TextBox ID="txtRoutingNumberForCheck" runat="server" MaxLength="9" Enabled="false"></asp:TextBox></span>
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
                                                                <asp:DropDownList ID="ddlAccType" runat="server" Enabled="false">
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
                                <table width="100%" class=" table2 tbl4">
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
                                                                    <asp:TextBox ID="txtPaytransID" runat="server" MaxLength="30" Style="width: 76%;"
                                                                        Enabled="false"></asp:TextBox>
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
                                                                        Style="width: 72%;" Enabled="false"></asp:TextBox>
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
                        <div class="inn editInputStyle">
                            <table style="width: 71%" class=" table2 tbl4">
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
                                                    onkeyup="return ChangeValuesHidden()" Enabled="false" Style="width: 72%;"></asp:TextBox>
                                            </span>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="field">
                                            <label class="left" style="width: 175px">
                                                PD Payment Date:</label>
                                            <span class="left2"><span class="star" style="color: Red">*</span><asp:CheckBox ID="chkboxlstPDsale"
                                                runat="server" CssClass="noLM" />
                                                <asp:TextBox ID="txtPDDate" runat="server" ReadOnly="true" Enabled="false" ForeColor="Red"
                                                    Style="width: 137px"></asp:TextBox>
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
                                                <asp:TextBox ID="txtTotalAmount" ReadOnly="true" runat="server" Enabled="false"></asp:TextBox>
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
                    <div class="editInputStyle">
                        <table class=" table2 tbl4">
                            <tr>
                                <td style="width: 25%">
                                    <h4 class="field">
                                        <label class="left">
                                            <span class="star">*</span>Voice file confirmation #:</label>
                                        <span class="left2">
                                            <asp:TextBox ID="txtVoicefileConfirmNo" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                        </span>
                                    </h4>
                                </td>
                                <td style="width: 3%;">
                                    &nbsp;
                                </td>
                                <td style="width: 25%">
                                    <h4 class="field">
                                        <label class="left">
                                            <span class="star">*</span>Voice file Location :</label>
                                        <span class="left2">
                                            <asp:TextBox ID="txtVoiceFileLocation" runat="server" Enabled="false"></asp:TextBox>
                                        </span>
                                    </h4>
                                </td>
                                <td style="width: 3%;">
                                    &nbsp;
                                </td>
                                <td style="padding: 0; width: 20%">
                                    <asp:DropDownList ID="ddlPmntStatus" runat="server" Font-Size="14px" Font-Bold="true"
                                        ForeColor="#2B4BB1" onchange="return PayInfoChanges();" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0">Select Pmnt Status</asp:ListItem>
                                        <asp:ListItem Value="3">Pending</asp:ListItem>
                                        <asp:ListItem Value="1">FullyPaid</asp:ListItem>
                                        <asp:ListItem Value="5">Returned</asp:ListItem>
                                        <asp:ListItem Value="2">Reject</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 3%;">
                                    &nbsp;
                                </td>
                                <td>
                                    <div style="margin: 7px 0 0 0;">
                                        <%--<input type="submit" name="btnSale" value="Process" onclick="return ValidateSavedData();"
                                                                    id="btnprocess" class="g-button g-button-submit">--%>
                                        &nbsp;
                                        <asp:Button ID="btnPmntUpdate" runat="server" CssClass="btn btn-warning btn-xs" Text="Pmnt Update"
                                            OnClientClick="return PmntValidation();" OnClick="btnPmntUpdate_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnProcess" runat="server" Text="Process" CssClass="btn btn-warning btn-xs"
                                            Visible="true" Enabled="false" OnClick="btnProcess_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnCheckProcess" runat="server" Text="Process" CssClass="btn btn-warning btn-xs"
                                            Visible="true" Enabled="false" OnClick="btnCheckProcess_Click" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td id="divReason" runat="server" style="display: none;">
                                    <div style="width: 500px; float: right; margin: 0 auto 10px auto; clear: both; text-align: right">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 21%; padding-left: 110px;">
                                                    <b>Reason</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlPayCancelReason" runat="server" CssClass="input1" Font-Size="14px"
                                                        Font-Bold="true" ForeColor="#2B4BB1" Enabled="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- Voice file confirmation Emd -->
                    <div class="clear">
                        &nbsp;</div>
                    <div class=" box1 boxBlue">
                        <h1 class="hed1 hed2">
                            Payment Notes</h1>
                        <div class="inn">
                            <table class=" table2 tbl4">
                                <tr>
                                    <td colspan="5" style="padding-top: 5px;">
                                        <h2 class="h200" style="margin-top: 0">
                                            <div class="close">
                                            </div>
                                        </h2>
                                        <div class="hidden">
                                            <fieldset style="height: 150px;">
                                                <!-- <legend>Vehicle Description</legend>  -->
                                                <%--  <textarea style="width: 99%; height: 75px; resize: none;"></textarea>--%>
                                                <asp:TextBox ID="txtPaymentNotes" runat="server" Style="width: 99%; height: 65px;
                                                    resize: none;" TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false"
                                                    Enabled="false"></asp:TextBox>
                                                <div style="height: 5px;">
                                                    &nbsp;</div>
                                                <asp:TextBox ID="txtPaymentNotesNew" runat="server" MaxLength="1000" Style="width: 99%;
                                                    height: 45px; resize: none;" TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false"></asp:TextBox>
                                            </fieldset>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="clear">
                        &nbsp;</div>
                    <div class=" box1 boxBlue">
                        <h1 class="hed1 hed2">
                            QC Notes</h1>
                        <div class="inn">
                            <table class=" table2 tbl4">
                                <tr>
                                    <td colspan="5" style="padding-top: 5px;">
                                        <h2 class="h200" style="margin-top: 0">
                                            <div class="close">
                                            </div>
                                        </h2>
                                        <div class="hidden">
                                            <fieldset style="height: 150px;">
                                                <!-- <legend>Vehicle Description</legend>  -->
                                                <%--  <textarea style="width: 99%; height: 75px; resize: none;"></textarea>--%>
                                                <asp:TextBox ID="txtOldQcNotes" runat="server" Style="width: 99%; height: 65px; resize: none;"
                                                    TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false" Enabled="false"></asp:TextBox>
                                                <div style="height: 5px;">
                                                    &nbsp;</div>
                                                <asp:TextBox ID="txtQCNotes" runat="server" MaxLength="1000" Style="width: 99%; height: 45px;
                                                    resize: none;" TextMode="MultiLine" CssClass="textAr" data-plus-as-tab="false"
                                                    Enabled="false"></asp:TextBox>
                                            </fieldset>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br />
                </div>
            </div>
            <!-- PAYMENT DETAILS End  -->
            <div class="clear">
                &nbsp;</div>
        </div>
        <!-- Content End  -->
        <!-- Content End  -->
        <div class="clear">
            &nbsp;</div>
    </div>
    <!-- Main Wrapper Emd  -->
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    <cc1:ModalPopupExtender ID="mdepNoTransHis" runat="server" PopupControlID="divNoTransHIs"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnNoTransHis" OkControlID="btnNotransClose1"
        CancelControlID="btnNotransClose2">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnNoTransHis" runat="server" />
    <div id="divNoTransHIs" class="alert" style="display: none">
        <h4 id="H6">
            Alert
            <asp:Button ID="btnNotransClose1" class="cls" runat="server" Text="" BorderWidth="0"
                Enabled="false" />
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="data">
            <p>
                <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblNotransError" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnNotransClose2" class="btn" runat="server" Text="Ok" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mdepAlertRejectThere" runat="server" PopupControlID="divRejectThere"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnRejectThere" OkControlID="btnRejectThereNo">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnRejectThere" runat="server" />
    <div id="divRejectThere" class="alert" style="display: none">
        <h4 id="H7">
            Alert
            <%--<asp:Button ID="btnDiv" class="cls" runat="server" Text="" BorderWidth="0" />--%>
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="data">
            <p>
                <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblRejectThereError" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="clear">
                </div>
            </p>
            <asp:Button ID="btnRejectThereNo" class="btn" runat="server" Text="No" />
            &nbsp;
            <asp:Button ID="btnRejectThereYes" class="btn" runat="server" Text="Yes" OnClick="btnRejectThereYes_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="MdepAddAnotherCarAlert" runat="server" PopupControlID="divAddAnotherCarAlert"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAddAnotherCarAlert" OkControlID="btnAddAnotherCarNo">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAddAnotherCarAlert" runat="server" />
    <div id="divAddAnotherCarAlert" class="alert" style="display: none">
        <h4 id="H8">
            Alert
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="data">
            <p>
                <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblAddAnotherCarAlertError" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnAddAnotherCarNo" class="btn" runat="server" Text="No" />&nbsp;
            <asp:Button ID="btnAddAnotherCarYes" class="btn" runat="server" Text="Yes" OnClick="btnAddAnotherCarYes_Click" />
        </div>
    </div>
    <!-- Agent Update -->
    <cc1:ModalPopupExtender ID="MdlPopAgentUpdate" runat="server" PopupControlID="tblUpdate13"
        BackgroundCssClass="ModalPopupBG" TargetControlID="lnkAgentUpdate1">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="lnkAgentUpdate1" runat="server" />
    <div id="tblUpdate13" class="popup" style="display: none;">
        <h2>
            Agent Update
        </h2>
        <div class="content" style="padding: 0 0 0 6; height: 280px; width: 300px;">
            <table id="Table10" runat="server" align="center" cellpadding="0" cellspacing="0"
                style="width: 90%; margin: 0 auto;">
                <tr>
                    <td style="width: 100%;">
                        <asp:UpdatePanel ID="UpdatePanel17" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 98%; margin: 0 auto;"
                                    class="noPad">
                                    <tr>
                                        <td>
                                            <table width="100%" style="margin-top: 10px;">
                                                <tr>
                                                    <td>
                                                        <b>SaleId:</b>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="qccarid" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <b>Agent: </b>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblactualAgent" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Change Agent
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlAgentUpdate" runat="server" Font-Size="14px" Font-Bold="true"
                                                ForeColor="#2B4BB1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="AgentUdfate" CssClass="btn btn-warning btn-sm" runat="server" Text="Update"
                                                OnClick="AgentUdfate_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="Button7" CssClass="btn btn-warning btn-sm" runat="server" Text="Close"
                                                OnClientClick="return ClosePopup9();" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                                </td> </tr> </table> </div>
                                <!-- paypal End  -->
                                <div class="clear">
                                    &nbsp;</div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <div class="clearFix">
                &nbsp</div>
        </div>
        <div class="clear">
            &nbsp;</div>
        <div class="clear">
            &nbsp;</div>
    </div>
    <!-- Verifier Update -->
    <cc1:ModalPopupExtender ID="MdlPopVerifier" runat="server" PopupControlID="tblUpdate14"
        BackgroundCssClass="ModalPopupBG" TargetControlID="lnkVerifierName1">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="lnkVerifierName1" runat="server" />
    <div id="tblUpdate14" class="popup" style="display: none;">
        <h2>
            Agent Update
        </h2>
        <div class="content" style="padding: 0 0 0 6; height: 280px; width: 300px;">
            <table id="Table1" runat="server" align="center" cellpadding="0" cellspacing="0"
                style="width: 90%; margin: 0 auto;">
                <tr>
                    <td style="width: 100%;">
                        <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 98%; margin: 0 auto;"
                                    class="noPad">
                                    <tr>
                                        <td>
                                            <table width="100%" style="margin-top: 10px;">
                                                <tr>
                                                    <td>
                                                        <b>SaleId:</b>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblVerSaleId" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <b>Verifier: </b>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblVerName" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Change Verifier
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlVerifierUpdate" runat="server" Font-Size="14px" Font-Bold="true"
                                                ForeColor="#2B4BB1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="VUpdate" CssClass="btn btn-warning btn-sm" runat="server" Text="Update"
                                                OnClick="VUpdate_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="Button2" CssClass="btn btn-warning btn-sm" runat="server" Text="Close"
                                                OnClientClick="return ClosePopup10();" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                                </td> </tr> </table> </div>
                                <!-- paypal End  -->
                                <div class="clear">
                                    &nbsp;</div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <div class="clearFix">
                &nbsp</div>
        </div>
        <div class="clear">
            &nbsp;</div>
        <div class="clear">
            &nbsp;</div>
    </div>
    <!-- Leads Details form -->
    <cc1:ModalPopupExtender ID="MDLPOPLeadsPhn" runat="server" PopupControlID="tblUpdate61"
        BackgroundCssClass="ModalPopupBG" TargetControlID="HdnLeadsPhn">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="HdnLeadsPhn" runat="server" />
    <div id="tblUpdate61" class="PopUpHolder" style="display: none;">
        <div class="popup" style="height: 160px; margin-top: 70px; width: 250px">
            <h4>
                Enter Phone Number
                <!-- <div class="cls">
            </div> -->
            </h4>
            <div class="content" style="padding: 0 0 0 3; height: 120px;">
                <table id="Table7" runat="server" align="center" cellpadding="0" cellspacing="0"
                    style="width: 100%; margin: 0 auto;">
                    <tr>
                        <td style="width: 100%;">
                            <asp:UpdatePanel ID="UpdatePanel40" runat="server">
                                <ContentTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 98%; margin: 0 auto;"
                                        class="noPad">
                                        <tr>
                                            <td>
                                                <table width="100%" style="margin-top: 10px;">
                                                    <tr>
                                                        <td style="width: 100px;">
                                                            <b>Phone #:</b> &nbsp;
                                                        </td>
                                                        <td style="width: 200px;">
                                                            <asp:TextBox ID="txtLoadPhone" runat="server" MaxLength="10" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                    <!-- paypal End  -->
                                    <div class="clear">
                                        &nbsp;</div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel41" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr align="center">
                                            <td colspan="4" style="padding-top: 15px;">
                                                <div style="width: 240px; margin: 0 auto;">
                                                    <asp:Button ID="btnPhoneOk" runat="server" Text="Ok" CssClass="btn btn-warning btn-sm"
                                                        OnClick="btnPhoneOk_Click" OnClientClick="return ValidatePhone();" />
                                                    <asp:Button ID="Button8" CssClass="btn btn-warning btn-sm" runat="server" Text="Close"
                                                        OnClientClick="return ClosePopup21();" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                <div class="clearFix">
                    &nbsp</div>
            </div>
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mpeaSalesData" runat="server" PopupControlID="divViewregisterMail"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnViewregisterMail" CancelControlID="BtnClsSendRegMail">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnViewregisterMail" runat="server" />
    <div id="divViewregisterMail" class="PopUpHolder">
        <div class="popup" style="width: 1120px">
            <h4>
                Payment Transaction History
                <asp:LinkButton ID="BtnClsSendRegMail" runat="server" Text="Close" BorderWidth="0"
                    CssClass="close"></asp:LinkButton>
                <!-- <div class="cls">
            </div> -->
            </h4>
            <div class="content" style="padding: 0 10px; width: 98%;">
                <asp:UpdatePanel ID="updtpnlHistory" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%; margin: 10px 0;">
                            <tr>
                                <td style="vertical-align: top;">
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                            <div>
                                                <b>Sale ID:&nbsp;<asp:Label ID="lblPayTransSaleID" runat="server"></asp:Label></b>
                                            </div>
                                            <div style="width: 100%">
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <div style="width: 100%;" id="divresults" runat="server">
                                        <div style="width: 100%; position: relative; padding: 0 3px; height: 1px">
                                            <asp:UpdatePanel ID="UpdtpnlHeader" runat="server">
                                                <ContentTemplate>
                                                    <table class="grid1 gridBoldHed" cellpadding="0" cellspacing="0" style="position: absolute;
                                                        top: 2px; padding-top: 2px; width: 1070px; background: #fff;">
                                                        <tr class="tbHed">
                                                            <td width="110px" align="left">
                                                                Trans Dt
                                                            </td>
                                                            <td align="left" width="90px">
                                                                Trans By
                                                            </td>
                                                            <td width="80px" align="left">
                                                                Card Type
                                                            </td>
                                                            <td width="60px" align="left">
                                                                Card #
                                                            </td>
                                                            <td width="110px" align="left">
                                                                First Name
                                                            </td>
                                                            <td width="110px" align="left">
                                                                Last Name
                                                            </td>
                                                            <td width="110px" align="left">
                                                                Address
                                                            </td>
                                                            <td width="80px" align="left">
                                                                City
                                                            </td>
                                                            <td width="50px" align="left">
                                                                State
                                                            </td>
                                                            <td width="55px" align="left">
                                                                Zip
                                                            </td>
                                                            <td width="70px" align="left">
                                                                Amount
                                                            </td>
                                                            <td align="left">
                                                                Result
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <div style="width: 1090px; overflow-y: scroll; overflow-x: hidden; padding: 26px 3px 3px 3px;
                                            border: #ccc 1px solid; height: 300px">
                                            <asp:Panel ID="Panel1" Width="100%" runat="server">
                                                <asp:UpdatePanel ID="updtpanelGridPopup" runat="server">
                                                    <ContentTemplate>
                                                        <input style="width: 91px" id="Hidden1" type="hidden" runat="server" enableviewstate="true" />
                                                        <input style="width: 40px" id="Hidden2" type="hidden" runat="server" enableviewstate="true" />
                                                        <asp:GridView Width="1070px" ID="grdIntroInfo" runat="server" CellSpacing="0" CellPadding="0"
                                                            CssClass="grid1" AutoGenerateColumns="False" GridLines="None" ShowHeader="false"
                                                            OnRowDataBound="grdIntroInfo_RowDataBound">
                                                            <PagerStyle HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                                                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle CssClass="tbHed" />
                                                            <PagerSettings Position="Top" />
                                                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                            <RowStyle CssClass="row1" />
                                                            <AlternatingRowStyle CssClass="row2" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransDt" runat="server" Text='<%# Bind("PayTryDatetime", "{0:MM/dd/yy hh:mm tt}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransBy" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"AgentUserName"),11)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="90px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransCardType" runat="server" Text='<%# Eval("CardType")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransCardNum" runat="server"></asp:Label>
                                                                        <asp:HiddenField ID="hdnTransCardNum" runat="server" Value='<%# Eval("CardNumber")%>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="60px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransFirstName" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"CCFirstName"),15)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransLastName" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"CCLastName"),15)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransAddress" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"Address"),15)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransCity" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"City"),10)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransState" runat="server" Text='<%# Eval("State")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="50px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransZip" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"Zip"),5)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="55px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransAmount" runat="server" Text='<%# Eval("Amount")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="70px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTransResult" runat="server" Text='<%# Eval("Result")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="grdIntroInfo" EventName="Sorting" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </asp:Panel>
                                        </div>
                                        <div class="clear" style="height: 12px;">
                                            &nbsp;</div>
                                    </div>
                                    <div style="width: 100%;" id="divCheckResults" runat="server">
                                        <div style="width: 100%; position: relative; padding: 0 3px; height: 1px">
                                            <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                <ContentTemplate>
                                                    <table class="grid1 gridBoldHed" cellpadding="0" cellspacing="0" style="position: absolute;
                                                        top: 2px; padding-top: 2px; width: 1070px; background: #fff;">
                                                        <tr class="tbHed">
                                                            <td width="110px" align="left">
                                                                Trans Dt
                                                            </td>
                                                            <td align="left" width="90px">
                                                                Trans By
                                                            </td>
                                                            <td width="80px" align="left">
                                                                Acc Type
                                                            </td>
                                                            <td width="130px" align="left">
                                                                Acc #
                                                            </td>
                                                            <td width="130px" align="left">
                                                                Acc Holder Name
                                                            </td>
                                                            <td width="110px" align="left">
                                                                Address
                                                            </td>
                                                            <td width="80px" align="left">
                                                                City
                                                            </td>
                                                            <td width="50px" align="left">
                                                                State
                                                            </td>
                                                            <td width="55px" align="left">
                                                                Zip
                                                            </td>
                                                            <td width="70px" align="left">
                                                                Amount
                                                            </td>
                                                            <td align="left">
                                                                Result
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <div style="width: 1090px; overflow-y: scroll; overflow-x: hidden; padding: 26px 3px 3px 3px;
                                            border: #ccc 1px solid; height: 300px">
                                            <asp:Panel ID="Panel2" Width="100%" runat="server">
                                                <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                                    <ContentTemplate>
                                                        <input style="width: 91px" id="Hidden3" type="hidden" runat="server" enableviewstate="true" />
                                                        <input style="width: 40px" id="Hidden4" type="hidden" runat="server" enableviewstate="true" />
                                                        <asp:GridView Width="1070px" ID="grdCheckResults" runat="server" CellSpacing="0"
                                                            CellPadding="0" CssClass="grid1" AutoGenerateColumns="False" GridLines="None"
                                                            ShowHeader="false" OnRowDataBound="grdCheckResults_RowDataBound">
                                                            <PagerStyle HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                                                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle CssClass="tbHed" />
                                                            <PagerSettings Position="Top" />
                                                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                            <RowStyle CssClass="row1" />
                                                            <AlternatingRowStyle CssClass="row2" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransDt" runat="server" Text='<%# Bind("PayTryDatetime", "{0:MM/dd/yy hh:mm tt}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransBy" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"AgentUserName"),11)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="90px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransAccType" runat="server" Text='<%# Eval("AccountType")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransAccNum" runat="server"></asp:Label>
                                                                        <asp:HiddenField ID="hdnCheckTransAccNum" runat="server" Value='<%# Eval("AccountNumber")%>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="130px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckAccHolderName" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"AccountHolderName"),15)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="130px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransAddress" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"Address"),15)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="110px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransCity" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"City"),10)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransState" runat="server" Text='<%# Eval("State")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="50px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransZip" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"Zip"),5)%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="55px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransAmount" runat="server" Text='<%# Eval("Amount")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="70px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCheckTransResult" runat="server" Text='<%# Eval("Result")%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="grdCheckResults" EventName="Sorting" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </asp:Panel>
                                        </div>
                                        <div class="clear" style="height: 12px;">
                                            &nbsp;</div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="clear">
                &nbsp;</div>
        </div>
        <div class="clear">
            &nbsp;</div>
    </div>
    <!-- end -->
    <cc1:ModalPopupExtender ID="mpealteruserUpdated" runat="server" PopupControlID="AlertUserUpdated"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAlertuserUpdated">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAlertuserUpdated" runat="server" />
    <div id="AlertUserUpdated" class="popup" style="display: none">
        <h4>
            Alert
            <asp:Button ID="BtnClsUpdated" class="cls" runat="server" Text="" BorderWidth="0"
                OnClick="BtnClsUpdated_Click" />
            <!-- <div class="cls">
            </div> -->
        </h4>
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
    <cc1:ModalPopupExtender ID="mpealteruser" runat="server" PopupControlID="AlertUser"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAlertuser">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAlertuser" runat="server" />
    <div id="AlertUser" class="alert" style="display: none">
        <h4>
            Alert
            <%--<asp:Button ID="BtnCls" class="cls" runat="server" Text="" BorderWidth="0" OnClick="btnNo_Click" />--%>
            <!-- <div class="cls"> </div> -->
        </h4>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="updpnlMsgUser1" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:RadioButton ID="rdbtnPmntPending" runat="server" Text="Pending" CssClass="noLM"
                GroupName="PmntStatus" Checked="true" />
            <asp:RadioButton ID="rdbtnPmntReject" runat="server" Text="Reject" CssClass="noLM"
                GroupName="PmntStatus" />
            <asp:RadioButton ID="rdbtnPmntReturned" runat="server" Text="Returned" CssClass="noLM"
                GroupName="PmntStatus" />
            &nbsp;
            <asp:Button ID="btnUpdate" class="btn" runat="server" Text="Update" OnClick="btnUpdate_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mdepalertMoveSmartz" runat="server" PopupControlID="divdraftPhone"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdndraftPhNo">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdndraftPhNo" runat="server" />
    <div id="divdraftPhone" class="alert" style="display: none">
        <h4>
            Alert
            <%--<asp:Button ID="btnDiv" class="cls" runat="server" Text="" BorderWidth="0" />--%>
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblMoveSmartz" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="clear">
                </div>
            </p>
            <asp:Button ID="btnMoveSmartzNo" class="btn" runat="server" Text="No" OnClick="btnMoveSmartzNo_Click" />
            &nbsp;
            <asp:Button ID="btnMoveSmartzYes" class="btn" runat="server" Text="Yes" OnClick="MoveSmartz_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mdepAlertExists" runat="server" PopupControlID="divExists"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnExists">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnExists" runat="server" />
    <div id="divExists" class="alert" style="display: none">
        <h4>
            Alert
            <asp:Button ID="btnExustCls" class="cls" runat="server" Text="" BorderWidth="0" OnClick="btnNo_Click" />
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErrorExists" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnOk" class="btn" runat="server" Text="Ok" OnClick="btnNo_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mpealteruserUpdatedSmartz" runat="server" PopupControlID="AlertUserUpdatedSmartz"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAlertuserUpdatedSmartz">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAlertuserUpdatedSmartz" runat="server" />
    <div id="AlertUserUpdatedSmartz" class="alert" style="display: none">
        <h4>
            Alert
            <asp:Button ID="btnYesUpdatedSmartz1" class="cls" runat="server" Text="" BorderWidth="0"
                OnClick="btnYesUpdatedSmartz1_Click" />
            <!-- <div class="cls">
            </div> -->
        </h4>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErrUpdatedSmartz" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnYesUpdatedSmartz2" class="btn" runat="server" Text="Ok" OnClick="btnYesUpdatedSmartz1_Click" />
        </div>
    </div>
    <!-- Leads Se4arch form -->
    <cc1:ModalPopupExtender ID="MdlPopLeadDetails" runat="server" PopupControlID="tblUpdate62"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnLeadDetails">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnLeadDetails" runat="server" />
    <div id="tblUpdate62" class="PopUpHolder" style="display: none;">
        <div class="main" style="height: 600px; margin-top: 70px; width: 750px">
            <h4>
                Lead Details Form
                <!-- <div class="cls">
            </div> -->
            </h4>
            <div class="content" style="padding: 0 0 0 3; height: 120px;">
                <table id="Table11" runat="server" align="center" cellpadding="0" cellspacing="0"
                    style="width: 100%; margin: 0 auto;">
                    <tr>
                        <td style="width: 100%;">
                            <asp:UpdatePanel ID="UpdatePanel42" runat="server">
                                <ContentTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 98%; margin: 0 auto;"
                                        class="noPad">
                                        <tr>
                                            <td>
                                                <table width="100%" style="margin-top: 10px;">
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>Phone #:</b>
                                                            <asp:Label ID="txtLeadPhnDeta" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>Lead Date :</b>
                                                            <asp:Label ID="lblLeaddate" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>Price:</b>
                                                            <asp:Label ID="lblLeadPrice" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>Model:</b>
                                                            <asp:Label ID="lblLeadModel" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>State:</b>
                                                            <asp:Label ID="lblLeadState" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;">
                                                            <b>City:</b>
                                                            <asp:Label ID="lblLeadCity" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;" colspan="2">
                                                            <b>CusEmailId:</b>
                                                            <asp:Label ID="lblLeadEmail" runat="server" MaxLength="10"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;" colspan="2">
                                                            <b>Description:</b>
                                                            <asp:Label ID="lblDescriptin" runat="server" MaxLength="300"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;" colspan="2">
                                                            <b>URL:</b><asp:LinkButton ID="lnkLeadURL" runat="server" Text=""></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                    <!-- paypal End  -->
                                    <div class="clear">
                                        &nbsp;</div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel43" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr align="center">
                                            <td colspan="4" style="padding-top: 15px;">
                                                <div style="width: 240px; margin: 0 auto;">
                                                    <asp:Button ID="Button11" CssClass="btn btn-warning btn-sm" runat="server" Text="Close"
                                                        OnClientClick="return ClosePopup22();" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                <div class="clearFix">
                    &nbsp</div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
