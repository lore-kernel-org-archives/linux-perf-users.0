From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/11] perf tools: Pass build flags to traceevent build
Date: Wed, 17 Oct 2018 19:55:00 -0300
Message-ID: <20181017225501.32150-11-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Herton R. Krzesinski" <herton@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Yordan Karadzhov <y.karadz@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So the extra user build flags are propagated to libtraceevent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: "Herton R. Krzesinski" <herton@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Link: http://lkml.kernel.org/r/20181016150614.21260-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..0be411695379 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -635,7 +635,7 @@ $(LIBPERF_IN): prepare FORCE
 $(LIB_FILE): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
 
-LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ)
+LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
 
 $(LIBTRACEEVENT): FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
-- 
2.14.4
