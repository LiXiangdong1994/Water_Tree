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
                case "Register":
                    Register(context);
                    break;
                case "CommitSuggest":
                    CommitSuggest(context);
                    break; 
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
                case "GetUserTreeData":
                    GetUserTreeData(context);
                    break;
                case "SendMessage":
                    SendMessage(context);
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
        //已抛弃
        public void GetUserTreeData(HttpContext context)
        {
            //已定义了实体类TreeData
            SqlDataReader read = DbHelperSQL.ExecuteReader("select * from vwUserWithParentName");
            List<TreeData> list = null;
            list = new List<TreeData>();
            while (read.Read())
            {
                TreeData treeData = new TreeData();
                treeData.id = int.Parse(read["id"].ToString());
                treeData.title = read["Name"].ToString();
                treeData.ParentID = int.Parse(read["parentid"].ToString());
                treeData.PathName = read["path_name"].ToString();//
                list.Add(treeData);
            }
            string jsonData = JsonConvert.SerializeObject(list);//转为Json格式
            context.Response.Write(jsonData);
        }












        public void GetLayerTreeData(HttpContext context)
        {
            SqlDataReader read = DbHelperSQL.ExecuteReader("select id,departname,parentid ,path_name from bdepart");
            List<TreeData> list = null;
            list = new List<TreeData>();
            while (read.Read())
            {
                TreeData treeData = new TreeData();
                treeData.id = int.Parse(read["ID"].ToString());
                treeData.title = read["departname"].ToString();
                treeData.ParentID = int.Parse(read["parentid"].ToString());
                treeData.PathName = read["path_name"].ToString();
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
                    temp.PathName = model.PathName;
                    temp.children = new List<TreeData>();
                    pnode.children.Add(temp);
                    GetTree(list, pnode.children[pnode.children.Count - 1], _name);
                }
            }
            return pnode;
        }
        /// <summary>
        /// 注册
        /// </summary>
        /// <param name="context"></param>
        public void Register(HttpContext context)
        {
            string username=context.Request["username"];
            string mobile= context.Request["mobile"];
            string departid= context.Request["departid"];
            UserInfo user = new UserInfo();
            user.username = username;
            user.mobile = mobile;
            user.departid = departid;
            int num = DbHelperSQL.ExecuteSql("insert into sys_UserInfo(username,mobile,departid) values('"+ username + "','" + mobile + "','" + departid + "')");
            var result = new BaseDataPackage<UserInfo>();
            if (num != 0) {
            result.code = ApiStatusCode.OK;
            result.data = user;
            result.msg = "注册成功";
            }else
            {
                result.code = ApiStatusCode.FAIL;
                result.data = user;
                result.msg = "注册失败";
            }
            string jsonData = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonData);
        }
        public void CommitSuggest(HttpContext context)
        {
            string fileNewName = string.Empty;
            string filePath = string.Empty;
            var result = new BaseDataPackage<UserSuggest>();
            HttpPostedFile file = context.Request.Files["file1"];
            HttpPostedFile file2 = context.Request.Files["file2"];
            HttpPostedFile file3 = context.Request.Files["file3"];
            string Title = context.Request["Title"];
            string Suggest = context.Request["Suggest"];
            string UserID = context.Request["UserID"];
            string paths = context.Request["paths"];
            string pathsNew = "";
            if ( paths!= "")
            {
                string[] sArray = paths.Split(',');
                foreach (string pathSplit in sArray) {
                    if (pathSplit != "") {
                    fileNewName = DateTime.Now.ToString("yyyyMMddHHmmssff") + "_" + System.IO.Path.GetFileName(pathSplit);
                    string virtualPath = String.Format("/File/{0}", fileNewName);//上传到指定文件夹
                    string path = virtualPath;//相对获取文件路径
                    pathsNew += path + ",";
                 }
                }
            }
            if (file!=null)
            {
                file.SaveAs(context.Server.MapPath("~/File/" + DateTime.Now.ToString("yyyyMMddHHmmssff") + "_" + System.IO.Path.GetFileName(file.FileName)));
            }
            if (file2 != null)
            {
                file2.SaveAs(context.Server.MapPath("~/File/" + DateTime.Now.ToString("yyyyMMddHHmmssff") + "_" + System.IO.Path.GetFileName(file2.FileName)));
            }
            if (file3 != null)
            {
                file3.SaveAs(context.Server.MapPath("~/File/" + DateTime.Now.ToString("yyyyMMddHHmmssff") + "_" + System.IO.Path.GetFileName(file3.FileName)));
            }
            result.code = ApiStatusCode.OK;
            result.msg = "";
            result.data = null;
            UserSuggest userSuggest = new UserSuggest();
            userSuggest.commitUserID = int.Parse(UserID);
            userSuggest.title = Title;
            userSuggest.suggest = Suggest;
            userSuggest.commitDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            userSuggest.files = pathsNew;
            int num = DbHelperSQL.ExecuteSql("insert into sys_UserSuggest(commitUserID,title,suggest,commitDate,files) values('" + userSuggest.commitUserID + "','" + userSuggest.title + "','" + userSuggest.suggest + "','" + userSuggest.commitDate + "','" + userSuggest.files + "')");
            if (num != 0)
            {
                result.code = ApiStatusCode.OK;
                result.msg = "提交成功！";
                result.data = userSuggest;
            }
            else
            {
                result.code = ApiStatusCode.OK;
                result.msg = "提交失败！";
                result.data = userSuggest;
            }
            string jsonData = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonData);
        }

        //发布消息的树
        //public void GetUserTreeData(HttpContext context)
        //{
        //    SqlDataReader read = DbHelperSQL.ExecuteReader("select * from vwUserWithParentName");
        //    List<TreeData> list = null;
        //    list = new List<TreeData>();
        //    while (read.Read())
        //    {
        //        TreeData treeData = new TreeData();
        //        treeData.id = int.Parse(read["id"].ToString());
        //        treeData.title = read["Name"].ToString();
        //        treeData.ParentID = int.Parse(read["parentid"].ToString());
        //        treeData.PathName = read["path_name"].ToString();
        //        list.Add(treeData);
        //    }

        //    TreeData tree = new TreeData();
        //    tree.id = list[0].id;
        //    tree.ParentID = list[0].ParentID;
        //    tree.title = list[0].title;
        //    tree.children = new List<TreeData>();
        //    string name = "";
        //    tree = GetTree(list, tree, name);
        //    string jsonData = JsonConvert.SerializeObject(tree);
        //    context.Response.Write(jsonData);
        //}

        public void SendMessage(HttpContext context)
        {
            var result = new BaseDataPackage<UserMessage>();
            string AcceptUserID = context.Request["AcceptUserID"];
            string AcceptUserName = context.Request["AcceptUserName"];
            string SendUserID = context.Request["SendUserID"];
            string SendUserName = context.Request["SendUserName"];
            string MsgTitle = context.Request["MsgTitle"];
            string MsgText = context.Request["MsgText"];
            string SendToList = context.Request["SendToList"];
            string MessageType ="";


            UserMessage UserMessage = new UserMessage();
            UserMessage.AcceptUserID = AcceptUserID;
            UserMessage.AcceptUserName = AcceptUserName;
            UserMessage.SendUserID = SendUserID;
            UserMessage.SendUserName = SendUserName;
            UserMessage.MsgTitle = MsgTitle;
            UserMessage.MsgText = MsgText;
            UserMessage.SendToList = SendToList;
            UserMessage.MessageType = MessageType;
            UserMessage.bRead = false;
            UserMessage.SendDateTime = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            int num = DbHelperSQL.ExecuteSql("insert into sys_UserMessage (AcceptUserID, AcceptUserName, SendUserID, SendUserName, MsgTitle, MsgText, SendToList, MessageType, bRead, SendDateTime) values('" + AcceptUserID + "', '" + AcceptUserName + "', '" + SendUserID + "', '" + SendUserName+ "', '" +MsgTitle + "' , '" +MsgText + "', '" +SendToList + "', '" +MessageType + "', '" + false + "', '" + UserMessage.SendDateTime + "' )");
            if (num != 0)
            {
                result.code = ApiStatusCode.OK;
                result.msg = "发送成功！";
                result.data = UserMessage;
            }
            else
            {
                result.code = ApiStatusCode.OK;
                result.msg = "发送失败！";
                result.data = UserMessage;
            }
            string jsonData = JsonConvert.SerializeObject(result);
            context.Response.Write(jsonData);
        }




        /// <summary>
        /// 状态码
        /// </summary>
        public class ApiStatusCode
        {
            /// <summary>
            /// OK
            /// </summary>
            public const int OK = 0;

            /// <summary>
            /// 失败
            /// </summary>
            public const int FAIL = 1;

            /// <summary>
            /// 异常
            /// </summary>
            public const int EXCEPTION = 2;
        }

        public class BaseDataPackage<T>
        {
            public int code { get; set; }
            public string msg { get; set; }
            public T data { get; set; }


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