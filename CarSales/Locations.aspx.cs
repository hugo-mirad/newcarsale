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


public partial class Locations : System.Web.UI.Page
{
    public GeneralFunc objGeneralFunc = new GeneralFunc();
    DropdownBL objdropdownBL = new DropdownBL();
    DataSet CarsDetails = new DataSet();
    DataSet dsDropDown = new DataSet();
    DataSet dsActiveSaleAgents = new DataSet();
    CentralDBMainBL objCentralDBBL = new CentralDBMainBL();
    UserRegistrationInfo objUserregInfo = new UserRegistrationInfo();
    HotLeadsBL objHotLeadBL = new HotLeadsBL();

    //string modid1 = ""; string modid2 = ""; string modid3 = ""; string modid4 = ""; string modid5 = ""; string modid6 = ""; string modid7 = "";
    //string proid1 = ""; string proid2 = ""; string proid3 = ""; string proid4 = ""; string proid5 = ""; string proid6 = ""; string proid7 = "";
    //string brandid1 = ""; string brandid2 = ""; string brandid3 = ""; string brandid4 = ""; string brandid5 = ""; string brandid6 = ""; string brandid7 = "";
    string UpleadsUpload = ""; string UpSales = ""; string UpCustomerService = "";
    string UpProcess = ""; string UpTransfersIn = ""; string UpAbondons = ""; string UpFreePosts = "";
    string DelleadsUpload = ""; string DelSales = ""; string DelCustomerService = "";
    string DelProcess = ""; string DelTransfersIn = ""; string DelAbondons = ""; string DelFreePosts = "";
    string centerid = "";
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

