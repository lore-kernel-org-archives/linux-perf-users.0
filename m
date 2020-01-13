From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Date: Mon, 13 Jan 2020 15:14:40 +0530
Message-ID: <d3e490aa-994f-3bec-cddf-cd5659e5859d@linux.ibm.com>
References: <20191205193224.24629-1-acme@kernel.org>
 <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
 <20200113092539.GD35080@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200113092539.GD35080@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 1/13/20 2:55 PM, Jiri Olsa wrote:
> On Mon, Jan 13, 2020 at 01:58:59PM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
>>          | ^~~~
>>    In file included from /usr/include/glib-2.0/gobject/gobject.h:24,
>>                     from /usr/include/glib-2.0/gobject/gbinding.h:29,
>>                     from /usr/include/glib-2.0/glib-object.h:23,
>>                     from /usr/include/glib-2.0/gio/gioenums.h:28,
>>                     from /usr/include/glib-2.0/gio/giotypes.h:28,
>>                     from /usr/include/glib-2.0/gio/gio.h:26,
>>                     from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
>>                     from /usr/include/gtk-2.0/gdk/gdk.h:32,
>>                     from /usr/include/gtk-2.0/gtk/gtk.h:32,
>>                     from test-gtk2.c:3:
>>    /usr/include/glib-2.0/gobject/gtype.h:679:1: note: declared here
>>      679 | {
>>          | ^
>>    In file included from /usr/include/gtk-2.0/gtk/gtktoolitem.h:31,
>>                     from /usr/include/gtk-2.0/gtk/gtktoolbutton.h:30,
>>                     from /usr/include/gtk-2.0/gtk/gtkmenutoolbutton.h:30,
>>                     from /usr/include/gtk-2.0/gtk/gtk.h:126,
>>                     from test-gtk2.c:3:
>>    /usr/include/gtk-2.0/gtk/gtktooltips.h:73:3: error: ‘GTimeVal’ is deprecated: Use 'GDateTime' instead [-Werror=deprecated-declarations]
>>       73 |   GTimeVal last_popdown;
>>          |   ^~~~~~~~
>>    In file included from /usr/include/glib-2.0/glib/galloca.h:32,
>>                     from /usr/include/glib-2.0/glib.h:30,
>>                     from /usr/include/glib-2.0/gobject/gbinding.h:28,
>>                     from /usr/include/glib-2.0/glib-object.h:23,
>>                     from /usr/include/glib-2.0/gio/gioenums.h:28,
>>                     from /usr/include/glib-2.0/gio/giotypes.h:28,
>>                     from /usr/include/glib-2.0/gio/gio.h:26,
>>                     from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
>>                     from /usr/include/gtk-2.0/gdk/gdk.h:32,
>>                     from /usr/include/gtk-2.0/gtk/gtk.h:32,
>>                     from test-gtk2.c:3:
>>    /usr/include/glib-2.0/glib/gtypes.h:551:8: note: declared here
>>      551 | struct _GTimeVal
>>          |        ^~~~~~~~~
>>    cc1: all warnings being treated as errors
>>
> 
> patch below fixes that for me.. please let me know
> if it works for you and I'll post full patch
> 
> jirka
> 

LGTM. You can add:

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
