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
    public partial class messageDetail : PageBase
    {
        override
        protected void Page_Load(object sender, EventArgs e)
        {
            string ID = Request.Params["ID"];
            GetMessage(ID);
        }
        protected void GetMessage (string ID)
        {
            DataSet dt = DbHelperSQL.Query("select * from sys_UserMessage where id ='"+ID+"'");
            DbHelperSQL.ExecuteSql("update sys_UserMessage set bRead='True' where id ='" + ID + "'");
            DataView dv = dt.Tables[0].DefaultView;
            MessageDetail.DataSource = dv;
            MessageDetail.DataBind();
        }
    }
}