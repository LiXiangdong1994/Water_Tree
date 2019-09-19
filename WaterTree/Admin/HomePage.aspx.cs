using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBUtility;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

namespace WaterTree.Admin
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //YearList();
            GetTreeCount();//植树数
            GetTaskzbCount();//活动数
            GetConcerntCount();//关注人数
            GetActiveUserCount();//活跃人数
            GetTaskmxCommentList();//最新评论、点赞
            GetNewTreeList();//最新植树表
            GetGOODList();//点赞排行榜
        }

        //植树数
        protected void GetTreeCount()
        {
            //当月植树数
            IDataParameter[] parameters = new SqlParameter[6];
            parameters[0] = new SqlParameter("@table", "taskmx_tree");
            parameters[1] = new SqlParameter("@NowYear", null);
            parameters[2] = new SqlParameter("@NowMonth", "begindate");
            parameters[3] = new SqlParameter("@LeastMonth ", null);
            parameters[4] = new SqlParameter("@LastDay", null);
            parameters[5] = new SqlParameter("@bselfcheck", null);
            double TreeNumMonth = 0;
           
            DataSet dt = DbHelperSQL.RunProcedure("GetTableRow", parameters, "NewTaskmx_tree");
            if (dt.Tables[0].Rows.Count > 0)
            {
                TreeNumMonth = double.Parse(dt.Tables[0].Rows[0]["num"].ToString());
            }
            TreeNum.InnerText = TreeNumMonth.ToString();
            //所有植树总数
            IDataParameter[] parameters2 = new SqlParameter[6];
            parameters2[0] = new SqlParameter("@table", "taskmx_tree");
            parameters2[1] = new SqlParameter("@NowYear", null);
            parameters2[2] = new SqlParameter("@NowMonth", null);
            parameters2[3] = new SqlParameter("@LeastMonth ", null);
            parameters2[4] = new SqlParameter("@LastDay", null);
            parameters2[5] = new SqlParameter("@bselfcheck", null);
            double TreeNumTotal = 0;
            DataSet dt2 = DbHelperSQL.RunProcedure("GetTableRow", parameters2, "NewTaskmx_tree2");
            if (dt2.Tables[0].Rows.Count > 0)
            {
                TreeNumTotal = double.Parse(dt2.Tables[0].Rows[0]["num"].ToString());
            }
            TreeToal.InnerText = TreeNumMonth.ToString();
            TreePercent.InnerText = (TreeNumMonth / TreeNumTotal).ToString("0%");
            TreeToalPercent.InnerText = (TreeNumMonth / TreeNumTotal).ToString("0%");
            //最近一个月植树数
            IDataParameter[] parameters3 = new SqlParameter[6];
            parameters3[0] = new SqlParameter("@table", "taskmx_tree");
            parameters3[1] = new SqlParameter("@NowYear", null);
            parameters3[2] = new SqlParameter("@NowMonth", "begindate");
            parameters3[3] = new SqlParameter("@LeastMonth ", null);
            parameters3[4] = new SqlParameter("@LastDay", null);
            parameters3[5] = new SqlParameter("@bselfcheck", null);
            double LeastMonthTree3 = 0;
            DataSet dt3 = DbHelperSQL.RunProcedure("GetTableRow", parameters3, "NewTaskmx_tree");
            if (dt3.Tables[0].Rows.Count > 0)
            {
                LeastMonthTree3 = double.Parse(dt3.Tables[0].Rows[0]["num"].ToString());
            }
            LeastMonthTree.InnerText = LeastMonthTree3.ToString();
            LeastMonthTreePercent.InnerText = (LeastMonthTree3/ TreeNumTotal).ToString("0%");
        }
        //任务
        protected void GetTaskzbCount()
        {
            //活动未完成数
            IDataParameter[] parameters = new SqlParameter[6];
            parameters[0] = new SqlParameter("@table", "taskzb");
            parameters[1] = new SqlParameter("@NowYear", "addtime");
            parameters[2] = new SqlParameter("@NowMonth", null);
            parameters[3] = new SqlParameter("@LeastMonth ", null);
            parameters[4] = new SqlParameter("@LastDay", null);
            parameters[5] = new SqlParameter("@bselfcheck", "0");
            DataSet dt = DbHelperSQL.RunProcedure("GetTableRow", parameters, "NewTaskzb");
            double Check = 0;
           
            if (dt.Tables[0].Rows.Count > 0)
            {
                Check = double.Parse(dt.Tables[0].Rows[0]["num"].ToString());
            }
            TaskNum.InnerText = Check.ToString();
            //活动总数
            IDataParameter[] parameters2 = new SqlParameter[6];
            parameters2[0] = new SqlParameter("@table", "taskzb");
            parameters2[1] = new SqlParameter("@NowYear", "addtime");
            parameters2[2] = new SqlParameter("@NowMonth", null);
            parameters2[3] = new SqlParameter("@LeastMonth ", null);
            parameters2[4] = new SqlParameter("@LastDay", null);
            parameters2[5] = new SqlParameter("@bselfcheck", null);
            double TaskTotal = 0;
            DataSet dt2 = DbHelperSQL.RunProcedure("GetTableRow", parameters2, "NewTaskzb");
            if (dt2.Tables[0].Rows.Count > 0)
            {
                TaskTotal = double.Parse(dt2.Tables[0].Rows[0]["num"].ToString());
            }
            //TaskNum.InnerText = TaskTotal.ToString();
            TaskPercent.InnerText = (Check / TaskTotal).ToString("0 %");

            //最近一个月活动总数
            IDataParameter[] parameters3 = new SqlParameter[6];
            parameters3[0] = new SqlParameter("@table", "taskzb");
            parameters3[1] = new SqlParameter("@NowYear", null);
            parameters3[2] = new SqlParameter("@NowMonth", null);
            parameters3[3] = new SqlParameter("@LeastMonth ", "addtime");
            parameters3[4] = new SqlParameter("@LastDay", null);
            parameters3[5] = new SqlParameter("@bselfcheck", null);
            double LeastMonthTask3 = 0;
            DataSet dt3 = DbHelperSQL.RunProcedure("GetTableRow", parameters3, "NewTaskzb");
            if (dt3.Tables[0].Rows.Count > 0)
            {
                LeastMonthTask3 = double.Parse(dt3.Tables[0].Rows[0]["num"].ToString());
            }
            LeastMonthTask.InnerText = LeastMonthTask3.ToString();
            LeastMonthTaskPercent.InnerText = (LeastMonthTask3 / TaskTotal).ToString("0 %");
        }
        //关注人数
        protected void GetConcerntCount()
        {
           //昨天关注人数
            IDataParameter[] parameters = new SqlParameter[6];
            parameters[0] = new SqlParameter("@table", "bweixin_openid");
            parameters[1] = new SqlParameter("@NowYear", null);
            parameters[2] = new SqlParameter("@NowMonth", null);
            parameters[3] = new SqlParameter("@LeastMonth ", null);
            parameters[4] = new SqlParameter("@LastDay", "menddate");
            parameters[5] = new SqlParameter("@bselfcheck", null);
            DataSet dt = DbHelperSQL.RunProcedure("GetTableRow", parameters, "NewBweixin");
            double LastConcert = 0;
            double AllConcert = 0;
            if (dt.Tables[0].Rows.Count > 0)
            {
                LastConcert = double.Parse( dt.Tables[0].Rows[0]["num"].ToString());
            }
            ConcernsCount.InnerText = LastConcert.ToString();
           //总关注人数
           IDataParameter[] parameters2 = new SqlParameter[6];
            parameters2[0] = new SqlParameter("@table", "bweixin_openid");
            parameters2[1] = new SqlParameter("@NowYear", null);
            parameters2[2] = new SqlParameter("@NowMonth", null);
            parameters2[3] = new SqlParameter("@LeastMonth ", null);
            parameters2[4] = new SqlParameter("@LastDay", null);
            parameters2[5] = new SqlParameter("@bselfcheck", null);
            DataSet dt2 = DbHelperSQL.RunProcedure("GetTableRow", parameters2, "NewBweixin");
            if (dt2.Tables[0].Rows.Count > 0)
            {
                AllConcert = double.Parse( dt2.Tables[0].Rows[0]["num"].ToString());
            }
            ConcernsPercent.InnerText = (LastConcert / AllConcert).ToString("0%");
        }
        //最近一个月活跃用户
        protected void GetActiveUserCount()
        {
            //最近一个月活跃
            IDataParameter[] parameters = new SqlParameter[6];
            parameters[0] = new SqlParameter("@table", "sys_UserInfo");
            parameters[1] = new SqlParameter("@NowYear", null);
            parameters[2] = new SqlParameter("@NowMonth", null);
            parameters[3] = new SqlParameter("@LeastMonth ", "lastlogindatetime");
            parameters[4] = new SqlParameter("@LastDay", null);
            parameters[5] = new SqlParameter("@bselfcheck", null);
            DataSet dt = DbHelperSQL.RunProcedure("GetTableRow", parameters, "NewUserInfo");
            double LeastMonth = 0;
            double NowMonth = 0;
            if (dt.Tables[0].Rows.Count > 0)
            {
                LeastMonth =double.Parse( dt.Tables[0].Rows[0]["num"].ToString());
            }
            ActiveUserCount.InnerText = LeastMonth.ToString();
           //最近一个月活跃
           IDataParameter[] parameters2 = new SqlParameter[6];
            parameters2[0] = new SqlParameter("@table", "sys_UserInfo");
            parameters2[1] = new SqlParameter("@NowYear", null);
            parameters2[2] = new SqlParameter("@NowMonth", "lastlogindatetime");
            parameters2[3] = new SqlParameter("@LeastMonth ", null);
            parameters2[4] = new SqlParameter("@LastDay", null);
            parameters2[5] = new SqlParameter("@bselfcheck", null);
            DataSet dt2 = DbHelperSQL.RunProcedure("GetTableRow", parameters2, "NewUserInfo");
            if (dt2.Tables[0].Rows.Count > 0)
            {
                NowMonth = double.Parse( dt2.Tables[0].Rows[0]["num"].ToString());
            }
            ActivePercent.InnerText = (NowMonth / LeastMonth).ToString("0%");
            Month.InnerText= DateTime.Now.ToString("MM")+"月";
        }

        //最新植树列表
        protected void GetNewTreeList()
        {
            SqlDataAdapter sda = new SqlDataAdapter();
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select top 6 treename,DeptName,begindate,COUNT(*) as num from vwNewTreeList group by treename,DeptName,begindate order by begindate desc");
            DataView dv = ds.Tables[0].DefaultView;
            NewTreeList.DataSource = dv;
            NewTreeList.DataBind();
        }
        //点赞排行
        protected void GetGOODList()
        {
       SqlDataAdapter sda = new SqlDataAdapter();
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select top 10 DeptName,COUNT(*) as num  from vwtaskmx_comment group by DeptName order by num desc");
            DataView dv = ds.Tables[0].DefaultView;
            GOODList.DataSource = dv;
            GOODList.DataBind();
        }
        //点赞评论
        protected void GetTaskmxCommentList()
        {
   
                  SqlDataAdapter sda = new SqlDataAdapter();
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query("select top 5*,  DATEDIFF(DAY,GETDATE(), menddate)   AS TimeDiff from vwtaskmx_comment2 order by menddate desc");
            DataView dv = ds.Tables[0].DefaultView;
            TaskmxCommentList.DataSource = dv;
            TaskmxCommentList.DataBind();
        }

        protected void OtherContrast_Click(object sender, EventArgs e)
        {
            Response.Redirect("OtherContrast.aspx");
        }
    }
}