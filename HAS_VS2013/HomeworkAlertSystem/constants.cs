using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeworkAlertSystem
{
    public class constants
    {
        public const string SESSION_PID = "SessionPID";
        public const string SESSION_MODE = "SessionMode";
        public const string SESSION_MODE_DEFAULT = "default";
        public const string SESSION_MODE_VIEW = "view";
        public const string SESSION_MODE_VIEW_ID = "viewId";
        public const string SESSION_MODE_ADD = "add";
        public const string SESSION_MODE_EDIT_CLASS = "editClass";
        public const string SESSION_MODE_EDIT_STUDENT = "editStudent";
        public const string SESSION_MODE_EDIT_ALERT = "editAlert";
        public const string SESSION_MODE_SEND_ALERT = "sendAlert";
        public const string SESSION_MODE_EDIT_CID = "editCid";
        public const string SESSION_MODE_EDIT_SID = "editSid";
        public const string SESSION_MODE_EDIT_AID = "editAid";
        public const string SESSION_MODE_SEND_AID = "sendAid";
        public const string SESSION_MODE_SENDING = "sending";
        public const string SESSION_MODE_SENDING_PROGRESS = "progress";
        public const string SESSION_MODE_SENDING_FINISHED = "sendingFinished";
    }
}