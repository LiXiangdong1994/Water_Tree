using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBUtility;
namespace WaterTree.Admin
{
    public partial class Other : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadYearList();//加载年数据
        }
        protected void LoadYearList()
        {

            SqlDataReader read = DbHelperSQL.ExecuteReader("select distinct Time from  vwTownTreeSum order by Time desc");
                while (read.Read())
                {
                    string value = read["Time"].ToString();
                    string Year = read["Time"].ToString();
                    year.Items.Add(new ListItem(Year, value));
            }
        }
    }
}