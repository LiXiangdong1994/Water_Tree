using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class UserSuggest
    {
 
        public UserSuggest() { }

        public UserSuggest(int id, int commitUserID, string commitUserName, string title, string suggest, string files, DateTime commitDate, string reply, int replyUserID, string replyUserName, DateTime replyDate,string statusColor)
        {
            this.id = id;
            this.commitUserID = commitUserID;
            this.commitUserName = commitUserName;
            this.title = title;
            this.suggest = suggest;
            this.files = files;
            this.commitDate = commitDate;
            this.reply = reply;
            this.replyUserID = replyUserID;
            this.replyUserName = replyUserName;
            this.replyDate = replyDate;
            this.statusColor = statusColor;
        }

        public int id { get; set; }
        public int commitUserID { get; set; }
        public string commitUserName { get; set; }
        public string title { get; set; }
        public string suggest { get; set; }
        public string files { get; set; }
        public DateTime commitDate { get; set; }
        public string reply { get; set; }
        public int replyUserID { get; set; }
        public string replyUserName { get; set; }
        public DateTime replyDate { get; set; }
        public string statusColor { get; set; }

    }
}
