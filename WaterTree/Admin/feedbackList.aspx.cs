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
    public partial class feedbackList :PageBase
    {
        override
        protected void Page_Load(object sender, EventArgs e)
        {
            GetALLSuggestList();
            GetReplyList();
            GetNotReplyList();
        }

        protected void GetALLSuggestList()
        {

            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select * from sys_UserSuggest");
            DataView dv = ds.Tables[0].DefaultView;
            allSuggestList.DataSource = dv;
            allSuggestList.DataBind();
        }
        protected void GetReplyList()
        {

            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select * from sys_UserSuggest where reply<>''");
            DataView dv = ds.Tables[0].DefaultView;
            replyList.DataSource = dv;
            replyList.DataBind();
        }
        protected void GetNotReplyList()
        {

            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select * from sys_UserSuggest where reply is null");
            DataView dv = ds.Tables[0].DefaultView;
            notReplyList.DataSource = dv;
            notReplyList.DataBind();
        }
        public string ReturnStr(string str)
        {
            if (string.IsNullOrEmpty(str))
            {
                return "未回复";
            }
            else
            {
                return "已回复";
            }
        }
    }
}