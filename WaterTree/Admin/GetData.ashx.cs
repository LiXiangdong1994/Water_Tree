using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DBUtility;
using System.Data;
using System.Data.SqlClient;
using Models;
using Newtonsoft.Json;
using System.Collections;

namespace WaterTree.Admin
{
    /// <summary>
    /// GetData 的摘要说明
    /// </summary>
    public class GetData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.ContentType = "text/plain";
      
           
            string action = context.Request["action"].ToString();
            switch (action)
            {
                case "GetTreeAndTaskCountByDayMonth":
                    GetTreeAndTaskCountByDayMonth(context);
                    break;
                case "TownContrast":
                    TownContrast(context);
                    break;

                case "PartyContrast":
                    PartyContrast(context);
                    break;
                case "PartyContrastByMonth":
                    PartyContrastByMonth(context);
                    break;
                case "YearContrast":
                    YearContrast(context);
                    break;
                 case "TreeTypeContrast":
                    TreeTypeContrast(context);
                    break;

                case "GetLayerTreeData":
                    GetLayerTreeData(context);
                    break;
                default:
                    break;
                    
            }
        }
        //当月数据
        public void GetTreeAndTaskCountByDayMonth(HttpContext context)
        {
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
        //镇区对比
        public void TownContrast(HttpContext context)
        {
            string compareObject = context.Request["compareObject"];
            string year= context.Request["year"];

            if (compareObject != "")
            {
                compareObject = compareObject.ToString();
            }
            else
            {
                compareObject = "vwTownTreeSum";
            }
            if (year != "")
            {
                year = year.ToString();
            }
            else
            {
                year = "2019";
            }
            IDataParameter[] parames = new IDataParameter[2];
            parames[0] = new SqlParameter("@View", compareObject);
            parames[1] = new SqlParameter("@Year", year);
            SqlDataReader TownTreeDR = DbHelperSQL.RunProcedure("GetTownCountByYear", parames);
            List<ChartDa> list = null;
            if (TownTreeDR.HasRows)
            {
                list = new List<ChartDa>();
                while (TownTreeDR.Read())
                {
                    ChartDa data = new ChartDa();
                    data.TownName = TownTreeDR["TownName"].ToString();
                    data.Time = TownTreeDR["Time"].ToString();
                    data.TreeNum = int.Parse(TownTreeDR["Sum"].ToString());
                    list.Add(data);
                }
            }
             string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }
        //各年对比
        public void YearContrast(HttpContext context)
        {

            string compareObject = context.Request["compareObject"];
            if (compareObject == "")
            {
                compareObject = "vwTreeSumByYear";
            }

            SqlDataReader PartyTreeDR = DbHelperSQL.ExecuteReader("select * from "+ compareObject + " order by Time asc");
            List<ChartDa> list = null;
            if (PartyTreeDR.HasRows)
            {
                list = new List<ChartDa>();
                while (PartyTreeDR.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = PartyTreeDR["Time"].ToString();
                    data.TreeNum = int.Parse(PartyTreeDR["Sum"].ToString());

                    list.Add(data);
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }

        //各树类对比
        public void TreeTypeContrast(HttpContext context)
        {

            string compareObject = context.Request["compareObject"];
            if (compareObject == "")
            {
                compareObject = "vwTreeSumByYear";
            }

            SqlDataReader PartyTreeDR = DbHelperSQL.ExecuteReader("select * from " + compareObject);
            List<ChartDa> list = null;
            if (PartyTreeDR.HasRows)
            {
                list = new List<ChartDa>();
                while (PartyTreeDR.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = PartyTreeDR["treename"].ToString();
                    data.TreeNum = int.Parse(PartyTreeDR["Sum"].ToString());
                    list.Add(data);
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }

        //党支部对比
        public void PartyContrast(HttpContext context)
        {
           
            string compareObject = context.Request["compareObject"];
            string year = context.Request["year"];
            string TownName = context.Request["TownName"];
            if (compareObject == "")
            {
                compareObject = "vwPartyTreeSum";
            }

            if (year != "")
            {
                year = year.ToString();
            }
            else
            {
                year = "2019";
            }
            if (TownName != "")
            {
                TownName = TownName.ToString();
            }
            else
            {
                TownName = "石龙镇";
            }
            IDataParameter[] parames = new IDataParameter[3];
            parames[0] = new SqlParameter("@View", compareObject);
            parames[1] = new SqlParameter("@Year", year);
            parames[2] = new SqlParameter("@TownName", TownName);
            SqlDataReader PartyTreeDR = DbHelperSQL.RunProcedure("GetPartyCountByYear", parames);
            List<ChartDa> list = null;
            if (PartyTreeDR.HasRows)
            {
                list = new List<ChartDa>();
                while (PartyTreeDR.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = PartyTreeDR["Time"].ToString();
                    data.PartyName = PartyTreeDR["PartyName"].ToString();
                    data.TreeNum = int.Parse(PartyTreeDR["Sum"].ToString());
                  
                    list.Add(data);
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }

        //党支部树木对比12个月
        public void PartyContrastByMonth(HttpContext context)
        {
            string compareObject = context.Request["compareObject"];
            string year = context.Request["year"];
            string TownName = context.Request["TownName"];
            string PartyName = context.Request["PartyName"];
            if (year != "")
            {
                year = year.ToString();
            }
            else
            {
                year = "2019";
            }
            if (TownName != "")
            {
                TownName = TownName.ToString();
            }
            else
            {
                TownName = "石龙镇";
            }
            if (PartyName != "")
            {
                PartyName = PartyName.ToString();
            }
            else
            {
                PartyName = "石龙镇党支部1";
            }
            IDataParameter[] parames = new IDataParameter[5];
            parames[0] = new SqlParameter("@View", compareObject);
            parames[2] = new SqlParameter("@Year", year);
            parames[3] = new SqlParameter("@TownName", TownName);
            parames[4] = new SqlParameter("@PartyName", PartyName);
            SqlDataReader MonthTreeDR = DbHelperSQL.RunProcedure("GetCountByMonthInYear", parames);
            List<ChartDa> list = null;
            if (MonthTreeDR.HasRows)
            {
                list = new List<ChartDa>();
                while (MonthTreeDR.Read())
                {
                    ChartDa data = new ChartDa();
                    data.Time = MonthTreeDR["Time"].ToString();
                    data.TreeNum = int.Parse(MonthTreeDR["Sum"].ToString());
                    list.Add(data);
                }
            }
            string jsonData = JsonConvert.SerializeObject(list);
            context.Response.Write(jsonData);
        }

        //已抛弃
        //public void GetLayerTreeData(HttpContext context)
        //{
        //    //已定义了实体类TreeData
        //    SqlDataReader read = DbHelperSQL.ExecuteReader("select *  from vwDepartWithParentName");
        //    List<TreeData> list = null;
        //    list = new List<TreeData>();
        //    while (read.Read())
        //    {
        //        TreeData treeData = new TreeData();
        //        treeData.ID = int.Parse(read["ID"].ToString());
        //        treeData.Name = read["departname"].ToString();
        //        treeData.ParentID = int.Parse(read["parentid"].ToString());
        //        treeData.PathName = read["path_name"].ToString();//
        //        list.Add(treeData);
        //    }
        //    string jsonData = JsonConvert.SerializeObject(list);//转为Json格式
        //    context.Response.Write(jsonData);
        //}












        public void GetLayerTreeData(HttpContext context)
        {
            SqlDataReader read = DbHelperSQL.ExecuteReader("select *  from vwDepartWithParentName");
            List<TreeData> list = null;
            list = new List<TreeData>();
            while (read.Read())
            {
                TreeData treeData = new TreeData();
                treeData.id = int.Parse(read["ID"].ToString());
                treeData.title = read["departname"].ToString();
                treeData.ParentID = int.Parse(read["parentid"].ToString());
                treeData.PathName = read["path_name"].ToString();
                try
                {
                    treeData.ParentName = read["parentname"].ToString();
                }
                catch (Exception ex)
                {
                    treeData.ParentName = "";
                }
                list.Add(treeData);
            }

            TreeData tree = new TreeData();
            tree.id = list[0].id;
            tree.ParentID = list[0].ParentID;
            tree.title = list[0].title;
            tree.children = new List<TreeData>();
            string name = "";
            tree = GetTree(list, tree, name);
            string jsonData = JsonConvert.SerializeObject(tree);
            context.Response.Write(jsonData);
        }

        public TreeData GetTree(IList<TreeData> list, TreeData pnode, string _name)
        {
            foreach (TreeData model in list)
            {
                if (model.ParentID == 0 && pnode.id == 0)
                {
                    if (_name == model.title)
                    {
                        continue;
                    }
                    TreeData temp = new TreeData();
                    temp.id = model.id;
                    temp.ParentID = model.ParentID;
                    temp.title = model.title;
                    temp.ParentName = model.title;
                    temp.PathName = model.title;
                    temp.children = new List<TreeData>();
                    _name = model.title;
                    pnode.children.Add(temp);
                    GetTree(list, pnode.children[pnode.children.Count - 1], _name);
                }
                else if (model.ParentID == pnode.id)
                {
                    TreeData temp = new TreeData();
                    temp.id = model.id;
                    temp.ParentID = model.ParentID;
                    temp.title = model.title;
                    temp.ParentName = model.ParentName;
                    temp.PathName = model.PathName;
                    temp.children = new List<TreeData>();
                    pnode.children.Add(temp);
                    GetTree(list, pnode.children[pnode.children.Count - 1], _name);
                }
            }
            return pnode;
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