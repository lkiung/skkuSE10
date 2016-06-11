using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeworkAlertSystem
{
    public class tools
    {
        public bool SessionCheck(System.Web.SessionState.HttpSessionState session)
        {
            bool check = false;
            try
            {
                if (session[constants.SESSION_PID].ToString() == null || session[constants.SESSION_PID].ToString() == "0")
                    check = true;
            }
            catch
            {
                check = true;
            }

            return check;
        }

        public alertprogress CreateSendingOrderIdList(datasethas hasData)
        {
            alertprogress ap = new alertprogress(new List<string>(), new List<string>());

            foreach (System.Data.DataRow dr in hasData.student.Rows)
            {
                ap.unsent.Add(dr["id"].ToString());
            }

            return ap;
        }

        public void Alerting(System.Web.SessionState.HttpSessionState session, alertprogress ap)
        {
            homeworkAlertSystem has = new homeworkAlertSystem(ap.unsent[0], session[constants.SESSION_MODE_SEND_AID].ToString());

            if (has.isSent)
                ap.sent.Add(ap.unsent[0]);
            else
                ap.error.Add(ap.unsent[0], has.errorMessage);

            ap.unsent.Remove(ap.unsent[0]);
            session.Remove(constants.SESSION_MODE_SENDING_PROGRESS);
            session.Add(constants.SESSION_MODE_SENDING_PROGRESS, ap);

            if (ap.unsent.Count == 0)
                session[constants.SESSION_MODE] = constants.SESSION_MODE_SENDING_FINISHED;
        }
    }
}