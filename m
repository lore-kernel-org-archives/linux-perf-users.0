From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/75] tools lib traceevent: Install trace-seq.h API header file
Date: Thu,  6 Dec 2018 18:25:16 -0300
Message-ID: <20181206212602.20474-30-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch installs trace-seq.h header file on "make install".

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.176265533@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index adb16f845ab3..67fe5d7ef190 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -285,7 +285,7 @@ define do_install_pkgconfig_file
 	fi
 endef
 
-install_lib: all_cmd install_plugins install_pkgconfig
+install_lib: all_cmd install_plugins install_headers install_pkgconfig
 	$(call QUIET_INSTALL, $(LIB_TARGET)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
@@ -302,6 +302,7 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
 		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
+		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
 		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)
 
 install: install_lib
-- 
2.19.2