                        GetCentersUpdateLIst();

                    }

                }
            }
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


    private void GetCentersUpdateLIst()
    {
        DataSet GridCentersUpa = new DataSet();
        GridCentersUpa = objHotLeadBL.GetAllLocations();
        GridCentersUpades.DataSource = GridCentersUpa.Tables[0];
        GridCentersUpades.DataBind();
    }
    protected void lnkBtnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("login.aspx");
    }

    private void GetVehicleTypes()
    {
        DataSet GetVehicles = new DataSet();
        GetVehicles = objHotLeadBL.VehicleTypes();
        GridCentersUpades.DataSource = GetVehicles.Tables[0];
        GridCentersUpades.DataBind();
    }
    protected void GridCentersUpades_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                LinkButton lblLeadsUpload = (LinkButton)e.Row.FindControl("lnkUName1");
                Label LeadsUpload = (Label)e.Row.FindControl("LeadsUpload");
                Label lblSales = (Label)e.Row.FindControl("lblSales");
                Label lblcustmerserv = (Label)e.Row.FindControl("lblcustmerserv");
                Label lblprocess = (Label)e.Row.FindControl("lblprocess");
                Label lbltransin = (Label)e.Row.FindControl("lbltransin");
                Label lblabonds = (Label)e.Row.FindControl("lblabonds");
                Label lblfreeposts = (Label)e.Row.FindControl("lblfreeposts");


                HiddenField centerid = (HiddenField)e.Row.FindControl("centerid");
                string cenetrids = centerid.Value;


                DataSet dsTasks3 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 1);
                for (int i = 0; i < dsTasks3.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        //string va
                        LeadsUpload.Text += dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() + ",";

                    }
                    catch { }
                }
                if (LeadsUpload.Text.EndsWith(","))
                    LeadsUpload.Text = LeadsUpload.Text.Substring(0, LeadsUpload.Text.LastIndexOf(','));
                //Sales
                DataSet dsTasks4 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 15);
                for (int i = 0; i < dsTasks4.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lblSales.Text += dsTasks4.Tables[0].Rows[i]["Brand"].ToString() + ",";

                    }
                    catch { }
                }
                if (lblSales.Text.EndsWith(","))
                    lblSales.Text = lblSales.Text.Substring(0, lblSales.Text.LastIndexOf(','));
                //lblcustmerserv
                DataSet dsTasks5 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 30);
                for (int i = 0; i < dsTasks5.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lblcustmerserv.Text += dsTasks5.Tables[0].Rows[i]["Brand"].ToString() + ",";

                    }
                    catch { }
                }
                if (lblcustmerserv.Text.EndsWith(","))
                    lblcustmerserv.Text = lblcustmerserv.Text.Substring(0, lblcustmerserv.Text.LastIndexOf(','));
                // lblprocess
                DataSet dsTasks6 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 16);
                for (int i = 0; i < dsTasks6.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lblprocess.Text += dsTasks6.Tables[0].Rows[i]["Brand"].ToString() + ",";

                    }
                    catch { }
                }
                if (lblprocess.Text.EndsWith(","))
                    lblprocess.Text = lblprocess.Text.Substring(0, lblprocess.Text.LastIndexOf(','));
                //lbltransin
                DataSet dsTasks7 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 8);
                for (int i = 0; i < dsTasks7.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lbltransin.Text += dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() + ",";

                    }
                    catch { }
                }
                if (lbltransin.Text.EndsWith(","))
                    lbltransin.Text = lbltransin.Text.Substring(0, lbltransin.Text.LastIndexOf(','));
                //lblabonds
                DataSet dsTasks8 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 3);
                for (int i = 0; i < dsTasks8.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lblabonds.Text += dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() + ",";

                    }
                    catch { }
                }
                if (lblabonds.Text.EndsWith(","))
                    lblabonds.Text = lblabonds.Text.Substring(0, lblabonds.Text.LastIndexOf(','));
                //lblfreeposts
                DataSet dsTasks9 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 4);
                for (int i = 0; i < dsTasks9.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        lblfreeposts.Text += dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() + ",";

                    }
                    catch { }
                }
                if (lblfreeposts.Text.EndsWith(","))
                    lblfreeposts.Text = lblfreeposts.Text.Substring(0, lblfreeposts.Text.LastIndexOf(','));

            }

        }
        catch { }

    }
    protected void GridCentersUpades_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;

            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "Center Code";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Leads Upoad";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell.CssClass = "BL BR";

            HeaderCell = new TableCell();
            HeaderCell.Text = "Sales";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Customer Service";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell.CssClass = "BL BR";

            HeaderCell = new TableCell();
            HeaderCell.Text = "Process";
            HeaderCell.ColumnSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell.CssClass = "BR ";

            HeaderCell = new TableCell();
            HeaderCell.Text = "Leads Download";
            HeaderCell.ColumnSpan = 3;
            HeaderGridRow.Cells.Add(HeaderCell);

            GridCentersUpades.Controls[0].Controls.AddAt(0, HeaderGridRow);
        }


    }
    protected void GridCentersUpades_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ModalPopupExtender2.Show();
        LeadsUpload1.ClearSelection(); Sales1.ClearSelection();
        CustomerService1.ClearSelection(); Process1.ClearSelection();
        TransfersIn1.ClearSelection(); Abondons1.ClearSelection(); FreePosts1.ClearSelection();

        if (Convert.ToInt32(e.CommandArgument) == 1)
        {
            LinkButton1.Text = "INDG";

        }
        else if (Convert.ToInt32(e.CommandArgument) == 2)
        {
            LinkButton1.Text = "INBH";
        }
        else if (Convert.ToInt32(e.CommandArgument) == 3)
        {
            LinkButton1.Text = "USMP";
        }
        else if (Convert.ToInt32(e.CommandArgument) == 4)
        {
            LinkButton1.Text = "USWB";
        }



        //* Filling data into Popup:

        int cenetrids = Convert.ToInt32(e.CommandArgument);


        DataSet dsTasks3 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 1);
        for (int i = 0; i < dsTasks3.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Car Ads")
                    LeadsUpload1.Items[0].Selected = true;
                else if (dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Car Dealer Services")
                    LeadsUpload1.Items[1].Selected = true;
                else if (dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used RV Ads")
                    LeadsUpload1.Items[2].Selected = true;
                else if (dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Classic Car Ads")
                    LeadsUpload1.Items[3].Selected = true;
                else if (dsTasks3.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Truck Ads")
                    LeadsUpload1.Items[4].Selected = true;

            }
            catch { }
        }
        //Sales
        DataSet dsTasks4 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 15);
        for (int i = 0; i < dsTasks4.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks4.Tables[0].Rows[i]["Brand"].ToString() == "UCE")
                    Sales1.Items[0].Selected = true;
                else if (dsTasks4.Tables[0].Rows[i]["Brand"].ToString() == "MAR")
                    Sales1.Items[1].Selected = true;
                else if (dsTasks4.Tables[0].Rows[i]["Brand"].ToString() == "CRA ")
                    Sales1.Items[2].Selected = true;
                else if (dsTasks4.Tables[0].Rows[i]["Brand"].ToString() == "URV")
                    Sales1.Items[3].Selected = true;
                else if (dsTasks4.Tables[0].Rows[i]["Brand"].ToString() == "Trucks")
                    Sales1.Items[4].Selected = true;
               

            }
            catch { }
        }

        //lblcustmerserv
        DataSet dsTasks5 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 30);
        //lblcustmerserv
        for (int i = 0; i < dsTasks5.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks5.Tables[0].Rows[i]["Brand"].ToString() == "UCE")
                    CustomerService1.Items[0].Selected = true;
                else if (dsTasks5.Tables[0].Rows[i]["Brand"].ToString() == "MAR")
                    CustomerService1.Items[1].Selected = true;
                else if (dsTasks5.Tables[0].Rows[i]["Brand"].ToString() == "CRA ")
                    CustomerService1.Items[2].Selected = true;
                else if (dsTasks5.Tables[0].Rows[i]["Brand"].ToString() == "URV")
                    CustomerService1.Items[3].Selected = true;
                else if (dsTasks5.Tables[0].Rows[i]["Brand"].ToString() == "Trucks")
                    CustomerService1.Items[4].Selected = true;

            }
            catch { }
        }
        // lblprocess
        DataSet dsTasks6 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 16);
        for (int i = 0; i < dsTasks6.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks6.Tables[0].Rows[i]["Brand"].ToString() == "UCE")
                    Process1.Items[0].Selected = true;
                else if (dsTasks6.Tables[0].Rows[i]["Brand"].ToString() == "MAR")
                    Process1.Items[1].Selected = true;
                else if (dsTasks6.Tables[0].Rows[i]["Brand"].ToString() == "CRA ")
                    Process1.Items[2].Selected = true;
                else if (dsTasks6.Tables[0].Rows[i]["Brand"].ToString() == "URV")
                    Process1.Items[3].Selected = true;
                else if (dsTasks6.Tables[0].Rows[i]["Brand"].ToString() == "Trucks")
                    Process1.Items[4].Selected = true;

            }
            catch { }
        }

        //lbltransin
        DataSet dsTasks7 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 8);
        for (int i = 0; i < dsTasks7.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Car Ads")
                    TransfersIn1.Items[0].Selected = true;
                else if (dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Car Dealer Services")
                    TransfersIn1.Items[1].Selected = true;
                else if (dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used RV Ads")
                    TransfersIn1.Items[2].Selected = true;
                else if (dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Classic Car Ads")
                    TransfersIn1.Items[3].Selected = true;
                else if (dsTasks7.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Truck Ads")
                    TransfersIn1.Items[4].Selected = true;

            }
            catch { }
        }
        ////lblabonds
        DataSet dsTasks8 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 3);
        for (int i = 0; i < dsTasks8.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Car Ads")
                    Abondons1.Items[0].Selected = true;
                else if (dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Car Dealer Services")
                    Abondons1.Items[1].Selected = true;
                else if (dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used RV Ads")
                    Abondons1.Items[2].Selected = true;
                else if (dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Classic Car Ads")
                    Abondons1.Items[3].Selected = true;
                else if (dsTasks8.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Truck Ads")
                    Abondons1.Items[4].Selected = true;

            }
            catch { }
        }
        ////lblfreeposts
        DataSet dsTasks9 = objHotLeadBL.UpdatecentersById(Convert.ToInt32(cenetrids.ToString()), 4);
        for (int i = 0; i < dsTasks9.Tables[0].Rows.Count; i++)
        {
            try
            {
                if (dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Car Ads")
                    FreePosts1.Items[0].Selected = true;
                else if (dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Car Dealer Services")
                    FreePosts1.Items[1].Selected = true;
                else if (dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used RV Ads")
                    FreePosts1.Items[2].Selected = true;
                else if (dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Classic Car Ads")
                    FreePosts1.Items[3].Selected = true;
                else if (dsTasks9.Tables[0].Rows[i]["vehicleTypename"].ToString() == "Used Truck Ads")
                    FreePosts1.Items[4].Selected = true;

            }
            catch { }
        }
        //* ENd Data Filling to popup




    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (LinkButton1.Text == "INDG")
        {
            centerid = "1";
        }
        else if (LinkButton1.Text == "INBH")
        {
            centerid = "2";
        }
        else if (LinkButton1.Text == "USMP")
        {
            centerid = "3";
        }
        else if (LinkButton1.Text == "USWB")
        {
            centerid = "4";
        }


        string[] proid1 = { }; string[] proid2 = { }; string[] proid3 = { };
        string[] proid4 = { }; string[] proid5 = { }; string[] proid6 = { }; string[] proid7 = { };
        string[] brandid1 = { }; string[] brandid2 = { }; string[] brandid3 = { };
        string[] brandid4 = { }; string[] brandid5 = { }; string[] brandid6 = { }; string[] brandid7 = { };
        string[] brandids = { }; string[] proids = { };

        Session["modid1"] = "1"; Session["modid2"] = "15"; Session["modid3"] = "6";
        Session["modid4"] = "16"; Session["modid5"] = "8"; Session["modid6"] = "3"; Session["modid7"] = "4";

        Session["brandid1"] = "0"; Session["brandid5"] = "0"; Session["brandid6"] = "0"; Session["brandid7"] = "0";
        Session["proid2"] = "0"; Session["proid3"] = "0"; Session["proid4"] = "0";


        foreach (ListItem checkItem in LeadsUpload1.Items)
        {
            if (checkItem.Selected)
            {

                objHotLeadBL.UpdateCentersList(1, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 1);

            }
            else
            {
                objHotLeadBL.UpdateCentersList(1, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in Sales1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(15, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(15, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in CustomerService1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(6, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(6, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in Process1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(16, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(16, Convert.ToInt32(checkItem.Value), 0, Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in TransfersIn1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(8, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(8, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in Abondons1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(3, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(3, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 0);
            }
        }
        foreach (ListItem checkItem in FreePosts1.Items)
        {
            if (checkItem.Selected)
            {
                objHotLeadBL.UpdateCentersList(4, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 1);
            }
            else
            {
                objHotLeadBL.UpdateCentersList(4, 0, Convert.ToInt32(checkItem.Value), Convert.ToInt32(centerid), 0);
            }
        }



        GetCentersUpdateLIst();
        ModalPopupExtender2.Hide();
    }

}

