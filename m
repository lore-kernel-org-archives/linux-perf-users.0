From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/24] perf tools: Unify a bit the build directory output
Date: Wed, 25 Mar 2020 09:41:15 -0300
Message-ID: <20200325124124.32648-16-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Removing the extra 'SUBDIR' line from clean and doc build output.
Because it's annoying.. ;-)

Before:

  $ make clean
  ...
  SUBDIR   Documentation
  CLEAN    Documentation

After:

  $ make clean
  ...
  CLEAN    Documentation

Before:

  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  SUBDIR   Documentation
  ASCIIDOC perf-stat.html
  ...

After:

  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  ASCIIDOC perf-stat.html
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200318204522.1200981-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3eda9d4b88e7..a02aca9b21f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -231,6 +231,7 @@ TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
+DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
@@ -792,7 +793,6 @@ $(LIBSUBCMD): FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
 
 $(LIBSUBCMD)-clean:
-	$(call QUIET_CLEAN, libsubcmd)
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) clean
 
 help:
@@ -832,7 +832,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
@@ -959,7 +959,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:-doc=)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=)
 
 ### Cleaning rules
 
@@ -1008,7 +1008,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array) \
 		$(OUTPUT)$(sync_file_range_arrays)
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
+	$(call QUIET_CLEAN, Documentation) \
+	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
-- 
2.21.1
