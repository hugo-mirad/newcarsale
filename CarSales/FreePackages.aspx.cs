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


public partial class FreePackages : System.Web.UI.Page
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
                        lnkTicker.Attributes.Add("href", "javascript:poptastic('Ticker.aspx?CID=" + Session[Constants.CenterCodeID] + "&CNAME=" + Session[Constants.CenterCode] + "');");

                        Session["SortDirec"] = null;


                        Filllocations();
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

    private void Filllocations()
    {
        try
        {
            DataSet dsCenters = objHotLeadBL.GetAllLocations();
            ddlCenters.Items.Clear();
            for (int i = 0; i < dsCenters.Tables[0].Rows.Count; i++)
            {
                if (dsCenters.Tables[0].Rows[i]["LocationId"].ToString() != "0")
                {
                    ListItem list = new ListItem();
                    list.Text = dsCenters.Tables[0].Rows[i]["LocationName"].ToString();
                    list.Value = dsCenters.Tables[0].Rows[i]["LocationId"].ToString();
                    ddlCenters.Items.Add(list);
                }
            }
            ddlCenters.Items.Insert(0, new ListItem("All", "0"));

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void GetUserLogDetails()
    {
        DateTime StartDate = Convert.ToDateTime(DateTime.Now.AddDays(-6));
        DateTime EndDate = Convert.ToDateTime(DateTime.Now);
        DateTime StartingDate = StartDate;
        DateTime EndingDate = EndDate;
        string SaleAgentID = Session[Constants.USER_ID].ToString();
        int CenterCode = Convert.ToInt32(1);
        DataSet AbandonSales = objHotLeadBL.GetAllCentersAgentsAbandonSalesData(StartingDate, EndingDate, CenterCode);

    }
    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("login.aspx");
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
                HiddenField hdnPackDiscount = (HiddenField)e.Row.FindControl("hdnPackDiscount");
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
                Label lnkCarID = (Label)e.Row.FindControl("lnkCarID");
                HiddenField hdnPSIDNotes = (HiddenField)e.Row.FindControl("hdnPSIDNotes");
                Label lblName = (Label)e.Row.FindControl("lblName");
                HiddenField hdnSellerName = (HiddenField)e.Row.FindControl("hdnSellerName");
                HiddenField hdnLastName = (HiddenField)e.Row.FindControl("hdnLastName");
                HiddenField hdnQCStatusID = (HiddenField)e.Row.FindControl("hdnQCStatusID");
                HiddenField hdnAgentCenterCode = (HiddenField)e.Row.FindControl("hdnAgentCenterCode");
                HiddenField hdnVerifierCenterCode = (HiddenField)e.Row.FindControl("hdnVerifierCenterCode");

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



                //Discount 21-11-2013 starts 
                //Double PackCost = new Double();
                //PackCost = Convert.ToDouble(hdnPackCost.Value.ToString());
                //string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                //string PackName = hdnPackName.Value.ToString();
                //lblPackage.Text = PackName + "($" + PackAmount + ")";
                //Discount 21-11-2013 Ends

                Double PackCost = new Double();
                PackCost = Convert.ToDouble(hdnPackCost.Value.ToString());
                string PackAmount = string.Format("{0:0.00}", PackCost).ToString();
                string PackName = hdnPackName.Value.ToString();
                lblPackage.Text = PackName + "($" + PackAmount + "";
                if (hdnPackDiscount.Value != "0")
                {
                    if (hdnPackDiscount.Value != "")
                        lblPackage.Text += "-" + hdnPackDiscount.Value + ")";
                }
                else
                    lblPackage.Text += ")";


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
                    lblAgent.Text = objGeneralFunc.GetCenterCode(hdnAgentCenterCode.Value) + ":" + objGeneralFunc.WrapTextByMaxCharacters(hdnAgentName.Value.ToString(), 15);
                }
                else
                {
                    lblAgent.Text = "";
                }

                if (hdnVerifierID.Value.ToString() != "0")
                {
                    lblVerifier.Text = objGeneralFunc.GetCenterCode(hdnVerifierCenterCode.Value) + ":" + objGeneralFunc.WrapTextByMaxCharacters(hdnVerifierName.Value.ToString(), 15);
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
                    string sTable = CreateTable(hdnQCNotes.Value);
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
    public void btnSearchMonth_Click(object sender, EventArgs e)
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
    private void GetResults(DateTime StartDate, DateTime EndDate)
    {
        // DateTime StartingDate = Convert.ToDateTime(StartDate.AddDays(-1).ToString("MM/dd/yyyy"));
        //DateTime EndingDate = Convert.ToDateTime(EndDate.AddDays(1).ToString("MM/dd/yyyy"));
        DateTime StartingDate = StartDate;
        DateTime EndingDate = EndDate;
        string SaleAgentID = Session[Constants.USER_ID].ToString();
        int CenterCode = Convert.ToInt32(ddlCenters.SelectedItem.Value);
        DataSet SingleAgentSales = new DataSet();
        SingleAgentSales = objHotLeadBL.GetAllCentersAgentsSalesData(StartingDate, EndingDate, CenterCode);
        Session["AllCentersAgentSales"] = SingleAgentSales;

        lblResHead.Text = "All centers performance report for the period " + StartDate.ToString("MM/dd/yyyy") + " to " + EndDate.ToString("MM/dd/yyyy");


        try
        {
            lblResCount.Text = "";
            lblRes.Text = "";
            grdWarmLeadInfo.Visible = true;
            if (SingleAgentSales.Tables[0].Rows.Count > 0)
            {

                grdWarmLeadInfo.Visible = true;
                lblResCount.Visible = true;
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
        catch { }


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

}