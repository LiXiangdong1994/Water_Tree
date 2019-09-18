using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.IO;

namespace WaterTree.Admin
{
        /// <summary>
        /// 基本页
        /// </summary>
        public class PageBase : System.Web.UI.Page
        {
            #region 内部常量
            private static readonly string SCRIPT_INCLUDE_TEMPLATE = "<script src=\"{0}\" type=\"text/javascript\"></script>\r\n";
            private static readonly string STYLE_INCLUDE_TEMPLATE = "\r\n<link href=\"{0}\" rel=\"stylesheet\" type=\"text/css\"/>\r\n";
            private static readonly string SCRIPT_CONTENT_TEMPLATE = "<script type=\"text/javascript\">{0}</script>\r\n";
        #endregion

        protected void Page_InitComplete(object sender, EventArgs e)
            {
                AddMeta();
                AddDefaultCss();
                AddDefaultJs();
                AddCurrentPageJsCss();
            }

            /// <summary>
            /// 添加meta
            /// </summary>
            private void AddMeta()
            {
                LiteralControl viewportControl = new LiteralControl();
                viewportControl.ID = "viewport";
                viewportControl.Text = "\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />";
                this.Header.Controls.AddAt(GetNextControlIndex(this), viewportControl);
            }

            /// <summary>
            /// 添加默认的CSS
            /// </summary>
            private void AddDefaultCss()
            {
                //加载element-ui.css
                AddCss("layui.css", "/Scripts/layui/css/layui.css", "/Scripts/layui/css/layui.css");
                AddCss("style.css", "/css/style.css", "/css/style.css");
                AddCss("mui.min.css", "/css/mui.min.css", "/css/mui.min.css");
        }
            /// <summary>
            /// 添加css
            /// </summary>
            /// <param name="cssId">css的id</param>
            /// <param name="cssFullPathOfDebug">调试的CSS完整路径</param>
            /// <param name="cssFullPathOfRelease">发布的CSS完整路径</param>
            private void AddCss(string cssId, string cssFullPathOfDebug, string cssFullPathOfRelease)
            {
                LiteralControl cssControl = new LiteralControl();
                cssControl.ID = cssId;
#if DEBUG
                cssControl.Text = String.Format(STYLE_INCLUDE_TEMPLATE, cssFullPathOfDebug);
#else
               elementUICssControl.Text = String.Format(STYLE_INCLUDE_TEMPLATE, cssFullPathOfRelease);
#endif

                this.Header.Controls.AddAt(GetNextControlIndex(this), cssControl);
            }

            /// <summary>
            /// 添加默认的所有页面需要的js
            /// </summary>
            private void AddDefaultJs()
            {
                //Jquery
                AddJs("jquery-3.3.1.min.js", "/js/jquery-3.3.1.min.js", "/js/jquery-3.3.1.min.js");

                //layui.js
                AddJs("layui.js", "/Scripts/layui/layui.js", "/Scripts/layui/layui.js");
            AddJs("rem.js", "/js/rem.js", "/js/rem.js");
            AddJs("mui.min.js", "/js/mui.min.js", "/js/mui.min.js");
            AddJs("common.js", "/js/common.js", "/js/common.js");

        }

            /// <summary>
            /// 添加JS
            /// </summary>
            /// <param name="jsId">js的id</param>
            /// <param name="jsFullPathOfDebug">调试的JS完整路径</param>
            /// <param name="jsFullPathOfRelease">发布的JS完整路径</param>
            private void AddJs(string jsId, string jsFullPathOfDebug, string jsFullPathOfRelease)
            {
                LiteralControl jsControl = new LiteralControl();
                jsControl.ID = jsId;
#if DEBUG
                jsControl.Text = String.Format(SCRIPT_INCLUDE_TEMPLATE, jsFullPathOfDebug);
#else
            jqueryControl.Text = String.Format(SCRIPT_INCLUDE_TEMPLATE, releaseFullPath);
#endif
                this.Header.Controls.AddAt(GetNextControlIndex(this), jsControl);
            }


            #region GetNextControlIndex
            /// <summary>
            /// 取得下一个控件的位置
            /// </summary>
            /// <returns></returns>
            private static int GetNextControlIndex(Page page)
            {
                int index = 0;

                // 如果存在自定义（以CONTROL_ID_PREFIX开头）的控件，则返回最后一个自定义控件的下一个位置
                // 如果不存在自定义的控件，则返回<title>的下一个位置
                bool startControlBlock = false;
                int titleIndex = 0;
                String CONTROL_ID_PREFIX = "";
                foreach (Control c in page.Header.Controls)
                {
                    if (c is HtmlTitle)
                    {
                        titleIndex = index;
                    }

                    if (c.ID != null && c.ID.StartsWith(CONTROL_ID_PREFIX))
                    {
                        startControlBlock = true;
                    }
                    else
                    {
                        if (startControlBlock)
                        {
                            break;
                        }
                    }

                    index++;
                }

                int retIndex = startControlBlock ? index : titleIndex + 1;
                if (retIndex < 0)
                {
                    retIndex = 0;
                }
                else if (retIndex >= page.Header.Controls.Count)
                {
                    retIndex = page.Header.Controls.Count - 1;
                }

                return retIndex;
            }
            #endregion


            #region AddCurrentPageJsCss
            /// <summary>
            /// 添加当前页的JS和CSS
            /// </summary>
            private void AddCurrentPageJsCss()
            {
                var cssPath = AppRelativeVirtualPath.Replace(".aspx", ".css");
                var jsPath = AppRelativeVirtualPath.Replace(".aspx", ".js");
                if (File.Exists(Server.MapPath(cssPath)))
                {
                    cssPath = cssPath.Replace("~", "");
                    AddCss(cssPath, cssPath, cssPath);
                }
                if (File.Exists(Server.MapPath(jsPath)))
                {
                    jsPath = jsPath.Replace("~", "");
                    AddJs(jsPath, jsPath, jsPath);
                }
            }
            #endregion

            protected virtual void Page_Load(object sender, EventArgs e)
            {

            }
        }
    }
