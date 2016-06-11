using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class students : System.Web.UI.Page
    {
        private datasethas _dataSetStudents;

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
            _dataSetStudents = da.GetStudentsByPidAndCid(pid, cid);

            this.labelClassId.Text = cid.ToString();
            this.labelClassnumber.Text = dshClass._class[0].classnumber;


            switch (Session[constants.SESSION_MODE].ToString())
            { 
                case constants.SESSION_MODE_ADD:
                    this.FormViewStudents.Visible = true;
                    this.FormViewStudents.ChangeMode(FormViewMode.Insert);
                    break;

                case constants.SESSION_MODE_EDIT_STUDENT:
                    this.FormViewStudents.Visible = true;

                    //removing existing parameters because of postback
                    for (int i = 0; i < this.SqlDataSourceFormViewStudents.SelectParameters.Count; i++)
                        if (this.SqlDataSourceFormViewStudents.SelectParameters[i].Name == "sid")
                            this.SqlDataSourceFormViewStudents.SelectParameters.Remove(this.SqlDataSourceFormViewStudents.SelectParameters[i]);

                    for (int i = 0; i < this.SqlDataSourceFormViewStudents.UpdateParameters.Count; i++)
                        if (this.SqlDataSourceFormViewStudents.UpdateParameters[i].Name == "sid")
                            this.SqlDataSourceFormViewStudents.UpdateParameters.Remove(this.SqlDataSourceFormViewStudents.SelectParameters[i]);

                    this.SqlDataSourceFormViewStudents.SelectParameters.Add("sid", Session[constants.SESSION_MODE_EDIT_SID].ToString());
                    this.SqlDataSourceFormViewStudents.UpdateParameters.Add("sid", Session[constants.SESSION_MODE_EDIT_SID].ToString());
                    this.FormViewStudents.ChangeMode(FormViewMode.Edit);
                    break;

                default:
                    this.FormViewStudents.Visible = false;
                    break;
            }

            this.SqlDataSourceRepeaterStudents.SelectParameters.Clear(); //remove all without selection

            this.SqlDataSourceRepeaterStudents.SelectParameters.Add("pid", Session[constants.SESSION_PID].ToString());
            this.SqlDataSourceRepeaterStudents.SelectParameters.Add("cid", Session[constants.SESSION_MODE_EDIT_CID].ToString());
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentNumber_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _dataSetStudents._class.Select("", "number", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentName_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _dataSetStudents._class.Select("", "name", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentPhone_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _dataSetStudents._class.Select("", "phone", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonSortStudentEmail_Click(object sender, EventArgs e)
        {
            this.RepeaterStudents.DataSource = _dataSetStudents._class.Select("", "email", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterStudents.DataSourceID = "";
            this.RepeaterStudents.DataBind();
        }

        protected void LinkButtonEditStudent_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_STUDENT;
            Session.Add(constants.SESSION_MODE_EDIT_SID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("students.aspx");
        }

        protected void LinkButtonNewStudent_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_ADD;
            Response.Redirect("students.aspx");
        }

        protected void repeaterStudents_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (this.RepeaterStudents.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    Label lblFooter = (Label)e.Item.FindControl("labelNoData");
                    lblFooter.Visible = true;
                }
            }
        }

        protected void formViewStudents_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            dataaccess da = new dataaccess();
            int newSid = da.GetMaxStudentId();
            int cid = int.Parse(Session[constants.SESSION_MODE_EDIT_CID].ToString());

            da.InsertClassHasStudents(cid, newSid);
            Response.Redirect("students.aspx");
        }

        protected void formViewStudents_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            //revert class edit mode
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
            Response.Redirect("students.aspx");
        }
    }
}