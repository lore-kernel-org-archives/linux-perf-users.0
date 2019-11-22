From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/26] libtraceevent: Fix header installation
Date: Fri, 22 Nov 2019 11:57:08 -0300
Message-ID: <20191122145711.3171-24-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-devel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

When we passed some location in DESTDIR, install_headers called
do_install with DESTDIR as part of the second argument.

But do_install is again using '$(DESTDIR_SQ)$2', so as a result the
headers were installed in a location $DESTDIR/$DESTDIR.

In my testing I passed DESTDIR=/home/sudip/test and the headers were
installed in: /home/sudip/test/home/sudip/test/usr/include/traceevent.

Lets remove DESTDIR from the second argument of do_install so that the
headers are installed in the correct location.

Signed-off-by: Sudipm Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Sudipm Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191114133719.309-1-sudipm.mukherjee@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 5315f3787f8d..cbb429f55062 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -232,10 +232,10 @@ install_pkgconfig:
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
-		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
-		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
-		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
+		$(call do_install,event-parse.h,$(includedir_SQ),644); \
+		$(call do_install,event-utils.h,$(includedir_SQ),644); \
+		$(call do_install,trace-seq.h,$(includedir_SQ),644); \
+		$(call do_install,kbuffer.h,$(includedir_SQ),644)
 
 install: install_lib
 
-- 
2.21.0
