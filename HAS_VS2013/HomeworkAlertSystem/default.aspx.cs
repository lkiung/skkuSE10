using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeworkAlertSystem
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.TextBoxId.Focus();
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            dataaccess da = new dataaccess();
            datasetlogin dsh = new datasetlogin();

            if (this.IsPostBack &&
                this.TextBoxId.Text != "" &&
                this.TextBoxPw.Text != "")
            {
                dsh = da.GetProfessorsByLogin(this.TextBoxId.Text, this.TextBoxPw.Text);
                if (dsh.professor.Rows.Count == 1)
                {
                    if (dsh.professor[0].login.Trim() == this.TextBoxId.Text &&
                        dsh.professor[0].pw.Trim() == this.TextBoxPw.Text)
                    { 
                        //set session and redirect
                        Session.Add(constants.SESSION_MODE, constants.SESSION_MODE_DEFAULT);
                        Session.Add(constants.SESSION_PID, dsh.professor[0].id.ToString());
                        Response.Redirect("home.aspx");
                    }
                }
            }

        }
    }
}