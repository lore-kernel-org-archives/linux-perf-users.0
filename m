From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/73] tools lib traceevent: Remove hard coded install paths from pkg-config file
Date: Fri, 17 May 2019 16:35:02 -0300
Message-ID: <20190517193611.4974-5-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Jiri Olsa <jolsa@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Install directories of header and library files are hard coded in
pkg-config template file.

They must be configurable, the Makefile should set them on the
compilation / install stage.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190418211556.5a12adc3@oasis.local.home
Link: http://lkml.kernel.org/r/20190329144546.5819-1-tstoyanov@vmware.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile                  | 13 +++++++++----
 tools/lib/traceevent/libtraceevent.pc.template |  4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 941761d9923d..34cf33a4f001 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -50,6 +50,9 @@ man_dir = $(prefix)/share/man
 man_dir_SQ = '$(subst ','\'',$(man_dir))'
 pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
 			--variable pc_path pkg-config | tr ":" " "))
+includedir_relative = traceevent
+includedir = $(prefix)/include/$(includedir_relative)
+includedir_SQ = '$(subst ','\'',$(includedir))'
 
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
@@ -279,6 +282,8 @@ define do_install_pkgconfig_file
 		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|LIB_DIR|${libdir}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|HEADER_DIR|$(includedir)|g" ${PKG_CONFIG_FILE}; \
 		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
 	else 									\
 		(echo Failed to locate pkg-config directory) 1>&2;		\
@@ -300,10 +305,10 @@ install_pkgconfig:
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)
+		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
 
 install: install_lib
 
diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
index 42e4d6cb6b9e..86384fcd57f1 100644
--- a/tools/lib/traceevent/libtraceevent.pc.template
+++ b/tools/lib/traceevent/libtraceevent.pc.template
@@ -1,6 +1,6 @@
 prefix=INSTALL_PREFIX
-libdir=${prefix}/lib64
-includedir=${prefix}/include/traceevent
+libdir=LIB_DIR
+includedir=HEADER_DIR
 
 Name: libtraceevent
 URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1
