using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class UserMessage
    {
        public UserMessage(int id, string acceptUserID, string acceptUserName, string sendUserID, string sendUserName, string msgTitle, string msgText, string sendToList, string messageType, DateTime sendDateTime, bool bRead,string statusColor)
        {
            this.id = id;
            AcceptUserID = acceptUserID;
            AcceptUserName = acceptUserName;
            SendUserID = sendUserID;
            SendUserName = sendUserName;
            MsgTitle = msgTitle;
            MsgText = msgText;
            SendToList = sendToList;
            MessageType = messageType;
            SendDateTime = sendDateTime;
            this.bRead = bRead;
            this.statusColor = statusColor;
        }
        public UserMessage() { }
        public  int id { get; set; }
        public string AcceptUserID { get; set; }
        public string AcceptUserName { get; set; }
        public string SendUserID { get; set; }
        public string SendUserName { get; set; }
        public string MsgTitle { get; set; }
        public string MsgText { get; set; }
        public string SendToList { get; set; }
        public string MessageType { get; set; }
        public DateTime SendDateTime { get; set; }
        public bool bRead { get; set; }
        public string statusColor { get; set; }
    }
}
