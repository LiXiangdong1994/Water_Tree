using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBUtility;
using Models;
using System.Data;

namespace WaterTree.Admin
{
    public partial class feedbackDetail : PageBase
    {
        override
        protected void Page_Load(object sender, EventArgs e)
        {
            string ID = Request.Params["ID"];
            GetSuggest(ID);
        }
        protected void GetSuggest(string ID)
        {
           DataSet dt = DbHelperSQL.Query("select * from vwSuggestDetail where id =" + ID+"");
            DataView dv = dt.Tables[0].DefaultView;
            suggestDetail.DataSource= dv;
            suggestDetail.DataBind();
        }
    }
}