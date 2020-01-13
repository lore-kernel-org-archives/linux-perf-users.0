From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Date: Mon, 13 Jan 2020 10:25:39 +0100
Message-ID: <20200113092539.GD35080@krava>
References: <20191205193224.24629-1-acme@kernel.org>
 <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 13, 2020 at 01:58:59PM +0530, Ravi Bangoria wrote:

SNIP

>         | ^~~~
>   In file included from /usr/include/glib-2.0/gobject/gobject.h:24,
>                    from /usr/include/glib-2.0/gobject/gbinding.h:29,
>                    from /usr/include/glib-2.0/glib-object.h:23,
>                    from /usr/include/glib-2.0/gio/gioenums.h:28,
>                    from /usr/include/glib-2.0/gio/giotypes.h:28,
>                    from /usr/include/glib-2.0/gio/gio.h:26,
>                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:=
30,
>                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
>                    from test-gtk2.c:3:
>   /usr/include/glib-2.0/gobject/gtype.h:679:1: note: declared here
>     679 | {
>         | ^
>   In file included from /usr/include/gtk-2.0/gtk/gtktoolitem.h:31,
>                    from /usr/include/gtk-2.0/gtk/gtktoolbutton.h:30,
>                    from /usr/include/gtk-2.0/gtk/gtkmenutoolbutton.h:30=
,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:126,
>                    from test-gtk2.c:3:
>   /usr/include/gtk-2.0/gtk/gtktooltips.h:73:3: error: =E2=80=98GTimeVal=
=E2=80=99 is deprecated: Use 'GDateTime' instead [-Werror=3Ddeprecated-de=
clarations]
>      73 |   GTimeVal last_popdown;
>         |   ^~~~~~~~
>   In file included from /usr/include/glib-2.0/glib/galloca.h:32,
>                    from /usr/include/glib-2.0/glib.h:30,
>                    from /usr/include/glib-2.0/gobject/gbinding.h:28,
>                    from /usr/include/glib-2.0/glib-object.h:23,
>                    from /usr/include/glib-2.0/gio/gioenums.h:28,
>                    from /usr/include/glib-2.0/gio/giotypes.h:28,
>                    from /usr/include/glib-2.0/gio/gio.h:26,
>                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:=
30,
>                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
>                    from test-gtk2.c:3:
>   /usr/include/glib-2.0/glib/gtypes.h:551:8: note: declared here
>     551 | struct _GTimeVal
>         |        ^~~~~~~~~
>   cc1: all warnings being treated as errors
>=20

patch below fixes that for me.. please let me know
if it works for you and I'll post full patch

jirka


---
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f30a89046aa3..7ac0d8088565 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -197,7 +197,7 @@ $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
=20
 $(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -W=
no-deprecated-declarations
=20
 $(OUTPUT)test-gtk2-infobar.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index ec22e899a224..eef708c502f4 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -1,4 +1,4 @@
-CFLAGS_gtk +=3D -fPIC $(GTK_CFLAGS)
+CFLAGS_gtk +=3D -fPIC $(GTK_CFLAGS) -Wno-deprecated-declarations
=20
 gtk-y +=3D browser.o
 gtk-y +=3D hists.o
@@ -7,3 +7,8 @@ gtk-y +=3D util.o
 gtk-y +=3D helpline.o
 gtk-y +=3D progress.o
 gtk-y +=3D annotate.o
+gtk-y +=3D zalloc.o
+
+$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
