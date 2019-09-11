using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class TreeData
    {
        public TreeData(int iD, string name, int parentID, string parentName,string pathName,List<TreeData> children)
        {
            id = iD;
            title = name;
            ParentID = parentID;
            ParentName = parentName;
            this.children = children;
            PathName = pathName;
        }
        public TreeData() { }


        public int id { get; set; }
        public string  title { get; set; }
        public int ParentID { get; set; }
        public string ParentName { get; set; }
        public string PathName { get; set; }
        public List<TreeData> children { get; set; }
    }
}
