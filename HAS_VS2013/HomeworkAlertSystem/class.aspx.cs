using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class _class : System.Web.UI.Page
    {
        private datasethas _dataSetClasses;
        private string _currentClassId;

        protected void Page_Load(object sender, EventArgs e)
        {
            dataaccess da = new dataaccess();
            bool cancel = new tools().SessionCheck(Session);

            if (cancel)
                Response.Redirect("Default.aspx");

            this.SqlDataSourceRepeaterClasses.SelectParameters.Add("id", Session[constants.SESSION_PID].ToString());
            _dataSetClasses = da.GetAllClasses(int.Parse(Session[constants.SESSION_PID].ToString()));

            switch (Session[constants.SESSION_MODE].ToString())
            {
                case constants.SESSION_MODE_EDIT_CLASS:
                    this.FormViewClass.ChangeMode(FormViewMode.Edit);
                    _currentClassId = Session[constants.SESSION_MODE_EDIT_CID].ToString();
                    this.SqlDataSourceClass.UpdateParameters.Add("cid", _currentClassId);
                    break;

                case constants.SESSION_MODE_VIEW:
                    this.FormViewClass.ChangeMode(FormViewMode.ReadOnly);
                    _currentClassId = Session[constants.SESSION_MODE_VIEW_ID].ToString();
                    break;

                default:
                case constants.SESSION_MODE_ADD:
                    this.FormViewClass.ChangeMode(FormViewMode.Insert);
                    break;
            }

            this.SqlDataSourceClass.SelectParameters.Add("cid", _currentClassId);
        }

        protected void LinkButtonSortClassnumber_Click(object sender, EventArgs e)
        {
            this.RepeaterClasses.DataSource = _dataSetClasses._class.Select("", "classnumber", System.Data.DataViewRowState.CurrentRows);
            this.RepeaterClasses.DataSourceID = "";
            this.RepeaterClasses.DataBind();
        }
        protected void LinkButtonDeleteClass_Click(object sender, EventArgs e)
        {
            new dataaccess().DeleteClassEntries(int.Parse(((LinkButton)sender).CommandArgument.ToString()));
            Response.Redirect("home.aspx");
        }
        protected void LinkButtonNewClass_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_ADD;
            Response.Redirect("class.aspx");
        }

        protected void LinkButtonEditClass_Click(object sender, EventArgs e)
        {
            Session[constants.SESSION_MODE] = constants.SESSION_MODE_EDIT_CLASS;
            Session.Add(constants.SESSION_MODE_EDIT_CID, ((LinkButton)sender).CommandArgument);
            Response.Redirect("class.aspx");
        }

        protected string GetSelectedClass(string id)
        {
            string cssClass = "hl";

            if (id == _currentClassId)
                cssClass = "selectedRow";

            return cssClass;
        }

        protected void formViewClass_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            dataaccess da = new dataaccess();
            int newCid = da.GetMaxClassId();
            int pid = int.Parse(Session[constants.SESSION_PID].ToString());

            da.InsertProfessorHasClasses(pid, newCid);
            Response.Redirect("home.aspx");
        }

        protected void formViewClass_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}