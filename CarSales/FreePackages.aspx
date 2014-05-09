<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FreePackages.aspx.cs" Inherits="FreePackages" %>

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
    <!-- 
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    -->

    <script type="text/javascript" language="javascript" src="js/jquery-1.7.min.js"></script>

    <script src="Static/JS/calendar.js" type="text/javascript"></script>

    <link href="Static/Css/calender.css" rel="stylesheet" type="text/css" />
    <!-- 
    <script type="text/javascript" src="js/emulatetab.joelpurra.js"></script>

    <script type="text/javascript" src="js/plusastab.joelpurra.js"></script>

   
    <link href="css/css2.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
   
    
    <script type='text/javascript' language="javascript" src='js/jquery.alphanumeric.pack.js'></script>

    <script src="js/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="Static/JS/calendar.js" type="text/javascript"></script>

    <link href="Static/Css/calender.css" rel="stylesheet" type="text/css" />

    
    
     -->

    <script src="Static/JS/calendar.js" type="text/javascript"></script>

    <link href="Static/Css/calender.css" rel="stylesheet" type="text/css" />

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
	newwindow=window.open(url,'name','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,height=420,width=300');
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
    function ValidateData() {
            var valid = true;
            var today = new Date();
            var month = today.getMonth() + 1
            var day = today.getDate()
            var year = today.getFullYear()
            today = month + "/" + day + "/" + year
            var today = new Date(today);
            var SDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
            var EDate = document.getElementById('<%= txtEndDate.ClientID %>').value;
            var endDate = new Date(EDate);
            var startDate = new Date(SDate);
            var Startmonth = startDate.getMonth() + 1
            var Startday = startDate.getDate()
            var Startyear = startDate.getFullYear()
            startDate = Startmonth + "/" + Startday + "/" + Startyear
            var startDate = new Date(startDate);

            var Endmonth = endDate.getMonth() + 1
            var Endday = endDate.getDate()
            var Endyear = endDate.getFullYear()
            var oneDay = 24 * 60 * 60 * 1000;

            endDate = Endmonth + "/" + Endday + "/" + Endyear

            var endDate = new Date(endDate);

            var ValidOldData = Math.abs((startDate.getTime() - today.getTime()) / (oneDay));
            var ValidDates = Math.abs((startDate.getTime() - endDate.getTime()) / (oneDay));
            
          
            if (SDate == '') {
                alert("Please enter start date");

                valid = false;
                return valid;
            }
            if (EDate == '') {

                alert("Please enter end date");
                valid = false;
                return valid;
            }
            var dtFromDt = document.getElementById('<%=txtStartDate.ClientID%>').value;
            if (isDate(dtFromDt) == false) {
                document.getElementById('<%=txtStartDate.ClientID%>').focus();
                valid = false;
                return valid;
            }

            var dtTodt = document.getElementById('<%=txtEndDate.ClientID%>').value;
            if (isDate(dtTodt) == false) {
                document.getElementById('<%=txtEndDate.ClientID%>').focus();
                valid = false;
                return valid;
            }                   
            
            if (SDate != '' && EDate != '' && startDate > endDate) {
                alert("Start date is greater than end date");
                valid = false;
                return valid;
            }
            if (startDate > today) {
                alert("Start date should not be greater Than current date");
                valid = false;
                return valid;
            }
            if (endDate > today) {

                alert("End date should not be greater than current date");
                valid = false;
                return valid;
            }
            if (ValidOldData >= 365) {
                alert("Report can be generated for maximum of one year prior. Please change the dates and resubmit again");
                document.getElementById("<%=txtStartDate.ClientID%>").focus();
                valid = false;
                return valid;
            }
            return valid;
        }


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
                alert("Report can be generated for maximum of one year prior. Please change the dates and resubmit again");
                return false
            }
            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }
            return true
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
	     function ValidateData() {
            var valid = true;
            var today = new Date();
            var month = today.getMonth() + 1
            var day = today.getDate()
            var year = today.getFullYear()
            today = month + "/" + day + "/" + year
            var today = new Date(today);
            var SDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
            var EDate = document.getElementById('<%= txtEndDate.ClientID %>').value;
            var endDate = new Date(EDate);
            var startDate = new Date(SDate);
            var Startmonth = startDate.getMonth() + 1
            var Startday = startDate.getDate()
            var Startyear = startDate.getFullYear()
            startDate = Startmonth + "/" + Startday + "/" + Startyear
            var startDate = new Date(startDate);

            var Endmonth = endDate.getMonth() + 1
            var Endday = endDate.getDate()
            var Endyear = endDate.getFullYear()
            var oneDay = 24 * 60 * 60 * 1000;

            endDate = Endmonth + "/" + Endday + "/" + Endyear

            var endDate = new Date(endDate);

            var ValidOldData = Math.abs((startDate.getTime() - today.getTime()) / (oneDay));
            var ValidDates = Math.abs((startDate.getTime() - endDate.getTime()) / (oneDay));
            
          
            if (SDate == '') {
                alert("Please enter start date");

                valid = false;
                return valid;
            }
            if (EDate == '') {

                alert("Please enter end date");
                valid = false;
                return valid;
            }
            var dtFromDt = document.getElementById('<%=txtStartDate.ClientID%>').value;
            if (isDate(dtFromDt) == false) {
                document.getElementById('<%=txtStartDate.ClientID%>').focus();
                valid = false;
                return valid;
            }

            var dtTodt = document.getElementById('<%=txtEndDate.ClientID%>').value;
            if (isDate(dtTodt) == false) {
                document.getElementById('<%=txtEndDate.ClientID%>').focus();
                valid = false;
                return valid;
            }                   
            
            if (SDate != '' && EDate != '' && startDate > endDate) {
                alert("Start date is greater than end date");
                valid = false;
                return valid;
            }
            if (startDate > today) {
                alert("Start date should not be greater Than current date");
                valid = false;
                return valid;
            }
            if (endDate > today) {

                alert("End date should not be greater than current date");
                valid = false;
                return valid;
            }
            if (ValidOldData >= 365) {
                alert("Report can be generated for maximum of one year prior. Please change the dates and resubmit again");
                document.getElementById("<%=txtStartDate.ClientID%>").focus();
                valid = false;
                return valid;
            }
            return valid;
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="SM" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="Up1"
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
                        <li class="parent active"><a href="#">Leads <span class="cert"></span></a>
                            <ul class="sub1">
                                <li>
                                    <asp:LinkButton ID="LeadsUpload" runat="server" Text="Upload" Enabled="false" PostBackUrl="~/LeadsUpload.aspx"></asp:LinkButton></li><li>
                                <li>
                                    <asp:LinkButton ID="LeadsDownLoad" runat="server" Text="Download" Enabled="false"
                                        PostBackUrl="~/LeadDownLoad.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Abondoned" runat="server" Text="Abondon" Enabled="false" PostBackUrl="~/Abonded.aspx"></asp:LinkButton></li>
                                <li  class="act">
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
                                <li>
                                    <asp:LinkButton ID="MyReport" runat="server" Text="My Report" Enabled="false" PostBackUrl="~/AllCentersReport.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="lnkSetGrup" runat="server" Text="SetGroup" Enabled="false"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="lnkGroupreport" runat="server" Text="Group Report" Enabled="false"></asp:LinkButton></li>
                            </ul>
                        </li>
                        <li class="parent"><a href="#">Process <span class="cert"></span></a>
                            <ul class="sub1">
                                <li>
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
                                <li>
                                    <asp:LinkButton ID="Leads" runat="server" Text="Leads" Enabled="false"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Sales" runat="server" Text="Sales" Enabled="false" PostBackUrl="~/CarSalesReportNew.aspx"></asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="Process" runat="server" Text="Process" Enabled="false" PostBackUrl="~/ProcessRights.aspx"></asp:LinkButton></li>
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
                                            <asp:LinkButton ID="LeadsList" runat="server" Text="Leads State Wise" PostBackUrl="~/StatewiseLeads.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LeadsSatus" runat="server" Text="Leads Status" PostBackUrl="~/StateWiseLeadsStatus.aspx"></asp:LinkButton></li>
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
                                <li >
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
        <div class="content wid1000">
            <div class=" box1 box50p center">
                <h1 class="hed1 hed2">
                    Search</h1>
                <div class="inn">
                    <!-- Start  -->
                    <table>
                        <tbody>
                            <tr>
                                <td style="width: 270px; padding-top: 2px;">
                                    <table style="width: 270px; float: left; border-collapse: collapse; margin-left: 0px;
                                        margin-right: 13px;">
                                        <tbody>
                                            <tr>
                                                <td colspan="3" align="left" style="padding: 0">
                                                    <div style="border-bottom: 1px #666 solid; text-align: center; width: 240px; margin: 0 auto 2px auto;
                                                        font-weight: bold; padding-bottom: 2px;">
                                                        Date range</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 45%; padding: 0; text-align: right">
                                                    <asp:TextBox ID="txtStartDate" runat="server" class="input1 " MaxLength="10" onkeypress="return isNumberKeyForDt(event)"
                                                        Width="70px"></asp:TextBox>&nbsp;
                                                    <img id="imgcal" runat="server" style="border-right: 0px; border-top: 0px; border-left: 0px;
                                                        border-bottom: 0px" title="Calendar Control" onclick="displayCalendar(document.forms[0].txtStartDate,'mm/dd/yyyy',this);"
                                                        alt="Calendar Control" src="images/Calender.gif" width="18" />
                                                </td>
                                                <td style="width: 26px; text-align: center; padding: 0;">
                                                    <b>to</b>
                                                </td>
                                                <td style="text-align: left; padding: 0;">
                                                    <asp:TextBox ID="txtEndDate" runat="server" class="input1 " MaxLength="10" onkeypress="return isNumberKeyForDt(event)"
                                                        Width="70px"></asp:TextBox>&nbsp;
                                                    <img id="img1" runat="server" style="border-right: 0px; border-top: 0px; border-left: 0px;
                                                        border-bottom: 0px" title="Calendar Control" onclick="displayCalendar(document.forms[0].txtEndDate,'mm/dd/yyyy',this);"
                                                        alt="Calendar Control" src="images/Calender.gif" width="18" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td>
                                    <strong>Location:</strong>
                                    <br>
                                    <asp:DropDownList ID="ddlCenters" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 105px; padding-top: 17px; padding-left: 10px;">
                                    <asp:UpdatePanel ID="Up1" runat="server">
                                        <ContentTemplate>
                                        
                                            <asp:Button ID="btnSearchMonth" runat="server" Text="Generate" CssClass="btn btn-warning btn-sm"
                                                OnClientClick="return ValidateData();" OnClick="btnSearchMonth_Click" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End  -->
                </div>
            </div>
            <!-- Start  -->
            <!-- End  -->
        </div>
        <div class="clear">
            &nbsp;</div>
        <!-- Content End  -->
        <div style="padding: 15px; width: auto;">
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="100%">
                                <asp:Label ID="lblResHead" Text="sdfsdfsdf" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <table style="width: 100%; display: block;" id="tblSales" runat="server">
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td align="left" style="width: 50%;">
                                    <asp:UpdatePanel ID="UpPanr" runat="server">
                                        <ContentTemplate>
                                            <h4>
                                                <asp:Label ID="Nameoftype" Text="Free Packages" runat="server"></asp:Label>
                                            </h4>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdtpnldatResCounts" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblRes" Font-Size="12px" Font-Bold="true" ForeColor="Black" runat="server"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td style="width: 35%;">
                                    <asp:UpdatePanel runat="server" ID="Updatepansg">
                                        <ContentTemplate>
                                            <asp:Label ID="lblResCount" runat="server"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                      <asp:Panel ID="pnl1" Width="100%" runat="server" Style="padding-top: 6px;">
                                <asp:UpdatePanel ID="UpdPnlGrid" runat="server">
                                    <ContentTemplate>
                                        <input style="width: 91px" id="txthdnSortOrder" type="hidden" runat="server" enableviewstate="true" />
                                        <input style="width: 40px" id="txthdnSortColumnId" type="hidden" runat="server" enableviewstate="true" />
                                        <asp:GridView Width="1408px" ID="grdWarmLeadInfo" runat="server" CellSpacing="0"
                                            AllowSorting="true" CellPadding="0" CssClass="table table-hover table-striped"
                                            AutoGenerateColumns="False" GridLines="None" ShowHeader="true" OnRowDataBound="grdWarmLeadInfo_RowDataBound"
                                            OnSorting="grdWarmLeadInfo_Sorting">
                                            <PagerStyle HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="tbHed" />
                                            <PagerSettings Position="Top" />
                                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                            <RowStyle CssClass="row1" />
                                            <AlternatingRowStyle CssClass="row2" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sale ID" SortExpression="carid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnkCarID" runat="server" Text='<%# Eval("carid")%>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="75px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sale Dt" SortExpression="SaleDate">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSaleDt" runat="server" Text='<%# Bind("SaleDate", "{0:MM/dd/yy hh:mm tt}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="120px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Agent" SortExpression="SaleAgent">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAgent" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnAgentID" runat="server" Value='<%# Eval("SaleAgentID")%>' />
                                                        <asp:HiddenField ID="hdnAgentName" runat="server" Value='<%# Eval("SaleAgent")%>' />
                                                        <asp:HiddenField ID="hdnAgentCenterCode" runat="server" Value='<%# Eval("LocationId")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="140px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Verifier" SortExpression="VerifierName">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVerifier" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnVerifierID" runat="server" Value='<%# Eval("SaleVerifierID")%>' />
                                                        <asp:HiddenField ID="hdnVerifierName" runat="server" Value='<%# Eval("VerifierName")%>' />
                                                        <asp:HiddenField ID="hdnVerifierCenterCode" runat="server" Value='<%# Eval("VerifierCenterID")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="140px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Year/Make/Model" SortExpression="make">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblYear" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnYear" runat="server" Value='<%# Eval("yearOfMake")%>' />
                                                        <asp:HiddenField ID="hdnMake" runat="server" Value='<%# Eval("make")%>' />
                                                        <asp:HiddenField ID="hdnModel" runat="server" Value='<%# Eval("model")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="160px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Package" SortExpression="PackageCode">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPackage" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnPackName" runat="server" Value='<%# Eval("PackageCode")%>' />
                                                        <asp:HiddenField ID="hdnPackDiscount" runat="server" Value='<%# Eval("UCS_Discountid")%>' />
                                                        <asp:HiddenField ID="hdnPackCost" runat="server" Value='<%# Eval("Price")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="85px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QC Status" SortExpression="QCStatusName">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQcStatus" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnQCStatusID" runat="server" Value='<%# Eval("QCStatusID")%>' />
                                                        <asp:HiddenField ID="hdnQcStatus" runat="server" Value='<%# Eval("QCStatusName")%>' />
                                                        <asp:HiddenField ID="hdnQCNotes" runat="server" Value='<%# Eval("QCNotes")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="$ Paid	" SortExpression="PSStatusID1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPaid" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnPSID1Status" runat="server" Value='<%# Eval("PSStatusID1")%>' />
                                                        <asp:HiddenField ID="hdnPSID2Status" runat="server" Value='<%# Eval("PSStatusID2")%>' />
                                                        <asp:HiddenField ID="hdnPSIDNotes" runat="server" Value='<%# Eval("PaymentNotes")%>' />
                                                        <asp:HiddenField ID="hdnAmount1" runat="server" Value='<%# Eval("Amount1")%>' />
                                                        <asp:HiddenField ID="hdnAmount2" runat="server" Value='<%# Eval("Amount2")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="80px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="$ Pending">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPending" runat="server" Style="padding-right: 10px;"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="80px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Pmnt Status" SortExpression="PSStatusName1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPmntStatus" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnPmntStatus" runat="server" Value='<%# Eval("PSStatusName1")%>' />
                                                        <asp:HiddenField ID="hdnPmntReason" runat="server" Value='<%# Eval("PaymentCancelReasonName")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Cust Name" SortExpression="sellerName">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnSellerName" runat="server" Value='<%# Eval("sellerName")%>' />
                                                        <asp:HiddenField ID="hdnLastName" runat="server" Value='<%# Eval("LastName")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Phone" SortExpression="PhoneNum">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnPhoneNum" runat="server" Value='<%# Eval("PhoneNum")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="grdWarmLeadInfo" EventName="Sorting" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
        <!-- Main Wrapper Emd  -->
    </div>
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    </form>
</body>
</html>
