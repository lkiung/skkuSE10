using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class alert : System.Web.UI.Page
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

            switch (Session[constants.SESSION_MODE].ToString())
            { 
                case constants.SESSION_MODE_ADD:
                    this.FormViewAlert.ChangeMode(FormViewMode.Insert);
                    break;
                case constants.SESSION_MODE_EDIT_ALERT:
                    //removing existing parameters because of postback
                    this.SqlDataSourceFormViewAlert.SelectParameters.Clear();

                    foreach (Parameter p in this.SqlDataSourceFormViewAlert.UpdateParameters)
                    {
                        if (p.Name == "cid" || p.Name == "pid" || p.Name == "aid")
                            this.SqlDataSourceFormViewAlert.UpdateParameters.Remove(p);
                    }

                    this.SqlDataSourceFormViewAlert.SelectParameters.Add("cid", Session[constants.SESSION_MODE_EDIT_CID].ToString());
                    this.SqlDataSourceFormViewAlert.SelectParameters.Add("pid", Session[constants.SESSION_PID].ToString());
                    this.SqlDataSourceFormViewAlert.SelectParameters.Add("aid", Session[constants.SESSION_MODE_EDIT_AID].ToString());
                    this.SqlDataSourceFormViewAlert.UpdateParameters.Add("cid", Session[constants.SESSION_MODE_EDIT_CID].ToString());
                    this.SqlDataSourceFormViewAlert.UpdateParameters.Add("pid", Session[constants.SESSION_PID].ToString());
                    this.SqlDataSourceFormViewAlert.UpdateParameters.Add("aid", Session[constants.SESSION_MODE_EDIT_AID].ToString());

                    this.FormViewAlert.ChangeMode(FormViewMode.Edit);
                    
                    break;
            }
        }

        protected void FormViewAlert_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            int pid, cid;
            
            pid = int.Parse(Session[constants.SESSION_PID].ToString());
            cid = int.Parse(Session[constants.SESSION_MODE_EDIT_CID].ToString());

            e.Values["profid"] = pid;
            e.Values["classid"] = cid;
            e.Values["added"] = DateTime.Now;
        }

        protected void FormViewAlert_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("alerts.aspx");
        }

        protected void FormViewAlert_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            try 
            { 
                DateTime sent = (DateTime)e.OldValues["alertsent"];
                e.Cancel = true;
                this.labelUpdateCancel.Visible = true;
            }
            catch 
            {
                int pid, cid;

                pid = int.Parse(Session[constants.SESSION_PID].ToString());
                cid = int.Parse(Session[constants.SESSION_MODE_EDIT_CID].ToString());

                e.NewValues["profid"] = pid;
                e.NewValues["classid"] = cid;
                e.NewValues["added"] = DateTime.Now;
            }
        }

        protected void FormViewAlert_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("alerts.aspx");
        }
    }
}