From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/44] perf tools: Add python-clean target
Date: Fri, 22 Sep 2017 11:41:51 -0300
Message-ID: <20170922144220.9411-16-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To be able to cleanup only python related binaries.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908084621.31595-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 91ef44bfaf3e..1df93b4c4648 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -173,7 +173,7 @@ AWK     = awk
 # non-config cases
 config := 1
 
-NON_CONFIG_TARGETS := clean TAGS tags cscope help install-doc install-man install-html install-info install-pdf doc man html info pdf
+NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help install-doc install-man install-html install-info install-pdf doc man html info pdf
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
@@ -802,7 +802,10 @@ config-clean:
 	$(call QUIET_CLEAN, config)
 	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ $(if $(OUTPUT),OUTPUT=$(OUTPUT)feature/,) clean >/dev/null
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean config-clean fixdep-clean
+python-clean:
+	$(python-clean)
+
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean config-clean fixdep-clean python-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -819,7 +822,6 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
-	$(python-clean)
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
-- 
2.13.5
