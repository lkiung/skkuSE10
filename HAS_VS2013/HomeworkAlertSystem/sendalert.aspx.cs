using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class sendalert : System.Web.UI.Page
    {
        datasethas _hasData = new datasethas();
        protected void Page_Load(object sender, EventArgs e)
        {
            bool cancel = new tools().SessionCheck(Session);
            if (cancel)
                Response.Redirect("Default.aspx");

            int aid = int.Parse(Session[constants.SESSION_MODE_SEND_AID].ToString());
            dataaccess da = new dataaccess();

            _hasData = da.GetAlertClassAndStudentsByAlertId(aid);

            labelClassId.Text = _hasData._class[0].id.ToString();
            labelClassnumber.Text = _hasData._class[0].classnumber.ToString();

            this.RepeaterStudents.DataSource = _hasData.student;
            this.RepeaterStudents.DataBind();

            this.imageButtonSend.ToolTip = "Start Sending Alerts";

            if (Session[constants.SESSION_MODE].ToString() == constants.SESSION_MODE_SENDING)
            {
                tools t = new tools();
                alertprogress ap = (alertprogress)Session[constants.SESSION_MODE_SENDING_PROGRESS];

                this.imageButtonSend.ImageUrl = "~/img/sending.gif";
                this.imageButtonSend.ToolTip = "Sending Alerts~ (Please Wait)";
                this.SetRepeaterStatuses(ap);

                //Verify script isn't already registered
                if (!ClientScript.IsClientScriptBlockRegistered("waitScript"))
                {
                    string js = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"waitScript\">\n";
                    js += "wait(2000);";
                    js += "\n\n </script>";

                    ClientScript.RegisterClientScriptBlock(this.GetType(), "waitScript", js);
                }
                t.Alerting(Session, ap);
            }

            if (Session[constants.SESSION_MODE].ToString() == constants.SESSION_MODE_SENDING_FINISHED)
            {
                alertprogress ap = (alertprogress)Session[constants.SESSION_MODE_SENDING_PROGRESS];
                this.imageButtonSend.ImageUrl = "~/img/ok.png";
                this.imageButtonSend.ToolTip = "Finished Sending! Click to return to class~ ^^";
                this.SetRepeaterStatuses(ap);
                da.UpdateAlertStatus(aid);
            }
        }

        private void SetRepeaterStatuses(alertprogress ap)
        {
            foreach (RepeaterItem r in this.RepeaterStudents.Items)
            {
                Label sidLabel = (Label)r.FindControl("LabelStudentId");
                Image status = (Image)r.FindControl("ImageStatus");
                foreach (string sid in ap.sent)
                {
                    if (sidLabel.Text == sid)
                    {
                        status.ImageUrl = "~/img/ok.png";
                        status.ToolTip = "Sent!";
                    }   
                }

                foreach (KeyValuePair<string, string> kvp in ap.error)
                {
                    if (sidLabel.Text == kvp.Key)
                    {
                        status.ImageUrl = "~/img/error.png";
                        status.ToolTip = kvp.Value;
                    }
                }
            }
        }

        protected void LinkButtonSortStudentNumber_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _hasData.student.Select("", "number", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentName_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _hasData.student.Select("", "name", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentPhone_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _hasData.student.Select("", "phone", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentEmail_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _hasData.student.Select("", "email", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void imageButtonSend_Click(object sender, ImageClickEventArgs e)
        {
            if (Session[constants.SESSION_MODE].ToString() == constants.SESSION_MODE_SENDING_FINISHED)
            {
                //revert to class edit mode and leave
                Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
                Response.Redirect("alerts.aspx");
            }
            else
            {
                tools t = new tools();
                alertprogress ap = t.CreateSendingOrderIdList(_hasData);

                this.imageButtonSend.ImageUrl = "~/img/sending.gif";
                Session[constants.SESSION_MODE] = constants.SESSION_MODE_SENDING;
                t.Alerting(Session, ap);
                Response.Redirect("sendalert.aspx");
            }
        }
    }
}