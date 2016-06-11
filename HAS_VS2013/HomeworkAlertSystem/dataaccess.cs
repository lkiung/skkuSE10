using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace HomeworkAlertSystem
{
    public class dataaccess
    {
        public datasetlogin GetProfessorsByLogin(string login, string password)
        {
            datasetloginTableAdapters.professorTableAdapter professorTableAdapter = new datasetloginTableAdapters.professorTableAdapter();
            datasetlogin pData = new datasetlogin();
            professorTableAdapter.FillByLogin(pData.professor, login, password);
            return pData;
        }

        public datasethas GetAllClasses(int pid)
        {
            datasethasTableAdapters.classTableAdapter classTableAdapter = new datasethasTableAdapters.classTableAdapter();
            datasethas hasData = new datasethas();
            classTableAdapter.FillClassByPid(hasData._class, pid); //this is weird lol.. why _?
            return hasData;
        }

        public void InsertProfessorHasClasses(int pid, int cid)
        {
            datasethasTableAdapters.professorhasclassesTableAdapter professorHasClassesTableAdapter = new datasethasTableAdapters.professorhasclassesTableAdapter();
            professorHasClassesTableAdapter.InsertQuery(pid, cid);
        }

        public int GetMaxClassId()
        {
            datasethasTableAdapters.classTableAdapter classTableAdapter = new datasethasTableAdapters.classTableAdapter();
            datasethas hasData = new datasethas();
            return int.Parse(classTableAdapter.GetMaxId().ToString());
        }

        public void DeleteClassEntries(int cid)
        {
            datasethasTableAdapters.classTableAdapter classTableAdapter = new datasethasTableAdapters.classTableAdapter();
            datasethasTableAdapters.professorhasclassesTableAdapter professorHasClassesTableAdapter = new datasethasTableAdapters.professorhasclassesTableAdapter();
            professorHasClassesTableAdapter.DeleteQuery(cid);
            classTableAdapter.DeleteQuery(cid);
        }

        public datasethas GetStudentsByPidAndCid(int pid, int cid)
        {
            datasethasTableAdapters.studentTableAdapter studentTableAdapter = new datasethasTableAdapters.studentTableAdapter();
            datasethas hasData = new datasethas();
            studentTableAdapter.FillStudentsByByPidAndCid(hasData.student, pid, cid);
            return hasData;
        }

        public datasethas GetClassByPidAndCid(int pid, int cid)
        {
            datasethasTableAdapters.classTableAdapter classTableAdapter = new datasethasTableAdapters.classTableAdapter();
            datasethas hasData = new datasethas();
            classTableAdapter.FillClassByPidAndCid(hasData._class, pid, cid);
            return hasData;
        }

        public int GetMaxStudentId()
        {
            datasethasTableAdapters.studentTableAdapter studentTableAdapter = new datasethasTableAdapters.studentTableAdapter();
            datasethas hasData = new datasethas();
            return int.Parse(studentTableAdapter.GetMaxId().ToString());
        }

        public void InsertClassHasStudents(int cid, int sid)
        {
            datasethasTableAdapters.classhasstudentsTableAdapter classHasStudentsTableAdapter = new datasethasTableAdapters.classhasstudentsTableAdapter();
            classHasStudentsTableAdapter.InsertQuery(cid, sid);
        }

        public datasethas GetAlertClassAndStudentsByAlertId(int aid)
        {
            datasethasTableAdapters.alertTableAdapter alertTableAdapter = new datasethasTableAdapters.alertTableAdapter();
            datasethasTableAdapters.studentTableAdapter studentTableAdapter = new datasethasTableAdapters.studentTableAdapter();
            datasethasTableAdapters.classTableAdapter classTableAdapter = new datasethasTableAdapters.classTableAdapter();
            datasethas hasData = new datasethas();

            alertTableAdapter.FillAlertById(hasData.alert, aid);
            classTableAdapter.FillByClassId(hasData._class, hasData.alert[0].classid);
            studentTableAdapter.FillStudentsByAlertId(hasData.student, aid);

            return hasData;
        }

        public string GetStudentMail(int sid)
        {
            datasethasTableAdapters.studentTableAdapter studentTableAdapter = new datasethasTableAdapters.studentTableAdapter();
            datasethas hasData = new datasethas();

            studentTableAdapter.FillStudentByStudentId(hasData.student, sid);
            return hasData.student[0].email;
        }

        public datasethas GetAlert(int aid)
        {
            datasethasTableAdapters.alertTableAdapter alertTableAdapter = new datasethasTableAdapters.alertTableAdapter();
            datasethas hasData = new datasethas();

            alertTableAdapter.FillAlertById(hasData.alert, aid);

            return hasData;
        }

        internal void UpdateAlertStatus(int aid)
        {
            datasethasTableAdapters.alertTableAdapter alertTableAdapter = new datasethasTableAdapters.alertTableAdapter();
            alertTableAdapter.UpdateQueryAlertSent(DateTime.Now, aid);
        }
    } 
}