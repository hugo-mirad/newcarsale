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


public partial class DefaultRights : System.Web.UI.Page
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



                        GetUserDefaultRights();

                    }
                }
            }
        }
    }
    private void GetUserDefaultRights()
    {
        DataSet GetUserDefaultRight = new DataSet();
        GetUserDefaultRight = objHotLeadBL.GetUserDefaultRights(1);
        Session["MasterRoles"] = GetUserDefaultRight;
        GridDefaultUserRights.DataSource = GetUserDefaultRight.Tables[0];
        GridDefaultUserRights.DataBind();
    }


    protected void GridDefaultUserRights_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    DataSet dsTasks3 = (DataSet)Session["MasterRoles"];
            //    LinkButton lblRole = (LinkButton)e.Row.FindControl("lblRoleNamre");
            //    HiddenField Paymst = (HiddenField)e.Row.FindControl("hdnRoleId");
            //    Label lblVehType = (Label)e.Row.FindControl("lblVehType");
            //    lblVehType.Text = "Default";
            //    try
            //    {
            //        DataSet GetUserDefaultRight = new DataSet();
            //        string Paystats = Paymst.Value;
            //        GetUserDefaultRight = objHotLeadBL.GetUserDefaultRights(Convert.ToInt32(Paystats));

            //        for (int i = 0; i <= GetUserDefaultRight.Tables[0].Rows.Count; i++)
            //        {
            //            Label lblLeads = (Label)e.Row.FindControl("lblLeads");
            //            Label LblTransfers = (Label)e.Row.FindControl("LblTransfers");
            //            Label lblabondons = (Label)e.Row.FindControl("lblabondons");
            //            Label lblfreepots = (Label)e.Row.FindControl("lblfreepots");

            //            Label lblintromail = (Label)e.Row.FindControl("lblintromail");
            //            Label lblNeEntry = (Label)e.Row.FindControl("lblNeEntry");
            //            Label lblTransferOut = (Label)e.Row.FindControl("lblTransferOut");
            //            Label lblTicker = (Label)e.Row.FindControl("lblTicker");

            //            Label lblSelf = (Label)e.Row.FindControl("lblSelf");
            //            Label lblCenter = (Label)e.Row.FindControl("lblCenter");

            //            Label lblAdmin = (Label)e.Row.FindControl("lblAdmin");

            //            //1 Leads
            //            if (GetUserDefaultRight.Tables[0].Rows[i]["IsActive"].ToString() == "False")
            //            {
            //                LblTransfers.Text = ""; lblabondons.Text = ""; lblLeads.Text = ""; lblfreepots.Text = "";
            //            }
            //            else
            //            {
            //                LblTransfers.Text = "Y"; lblabondons.Text = "Y"; lblLeads.Text = "Y"; lblfreepots.Text = "Y";
            //            }
            //            //Sales
            //            if (GetUserDefaultRight.Tables[0].Rows[i]["IsActive"].ToString() == "False")
            //            {
            //                lblintromail.Text = ""; lblNeEntry.Text = ""; lblTransferOut.Text = ""; lblTicker.Text = "";
            //            }
            //            else
            //            {
            //                lblintromail.Text = "Y"; lblNeEntry.Text = "Y"; lblTransferOut.Text = "Y"; lblTicker.Text = "Y";
            //            }
            //            //3 Reports
            //            //4 Process
            //            if (GetUserDefaultRight.Tables[0].Rows[i]["IsActive"].ToString() == "False")
            //            {
            //                if (lblRole.Text == "Center Manager")
            //                {
            //                    lblSelf.Text = ""; lblCenter.Text = "Y";
            //                }
            //                else
            //                {
            //                    lblSelf.Text = ""; lblCenter.Text = "";
            //                }
            //            }
            //            else
            //            {
            //                if (lblRole.Text == "Center Manager")
            //                {
            //                    lblSelf.Text = "Y"; lblCenter.Text = "Y";
            //                }
            //                else
            //                {
            //                    lblSelf.Text = "Y"; lblCenter.Text = "";
            //                }
            //            }
            //            //Admin
            //            if ((GetUserDefaultRight.Tables[0].Rows[i]["IsActive"].ToString() == "False"))
            //            {
            //                lblAdmin.Text = "";
            //            }
            //            else
            //            {
            //                lblAdmin.Text = "Y";
            //            }

            //        }

            //    }
            //    catch { }
            //}
        }
        catch { }
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
                else
                {
                    string Modulename = dsIndidivitualRights.Tables[0].Rows[i]["SubModuleName"].ToString();
                    LinkButton lbl1;
                    lbl1 = (LinkButton)Page.FindControl(Modulename);
                    try
                    {
                        lbl1.Enabled = false;
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

    protected void GridDefaultUserRights_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;

            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "Role";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);


            HeaderCell = new TableCell();
            HeaderCell.Text = "Vehicle Type(s)";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Leads Download";
            HeaderCell.ColumnSpan = 4;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell.CssClass = "BL BR";

            HeaderCell = new TableCell();
            HeaderCell.Text = "Sales";
            HeaderCell.ColumnSpan = 4;
            HeaderGridRow.Cells.Add(HeaderCell);


            HeaderCell = new TableCell();
            HeaderCell.Text = "Reports";
            HeaderCell.ColumnSpan = 2;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell.CssClass = "BL BR";


            HeaderCell = new TableCell();
            HeaderCell.Text = "Sales Admin";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            GridDefaultUserRights.Controls[0].Controls.AddAt(0, HeaderGridRow);
        }

    }

    protected void btnAddVehicle_Click(object sender, EventArgs e)
    {
     
        bool LeadsUpload = false, LeadsDownLoad = false, Abondoned = false, FreePackage = false, Ticker = false, IntroMail = false,
                            NewEntry = false, Transferin = false, TransferOut = false, QC = false, Payments = false, Publish = false, MyReport1 = false,
                            Leads = false, Sales = false, Process = false, Executive = false, LeadsAdmin = false,
                            SalesAdmin = false, ProcessAdmin = false, ExecutiveAdmin = false, BrandsAdmin = false,
                            CentersAdmin = false, UsersLog = false, EditLog = false, Center = false, Self = false;
        int EMPID;

        if (Ckleads.Items[0].Selected == true)
        {
            LeadsUpload = true; LeadsDownLoad = true;
        }
        else
        {
            LeadsUpload = false; LeadsDownLoad = false;
        }

        if (Ckleads.Items[1].Selected == true) Transferin = true; else Transferin = false;
        if (Ckleads.Items[2].Selected == true) Abondoned = true; else Abondoned = false;
        if (Ckleads.Items[3].Selected == true) FreePackage = true; else FreePackage = false;


        if (chksales.Items[0].Selected == true) IntroMail = true; else IntroMail = false;
        if (chksales.Items[1].Selected == true) NewEntry = true; else NewEntry = false;
        if (chksales.Items[2].Selected == true) TransferOut = true; else TransferOut = false;
        if (chksales.Items[3].Selected == true) Ticker = true; else Ticker = false;


        if (ChkReports.Items[0].Selected == true) Self = true; else Self = false;
        if (ChkReports.Items[1].Selected == true) Center = true; else Center = false;

        if (chksaleadmin.Items[0].Selected == true) LeadsAdmin = true; else LeadsAdmin = false;


        EMPID =Convert.ToInt32(Session["EMpid"].ToString());

        string usertypid = "", LogPerson = "";
        try
        {
            usertypid = Session[Constants.USER_TYPE_ID].ToString();
        }
        catch { usertypid = "1"; }
        try
        {
            LogPerson = Session[Constants.USER_ID].ToString();
        }
        catch { }
        DataSet UserEmploRights = objHotLeadBL.UpdateDefalutRightsSales(EMPID, LeadsUpload, LeadsDownLoad, Abondoned, FreePackage, Ticker, IntroMail,
                           NewEntry, Transferin, TransferOut, Center, Self, LeadsAdmin, usertypid, LogPerson);

        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "Script", "alert('User Rights are updated successfully.');", true);
        GetUserDefaultRights();
        MpVechlAdd.Hide();

    }
    public void OnConfirm(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"];
        if (confirmValue == "Yes")
        {

            //Deactivating Empid from carsales.
            string EMpid = Session["EMpid"].ToString();
            DataSet dsSalesUpdateList = objHotLeadBL.DeleteEmployee(EMpid);
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "Script", "alert('" + EMpid + " has been deleted succesfully.');", true);
            MpVechlAdd.Hide();
            GetUserDefaultRights();
        }
        else
        {

        }
    }
    protected void GridDefaultUserRights_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            MpVechlAdd.Show();
            if (e.CommandName == "RoleId")
            {

                Ckleads.Items[0].Selected = false; Ckleads.Items[1].Selected = false; Ckleads.Items[2].Selected = false; Ckleads.Items[3].Selected = false;
                chksales.Items[0].Selected = false; chksales.Items[1].Selected = false; chksales.Items[2].Selected = false; chksales.Items[3].Selected = false;
                ChkReports.Items[0].Selected = false; ChkReports.Items[1].Selected = false; ChkReports.Items[1].Selected = false;
                chksaleadmin.Items[0].Selected = false;
                string EmpIdva = e.CommandArgument.ToString();


                Session["EMpid"] = EmpIdva.ToString();
                DataSet GetUserDefaultRight = new DataSet();
                string Paystats = EmpIdva.ToString();
                GetUserDefaultRight = objHotLeadBL.GetUserDefaultRightsForEditing(Convert.ToInt32(Paystats));

                if (GetUserDefaultRight.Tables[0].Rows[0]["LeadsUpload"].ToString() == "Y")
                    Ckleads.Items[0].Selected = true;
                else Ckleads.Items[0].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["Transferin"].ToString() == "Y")
                    Ckleads.Items[1].Selected = true;
                else Ckleads.Items[1].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["Abondoned"].ToString() == "Y")
                    Ckleads.Items[2].Selected = true;
                else Ckleads.Items[2].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["FreePackage"].ToString() == "Y")
                    Ckleads.Items[3].Selected = true;
                else Ckleads.Items[3].Selected = false;

                if (GetUserDefaultRight.Tables[0].Rows[0]["IntroMail"].ToString() == "Y")
                    chksales.Items[0].Selected = true;
                else chksales.Items[0].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["NewEntry"].ToString() == "Y")
                    chksales.Items[1].Selected = true;
                else chksales.Items[1].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["Transferout"].ToString() == "Y")
                    chksales.Items[2].Selected = true;
                else chksales.Items[2].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["Ticker"].ToString() == "Y")
                    chksales.Items[3].Selected = true;
                else chksales.Items[3].Selected = false;


                if (GetUserDefaultRight.Tables[0].Rows[0]["Self"].ToString() == "Y")
                    ChkReports.Items[0].Selected = true;
                else ChkReports.Items[0].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["Center"].ToString() == "Y")
                    ChkReports.Items[1].Selected = true;
                else ChkReports.Items[1].Selected = false;
                if (GetUserDefaultRight.Tables[0].Rows[0]["SalesAdmin"].ToString() == "Y")
                    chksaleadmin.Items[0].Selected = true;
                else chksaleadmin.Items[0].Selected = false;




            }


        }
        catch { }
    }
    

}
