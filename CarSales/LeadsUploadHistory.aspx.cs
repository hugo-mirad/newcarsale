﻿using System;
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
using HotLeadBL.Leads;


public partial class CopyPage : System.Web.UI.Page
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
                Session["CurrentPage"] = "Leads";

                if (Session[Constants.NAME] == null)
                {
                    lnkBtnLogout.Visible = false;
                    lblUserName.Visible = false;
                }
                else
                {
                    LoadIndividualUserRights();
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
                }
                lnkTicker.Attributes.Add("href", "javascript:poptastic('Ticker.aspx?CID=" + Session[Constants.CenterCodeID] + "&CNAME=" + Session[Constants.CenterCode] + "');");
                //LoadVehicletype();
            }
        }
    }


    private void LoadVehicletype()
    {
        try
        {
            VehicleTypeBL objVehicleTypeBL = new VehicleTypeBL();

            DataSet dsVehicleTypes = new DataSet();

            if (Cache["VehicleType"] == null)
            {
                dsVehicleTypes = objVehicleTypeBL.GetVehicleType();
                Cache["VehicleType"] = dsVehicleTypes;
            }
            else
            {
                dsVehicleTypes = (DataSet)Cache["VehicleType"];
            }



            ddlVehicleType.DataValueField = "VehicleTypeID";
            ddlVehicleType.DataTextField = "VehicleType";
            ddlVehicleType.DataSource = dsVehicleTypes.Tables[0];
            ddlVehicleType.DataBind();


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



    #region LoadUserRight

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
              
            }
            bValid = true;
            return bValid;
            //}
        }
        return bValid;
    }
    private void LoadUserRights()
    {

        DataSet dsSession = new DataSet();
        dsSession = objHotLeadBL.GetUserSession(Session[Constants.USER_ID].ToString());

        if (dsSession.Tables[0].Rows[0]["SessionID"].ToString() != HttpContext.Current.Session.SessionID.ToString())
        {
            // objUserlog.Perform_LogOut(Session[Constants.USER_ID].Tostring(), System.DateTime.Now, Session[Constants.USERLOG_ID].ToString(), 8);

            Session["SessionTimeOut"] = 1;
            Response.Redirect("Login.aspx");

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

    #endregion LoadUserRight


    private void GetLeadsDownloadHistory()
    {
        try
        {
            LeadsDownloadBL objLeadsDownloadBL = new LeadsDownloadBL();

            DataSet dsStateAllocation = objLeadsDownloadBL.GetLeadsDownloadUploadHistory(ddlVehicleType.SelectedItem.Value);
            if (dsStateAllocation.Tables[0].Rows.Count > 0)
            {
                rptrDownload.Visible = true;
                ldsHeading.Visible = true;
                ldsHeading.Text = "Center wise leads";
                rptrDownload.DataSource = dsStateAllocation.Tables[0];
                rptrDownload.DataBind();
            }
            else
            {
                ldsHeading.Visible = true;
                ldsHeading.Text = "Leads not uploaded";
                rptrDownload.Visible = false;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }


    }


    protected void btnGet_Click(object sender, EventArgs e)
    {
        try
        {
            GetLeadsDownloadHistory();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void rptrDownload_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            LinkButton lblIssuanceBatchID = (LinkButton)e.Item.FindControl("lblIssuanceBatchID");
            LeadsDownloadBL obj = new LeadsDownloadBL();

            DataSet ds = obj.LeadsUploadDetailsByBatchID(lblIssuanceBatchID.Text);

            DataSetToExcel.Convert(ds, Response, "LeadsUploadHistory" + lblIssuanceBatchID.Text);
            //DataSetToExcel.Convert(ds, Response, "LeadsHistory" + lblIssuanceBatchID.Text + ".xls");
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}
