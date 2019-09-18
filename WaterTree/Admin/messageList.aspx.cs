using DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WaterTree.Admin
{
    public partial class messageList :PageBase
    {
        override
        protected void Page_Load(object sender, EventArgs e)
        {
            string AcceptUserName = "刘映红";
            string SendUserName = "刘映红";
            GetAllMessageList(AcceptUserName, SendUserName);
            GetReadMessageList(AcceptUserName, SendUserName);
            GetNotReadMessageList(AcceptUserName, SendUserName);
        }
        protected void GetAllMessageList(string AcceptUserName, string SendUserName)
        {

            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select * from sys_UserMessage where AcceptUserName like '%" + AcceptUserName + "%' or SendUserName='" + SendUserName + "'");
            DataView dv = ds.Tables[0].DefaultView;
            ALLMessageList.DataSource = dv;
            ALLMessageList.DataBind();
            MySendMessage.DataSource = dv;
            MySendMessage.DataBind();
        }
        protected void GetReadMessageList(string AcceptUserName, string SendUserName)
        {

            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select *from(select * from sys_UserMessage where bRead='true')as xx where AcceptUserName like '%" + AcceptUserName + "%' or SendUserName='" + SendUserName + "'");
            DataView dv = ds.Tables[0].DefaultView;
            ReadMessageList.DataSource = dv;
            ReadMessageList.DataBind();
        }
        protected void GetNotReadMessageList(string AcceptUserName, string SendUserName)
        {
            
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select *from(select * from sys_UserMessage where bRead='false')as xx where AcceptUserName like '%" + AcceptUserName + "%' or SendUserName='" + SendUserName + "'");
            DataView dv = ds.Tables[0].DefaultView;
            NotReadMessageList.DataSource = dv;
            NotReadMessageList.DataBind();
        }
    }
}