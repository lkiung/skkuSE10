using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeworkAlertSystem
{
    public struct alertprogress
    {
        public List<string> sent;
        public List<string> unsent;
        public Dictionary<string, string> error;

        public alertprogress(List<string> s, List<string> u)
        {
            this.sent = s;
            this.unsent = u;
            this.error = new Dictionary<string, string>();
        }
    }
}