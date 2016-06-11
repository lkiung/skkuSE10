using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace HomeworkAlertSystem
{
    public class homeworkAlertSystem
    {
        public bool isSent = false;
        public string errorMessage;
        private string _sid;
        private string _aid;
        
        public homeworkAlertSystem(string studentId, string alertId)
        {
            this._sid = studentId;
            this._aid = alertId;
            this.SendAlert();
        }

        private void SendAlert()
        {
            dataaccess da = new dataaccess();
            datasethas hasData = da.GetAlert(int.Parse(this._aid));

            this.SendMail(da.GetStudentMail(int.Parse(this._sid)), hasData.alert[0].subject, hasData.alert[0].message);
        }

        private void SendMail(string email, string alertSubject, string alertBody)
        {
            MailMessage mail = new MailMessage("has@tenko.ch", email);
            SmtpClient client = new SmtpClient();

            client.Port = 587;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("has@tenko.ch", "skku546@");
            client.Host = "mail.tenko.ch";
            mail.Subject = alertSubject;
            mail.Body = alertBody;

            try
            {
                client.Send(mail);
                this.isSent = true;
            }
            catch (Exception ex)
            {
                //damn...
                this.errorMessage = ex.ToString();
            }
        }
    }
}