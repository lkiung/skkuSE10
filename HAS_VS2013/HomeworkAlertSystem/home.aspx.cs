using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class home : System.Web.UI.Page
    {
        private datasethas _dataSetClasses;

        protected void Page_Load(object sender, EventArgs e)
        {
            dataaccess da = new dataaccess();
            bool cancel = new tools().SessionCheck(Session);
            if (cancel)
                Response.Redirect("Default.aspx");

            this.SqlDataSourceRepeaterClasses.SelectParameters.Add("id", Session[constants.SESSION_PID].ToString());
            _dataSetClasses = da.GetAllClasses(int.Parse(Session[constants.SESSION_PID].ToString()));
        }

        protected void LinkButtonSortClassnumber_Click(object sender, EventArgs e)
        {
            this.RepeaterClasses.DataSource = _dataSetClasses._class.Select("", "classnumber", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterClasses.DataSourceID = "";
            this.RepeaterClasses.DataBind();
        }

        protected void LinkButtonNewClass_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_ADD;
            Response.Redirect("class.aspx");
        }

        protected void LinkButtonEditAlerts_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
            Session.Add(constants.SESSION_MODE_EDIT_CID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("alerts.aspx");
        }

        protected void LinkButtonEditClass_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
            Session.Add(constants.SESSION_MODE_EDIT_CID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("class.aspx");
        }

        protected void LinkButtonEditStudents_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
            Session.Add(constants.SESSION_MODE_EDIT_CID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("students.aspx");
        }

        protected void repeaterClasses_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.RepeaterClasses.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    Label lblFooter = (Label)e.Item.FindControl("labelNoData");
                    lblFooter.Visible = true;
                }
            }
        }
    }
}