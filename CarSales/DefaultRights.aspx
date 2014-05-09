<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DefaultRights.aspx.cs" Inherits="DefaultRights" %>

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
    </script>
<script type="text/javascript" language="javascript">
    
   
    function ClosePopup10() {
            $find('<%= MpVechlAdd.ClientID%>').hide();
            return false;
        }
       
    </script>
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
                                    <asp:LinkButton ID="Transferin" runat="server" Text="Transfer In" Enabled="false" PostBackUrl="~/LiveTransfers.aspx"></asp:LinkButton></li>
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
                        <li class="parent active"><a href="#">Admin <span class="cert"></span></a>
                            <ul class="sub1">
                                <li><a href="#">Leads <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="leadsRights" runat="server" Text="Leads User Rights" PostBackUrl="~/LeadsUserRights.aspx"></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="LeadsSatus" runat="server" Text="Leads Status" PostBackUrl="~/StateWiseLeadsStatus.aspx"></asp:LinkButton></li>
                                        <li class="last">
                                            <asp:LinkButton ID="LeadsAssign" runat="server" Text="Leads Assign" PostBackUrl="~/LeadAssign.aspx"></asp:LinkButton></li>
                                    </ul>
                                </li>
                                <li class="act"><a href="#">Sales <span class="cert"></span></a>
                                    <ul class="sub2">
                                        <li>
                                            <asp:LinkButton ID="SalesAdmin" runat="server" Text="User Rights" PostBackUrl="~/SalesUserRights.aspx"
                                                Enabled="false"></asp:LinkButton></li>
                                        <li class="act">
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
                                <li>
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
        <div class="content ">
            <div class="inn">
                <div class="box1 boxBlue">
                    <h1 class="hed1 hed2">
                        Default Rights</h1>
                    <div class="inn" style="margin: 0; padding: 0;">
                        <!-- Grid Start -->
                        <asp:UpdatePanel ID="updtpnltblGrdcar" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="GridDefaultUserRights" runat="server" CellSpacing="0" CellPadding="0"
                                                CssClass="table table-hover table-striped MB0 noBorder" AutoGenerateColumns="False"
                                                GridLines="None" OnRowCreated="GridDefaultUserRights_RowCreated" OnRowDataBound="GridDefaultUserRights_RowDataBound"
                                                OnRowCommand="GridDefaultUserRights_RowCommand">
                                                <PagerStyle HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="tbHed center" />
                                                <PagerSettings Position="Top" />
                                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                <RowStyle CssClass="row1" />
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lblRoleNamre" runat="server" Text='<%# Eval("RoleName")%>' CommandArgument='<%# Eval("RoleId")%>'
                                                            CommandName="RoleId"></asp:LinkButton>
                                                            <asp:HiddenField ID="hdnRoleId" runat="server" Value='<%# Eval("RoleId")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblVehType" runat="server" ForeColor="#2286C1" Text="Default"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Leads" HeaderStyle-CssClass="BL" >
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLeads" runat="server" ForeColor="#2286C1" Text='<%# Eval("LeadsUpload")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="BL center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Transfer Ins">
                                                        <ItemTemplate>
                                                            <asp:Label ID="LblTransfers" runat="server" ForeColor="#2286C1"  Text='<%# Eval("Transferin")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Abondons">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblabondons" runat="server" ForeColor="#2286C1"  Text='<%# Eval("Abondoned")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Free Posts" HeaderStyle-CssClass="BR">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblfreepots" runat="server" ForeColor="#2286C1"  Text='<%# Eval("FreePackage")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="BR center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Intro Mail">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblintromail" runat="server" ForeColor="#2286C1" Text='<%# Eval("IntroMail")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="New Entry">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNeEntry" runat="server" ForeColor="#2286C1"  Text='<%# Eval("NewEntry")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Transfer Out">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTransferOut" runat="server" ForeColor="#2286C1"   Text='<%# Eval("Transferout")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Ticker" HeaderStyle-CssClass="BR">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTicker" runat="server" ForeColor="#2286C1"   Text='<%# Eval("Ticker")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="BR center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Self">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSelf" runat="server" ForeColor="#2286C1"    Text='<%# Eval("Self")%>'> </asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Center" HeaderStyle-CssClass="BR">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCenter" runat="server" ForeColor="#2286C1"    Text='<%# Eval("Center")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="BR center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAdmin" runat="server" ForeColor="#2286C1"     Text='<%# Eval("SalesAdmin")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- Grid End  -->
                    </div>
                </div>
            </div>
            <div class="clear">
                &nbsp;</div>
        </div>
        <!-- Content End  -->
        <div class="clear">
            &nbsp;</div>
    </div>
    <!-- Main Wrapper Emd  -->
    <!-- Footer Start  -->
    <div class="footer">
        United Car Exchange © 2013
    </div>
    <cc1:ModalPopupExtender ID="MpVechlAdd" runat="server" PopupControlID="tblChangePW"
        BackgroundCssClass="ModalPopupBG" TargetControlID="hdnChangePW" CancelControlID="ImageButton1">
    </cc1:ModalPopupExtender>
    <asp:HiddenField ID="hdnChangePW" runat="server" />
    <div id="tblChangePW" style="display: none; width: 550px;" class="popup">
        <h2>
            Update Rights
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images\close.png" CssClass="floarR" /></h2>
        <div class="content">
            <asp:UpdatePanel ID="p1" runat="server">
                <ContentTemplate>
                    <table style="width: 96%; margin: 0 auto;">
                        <tr>
                            <td>
                                <b>Leads Download</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="Ckleads" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Leads</asp:ListItem>
                                    <asp:ListItem>Transfer Ins</asp:ListItem>
                                    <asp:ListItem>Abondons</asp:ListItem>
                                    <asp:ListItem>Free Posts</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Sales</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="chksales" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Intro Mail</asp:ListItem>
                                    <asp:ListItem>New Entry</asp:ListItem>
                                    <asp:ListItem>Transfer Out</asp:ListItem>
                                    <asp:ListItem>Ticker</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Reports</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="ChkReports" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Self</asp:ListItem>
                                    <asp:ListItem>Center</asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Sales Admin</b>
                            </td>
                            <td>
                                <asp:CheckBoxList ID="chksaleadmin" runat="server" RepeatDirection="Horizontal">
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
                                            <asp:Button ID="btnAddVehicle" CssClass="btn btn-warning" runat="server" Text="Update"
                                                OnClick="btnAddVehicle_Click" />&nbsp;
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <asp:Button ID="btnCancelPW" CssClass="btn  btn-default" runat="server" Text="Cancel"
                                    OnClientClick="return ClosePopup10();" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <!-- Footer End  -->
    </form>
</body>
</html>
