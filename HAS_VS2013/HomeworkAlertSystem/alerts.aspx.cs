using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class alerts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dataaccess da = new dataaccess();
            datasethas dshClass = new datasethas();
            int pid, cid;

            bool cancel = new tools().SessionCheck(Session);
            if (cancel)
                Response.Redirect("Default.aspx");

            pid = int.Parse(Session[constants.SESSION_PID].ToString());
            cid = int.Parse(Session[constants.SESSION_MODE_EDIT_CID].ToString());

            dshClass = da.GetClassByPidAndCid(pid, cid);

            this.labelClassId.Text = cid.ToString();
            this.labelClassnumber.Text = dshClass._class[0].classnumber;

            this.SqlDataSourceRepeaterAlerts.SelectParameters.Clear(); //remove all without selection

            this.SqlDataSourceRepeaterAlerts.SelectParameters.Add("pid", Session[constants.SESSION_PID].ToString());
            this.SqlDataSourceRepeaterAlerts.SelectParameters.Add("cid", Session[constants.SESSION_MODE_EDIT_CID].ToString());
            this.RepeaterAlerts.DataBind();
        }

        protected void repeaterAlerts_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.RepeaterAlerts.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    Label lblFooter = (Label)e.Item.FindControl("labelNoData");
                    lblFooter.Visible = true;
                }
            }

            //hiding the edit alert button for sent alerts
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string sent = ((dynamic)e.Item.DataItem).Row["alertsent"].ToString();

                if (sent != "")
                {
                    LinkButton lbEdit = (LinkButton)e.Item.FindControl("LinkButtonEditAlert");
                    lbEdit.Visible = false;
                }
            }
        }

        protected void LinkButtonEditAlert_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_ALERT;
            Session.Add(constants.SESSION_MODE_EDIT_AID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("alert.aspx");
        }

        protected void LinkButtonNewAlert_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_ADD;
            Response.Redirect("alert.aspx");
        }

        protected void LinkButtonSendAlert_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_SEND_ALERT;
            Session.Add(constants.SESSION_MODE_SEND_AID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("sendalert.aspx");
        }
    }
}