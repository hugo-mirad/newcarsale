<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QCReport.aspx.cs" Inherits="QCReport" %>

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

    <script src="Static/JS/calendar.js" type="text/javascript"></script>

    <link href="Static/Css/calender.css" rel="stylesheet" type="text/css" />
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

    <script type="text/javascript" language="javascript">window.history.forward(1);</script>

    <script type="text/javascript">
 function pageLoad()
   { 
      //InitializeTimer();   
      
      //date = new Date(parseInt(arr[2]), parseInt(arr[0])-1, parseInt(arr[1]) + 1);
      
         
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
    
   
    function ClosePopup() {
            $find('<%= MPEUpdate.ClientID%>').hide();
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

    <script type="text/javascript" language="javascript">

          function ClosePopup() {
            $find('<%= MPEUpdate.ClientID%>').hide();
            return false;
        }
        
         
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
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
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
    <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="updtpnltblGrdcar"
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
                        <li class="parent"><a href="#">Sales <span class="cert"></span></a>
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
                                        Brands <span class="cert"></span></a>
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
        <div class="content wid1000">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class=" box1 box50p" style="width: 540px">
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <table class="tbl3" style="width: 100%; padding: 10px; border-collapse: initial;
                                    border: #ccc 1px solid; float: left; height: 61px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding: 5px 0 0 0; width: 290px; vertical-align: middle">
                                            <asp:RadioButton ID="rdbtnQCOpen" runat="server" Text="QC Open" GroupName="QCReport"
                                                CssClass="noLM" Style="margin-left: 0;" />
                                            <asp:RadioButton ID="rdbtnQCDonepayopen" Text="QC Done pay open" runat="server" GroupName="QCReport" />
                                            <asp:RadioButton ID="rdbtnAll" runat="server" Text="All" GroupName="QCReport" Checked="true"
                                                OnCheckedChanged="rdbtnAll_CheckedChanged" />
                                        </td>
                                        <td style="text-align: left; padding-right: 10px; width: 145px; vertical-align: middle">
                                            Center:
                                            <asp:DropDownList ID="ddlCenters" runat="server" Style="width: 85px; margin-left: 3px;">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="vertical-align: middle">
                                            <asp:UpdatePanel ID="updbtnSearch" runat="server">
                                                <ContentTemplate>
                                                    <asp:Button ID="btnGenerate" runat="server" CssClass="btn btn-warning btn-sm" Text="Generate"
                                                        OnClientClick="return ValidateData();" OnClick="btnGenerate_Click" />&nbsp;
                                                    
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class=" box1 box33p" style="width: 440px">
                        <table class="tbl3" style="width: 100%; padding: 10px; border-collapse: collapse;
                            border: #ccc 1px solid; float: left; height: 61px; margin-left: 0px;">
                            <tr>
                                <td style="vertical-align: middle; padding-left: 10px;">
                                    search:&nbsp;&nbsp;
                                </td>
                                <td style="vertical-align: middle; width: 70px;">
                                    <asp:DropDownList ID="ddlQCSearch" runat="server">
                                        <asp:ListItem>SaleID</asp:ListItem>
                                        <%-- <asp:ListItem>Sale Date</asp:ListItem>--%>
                                        <asp:ListItem>Phone</asp:ListItem>
                                        <asp:ListItem>Name</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="vertical-align: middle; padding-left: 10px; padding-right: 10px;">
                                    <asp:TextBox ID="txtQCSearch" runat="server"></asp:TextBox>
                                </td>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <asp:Button ID="BtnQCSearch" runat="server" Text="QC Search" CssClass="btn btn-warning btn-sm"
                                        OnClick="BtnQCSearch_Click" />
                                </td>
                                <td>Brand&nbsp;</td>
                                <td><asp:DropDownList ID="ddlbrands" runat="server" Style="width: 100px;">
                                                    </asp:DropDownList></td> <%--OnSelectedIndexChanged="ddlBrandurl_SelectedIndexChanged"--%>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <table width="1400px">
                            <tr>
                                <td align="left" style="width: 40%;">
                                    <%-- <h2 style="margin: 0; padding: 0;">
                                            Sale(s)</h2>--%>
                                </td>
                                <td align="center">
                                    <asp:UpdatePanel ID="UpdtpnldatResCounts" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblRes" Font-Size="12px" Font-Bold="true" ForeColor="Black" runat="server"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td align="left" style="width: 40%;">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- Content End  -->
                    <div class="clear">
                        &nbsp;</div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="content wid1000">
            <h4>
                QC Results
                <asp:UpdatePanel ID="i4" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblResCount" runat="server" CssClass="floarR"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <span style="float: right; display: inline-block; width: 60px;">&nbsp;</span>
                <asp:Label ID="lblResHead" runat="server" CssClass="floarR"></asp:Label>
            </h4>
            <div class="clear">
            </div>
            <div class="scroll200" style="max-height: 390px; width: 100%">
                <asp:UpdatePanel ID="updtpnltblGrdcar" runat="server">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="UpdPnlGrid" runat="server">
                            <ContentTemplate>
                                <input style="width: 91px" id="txthdnSortOrder" type="hidden" runat="server" enableviewstate="true" />
                                <input style="width: 40px" id="txthdnSortColumnId" type="hidden" runat="server" enableviewstate="true" />
                                <asp:GridView Width="1400px" ID="grdWarmLeadInfo" runat="server" CellSpacing="0"
                                    CellPadding="0" CssClass="table table-hover table-striped" AutoGenerateColumns="False"
                                    GridLines="None" ShowHeader="true" OnRowDataBound="grdWarmLeadInfo_RowDataBound"
                                    OnRowCommand="grdWarmLeadInfo_RowCommand" Style="overflow-y: scroll;" AllowSorting="true"
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
                                                <asp:LinkButton ID="lnkCarID" runat="server" Text='<%# Eval("carid")%>' CommandArgument='<%# Eval("postingID")%>'
                                                    CommandName="EditSale"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sale Dt" SortExpression="SaleDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSaleDt" runat="server" Text='<%# Bind("SaleDate", "{0:MM/dd/yy hh:mm tt}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="150px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Agent" SortExpression="SaleAgent">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAgent" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnAgentID" runat="server" Value='<%# Eval("SaleAgentID")%>' />
                                                <asp:HiddenField ID="hdnAgentName" runat="server" Value='<%# Eval("SaleAgent")%>' />
                                                <asp:HiddenField ID="hdnAgentCenterID" runat="server" Value='<%# Eval("LocationId")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="145px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Voice Record #" SortExpression="VoiceRecord">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVoiceRecord" runat="server" Text='<%#objGeneralFunc.WrapTextByMaxCharacters(DataBinder.Eval(Container.DataItem,"VoiceRecord"),11)%>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="148px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="QC Status" SortExpression="QCStatusName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblQCStatus" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnQCStatusName" runat="server" Value='<%# Eval("QCStatusName")%>' />
                                                <asp:HiddenField ID="hdnQCStatusID" runat="server" Value='<%# Eval("QCStatusID")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="108px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pmnt Status" SortExpression="PSStatusID1">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnPaymentStatus" runat="server" CommandArgument='<%# Eval("postingID")%>'
                                                    CommandName="EditPayInfo"></asp:LinkButton>
                                                <asp:HiddenField ID="hdnPSID1Status" runat="server" Value='<%# Eval("PSStatusID1")%>' />
                                                <asp:HiddenField ID="hdnPSID1StatusName" runat="server" Value='<%# Eval("PSStatusName1")%>' />
                                                <asp:HiddenField ID="hdnPSAmount" runat="server" Value='<%# Eval("Amount1") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="105px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Smartz St" SortExpression="SmartzStatus">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnMoveSmartz" runat="server" CommandArgument='<%# Eval("postingID")%>'
                                                    CommandName="MoveSmartz"></asp:LinkButton>
                                                <asp:HiddenField ID="hdnSmartzStatus" runat="server" Value='<%# Eval("SmartzStatus")%>' />
                                                <asp:HiddenField ID="hdnSmartzCarID" runat="server" Value='<%# Eval("SmartzCarID")%>' />
                                                <asp:HiddenField ID="hdnSmartzMovedDate" runat="server" Value='<%# Eval("SmartzMovedDate")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="159px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Year/Make/Model" SortExpression="make">
                                            <ItemTemplate>
                                                <asp:Label ID="lblYear" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnYear" runat="server" Value='<%# Eval("yearOfMake")%>' />
                                                <asp:HiddenField ID="hdnMake" runat="server" Value='<%# Eval("make")%>' />
                                                <asp:HiddenField ID="hdnModel" runat="server" Value='<%# Eval("model")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="188px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Package" SortExpression="PackageCode">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPackage" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnPackName" runat="server" Value='<%# Eval("PackageCode")%>' />
                                                <asp:HiddenField ID="hdnPackDiscount" runat="server" Value='<%# Eval("UCS_Discountid")%>' />
                                                <asp:HiddenField ID="hdnPackCost" runat="server" Value='<%# Eval("Price")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="106px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name" SortExpression="sellerName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnSellerName" runat="server" Value='<%# Eval("sellerName")%>' />
                                                <asp:HiddenField ID="hdnLastName" runat="server" Value='<%# Eval("LastName")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="100px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone" SortExpression="PhoneNum">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnPhoneNum" runat="server" Value='<%# Eval("PhoneNum")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="grdWarmLeadInfo" EventName="Sorting" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <div class="clearfix">
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="clear">
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
        <div style="padding: 15px;">
        </div>
    </div>
    <!-- Main Wrapper Emd  -->
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    <asp:HiddenField ID="btnOpen" runat="server" />
    <cc1:ModalPopupExtender ID="MPEUpdate" runat="server" PopupControlID="tblUpdate"
        BackgroundCssClass="ModalPopupBG" TargetControlID="btnOpen" CancelControlID="btnCancelUpdate">
    </cc1:ModalPopupExtender>
    <div id="tblUpdate" class="PopUpHolder" style="display: none;">
        <div class="popup" style="height: 620px; margin-top: 70px; width: 650px">
            <h2>
                Update Payment Details
            </h2>
            <div class="content" style="padding: 0 0 0 3; overflow: scroll; height: 580px;">
                <table id="Table2" runat="server" align="center" cellpadding="0" cellspacing="0"
                    style="width: 100%; margin: 0 auto;">
                    <tr>
                        <td style="width: 100%;">
                            <asp:UpdatePanel ID="updPnlUser" runat="server">
                                <ContentTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 98%; margin: 0 auto;"
                                        class="noPad">
                                        <tr>
                                            <td>
                                                <table width="100%" style="margin-top: 10px;">
                                                    <tr>
                                                        <td style="width: 30%;">
                                                            <b>Sale ID</b> &nbsp;
                                                            <asp:Label ID="lblpaymentPopSaleID" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 30%">
                                                            <b>Phone</b> &nbsp;
                                                            <asp:Label ID="lblPayInfoPhone" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <b>Email</b> &nbsp;
                                                            <asp:Label ID="lblPayInfoEmail" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnPopPayType" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <b>Voice file confirmation #</b> &nbsp;
                                                            <asp:Label ID="lblPayInfoVoiceConfNo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 30%">
                                                            <b>Payment date</b> &nbsp;
                                                            <asp:Label ID="lblPoplblPayDate" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 30%">
                                                            <b>Amount</b> &nbsp;
                                                            <asp:Label ID="lblPoplblPayAmount" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnPophdnAmount" runat="server" />
                                                        </td>
                                                        <td>
                                                            <b>Package</b> &nbsp;
                                                            <asp:Label ID="lblPoplblPackage" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="trPopPDData" runat="server">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 30%">
                                                            <b>PD Date</b> &nbsp;
                                                            <asp:Label ID="lblPDDateForPop" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <b>Amount</b> &nbsp;
                                                            <asp:Label ID="lblPDAmountForPop" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <!-- Credit Card Start  -->
                                                <div id="divcard" runat="server" style="display: block; height: auto; min-height: auto;
                                                    max-height: auto; margin-bottom: 15px;">
                                                    <!-- 
                                                <table>
                                                    <tr>
                                                        <td style="width:49%;">
                                                            <table>
                                                                
                                                            </table>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                                -->
                                                    <table border="0" cellpadding="4" cellspacing="4" style="width: 99%; margin: 15px 0;
                                                        float: left;">
                                                        <tr>
                                                            <td colspan="5">
                                                                <h5 style="font-size: 15px; margin: 0; float: left; width: 130px;">
                                                                    <b>Card Details</b></h5>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Card Type</b>
                                                            </td>
                                                            <td colspan="4">
                                                                <asp:Label ID="lblCCCardType" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Card Holder First Name</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCardHolderName" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 50px;">
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 80px;">
                                                                <b>Last Name</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCardHolderLastName" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>Credit Card #</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCCNumber" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <b>Expiry Date</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCCExpiryDate" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>CVV#</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblCvv" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <b>Address</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblBillingAddress" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b>City</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblBillingCity" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td colspan="2">
                                                                <div style="width: 80px; display: inline-block; float: left; margin-right: 10px;">
                                                                    <b>State &nbsp;</b>
                                                                    <asp:Label ID="lblBillingState" runat="server"></asp:Label>
                                                                </div>
                                                                <div style="width: 120px; display: inline-block; float: left">
                                                                    <b>ZIP &nbsp;</b>
                                                                    <asp:Label ID="lblBillingZip" runat="server"></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!-- Credit Card End  -->
                                                <div class="clear">
                                                    &nbsp;</div>
                                                <!-- check Start  -->
                                                <div id="divcheck" runat="server" style="display: none; height: auto; min-height: auto;
                                                    max-height: auto">
                                                    <table border="0" cellpadding="4" cellspacing="4" style="width: 99%; margin: 15px 0;
                                                        float: left;">
                                                        <tr>
                                                            <td colspan="5">
                                                                <h5 style="font-size: 15px; margin: 0; float: left; width: 130px;">
                                                                    <b>Check Details</b></h5>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Account holder name</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAccHolderName" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 50px;">
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 80px;">
                                                                <b>Bank name</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblBankName" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Account type</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAccType" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 50px;">
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 80px;">
                                                                <b>Account #</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAccNumber" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Routing #</b>
                                                            </td>
                                                            <td colspan="4">
                                                                <asp:Label ID="lblRouting" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!-- check End  -->
                                                <div class="clear">
                                                    &nbsp;</div>
                                                <!-- paypal Start  -->
                                                <div id="divpaypal" runat="server" style="display: none; height: auto; min-height: auto;
                                                    max-height: auto;">
                                                    <table border="0" cellpadding="4" cellspacing="4" style="width: 99%; margin: 15px  0;
                                                        float: left;">
                                                        <tr>
                                                            <td colspan="2">
                                                                <h5 style="font-size: 15px; margin: 0; float: left; width: 130px;">
                                                                    <b>Paypal Details</b></h5>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Payment trans ID</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPaypalTranID" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 140px">
                                                                <b>Paypal account email</b>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPaypalEmail" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="clear">
                                                    &nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 21%;">
                                                            <b>Payment status</b>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPaymentStatus" runat="server" onchange="return PayInfoChanges();">
                                                                <asp:ListItem Value="4">Open</asp:ListItem>
                                                                <asp:ListItem Value="1">FullyPaid</asp:ListItem>
                                                                <asp:ListItem Value="7">PartialPaid</asp:ListItem>
                                                                <asp:ListItem Value="8">NoPayDue</asp:ListItem>
                                                                <asp:ListItem Value="3">Pending</asp:ListItem>
                                                                <asp:ListItem Value="5">Returned</asp:ListItem>
                                                                <asp:ListItem Value="2">Reject</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="divTransID" runat="server" style="display: none;">
                                                <!-- Credit Card Start  -->
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 21%;">
                                                            <b>Transaction ID</b>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPaytransID" runat="server" MaxLength="30"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="divPaymentDate" runat="server" style="display: none;">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 21%;">
                                                            <b>Payment Date</b>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPaymentDate" runat="server" CssClass="input1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="divPaymentAmount" runat="server" style="display: none;">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 21%;">
                                                            <b>Amount</b>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPaymentAmountInPop" runat="server" MaxLength="6" onkeypress="return isNumberKeyWithDot(event)"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="divReason" runat="server" style="display: none;">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 21%;">
                                                            <b>Reason</b>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPayCancelReason" runat="server" CssClass="input1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top;">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="vertical-align: top; width: 21%;">
                                                            <b>Old Notes</b> &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPaymentNotes" runat="server" MaxLength="1000" Style="width: 200px;
                                                                height: 45px; resize: none;" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top;">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="vertical-align: top; width: 21%;">
                                                            <b>Notes</b> &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPaymentNewNotes" runat="server" MaxLength="1000" Style="width: 200px;
                                                                height: 45px; resize: none;" TextMode="MultiLine"></asp:TextBox>
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
                            <asp:UpdatePanel ID="updtpnlBtns" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr align="center">
                                            <td style="padding-top: 15px;">
                                                <div style="width: 240px; margin: 0 auto;">
                                                    <asp:Button ID="btnUpdate" OnClientClick="return ValidateUpdate();" runat="server"
                                                        Text="Update" CssClass="btn btn-warning btn-sm" OnClick="btnUpdate_Click" />
                                                    &nbsp;&nbsp;
                                                    <asp:Button ID="btnCancelUpdate" CssClass="btn btn-warning btn-sm" runat="server"
                                                        Text="Cancel" OnClientClick="return ClosePopup();" />
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
                    &nbsp;</div>
            </div>
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
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblErrorExists" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnOk" class="btn" runat="server" Text="Ok" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="mpealteruserUpdated" runat="server" PopupControlID="AlertUserUpdated"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAlertuserUpdated">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAlertuserUpdated" runat="server" />
    <div id="AlertUserUpdated" class="popup" style="display: none">
        <h2>
            Alert
            <asp:Button ID="BtnClsUpdated" class="cls" runat="server" Text="" BorderWidth="0"
                OnClick="btnYesUpdated_Click" />
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
            <asp:Button ID="btnYesUpdated" class="btn" runat="server" Text="Ok" OnClick="btnYesUpdated_Click" />
        </div>
    </div>
    <cc1:ModalPopupExtender ID="MdepAddAnotherCarAlert" runat="server" PopupControlID="divAddAnotherCarAlert"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnAddAnotherCarAlert" OkControlID="btnAddAnotherCarNo">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnAddAnotherCarAlert" runat="server" />
    <div id="divAddAnotherCarAlert" class="popup" style="display: none">
        <h2>
            Alert
            <!-- <div class="cls">
            </div> -->
        </h2>
        <div class="content">
            <p>
                <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblAddAnotherCarAlertError" runat="server" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </p>
            <asp:Button ID="btnAddAnotherCarNo" class="btn" runat="server" Text="No" />&nbsp;
            <asp:Button ID="btnAddAnotherCarYes" class="btn" runat="server" Text="Yes" OnClick="btnAddAnotherCarYes_Click" />
        </div>
    </div>
    </form>
</body>
</html>
