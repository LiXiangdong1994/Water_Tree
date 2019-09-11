using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ChartDa
    {
     
        public ChartDa() { }

        public ChartDa(string time,string treeName, string townName, string partyName, int treeNum, int taskNum, int goodNum, int scoreNum)
        {
            Time = time;
            TreeName = treeName;
            TownName = townName;
            PartyName = partyName;
            TreeNum = treeNum;
            TaskNum = taskNum;
            GoodNum = goodNum;
            ScoreNum = scoreNum;
        }

        public string Time { get; set; }//日期
        public string TownName { get; set; }//镇名字
        public string PartyName { get; set; }//党支部名字
        public string TreeName { get; set; }//树木名字
        public int TreeNum { get; set; }//植树数
        public int TaskNum { get; set; }//活动数
        public int GoodNum { get; set; }//点赞数
        public int ScoreNum { get; set; } //评分
    }
}
