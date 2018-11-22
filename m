From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/28] perf jvmti: Separate jvmti cmlr check
Date: Thu, 22 Nov 2018 00:36:09 -0300
Message-ID: <20181122033611.15890-27-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, Gustavo Luiz Duarte <gduarte@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The Compiled Method Load Record (cmlr) is JDK specific interface to
access JVM stack info. This makes the jvmti agent code not compile under
another jdk, which does not support that.

Separating jvmti cmlr check into special feature check, and adding
HAVE_JVMTI_CMLR macro to indicate that.

Mark cmlr code in jvmti/libjvmti.c with HAVE_JVMTI_CMLR, so we can
compile it on system without cmlr support.

This change makes the jvmti compile with java-1.8.0-ibm package. It's
without the line numbers support, but the rest works.

Adding NO_JVMTI_CMLR compile variable for testing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Gustavo Luiz Duarte <gduarte@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20181121154341.21521-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile          |  4 ++++
 tools/build/feature/test-jvmti-cmlr.c | 11 +++++++++++
 tools/build/feature/test-jvmti.c      |  1 -
 tools/perf/Makefile.config            |  7 +++++++
 tools/perf/Makefile.perf              |  3 +++
 tools/perf/jvmti/libjvmti.c           | 12 ++++++++++++
 6 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-jvmti-cmlr.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 325087a0429c..38c22e122cb0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -55,6 +55,7 @@ FILES=                                          \
          test-sdt.bin                           \
          test-cxx.bin                           \
          test-jvmti.bin				\
+         test-jvmti-cmlr.bin			\
          test-sched_getcpu.bin			\
          test-setns.bin				\
          test-libopencsd.bin			\
@@ -267,6 +268,9 @@ $(OUTPUT)test-cxx.bin:
 $(OUTPUT)test-jvmti.bin:
 	$(BUILD)
 
+$(OUTPUT)test-jvmti-cmlr.bin:
+	$(BUILD)
+
 $(OUTPUT)test-llvm.bin:
 	$(BUILDXX) -std=gnu++11 				\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
diff --git a/tools/build/feature/test-jvmti-cmlr.c b/tools/build/feature/test-jvmti-cmlr.c
new file mode 100644
index 000000000000..c27b5b71a0f6
--- /dev/null
+++ b/tools/build/feature/test-jvmti-cmlr.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <jvmti.h>
+#include <jvmticmlr.h>
+
+int main(void)
+{
+	jvmtiCompiledMethodLoadInlineRecord	rec __attribute__((unused));
+	jvmtiCompiledMethodLoadRecordHeader	hdr __attribute__((unused));
+	PCStackInfo				p   __attribute__((unused));
+	return 0;
+}
diff --git a/tools/build/feature/test-jvmti.c b/tools/build/feature/test-jvmti.c
index 5cf31192f204..799916d2e3e3 100644
--- a/tools/build/feature/test-jvmti.c
+++ b/tools/build/feature/test-jvmti.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <jvmti.h>
-#include <jvmticmlr.h>
 
 int main(void)
 {
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 376d1f78be04..e110010e7faa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -855,6 +855,13 @@ ifndef NO_JVMTI
   $(call feature_check,jvmti)
   ifeq ($(feature-jvmti), 1)
     $(call detected_var,JDIR)
+    ifndef NO_JVMTI_CMLR
+      FEATURE_CHECK_CFLAGS-jvmti-cmlr := $(FEATURE_CHECK_CFLAGS-jvmti)
+      $(call feature_check,jvmti-cmlr)
+      ifeq ($(feature-jvmti-cmlr), 1)
+        CFLAGS += -DHAVE_JVMTI_CMLR
+      endif
+    endif # NO_JVMTI_CMLR
   else
     $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
     NO_JVMTI := 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d95655489f7e..239e7b3270f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -95,6 +95,9 @@ include ../scripts/utilities.mak
 #
 # Define NO_JVMTI if you do not want jvmti agent built
 #
+# Define NO_JVMTI_CMLR (debug only) if you do not want to process CMLR
+# data for java source lines.
+#
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 6add3e982614..aea7b1fe85aa 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -6,7 +6,9 @@
 #include <stdlib.h>
 #include <err.h>
 #include <jvmti.h>
+#ifdef HAVE_JVMTI_CMLR
 #include <jvmticmlr.h>
+#endif
 #include <limits.h>
 
 #include "jvmti_agent.h"
@@ -27,6 +29,7 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
 	}
 }
 
+#ifdef HAVE_JVMTI_CMLR
 static jvmtiError
 do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
 		    jvmti_line_info_t *tab, jint *nr)
@@ -125,6 +128,15 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 	*nr_lines = lines_total;
 	return JVMTI_ERROR_NONE;
 }
+#else /* HAVE_JVMTI_CMLR */
+
+static jvmtiError
+get_line_numbers(jvmtiEnv *jvmti __maybe_unused, const void *compile_info __maybe_unused,
+		 jvmti_line_info_t **tab __maybe_unused, int *nr_lines __maybe_unused)
+{
+	return JVMTI_ERROR_NONE;
+}
+#endif /* HAVE_JVMTI_CMLR */
 
 static void
 copy_class_filename(const char * class_sign, const char * file_name, char * result, size_t max_length)
-- 
2.14.5
