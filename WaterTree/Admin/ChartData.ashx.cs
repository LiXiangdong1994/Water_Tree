using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DBUtility;
using System.Data;
using System.Web.Script.Serialization;
using Models;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Collections;

namespace WaterTree.Admin
{
    /// <summary>
    /// ChartData 的摘要说明
    /// </summary>
    public class ChartData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string year = "";
            if (context.Request["year"] != null) {
                year = context.Request["year"].ToString();
            }
            switch (action)
            {
                case "GetTreeAndTaskCountByDayMonth":
                    GetTreeAndTaskCountByDayMonth(context);
                    break;
                case "GetCountByMonthInYear":
                    GetCountByMonthInYear(context, year);
                    break;
                case "GetCountByYear":
                    GetCountByYear(context);
                    break;
                default:
                    break;

            }
        }
        //当月数据
        public void GetTreeAndTaskCountByDayMonth(HttpContext context) {
            IDataParameter[] parame = null;
            SqlDataReader dr = DbHelperSQL.RunProcedure("GetTreeCountByDayInMonth", parame);
            SqlDataReader dr2 = DbHelperSQL.RunProcedure("GetTaskCountByDayInMonth", parame);
            List<ChartDa> list = null;
            ArrayList liststr = new ArrayList();
                if (dr2.HasRows)
                {
               
                    while (dr2.Read())
                    {
                        liststr.Add(int.Parse(dr2["num"].ToString()));
                    }
                }

                if (dr.HasRows)
                {
                    int i = 0;
                    list = new List<ChartDa>();
                    while (dr.Read())
                    {
                        ChartDa data = new ChartDa();
                        data.Time = dr["Time"].ToString();
                        data.TreeNum = int.Parse(dr["num"].ToString());
                        data.TaskNum = int.Parse(liststr[i].ToString());
                        list.Add(data);
                        i++;
                    }
                }
                string jsonData = JsonConvert.SerializeObject(list);
                context.Response.Write(jsonData);
        }
        //指定年每月对比
        public void GetCountByMonthInYear(HttpContext context,string year)
        {//查询植树数
            IDataParameter[] parames = new IDataParameter[3];
            parames[0] = new SqlParameter("@View", "vwTreeCountByDayMonth");
            parames[1] = new SqlParameter("@parame", "begindate");
            parames[2] = new SqlParameter("@Year", year);
            SqlDataReader dr = DbHelperSQL.RunProcedure("GetCountByMonthInYear", parames);
            //查询活动数
            IDataParameter[] Taskparames = new IDataParameter[3];
            Taskparames[0] = new SqlParameter("@View", "vwTaskCountByDayInMonth");
            Taskparames[1] = new SqlParameter("@parame", "begintime");
            Taskparames[2] = new SqlParameter("@Year", year);
            SqlDataReader Taskdr = DbHelperSQL.RunProcedure("GetCountByMonthInYear", Taskparames);
            //查询点赞数
            IDataParameter[] Goodparames = new IDataParameter[3];
            Goodparames[0] = new SqlParameter("@View", "vwGoodCountByDayInMonth");
            Goodparames[1] = new SqlParameter("@parame", "menddate");
            Goodparames[2] = new SqlParameter("@Year", year);
            SqlDataReader Gooddr = DbHelperSQL.RunProcedure("GetCountByMonthInYear", Goodparames);

            //查询评分人数
            IDataParameter[]Scoreparames = new IDataParameter[3];
            Scoreparames[0] = new SqlParameter("@View", "vwScoreCountByDayInMonth");
            Scoreparames[1] = new SqlParameter("@parame", "menddate");
            Scoreparames[2] = new SqlParameter("@Year", year);
            SqlDataReader Scoredr = DbHelperSQL.RunProcedure("GetCountByMonthInYear", Scoreparames);
            List<ChartDa> list = null;
            //循环活动数
            ArrayList Tasklist = new ArrayList();
            if (Taskdr.HasRows)
            {

                while (Taskdr.Read())
                {
                    Tasklist.Add(int.Parse(Taskdr["Sum"].ToString()));
                }
            }

            //循环点赞数
            ArrayList Goodlist = new ArrayList();
            if (Gooddr.HasRows)
            {

                while (Gooddr.Read())
                {
                    Goodlist.Add(int.Parse(Gooddr["Sum"].ToString()));
                }
            }
            //循环评分人数
            ArrayList Scorelist = new ArrayList();
            if (Scoredr.HasRows)
            {

                while (Scoredr.Read())
                {
                    Scorelist.Add(int.Parse(Scoredr["Sum"].ToString()));
                }
            }
            //循环植树数
            if (dr.HasRows)
            {
                int i = 0;
                list = new List<ChartDa>();
                while (dr.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = dr["Time"].ToString();
                    data.TreeNum = int.Parse(dr["Sum"].ToString());
                    if (Tasklist.Count != 0) {
                        data.TaskNum = int.Parse(Tasklist[i].ToString());
                    }
                    if (Goodlist.Count != 0)
                    {
                        data.GoodNum = int.Parse(Goodlist[i].ToString());
                    }
                    if (Scorelist.Count != 0)
                    {
                        data.ScoreNum = int.Parse(Scorelist[i].ToString());
                    }
                    list.Add(data);
                    i++;
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }

        //每年对比
        public void GetCountByYear(HttpContext context)
        {//查询植树数
            IDataParameter[] parames = new IDataParameter[2];
            parames[0] = new SqlParameter("@View", "vwTreeCountByDayMonth");
            parames[1] = new SqlParameter("@parame", "begindate");
            SqlDataReader dr = DbHelperSQL.RunProcedure("GetCountByYear", parames);
            //查询活动数
            IDataParameter[] Taskparames = new IDataParameter[2];
            Taskparames[0] = new SqlParameter("@View", "vwTaskCountByDayInMonth");
            Taskparames[1] = new SqlParameter("@parame", "begintime");
            SqlDataReader Taskdr = DbHelperSQL.RunProcedure("GetCountByYear", Taskparames);
            //查询点赞数
            IDataParameter[] Goodparames = new IDataParameter[2];
            Goodparames[0] = new SqlParameter("@View", "vwGoodCountByDayInMonth");
            Goodparames[1] = new SqlParameter("@parame", "menddate");
            SqlDataReader Gooddr = DbHelperSQL.RunProcedure("GetCountByYear", Goodparames);

            //查询评分人数
            IDataParameter[] Scoreparames = new IDataParameter[2];
            Scoreparames[0] = new SqlParameter("@View", "vwScoreCountByDayInMonth");
            Scoreparames[1] = new SqlParameter("@parame", "menddate");
            SqlDataReader Scoredr = DbHelperSQL.RunProcedure("GetCountByYear", Scoreparames);
            List<ChartDa> list = null;
            //循环活动数
            ArrayList Tasklist = new ArrayList();
            list = new List<ChartDa>();
            if (Taskdr.HasRows)
            {
                while (Taskdr.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = Taskdr["Time"].ToString();
                    data.TaskNum=int.Parse(Taskdr["Sum"].ToString());
                    list.Add(data);
                }
            }
            //循环点赞数
            ArrayList Goodlist = new ArrayList();
            if (Gooddr.HasRows)
            {

                while (Gooddr.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = Gooddr["Time"].ToString();
                    data.GoodNum = int.Parse(Gooddr["Sum"].ToString());
                    list.Add(data);
                }
            }
            //循环评分人数
            ArrayList Scorelist = new ArrayList();
            if (Scoredr.HasRows)
            {

                while (Scoredr.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = Scoredr["Time"].ToString();
                    data.ScoreNum = int.Parse(Scoredr["Sum"].ToString());
                    list.Add(data);
                }
            }
            //循环植树数
            if (dr.HasRows)
            {
               
                while (dr.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = dr["Time"].ToString();
                    data.TreeNum = int.Parse(dr["Sum"].ToString());
                    list.Add(data);
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }





















        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}