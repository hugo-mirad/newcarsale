﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LeadsUserRights.aspx.cs"
    Inherits="LeadsUserRights" %>

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
      <script type="text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete Emplyee?")) {
            confirm_value.value ="";
                confirm_value.value = "Yes";
            } else {
          
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>

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
	newwindow=window.open(url,'name','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,height=220,width=420');
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

          function ClosePopup9() {
            $find('<%= MpUserUpdatelist.ClientID%>').hide();
            return false;
        }
        
          function ClosePopup10() {
            $find('<%= MpUpdaterights.ClientID%>').hide();
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
		
		
	});
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="SM" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:UpdateProgress ID="UpdatePanel12" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                                            <asp:LinkButton ID="AllCentersReport" runat="server" Text="All Centers Report" Enabled="true" PostBackUrl="~/AllCentersReport.aspx"></asp:LinkButton></li>
                                             <li>
                                            <asp:LinkButton ID="Centersreport" runat="server" Text="Central Report" Enabled="true" PostBackUrl="~/CentralReport.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
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
                                            <asp:LinkButton ID="WeeklySalesGraphs" runat="server" Text="Weekly Sales Graphs" Enabled="true"
                                                PostBackUrl="~/WeeklysalesGraphReport.aspx"></asp:LinkButton></li>
                                        <li>
                                             <asp:LinkButton ID="MonthlySalesGraphs" runat="server" Text="Monthly Sales Graph" Enabled="true"
                                                PostBackUrl="~/MonthlysalesGraphReport.aspx"></asp:LinkButton></li>
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
                        <li class="parent active"><a href="#">Admin <span class="cert"></span></a>
                            <ul class="sub1">
                                <li class="act"><a href="#">Leads <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li class="act">
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
                                <li class="last">
                                    <asp:LinkButton ID="SuperAdmin" runat="server" Text="Super Admin" PostBackUrl="~/SuperadminRights.aspx"></asp:LinkButton></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Headder End  -->
        <!-- Content Start  -->
        <div class="content wid1000">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="inn">
                        <div class="box1 boxBlue">
                            <h1 class="hed1 hed2 " style="margin-bottom: 0">
                                Leads User Rights
                                <asp:Label ID="lblcenters" Text="Location" runat="server" Style="padding-left: 250px;font-size:11px;"></asp:Label>
                                <asp:DropDownList ID="ddlcenters" runat="server" Style="width: 150px;" OnSelectedIndexChanged="ddlcenters_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                                &nbsp;
                                <asp:LinkButton ID="lnlupdatelist" runat="server" Text="Update Users List" OnClick="lnlupdatelist_Click"
                                    CssClass="HedLeFont underline floarR" style="font-size:8px;"></asp:LinkButton>
                            </h1>
                            <div class="inn scroll200"  style="max-height: 450px; margin: 0; padding: 0;">
                                <!-- Grid Start -->
                                <asp:UpdatePanel ID="updtpnltblGrdcar" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="GridDefaultUserRights" runat="server" CellSpacing="0" CellPadding="0"
                                            ShowFooter="true" CssClass="table table-hover table-striped  MB0 noBorder" AutoGenerateColumns="False"
                                            GridLines="None" OnRowDataBound="GridDefaultUserRights_RowDataBound" OnRowCommand="GridDefaultUserRights_RowCommand">
                                            <PagerStyle HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="tbHed" />
                                            <PagerSettings Position="Top" />
                                            <FooterStyle BackColor="#C6C3C6" CssClass="tbHed center" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Emp ID">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lblEmpId" runat="server" Text='<%# Eval("EMPID")%>' CommandArgument='<%# Eval("EMPID")%>'
                                                            CommandName="Empdeta"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name" FooterText="Total" HeaderStyle-CssClass="BL BR">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LblFirstName" runat="server" Text='<%# Eval("Names")%>' CommandArgument='<%# Eval("EMPID")%>'
                                                            CommandName="Empdeta"></asp:LinkButton>
                                                        <%--<asp:HiddenField ID="lblLstname" runat="server" Value='<%# Eval("LastName")%>' />--%>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="BL BR" />
                                                </asp:TemplateField>
                                              <%--  <asp:TemplateField HeaderText="Role">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lblRoleNamre" runat="server" Text='<%# Eval("RoleName")%>' CommandArgument='<%# Eval("EMPID")%>'
                                                            CommandName="Empdeta"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Leads Upload" HeaderStyle-CssClass="BL BR">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lblLeadsUpload" runat="server" Text='<%# Eval("LeadsUpload")%>'
                                                            CommandArgument='<%# Eval("EMPID")%>' CommandName="Empdeta"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="center BR BL" />
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblleadscoun" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Leads Admin">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LeadsAdmin" runat="server" Text='<%# Eval("LeadsAdmin")%>' CommandArgument='<%# Eval("EMPID")%>'
                                                            CommandName="Empdeta"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="center" />
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblleadsAdmincoun" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <!-- Grid End  -->
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="clear">
                &nbsp;</div>
            <!-- Content End  -->
            <div class="clear">
                &nbsp;</div>
        </div>
    </div>
    <!-- Main Wrapper Emd  -->
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    <!-- Footer End  -->
    <cc1:ModalPopupExtender ID="MpUserUpdatelist" runat="server" PopupControlID="tblChangePW1"
        BackgroundCssClass="ModalPopupBG" TargetControlID="HdnUserPoyp" CancelControlID="img1">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="HdnUserPoyp" runat="server" />
    <div id="tblChangePW1" style="width: 950px; height: 470px;" class="popup">
        <h2>
            New Employees
            <asp:ImageButton ID="img1" runat="server" ImageUrl="images\close.png" CssClass="floarR" /></h2>
        <div class="content" style="">
            <div class="scroll1" style="border: 2px solid #CCC">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="GridUserUpdateList" runat="server" CellSpacing="0" CellPadding="0"
                            Style="height: 450px;" ShowFooter="true" CssClass="table table-hover table-striped tblNoborder"
                            AutoGenerateColumns="False" GridLines="None">
                            <Columns>
                                <asp:TemplateField ItemStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk_Check" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Emp ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSalesEmpid" runat="server" Text='<%# Eval("EMPID")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="LblSalesName" runat="server" Text='<%# Eval("Names")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="LblSalesUpName" runat="server" Text='<%# Eval("DeptName")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role" Visible="false">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlsalesroles" runat="server">
                                            <asp:ListItem Value="0">Undefined</asp:ListItem>
                                            <asp:ListItem Value="8">Leads Source</asp:ListItem>
                                            <asp:ListItem Value="9">Leads Manager</asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <br />
            <span class="floarC">
                <asp:Button ID="btnUpda" CssClass="btn btn-warning" runat="server" Text="Update"
                    OnClick="btnUpda_Click" />
                &nbsp;
                <asp:Button ID="btnClosp" CssClass="btn btn-default " runat="server" Text="Cancel"
                    OnClientClick="return ClosePopup9();" /></span>
        </div>
    </div>
    <cc1:ModalPopupExtender ID="MpUpdaterights" runat="server" PopupControlID="tblChangePW"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnChangePW" CancelControlID="ImageButton1">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnChangePW" runat="server" />
    <div id="tblChangePW" style="display: none; width: 550px;" class="popup">
        <h2>
            Update Rights
             <asp:LinkButton ID="btndelete" runat="server" Text="Delete User" style="padding-left: 255px;font-size: 14px;"
                                     CssClass="underline"           OnClick="OnConfirm" OnClientClick="Confirm()" ></asp:LinkButton>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images\close.png" CssClass="floarR" /></h2>
        <div class="content">
            <asp:UpdatePanel ID="p1" runat="server">
                <ContentTemplate>
                    <table style="width: 96%; margin: 0 auto;">
                        <tr>
                            <td>
                                <b>Leads Upload</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="Ckleads" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Leads</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Leads Admin</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="chkleadsadmin" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Admin</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td align="left">
                                <div style="margin: 0; padding-left: 0px; display: inline-block">
                                    <asp:UpdatePanel ID="updtPnlChangePwd" runat="server">
                                        <ContentTemplate>
                                            <asp:Button ID="btnAddVehicle" CssClass="btn  btn-warning" runat="server" Text="Update"
                                                OnClick="btnAddVehicle_Click" />&nbsp;
                                           
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <asp:Button ID="btnCancelPW" CssClass="btn btn-default" runat="server" Text="Cancel" 
                                    OnClientClick="return ClosePopup10();" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
