using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using HotLeadBL;
using HotLeadInfo;
using HotLeadBL.Transactions;
using HotLeadBL.CentralDBTransactions;
using HotLeadInfo;
using HotLeadBL.Masters;
using System.Collections.Generic;
using HotLeadBL.HotLeadsTran;
using System.Net.Mail;
using System.Text.RegularExpressions;


public partial class CentralReport : System.Web.UI.Page
{
    public GeneralFunc objGeneralFunc = new GeneralFunc();
    DropdownBL objdropdownBL = new DropdownBL();
    DataSet CarsDetails = new DataSet();
    DataSet dsDropDown = new DataSet();
    DataSet dsActiveSaleAgents = new DataSet();
    CentralDBMainBL objCentralDBBL = new CentralDBMainBL();
    UserRegistrationInfo objUserregInfo = new UserRegistrationInfo();
    HotLeadsBL objHotLeadBL = new HotLeadsBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session[Constants.NAME] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                Session["CurrentPage"] = "Brands";

                if (LoadIndividualUserRights() == false)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    if (Session[Constants.NAME] == null)
                    {
                        lnkBtnLogout.Visible = false;
                        lblUserName.Visible = false;
                    }
                    else
                    {

                        // LoadUserRights();
                        lnkBtnLogout.Visible = true;
                        lblUserName.Visible = true;
                        string LogUsername = Session[Constants.NAME].ToString();
                        string CenterCode = Session[Constants.CenterCode].ToString();
                        string UserLogName = Session[Constants.USER_NAME].ToString();
                        string Name = LogUsername + " " + UserLogName;
                        LogUsername = Name;
                        if (LogUsername.Length > 20)
                        {
                            lblUserName.Text = LogUsername.ToString().Substring(0, 20);
                            lblUserName.Text = lblUserName.Text + " (" + CenterCode.ToString() + ")";

                        }
                        else
                        {
                            lblUserName.Text = LogUsername;
                            if (CenterCode.Length > 5)
                            {
                                lblUserName.Text = lblUserName.Text + " (" + CenterCode.ToString().Substring(0, 5) + ")";
                            }
                            else
                            {
                                lblUserName.Text = lblUserName.Text + " (" + CenterCode.ToString() + ")";
                            }
                            //lblUserName.Text = lblUserName.Text + " (" + CenterCode.ToString() + ")";
                        }
                        FillAgents();
                        lnkTicker.Attributes.Add("href", "javascript:poptastic('Ticker.aspx?CID=" + Session[Constants.CenterCodeID] + "&CNAME=" + Session[Constants.CenterCode] + "');");
                        DataSet dsDatetime = objHotLeadBL.GetDatetime();
                        DateTime dtNow = Convert.ToDateTime(dsDatetime.Tables[0].Rows[0]["Datetime"].ToString());
                        txtStartDate.Text = dtNow.AddDays(-6).ToString("MM/dd/yyyy");
                        txtEndDate.Text = dtNow.ToString("MM/dd/yyyy");
                        DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
                        DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
                        GetResults(StartDate, EndDate);

                    }
                }
            }
        }
    }

    private void GetUserLogDetails()
    {
        //GriduserLog.DataSource = null;
        //GriduserLog.DataBind();
        //DataSet GetVehicles = new DataSet();
        //GetVehicles = objHotLeadBL.userLogDetails();
        //GriduserLog.DataSource = GetVehicles.Tables[0];
        //GriduserLog.DataBind();
    }

    private void LoadUserRights()
    {
        DataSet dsSession = new DataSet();
        dsSession = objHotLeadBL.GetUserSession((Session[Constants.USER_ID].ToString()));

        if (dsSession.Tables[0].Rows[0]["SessionID"].ToString() != HttpContext.Current.Session.SessionID.ToString())
        {

            Session["SessionTimeOut"] = 1;
            Response.Redirect("Login.aspx");

        }

    }
    private bool LoadIndividualUserRights()
    {
        DataSet dsIndidivitualRights = new DataSet();
        bool bValid = false;
        dsIndidivitualRights = objHotLeadBL.GetUserModules_ActiveInactive(Session[Constants.USER_ID].ToString());
        if (Session["IndividualUserRights"] == null)
        {
            dsIndidivitualRights = objHotLeadBL.GetUserModules_ActiveInactive(Session[Constants.USER_ID].ToString());
            Session["IndividualUserRights"] = dsIndidivitualRights;
        }
        else
        {
            dsIndidivitualRights = Session["IndividualUserRights"] as DataSet;
        }
        if (dsIndidivitualRights.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsIndidivitualRights.Tables[0].Rows.Count; i++)
            {

                //if (dsIndidivitualRights.Tables[0].Rows[i]["SubModuleName"].ToString() == Session["CurrentPage"].ToString())
                //{
                if (dsIndidivitualRights.Tables[0].Rows[i]["active"].ToString() == "1")
                {
                    string Modulename = dsIndidivitualRights.Tables[0].Rows[i]["SubModuleName"].ToString();

                    LinkButton lbl;
                    lbl = (LinkButton)Page.FindControl(Modulename);
                    try
                    {
                        lbl.Enabled = true;
                    }
                    catch { }
                }
                //else
                //{
                //    string Modulename = dsIndidivitualRights.Tables[0].Rows[i]["SubModuleName"].ToString();
                //    LinkButton lbl1;
                //    lbl1 = (LinkButton)Page.FindControl(Modulename);
                //    try
                //    {
                //        lbl1.Enabled = false;
                //    }
                //    catch { }
                //}



            }
            bValid = true;
            return bValid;
            //}
        }
        return bValid;
    }

    private void FillAgents()
    {
        try
        {
            DataSet dsverifier = objHotLeadBL.GetAgentsForAgents(Convert.ToInt32(Session[Constants.CenterCodeID].ToString()));
            ddlSaleAgent.Items.Clear();
            ddlSaleAgent.DataSource = dsverifier;
            ddlSaleAgent.DataTextField = "AgentUFirstName";
            ddlSaleAgent.DataValueField = "EMpid";
            ddlSaleAgent.DataBind();
            ddlSaleAgent.Items.Insert(0, new ListItem("All", "0"));
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void GetResults(DateTime StartDate, DateTime EndDate)
    {
        try
        {

            // DateTime StartingDate = Convert.ToDateTime(StartDate.AddDays(-1).ToString("MM/dd/yyyy"));
            //DateTime EndingDate = Convert.ToDateTime(EndDate.AddDays(1).ToString("MM/dd/yyyy"));
            string AgentID =ddlSaleAgent.SelectedItem.Value.ToString();
            DateTime StartingDate = StartDate;
            DateTime EndingDate = EndDate;
            string SaleAgentID = Session[Constants.USER_ID].ToString();
            int CenterCode = Convert.ToInt32(Session[Constants.CenterCodeID]);
            DataSet SingleAgentSales = new DataSet();
            SingleAgentSales = objHotLeadBL.GetAllAgentsSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            DataSet AbandonSales = objHotLeadBL.GetAllAgentsAbandonSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            DataSet dsTransferIn = objHotLeadBL.GetAllAgentsTransferOutSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            Session["AllAgentTransfersIN"] = dsTransferIn;
            tblTransfersIN.Style["display"] = "block";
            Session["AllAgentAbandonSales"] = AbandonSales;
            Session["AllAgentSales"] = SingleAgentSales;
            DataSet SingleVerifierSales = objHotLeadBL.GetAllAgentsVerifiesSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            Session["AllAgentVerifierSales"] = SingleVerifierSales;
            lblResHead.Text = "Center performance report for the period " + StartDate.ToString("MM/dd/yyyy") + " to " + EndDate.ToString("MM/dd/yyyy");
            if (SingleAgentSales.Tables[0].Rows.Count > 0)
            {
                lblTotSales.Text = SingleAgentSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotSales.Text = "0";
            }
            if (AbandonSales.Tables[0].Rows.Count > 0)
            {
                lblTotAbandon.Text = AbandonSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotAbandon.Text = "0";
            }
            if (SingleVerifierSales.Tables[0].Rows.Count > 0)
            {
                lblTotVerif.Text = SingleVerifierSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotVerif.Text = "0";
            }
            if (dsTransferIn.Tables[0].Rows.Count > 0)
            {
                lblTotTransfers.Text = dsTransferIn.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotTransfers.Text = "0";
            }

           if (rdbtnSales.Checked == true)
            {
                lblResCount.Text = "";
                lblRes.Text = "";
                grdWarmLeadInfo.Visible = true;
                grdVerifierData.Visible = false;
                grdAbandInfo.Visible = false;
                grdTransfersIn.Visible = false;
                if (SingleAgentSales.Tables[0].Rows.Count > 0)
                {
                  
                    grdWarmLeadInfo.Visible = true;
                    lblResCount.Visible = true;
                   // lblRes.Visible = false;
                    lblResCount.Text = "Total " + SingleAgentSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdWarmLeadInfo.DataSource = SingleAgentSales.Tables[0];
                    grdWarmLeadInfo.DataBind();
                   
                    Nameoftype.Text = "Sale(s)";
                }
                else
                {
                    grdWarmLeadInfo.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnAbandon.Checked == true)
            {
                lblResCount.Text = "";
                lblRes.Text = "";
                grdWarmLeadInfo.Visible = false;
                grdVerifierData.Visible = false;
                grdAbandInfo.Visible = true;
                grdTransfersIn.Visible = false;
                if (AbandonSales.Tables[0].Rows.Count > 0)
                {
                   
                    grdAbandInfo.Visible = true;
                    lblResCount.Visible = true;
                   // lblRes.Visible = false;
                    lblResCount.Text = "Total " + AbandonSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdAbandInfo.DataSource = AbandonSales.Tables[0];
                    grdAbandInfo.DataBind();
                    Nameoftype.Text = "Abondon(s)";
                }
                else
                {
                    grdAbandInfo.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnTransfers.Checked == true)
            {
                lblResCount.Text = "";
                lblRes.Text = "";
                grdWarmLeadInfo.Visible = false;
                grdVerifierData.Visible = false;
                grdAbandInfo.Visible = false;
                grdTransfersIn.Visible = true;
                if (dsTransferIn.Tables[0].Rows.Count > 0)
                {
                    grdTransfersIn.Visible = true;
                    lblResCount.Visible = true;
                  //  lblRes.Visible = false;
                    lblResCount.Text = "Total " + dsTransferIn.Tables[0].Rows.Count.ToString() + " transfer out records found";
                    grdTransfersIn.DataSource = dsTransferIn.Tables[0];
                    grdTransfersIn.DataBind();
                    Nameoftype.Text = "Transfer(s)";
                }
                else
                {
                    grdTransfersIn.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnVerifications.Checked == true)
            {
                lblResCount.Text = "";
                lblRes.Text = "";
                grdWarmLeadInfo.Visible = false;
                grdVerifierData.Visible = true;
                grdAbandInfo.Visible = false;
                grdTransfersIn.Visible = false;
                if (SingleVerifierSales.Tables[0].Rows.Count > 0)
                {

                    Nameoftype.Text = "Verifier(s)";
                    grdVerifierData.Visible = true;
                    lblResCount.Visible = true;
                   // lblRes.Visible = false;
                    lblResCount.Text = "Total " + SingleVerifierSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdVerifierData.DataSource = SingleVerifierSales.Tables[0];
                    grdVerifierData.DataBind();
                    string S1 = Nameoftype.Text;
                  
                }
                else
                {
                    grdVerifierData.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
          //  lblRes.Visible = false;
        }
        catch (Exception ex)
        {
            throw ex;
        }
      
    }
    protected void btnSearchMonth_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            GetResults(StartDate, EndDate);
        }
        catch (Exception ex) 
        {
            throw ex;
        }
    }
    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        try
        {
            HotLeadsBL objHotLeadsBL = new HotLeadsBL();
            DataSet dsDatetime = objHotLeadBL.GetDatetime();
            DateTime dtNow = Convert.ToDateTime(dsDatetime.Tables[0].Rows[0]["Datetime"].ToString());
            objHotLeadsBL.Perform_LogOut(Session[Constants.USER_ID].ToString(), dtNow, Session[Constants.USERLOG_ID].ToString(), 2);
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        catch (Exception ex)
        {
        }
    }
    protected void grdWarmLeadInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnAgentID = (HiddenField)e.Row.FindControl("hdnAgentID");
                Label lblAgent = (Label)e.Row.FindControl("lblAgent");
                HiddenField hdnAgentName = (HiddenField)e.Row.FindControl("hdnAgentName");
                HiddenField hdnVerifierID = (HiddenField)e.Row.FindControl("hdnVerifierID");
                Label lblVerifier = (Label)e.Row.FindControl("lblVerifier");
                HiddenField hdnVerifierName = (HiddenField)e.Row.FindControl("hdnVerifierName");

                HiddenField hdnPackName = (HiddenField)e.Row.FindControl("hdnPackName");
                HiddenField hdnPackCost = (HiddenField)e.Row.FindControl("hdnPackCost");
                Label lblPackage = (Label)e.Row.FindControl("lblPackage");
                Label lblPhone = (Label)e.Row.FindControl("lblPhone");
                HiddenField hdnPhoneNum = (HiddenField)e.Row.FindControl("hdnPhoneNum");

                Label lblPaid = (Label)e.Row.FindControl("lblPaid");
                Label lblPending = (Label)e.Row.FindControl("lblPending");
                HiddenField hdnPSID1Status = (HiddenField)e.Row.FindControl("hdnPSID1Status");
                HiddenField hdnPSID2Status = (HiddenField)e.Row.FindControl("hdnPSID2Status");
                HiddenField hdnAmount1 = (HiddenField)e.Row.FindControl("hdnAmount1");
                HiddenField hdnAmount2 = (HiddenField)e.Row.FindControl("hdnAmount2");
                Label lblQcStatus = (Label)e.Row.FindControl("lblQcStatus");
                HiddenField hdnQcStatus = (HiddenField)e.Row.FindControl("hdnQcStatus");
                HiddenField hdnQCNotes = (HiddenField)e.Row.FindControl("hdnQCNotes");

                Label lblPmntStatus = (Label)e.Row.FindControl("lblPmntStatus");
                HiddenField hdnPmntStatus = (HiddenField)e.Row.FindControl("hdnPmntStatus");
                HiddenField hdnPmntReason = (HiddenField)e.Row.FindControl("hdnPmntReason");
                LinkButton lnkCarID = (LinkButton)e.Row.FindControl("lnkCarID");
                HiddenField hdnPSIDNotes = (HiddenField)e.Row.FindControl("hdnPSIDNotes");
                Label lblName = (Label)e.Row.FindControl("lblName");
                HiddenField hdnSellerName = (HiddenField)e.Row.FindControl("hdnSellerName");
                HiddenField hdnLastName = (HiddenField)e.Row.FindControl("hdnLastName");
                HiddenField hdnQCStatusID = (HiddenField)e.Row.FindControl("hdnQCStatusID");

                Label lblYear = (Label)e.Row.FindControl("lblYear");
                HiddenField hdnYear = (HiddenField)e.Row.FindControl("hdnYear");
                HiddenField hdnMake = (HiddenField)e.Row.FindControl("hdnMake");
                HiddenField hdnModel = (HiddenField)e.Row.FindControl("hdnModel");

                lblYear.Text = hdnYear.Value + "/" + hdnMake.Value + "/" + hdnModel.Value;
                string TransName = string.Empty;
                if (hdnLastName.Value != "")
                {
                    TransName = hdnLastName.Value + " " + hdnSellerName.Value;
                }
                else
                {
                    TransName = hdnSellerName.Value;
                }
                if (TransName.Length > 15)
                {
                    lblName.Text = objGeneralFunc.WrapTextByMaxCharacters(TransName, 15);
                }
                else
                {
                    lblName.Text = TransName;
                }


                Double PackCost = new Double();
                PackCost = Convert.ToDouble(hdnPackCost.Value.ToString());
                string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                string PackName = hdnPackName.Value.ToString();
                lblPackage.Text = PackName + "($" + PackAmount + ")";
                if (hdnPhoneNum.Value.ToString() == "")
                {
                    lblPhone.Text = "";
                }
                else
                {
                    lblPhone.Text = objGeneralFunc.filPhnm(hdnPhoneNum.Value);
                }
                if (hdnAgentID.Value.ToString() != "0")
                {
                    lblAgent.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnAgentName.Value.ToString(), 15);
                }
                else
                {
                    lblAgent.Text = "";
                }

                if (hdnVerifierID.Value.ToString() != "0")
                {
                    lblVerifier.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnVerifierName.Value.ToString(), 15);
                }
                else
                {
                    lblVerifier.Text = "";
                }
                double PSID1AmountPaid = Convert.ToDouble("0.00");
                double PSID1AmountPend = Convert.ToDouble("0.00");
                if ((hdnPSID1Status.Value == "1") || (hdnPSID1Status.Value == "7"))
                {
                    //lblPrice.Text = "$" + string.Format("{0:0.00}", Convert.ToDouble(CarsDetails.Tables[0].Rows[0]["price"].ToString()));
                    PSID1AmountPaid = PSID1AmountPaid + Convert.ToDouble(hdnAmount1.Value);
                }
                else
                {
                    if (hdnAmount1.Value != "")
                    {
                        PSID1AmountPend = PSID1AmountPend + Convert.ToDouble(hdnAmount1.Value);
                    }
                }
                if (hdnPSID2Status.Value == "1")
                {
                    if (hdnAmount2.Value != "")
                    {
                        PSID1AmountPaid = PSID1AmountPaid + Convert.ToDouble(hdnAmount2.Value);
                    }
                }
                else
                {
                    if (hdnAmount2.Value != "")
                    {
                        PSID1AmountPend = PSID1AmountPend + Convert.ToDouble(hdnAmount2.Value);
                    }
                }
                lblPaid.Text = string.Format("{0:0.00}", PSID1AmountPaid);
                lblPending.Text = string.Format("{0:0.00}", PSID1AmountPend);
                if (hdnQcStatus.Value == "")
                {
                    lblQcStatus.Text = "QC Open";
                    lblQcStatus.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    if (hdnQCStatusID.Value == "1")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Green;
                    }
                    if (hdnQCStatusID.Value == "2")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Red;
                    }
                    if (hdnQCStatusID.Value == "3")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Orange;
                    }
                    if (hdnQCStatusID.Value == "4")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Blue;
                    }
                    lblQcStatus.Text = hdnQcStatus.Value;
                }
                if (hdnQCNotes.Value.Trim() != "")
                {
                    string sTable = CreateTable(hdnQCNotes.Value.Trim());
                    lblQcStatus.Attributes.Add("onmouseover", "return overlib1('" + sTable + "',STICKY, MOUSEOFF, CENTER, ABOVE,OFFSETX,30,  WIDTH, 100,  CSSCLASS,TEXTFONTCLASS,'summaryfontClass',FGCLASS,'summaryfgClass',BGCLASS,'summarybgClass',CAPTIONFONTCLASS,'summarycapfontClass', CLOSEFONTCLASS, 'summarycapfontClass');");
                    lblQcStatus.Attributes.Add("onmouseout", "return nd1(4000);");
                }
                lblPmntStatus.Text = hdnPmntStatus.Value;
                if ((hdnPSID1Status.Value == "2") || (hdnPSIDNotes.Value != ""))
                {
                    string NotesText = string.Empty;
                    if (hdnPmntReason.Value != "")
                    {
                        if (hdnPSID1Status.Value == "2")
                        {
                            NotesText = hdnPmntReason.Value + "<br />" + hdnPSIDNotes.Value;
                        }
                        else
                        {
                            NotesText = hdnPSIDNotes.Value;
                        }
                    }
                    else
                    {
                        NotesText = hdnPSIDNotes.Value;
                    }
                    if (NotesText.Trim() != "")
                    {
                        string sTable1 = CreateTable2(NotesText.Trim());
                        lblPmntStatus.Attributes.Add("onmouseover", "return overlib1('" + sTable1 + "',STICKY, MOUSEOFF, CENTER, ABOVE,OFFSETX,30,  WIDTH, 100,  CSSCLASS,TEXTFONTCLASS,'summaryfontClass',FGCLASS,'summaryfgClass',BGCLASS,'summarybgClass',CAPTIONFONTCLASS,'summarycapfontClass', CLOSEFONTCLASS, 'summarycapfontClass');");
                        lblPmntStatus.Attributes.Add("onmouseout", "return nd1(4000);");
                    }
                }
                if ((hdnPSID1Status.Value == "5") || (hdnQCStatusID.Value == "4"))
                {
                    lnkCarID.Enabled = true;
                }
                else
                {
                    lnkCarID.Enabled = false;
                }
                if ((hdnPSID1Status.Value == "1") || (hdnPSID1Status.Value == "7") || (hdnPSID1Status.Value == "8"))
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Green;
                }
                else if (hdnPSID1Status.Value == "2")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Red;
                }
                else if (hdnPSID1Status.Value == "3")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Orange;
                }
                else if ((hdnPSID1Status.Value == "4") || (hdnPSID1Status.Value == "6"))
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Black;
                }
                else if (hdnPSID1Status.Value == "5")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Blue;
                }
                else
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Yellow;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdWarmLeadInfo_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditSale")
            {
                int PostingID = Convert.ToInt32(e.CommandArgument.ToString());
                Session["AbandonSalePostingID"] = PostingID;
                Response.Redirect("NewSale.aspx");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdVerifierData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnAgentID = (HiddenField)e.Row.FindControl("hdnVerifyAgentID");
                Label lblAgent = (Label)e.Row.FindControl("lblVerifyAgent");
                HiddenField hdnAgentName = (HiddenField)e.Row.FindControl("hdnVerifyAgentName");
                HiddenField hdnVerifierID = (HiddenField)e.Row.FindControl("hdnVerifyVeriferID");
                Label lblVerifier = (Label)e.Row.FindControl("lblVerifyVerifer");
                HiddenField hdnVerifierName = (HiddenField)e.Row.FindControl("hdnVerifyVeriferName");

                HiddenField hdnPackName = (HiddenField)e.Row.FindControl("hdnVerifyPackName");
                HiddenField hdnPackCost = (HiddenField)e.Row.FindControl("hdnVerifyPackCost");
                Label lblPackage = (Label)e.Row.FindControl("lblVerifyPackage");
                Label lblPhone = (Label)e.Row.FindControl("lblVerifyPhone");
                HiddenField hdnPhoneNum = (HiddenField)e.Row.FindControl("hdnVerifyPhoneNum");

                Label lblPaid = (Label)e.Row.FindControl("lblVerifyPaid");
                Label lblPending = (Label)e.Row.FindControl("lblVerifyPending");
                HiddenField hdnPSID1Status = (HiddenField)e.Row.FindControl("hdnVerifyPSID1Status");
                HiddenField hdnPSID2Status = (HiddenField)e.Row.FindControl("hdnVerifyPSID2Status");
                HiddenField hdnAmount1 = (HiddenField)e.Row.FindControl("hdnVerifyAmount1");
                HiddenField hdnAmount2 = (HiddenField)e.Row.FindControl("hdnVerifyAmount2");
                Label lblQcStatus = (Label)e.Row.FindControl("lblVerifyQcStatus");
                HiddenField hdnQcStatus = (HiddenField)e.Row.FindControl("hdnVerifyQcStatus");
                HiddenField hdnQCNotes = (HiddenField)e.Row.FindControl("hdnVerifyQCNotes");

                Label lblPmntStatus = (Label)e.Row.FindControl("lblVerifyPmntStatus");
                HiddenField hdnPmntStatus = (HiddenField)e.Row.FindControl("hdnVerifyPmntStatus");
                HiddenField hdnPmntReason = (HiddenField)e.Row.FindControl("hdnVerifyPmntReason");
                Label lnkCarID = (Label)e.Row.FindControl("lnkVerifyCarID");
                HiddenField hdnPSIDNotes = (HiddenField)e.Row.FindControl("hdnVerifyPSIDNotes");
                Label lblName = (Label)e.Row.FindControl("lblVerifyName");
                HiddenField hdnSellerName = (HiddenField)e.Row.FindControl("hdnVerifySellerName");
                HiddenField hdnLastName = (HiddenField)e.Row.FindControl("hdnVerifyLastName");
                HiddenField hdnQCStatusID = (HiddenField)e.Row.FindControl("hdnVerifyQCStatusID");

                Label lblYear = (Label)e.Row.FindControl("lblVerifyYear");
                HiddenField hdnYear = (HiddenField)e.Row.FindControl("hdnVerifyYear");
                HiddenField hdnMake = (HiddenField)e.Row.FindControl("hdnVerifyMake");
                HiddenField hdnModel = (HiddenField)e.Row.FindControl("hdnVerifyModel");

                lblYear.Text = hdnYear.Value + "/" + hdnMake.Value + "/" + hdnModel.Value;
                string TransName = string.Empty;
                if (hdnLastName.Value != "")
                {
                    TransName = hdnLastName.Value + " " + hdnSellerName.Value;
                }
                else
                {
                    TransName = hdnSellerName.Value;
                }
                if (TransName.Length > 15)
                {
                    lblName.Text = objGeneralFunc.WrapTextByMaxCharacters(TransName, 15);
                }
                else
                {
                    lblName.Text = TransName;
                }


                Double PackCost = new Double();
                PackCost = Convert.ToDouble(hdnPackCost.Value.ToString());
                string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                string PackName = hdnPackName.Value.ToString();
                lblPackage.Text = PackName + "($" + PackAmount + ")";
                if (hdnPhoneNum.Value.ToString() == "")
                {
                    lblPhone.Text = "";
                }
                else
                {
                    lblPhone.Text = objGeneralFunc.filPhnm(hdnPhoneNum.Value);
                }
                if (hdnAgentID.Value.ToString() != "0")
                {
                    lblAgent.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnAgentName.Value.ToString(), 15);
                }
                else
                {
                    lblAgent.Text = "";
                }

                if (hdnVerifierID.Value.ToString() != "0")
                {
                    lblVerifier.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnVerifierName.Value.ToString(), 15);
                }
                else
                {
                    lblVerifier.Text = "";
                }
                double PSID1AmountPaid = Convert.ToDouble("0.00");
                double PSID1AmountPend = Convert.ToDouble("0.00");
                if ((hdnPSID1Status.Value == "1") || (hdnPSID1Status.Value == "7"))
                {
                    //lblPrice.Text = "$" + string.Format("{0:0.00}", Convert.ToDouble(CarsDetails.Tables[0].Rows[0]["price"].ToString()));
                    PSID1AmountPaid = PSID1AmountPaid + Convert.ToDouble(hdnAmount1.Value);
                }
                else
                {
                    if (hdnAmount1.Value != "")
                    {
                        PSID1AmountPend = PSID1AmountPend + Convert.ToDouble(hdnAmount1.Value);
                    }
                }
                if (hdnPSID2Status.Value == "1")
                {
                    if (hdnAmount2.Value != "")
                    {
                        PSID1AmountPaid = PSID1AmountPaid + Convert.ToDouble(hdnAmount2.Value);
                    }
                }
                else
                {
                    if (hdnAmount2.Value != "")
                    {
                        PSID1AmountPend = PSID1AmountPend + Convert.ToDouble(hdnAmount2.Value);
                    }
                }
                lblPaid.Text = string.Format("{0:0.00}", PSID1AmountPaid);
                lblPending.Text = string.Format("{0:0.00}", PSID1AmountPend);
                if (hdnQcStatus.Value == "")
                {
                    lblQcStatus.Text = "QC Open";
                    lblQcStatus.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    if (hdnQCStatusID.Value == "1")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Green;
                    }
                    if (hdnQCStatusID.Value == "2")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Red;
                    }
                    if (hdnQCStatusID.Value == "3")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Orange;
                    }
                    if (hdnQCStatusID.Value == "4")
                    {
                        lblQcStatus.ForeColor = System.Drawing.Color.Blue;
                    }
                    lblQcStatus.Text = hdnQcStatus.Value;
                }
                if (hdnQCNotes.Value.Trim() != "")
                {
                    string sTable = CreateTable(hdnQCNotes.Value.Trim());
                    lblQcStatus.Attributes.Add("onmouseover", "return overlib1('" + sTable + "',STICKY, MOUSEOFF, CENTER, ABOVE,OFFSETX,30,  WIDTH, 100,  CSSCLASS,TEXTFONTCLASS,'summaryfontClass',FGCLASS,'summaryfgClass',BGCLASS,'summarybgClass',CAPTIONFONTCLASS,'summarycapfontClass', CLOSEFONTCLASS, 'summarycapfontClass');");
                    lblQcStatus.Attributes.Add("onmouseout", "return nd1(4000);");
                }
                lblPmntStatus.Text = hdnPmntStatus.Value;
                if ((hdnPSID1Status.Value == "2") || (hdnPSIDNotes.Value != ""))
                {
                    string NotesText = string.Empty;
                    if (hdnPmntReason.Value != "")
                    {
                        if (hdnPSID1Status.Value == "2")
                        {
                            NotesText = hdnPmntReason.Value + "<br />" + hdnPSIDNotes.Value;
                        }
                        else
                        {
                            NotesText = hdnPSIDNotes.Value;
                        }
                    }
                    else
                    {
                        NotesText = hdnPSIDNotes.Value;
                    }
                    if (NotesText.Trim() != "")
                    {
                        string sTable1 = CreateTable2(NotesText.Trim());
                        lblPmntStatus.Attributes.Add("onmouseover", "return overlib1('" + sTable1 + "',STICKY, MOUSEOFF, CENTER, ABOVE,OFFSETX,30,  WIDTH, 100,  CSSCLASS,TEXTFONTCLASS,'summaryfontClass',FGCLASS,'summaryfgClass',BGCLASS,'summarybgClass',CAPTIONFONTCLASS,'summarycapfontClass', CLOSEFONTCLASS, 'summarycapfontClass');");
                        lblPmntStatus.Attributes.Add("onmouseout", "return nd1(4000);");
                    }
                }
                if ((hdnPSID1Status.Value == "5") || (hdnQCStatusID.Value == "4"))
                {
                    lnkCarID.Enabled = true;
                }
                else
                {
                    lnkCarID.Enabled = false;
                }
                if ((hdnPSID1Status.Value == "1") || (hdnPSID1Status.Value == "7") || (hdnPSID1Status.Value == "8"))
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Green;
                }
                else if (hdnPSID1Status.Value == "2")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Red;
                }
                else if (hdnPSID1Status.Value == "3")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Orange;
                }
                else if ((hdnPSID1Status.Value == "4") || (hdnPSID1Status.Value == "6"))
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Black;
                }
                else if (hdnPSID1Status.Value == "5")
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Blue;
                }
                else
                {
                    lblPmntStatus.ForeColor = System.Drawing.Color.Yellow;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void grdAbandInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnAbandonAgentID = (HiddenField)e.Row.FindControl("hdnAbandonAgentID");
                Label lblAbandonAgent = (Label)e.Row.FindControl("lblAbandonAgent");
                HiddenField hdnAbandonAgentName = (HiddenField)e.Row.FindControl("hdnAbandonAgentName");
                HiddenField hdnAbandonPackName = (HiddenField)e.Row.FindControl("hdnAbandonPackName");
                HiddenField hdnAbandonPackCost = (HiddenField)e.Row.FindControl("hdnAbandonPackCost");
                Label lblAbandonPackage = (Label)e.Row.FindControl("lblAbandonPackage");
                Label lblAbandonPhone = (Label)e.Row.FindControl("lblAbandonPhone");
                HiddenField hdnAbandonPhoneNum = (HiddenField)e.Row.FindControl("hdnAbandonPhoneNum");
                Label lblAbandonName = (Label)e.Row.FindControl("lblAbandonName");
                HiddenField hdnAbandonSellerName = (HiddenField)e.Row.FindControl("hdnAbandonSellerName");
                HiddenField hdnAbandonLastName = (HiddenField)e.Row.FindControl("hdnAbandonLastName");

                Label lblYear = (Label)e.Row.FindControl("lblAbandonYear");
                HiddenField hdnYear = (HiddenField)e.Row.FindControl("hdnAbandonYear");
                HiddenField hdnMake = (HiddenField)e.Row.FindControl("hdnAbandonMake");
                HiddenField hdnModel = (HiddenField)e.Row.FindControl("hdnAbandonModel");

                lblYear.Text = hdnYear.Value + "/" + hdnMake.Value + "/" + hdnModel.Value;
                string TransName = string.Empty;
                if (hdnAbandonLastName.Value != "")
                {
                    TransName = hdnAbandonLastName.Value + " " + hdnAbandonSellerName.Value;
                }
                else
                {
                    TransName = hdnAbandonSellerName.Value;
                }
                if (TransName.Length > 15)
                {
                    lblAbandonName.Text = objGeneralFunc.WrapTextByMaxCharacters(TransName, 15);
                }
                else
                {
                    lblAbandonName.Text = TransName;
                }

                Double PackCost = new Double();
                PackCost = Convert.ToDouble(hdnAbandonPackCost.Value.ToString());
                string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                string PackName = hdnAbandonPackName.Value.ToString();
                lblAbandonPackage.Text = PackName + "($" + PackAmount + ")";
                if (hdnAbandonPhoneNum.Value.ToString() == "")
                {
                    lblAbandonPhone.Text = "";
                }
                else
                {
                    lblAbandonPhone.Text = objGeneralFunc.filPhnm(hdnAbandonPhoneNum.Value);
                }
                if (hdnAbandonAgentID.Value.ToString() != "0")
                {
                    lblAbandonAgent.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnAbandonAgentName.Value.ToString(), 15);
                }
                else
                {
                    lblAbandonAgent.Text = "";
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdAbandInfo_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditSale")
            {
                int PostingID = Convert.ToInt32(e.CommandArgument.ToString());
                Session["AbandonSalePostingID"] = PostingID;
                Response.Redirect("NewSale.aspx");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdTransfersIn_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnAgentID = (HiddenField)e.Row.FindControl("hdnTransAgentID");
                Label lblAgent = (Label)e.Row.FindControl("lblTransAgent");
                HiddenField hdnAgentName = (HiddenField)e.Row.FindControl("hdnTransAgentName");
                HiddenField hdnPackName = (HiddenField)e.Row.FindControl("hdnTransPackName");
                HiddenField hdnPackCost = (HiddenField)e.Row.FindControl("hdnTransPackCost");
                Label lblPackage = (Label)e.Row.FindControl("lblTransPackage");
                Label lblPhone = (Label)e.Row.FindControl("lblTransPhone");
                HiddenField hdnPhoneNum = (HiddenField)e.Row.FindControl("hdnTransPhoneNum");

                HiddenField hdnTransVerifierID = (HiddenField)e.Row.FindControl("hdnTransVerifierID");
                Label lblTransVerifier = (Label)e.Row.FindControl("lblTransVerifier");
                HiddenField hdnTransVerifierName = (HiddenField)e.Row.FindControl("hdnTransVerifierName");
                Label lblTransStatus = (Label)e.Row.FindControl("lblTransStatus");
                HiddenField hdnTransStatusName = (HiddenField)e.Row.FindControl("hdnTransStatusName");
                HiddenField hdnTransStatusID = (HiddenField)e.Row.FindControl("hdnTransStatusID");
                HiddenField hdnTransDisposID = (HiddenField)e.Row.FindControl("hdnTransDisposID");
                HiddenField hdnTransDisposName = (HiddenField)e.Row.FindControl("hdnTransDisposName");
                Label lblTransName = (Label)e.Row.FindControl("lblTransName");
                HiddenField hdnTransSellerName = (HiddenField)e.Row.FindControl("hdnTransSellerName");
                HiddenField hdnTransLastName = (HiddenField)e.Row.FindControl("hdnTransLastName");

                Label lblYear = (Label)e.Row.FindControl("lblTransYear");
                HiddenField hdnYear = (HiddenField)e.Row.FindControl("hdnTransYear");
                HiddenField hdnMake = (HiddenField)e.Row.FindControl("hdnTransMake");
                HiddenField hdnModel = (HiddenField)e.Row.FindControl("hdnTransModel");

                lblYear.Text = hdnYear.Value + "/" + hdnMake.Value + "/" + hdnModel.Value;

                string TransName = string.Empty;
                if (hdnTransLastName.Value != "")
                {
                    TransName = hdnTransLastName.Value + " " + hdnTransSellerName.Value;
                }
                else
                {
                    TransName = hdnTransSellerName.Value;
                }
                if (TransName.Length > 15)
                {
                    lblTransName.Text = objGeneralFunc.WrapTextByMaxCharacters(TransName, 15);
                }
                else
                {
                    lblTransName.Text = TransName;
                }
                if (hdnTransStatusID.Value == "4")
                {
                    if (hdnTransDisposName.Value != "")
                    {
                        lblTransStatus.Text = hdnTransDisposName.Value;
                    }
                    else
                    {
                        lblTransStatus.Text = hdnTransStatusName.Value;
                    }
                }
                else
                {
                    lblTransStatus.Text = hdnTransStatusName.Value;
                }


                Double PackCost = new Double();
                PackCost = Convert.ToDouble(hdnPackCost.Value.ToString());
                string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                string PackName = hdnPackName.Value.ToString();
                lblPackage.Text = PackName + "($" + PackAmount + ")";
                if (hdnPhoneNum.Value.ToString() == "")
                {
                    lblPhone.Text = "";
                }
                else
                {
                    lblPhone.Text = objGeneralFunc.filPhnm(hdnPhoneNum.Value);
                }
                if (hdnAgentID.Value.ToString() != "0")
                {
                    lblAgent.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnAgentName.Value.ToString(), 15);
                }
                else
                {
                    lblAgent.Text = "";
                }
                if (hdnTransVerifierID.Value.ToString() != "0")
                {
                    lblTransVerifier.Text = objGeneralFunc.WrapTextByMaxCharacters(hdnTransVerifierName.Value.ToString(), 15);
                }
                else
                {
                    lblTransVerifier.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdTransfersIn_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditSale")
            {
                int PostingID = Convert.ToInt32(e.CommandArgument.ToString());
                Session["AbandonSalePostingID"] = PostingID;
                Response.Redirect("NewSale.aspx");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void rdbtnSales_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            GetResults(StartDate, EndDate);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rdbtnVerifications_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            GetResults(StartDate, EndDate);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rdbtnAbandon_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            GetResults(StartDate, EndDate);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rdbtnTransfers_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            GetResults(StartDate, EndDate);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

 
    private string CreateTable(string QcNotes)
    {
        QcNotes = QcNotes.Replace("\n", "<br />");
        string strTransaction = string.Empty;
        strTransaction = "<table width=\"330px\" id=\"SalesStatus\" style=\"display: block; box-shadow: 0 0 8px rgba(0,0,0,0.4);background-color: #fff; border: #999 1px solid; padding: 2px; height: 190px\">";
        strTransaction += "<tr id=\"CampaignsBody3\">";
        strTransaction += "<td  style=\"text-align:center;background-color:#ccc;width: 330px;\"> QC Notes";
        strTransaction += "</td>";
        strTransaction += " </tr>";
        strTransaction += "<tr >";
        strTransaction += "<td  style=\"padding-left:10px;\" align=\"left\"> <div style=\"overflow: scroll; width: 310px; height: 150px;\">";
        strTransaction += QcNotes;
        strTransaction += "</div></td>";
        strTransaction += " </tr>";
        strTransaction += "</table>";

        return strTransaction;

    }
    private string CreateTable2(string PmntStatusReason)
    {
        PmntStatusReason = PmntStatusReason.Replace("\n", "<br />");
        string strTransaction = string.Empty;
        strTransaction = "<table width=\"330px\" id=\"PmntStatus\" style=\"display: block; box-shadow: 0 0 8px rgba(0,0,0,0.4);background-color: #fff; border: #999 1px solid; padding: 2px; height: 190px\">";
        strTransaction += "<tr id=\"CampaignsBody3\">";
        strTransaction += "<td  style=\"text-align:center;background-color:#ccc;width: 330px;\"> Payment notes";
        strTransaction += "</td>";
        strTransaction += " </tr>";
        strTransaction += "<tr >";
        strTransaction += "<td  style=\"padding-left:10px;\" align=\"left\"> <div style=\"overflow: scroll; width: 310px; height: 150px;\">";
        strTransaction += PmntStatusReason;
        strTransaction += "</div></td>";
        strTransaction += " </tr>";
        strTransaction += "</table>";

        return strTransaction;

    }


    protected void BtnQCSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime StartDate = Convert.ToDateTime(txtStartDate.Text.ToString());
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text.ToString());
            string search = txtQCSearch.Text;
            search = search.Replace("-", "");
            GetResults1(StartDate, EndDate, search);
        }
        catch { }
    }
    private void GetResults1(DateTime StartDate, DateTime EndDate, string search)
    {
        try
        {

            // DateTime StartingDate = Convert.ToDateTime(StartDate.AddDays(-1).ToString("MM/dd/yyyy"));
            //DateTime EndingDate = Convert.ToDateTime(EndDate.AddDays(1).ToString("MM/dd/yyyy"));
            string AgentID =ddlSaleAgent.SelectedItem.Value;
            DateTime StartingDate = StartDate;
            DateTime EndingDate = EndDate;
            string SaleAgentID = Session[Constants.USER_ID].ToString();
            int CenterCode = Convert.ToInt32(Session[Constants.CenterCodeID]);
            DataSet SingleAgentSales = new DataSet();
            if (ddlQCSearch.Text == "SaleID")
                SingleAgentSales = objHotLeadBL.GetAllAgentsSalesDataSearchByPostingId(StartingDate, EndingDate, CenterCode, AgentID, txtQCSearch.Text);
            else if (ddlQCSearch.Text == "Phone")
                SingleAgentSales = objHotLeadBL.GetAllAgentsSalesDataSearchByPhone(StartingDate, EndingDate, CenterCode, AgentID, search);
            else if (ddlQCSearch.Text == "Name")
                SingleAgentSales = objHotLeadBL.GetAllAgentsSalesDataSearchByName(StartingDate, EndingDate, CenterCode, AgentID, txtQCSearch.Text);
            DataSet AbandonSales = objHotLeadBL.GetAllAgentsAbandonSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            DataSet dsTransferIn = objHotLeadBL.GetAllAgentsTransferOutSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            Session["AllAgentTransfersIN"] = dsTransferIn;
            tblTransfersIN.Style["display"] = "block";
            Session["AllAgentAbandonSales"] = AbandonSales;
            Session["AllAgentSales"] = SingleAgentSales;
            DataSet SingleVerifierSales = objHotLeadBL.GetAllAgentsVerifiesSalesData(StartingDate, EndingDate, CenterCode, AgentID);
            Session["AllAgentVerifierSales"] = SingleVerifierSales;
            lblResHead.Text = "Center performance report for the period " + StartDate.ToString("MM/dd/yyyy") + " to " + EndDate.ToString("MM/dd/yyyy");
            if (SingleAgentSales.Tables[0].Rows.Count > 0)
            {
                lblTotSales.Text = SingleAgentSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotSales.Text = "0";
            }
            if (AbandonSales.Tables[0].Rows.Count > 0)
            {
                lblTotAbandon.Text = AbandonSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotAbandon.Text = "0";
            }
            if (SingleVerifierSales.Tables[0].Rows.Count > 0)
            {
                lblTotVerif.Text = SingleVerifierSales.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotVerif.Text = "0";
            }
            if (dsTransferIn.Tables[0].Rows.Count > 0)
            {
                lblTotTransfers.Text = dsTransferIn.Tables[0].Rows.Count.ToString();
            }
            else
            {
                lblTotTransfers.Text = "0";
            }

            if (rdbtnSales.Checked == true)
            {
                tblSales.Style["display"] = "block";
                //tblVerifies.Style["display"] = "none";
                tblAbandon.Style["display"] = "none";
                tblTransfersIN.Style["display"] = "none";
                if (SingleAgentSales.Tables[0].Rows.Count > 0)
                {
                    grdWarmLeadInfo.Visible = true;
                    lblResCount.Visible = true;
                    lblRes.Visible = false;
                    lblResCount.Text = "Total " + SingleAgentSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdWarmLeadInfo.DataSource = SingleAgentSales.Tables[0];
                    grdWarmLeadInfo.DataBind();
                }
                else
                {
                    grdWarmLeadInfo.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnVerifications.Checked == true)
            {
                tblSales.Style["display"] = "none";
              //  tblVerifies.Style["display"] = "block";
                tblAbandon.Style["display"] = "none";
                tblTransfersIN.Style["display"] = "none";
                if (SingleVerifierSales.Tables[0].Rows.Count > 0)
                {
                    grdVerifierData.Visible = true;
                    lblResCount.Visible = true;
                    lblRes.Visible = false;
                    lblResCount.Text = "Total " + SingleVerifierSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdVerifierData.DataSource = SingleVerifierSales.Tables[0];
                    grdVerifierData.DataBind();
                }
                else
                {
                    grdVerifierData.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnAbandon.Checked == true)
            {
                tblSales.Style["display"] = "none";
               // tblVerifies.Style["display"] = "none";
                tblAbandon.Style["display"] = "block";
                tblTransfersIN.Style["display"] = "none";
                if (AbandonSales.Tables[0].Rows.Count > 0)
                {
                    grdAbandInfo.Visible = true;
                    lblResCount.Visible = true;
                    lblRes.Visible = false;
                    lblResCount.Text = "Total " + AbandonSales.Tables[0].Rows.Count.ToString() + " records found";
                    grdAbandInfo.DataSource = AbandonSales.Tables[0];
                    grdAbandInfo.DataBind();
                }
                else
                {
                    grdAbandInfo.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }
            }
            if (rdbtnTransfers.Checked == true)
            {
                tblSales.Style["display"] = "none";
              //  tblVerifies.Style["display"] = "none";
                tblAbandon.Style["display"] = "none";
                tblTransfersIN.Style["display"] = "block";
                if (dsTransferIn.Tables[0].Rows.Count > 0)
                {
                    grdTransfersIn.Visible = true;
                    lblResCount.Visible = true;
                    lblRes.Visible = false;
                    lblResCount.Text = "Total " + dsTransferIn.Tables[0].Rows.Count.ToString() + " transfer out records found";
                    grdTransfersIn.DataSource = dsTransferIn.Tables[0];
                    grdTransfersIn.DataBind();
                }
                else
                {
                    grdTransfersIn.Visible = false;
                    lblResCount.Visible = false;
                    lblRes.Visible = true;
                    lblRes.Text = "No records exist";
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void grdVerifierData__Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            DataSet dt = new DataSet();
            dt = Session["AllCentersVerifiesSales"] as DataSet;

            if (dt != null)
            {
                BizUtility.GridSort(txthdnSortOrder, e, grdVerifierData, 0, dt.Tables[0]);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdAbandInfo_Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            DataSet dt = new DataSet();
            dt = Session["AllCentersAgentAbandonSales"] as DataSet;

            if (dt != null)
            {
                BizUtility.GridSort(txthdnSortOrder, e, grdAbandInfo, 0, dt.Tables[0]);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void grdTransfersIn_Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            DataSet dt = new DataSet();
            dt = Session["AllCentersAgentTransferOutSales"] as DataSet;

            if (dt != null)
            {
                BizUtility.GridSort(txthdnSortOrder, e, grdTransfersIn, 0, dt.Tables[0]);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void grdWarmLeadInfo_Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            DataSet dt = new DataSet();
            dt = Session["AllCentersAgentSales"] as DataSet;

            if (dt != null)
            {
                BizUtility.GridSort(txthdnSortOrder, e, grdWarmLeadInfo, 0, dt.Tables[0]);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
