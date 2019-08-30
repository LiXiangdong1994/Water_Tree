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

        public ChartDa(string time, int treeNum, int taskNum, int goodNum, int scoreNum)
        {
            Time = time;
            TreeNum = treeNum;
            TaskNum = taskNum;
            GoodNum = goodNum;
            ScoreNum = scoreNum;
        }

        public string Time { get; set; }//日期
        public int TreeNum { get; set; }//植树数
        public int TaskNum { get; set; }//活动数
        public int GoodNum { get; set; }//点赞数
        public int ScoreNum { get; set; } //评分
    }
}
