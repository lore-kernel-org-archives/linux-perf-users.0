From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Date: Mon, 13 Jan 2020 13:58:59 +0530
Message-ID: <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 12/6/19 1:02 AM, Arnaldo Carvalho de Melo wrote:
>    39 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc31)

Not related to this pull request, but because we are discussing the
bison issue in this thread, I thought to report here.

On my Fedora 31, gtk2 also fails:

   $ rpm -qa | grep gtk2
   gtk2-2.24.32-6.fc31.x86_64
   gtk2-devel-2.24.32-6.fc31.x86_64

   $ make
   Auto-detecting system features:
   ...                         glibc: [ on  ]
   ...                          gtk2: [ OFF ]
   ...                      libaudit: [ on  ]

   Makefile.config:687: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev


Detail logs:

   $ cat tools/build/feature/test-gtk2.make.output
   In file included from /usr/include/gtk-2.0/gtk/gtkobject.h:37,
                    from /usr/include/gtk-2.0/gtk/gtkwidget.h:36,
                    from /usr/include/gtk-2.0/gtk/gtkcontainer.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkbin.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkwindow.h:36,
                    from /usr/include/gtk-2.0/gtk/gtkdialog.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkaboutdialog.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:33,
                    from test-gtk2.c:3:
   /usr/include/gtk-2.0/gtk/gtktypeutils.h:236:1: error: ‘GTypeDebugFlags’ is deprecated [-Werror=deprecated-declarations]
     236 | void            gtk_type_init   (GTypeDebugFlags    debug_flags);
         | ^~~~
   In file included from /usr/include/glib-2.0/gobject/gobject.h:24,
                    from /usr/include/glib-2.0/gobject/gbinding.h:29,
                    from /usr/include/glib-2.0/glib-object.h:23,
                    from /usr/include/glib-2.0/gio/gioenums.h:28,
                    from /usr/include/glib-2.0/gio/giotypes.h:28,
                    from /usr/include/glib-2.0/gio/gio.h:26,
                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
                    from test-gtk2.c:3:
   /usr/include/glib-2.0/gobject/gtype.h:679:1: note: declared here
     679 | {
         | ^
   In file included from /usr/include/gtk-2.0/gtk/gtktoolitem.h:31,
                    from /usr/include/gtk-2.0/gtk/gtktoolbutton.h:30,
                    from /usr/include/gtk-2.0/gtk/gtkmenutoolbutton.h:30,
                    from /usr/include/gtk-2.0/gtk/gtk.h:126,
                    from test-gtk2.c:3:
   /usr/include/gtk-2.0/gtk/gtktooltips.h:73:3: error: ‘GTimeVal’ is deprecated: Use 'GDateTime' instead [-Werror=deprecated-declarations]
      73 |   GTimeVal last_popdown;
         |   ^~~~~~~~
   In file included from /usr/include/glib-2.0/glib/galloca.h:32,
                    from /usr/include/glib-2.0/glib.h:30,
                    from /usr/include/glib-2.0/gobject/gbinding.h:28,
                    from /usr/include/glib-2.0/glib-object.h:23,
                    from /usr/include/glib-2.0/gio/gioenums.h:28,
                    from /usr/include/glib-2.0/gio/giotypes.h:28,
                    from /usr/include/glib-2.0/gio/gio.h:26,
                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
                    from test-gtk2.c:3:
   /usr/include/glib-2.0/glib/gtypes.h:551:8: note: declared here
     551 | struct _GTimeVal
         |        ^~~~~~~~~
   cc1: all warnings being treated as errors
