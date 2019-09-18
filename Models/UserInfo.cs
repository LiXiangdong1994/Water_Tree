using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
   public  class UserInfo
    {
        public UserInfo(int id, string username, string sex, string mobile, string userpwd, DateTime birthdate, DateTime joinpartydate, int roleid, string departid, string tel)
        {
            this.id = id;
            this.username = username;
            this.sex = sex;
            this.mobile = mobile;
            this.userpwd = userpwd;
            this.birthdate = birthdate;
            this.joinpartydate = joinpartydate;
            this.roleid = roleid;
            this.departid = departid;
            this.tel = tel;
        }
        public UserInfo() { }
        public int id { get; set; }
        public string username { get; set; }
        public string sex { get; set; }
        public string mobile { get; set; }
        public string userpwd { get; set; }
        public DateTime birthdate { get; set; }
        public DateTime joinpartydate { get; set; }
        public int roleid { get; set; }
        public string departid { get; set; }
        public string tel { get; set; }
    }
}
