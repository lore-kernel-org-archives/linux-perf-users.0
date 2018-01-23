From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/43] perf tools: Integrating the CoreSight decoding library
Date: Tue, 23 Jan 2018 10:12:36 -0300
Message-ID: <20180123131251.28197-29-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The Open CoreSight Decoding Library (openCSD) is a free and open library
to decode traces collected by the CoreSight hardware infrastructure.

This patch adds the required mechanic to recognise the presence of the
openCSD library on a system and set up miscellaneous flags to be used in
the compilation of the trace decoding feature.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: http://lkml.kernel.org/r/1516211539-5166-2-git-send-email-mathieu.poirier@linaro.org
Link: http://lkml.kernel.org/r/1516635644-24819-1-git-send-email-mathieu.poirier@linaro.org
[ Merged missing test-libopencsd.c file, provided later by Mathieu ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature          |  3 ++-
 tools/build/feature/Makefile          |  7 ++++++-
 tools/build/feature/test-all.c        |  5 +++++
 tools/build/feature/test-libopencsd.c |  8 ++++++++
 tools/perf/Makefile.config            | 25 +++++++++++++++++++++++++
 tools/perf/Makefile.perf              |  2 ++
 6 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libopencsd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index e52fcefee379..c378f003b007 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
         bpf                             \
         sched_getcpu			\
         sdt				\
-        setns
+        setns				\
+        libopencsd
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cff38f342283..59585fe20221 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,7 +52,8 @@ FILES=                                          \
          test-cxx.bin                           \
          test-jvmti.bin				\
          test-sched_getcpu.bin			\
-         test-setns.bin
+         test-setns.bin				\
+         test-libopencsd.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -104,6 +105,10 @@ $(OUTPUT)test-sched_getcpu.bin:
 $(OUTPUT)test-setns.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libopencsd.bin:
+	$(BUILD) # -lopencsd_c_api -lopencsd provided by
+		 # $(FEATURE_CHECK_LDFLAGS-libopencsd)
+
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
 DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6fdf83263ab7..8dc20a61341f 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -162,6 +162,10 @@
 # include "test-setns.c"
 #undef main
 
+#define main main_test_libopencsd
+# include "test-libopencsd.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -199,6 +203,7 @@ int main(int argc, char *argv[])
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
+	main_test_libopencsd();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
new file mode 100644
index 000000000000..5ff1246e6194
--- /dev/null
+++ b/tools/build/feature/test-libopencsd.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <opencsd/c_api/opencsd_c_api.h>
+
+int main(void)
+{
+	(void)ocsd_get_version();
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a042ccca4e93..0dfdaa9fa81e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -105,6 +105,16 @@ FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 
+ifdef CSINCLUDES
+  LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
+endif
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
+ifdef CSLIBS
+  LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
+endif
+FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
+
 ifeq ($(NO_PERF_REGS),0)
   CFLAGS += -DHAVE_PERF_REGS_SUPPORT
 endif
@@ -353,6 +363,21 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
+ifndef NO_CORESIGHT
+  ifeq ($(feature-libopencsd), 1)
+    CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
+    LDFLAGS += $(LIBOPENCSD_LDFLAGS)
+    EXTLIBS += $(OPENCSDLIBS)
+    $(call detected,CONFIG_LIBOPENCSD)
+    ifdef CSTRACE_RAW
+      CFLAGS += -DCS_DEBUG_RAW
+      ifeq (${CSTRACE_RAW}, packed)
+        CFLAGS += -DCS_RAW_PACKED
+      endif
+    endif
+  endif
+endif
+
 ifndef NO_LIBELF
   CFLAGS += -DHAVE_LIBELF_SUPPORT
   EXTLIBS += -lelf
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9a9b528a88bb..9b0351d3ce34 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -98,6 +98,8 @@ include ../scripts/utilities.mak
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
 
+# Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
 LC_COLLATE=C
-- 
2.14.3
