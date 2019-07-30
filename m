From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 051/107] libperf: Add build version support
Date: Mon, 29 Jul 2019 23:55:14 -0300
Message-ID: <20190730025610.22603-52-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a shared library version, generating the following files:

  $ ll tools/perf/lib/libperf.so*
  libperf.so -> libperf.so.0.0.1
  libperf.so.0 -> libperf.so.0.0.1
  libperf.so.0.0.1

Committer testing:

One has to build just libbperf to get this, building perf so far doesn't
trigger this, i.e. I tried:

  $ make O=/tmp/build/perf -C tools/perf

And the files above were not created, so one has to do:

  $ make O=/tmp/build/perf -C tools/perf/lib/
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so.0.0.1
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ ls -la /tmp/build/perf/*.so.*
  lrwxrwxrwx. 1 acme acme    16 Jul 22 15:37 /tmp/build/perf/libperf.so.0 -> libperf.so.0.0.1
  -rwxrwxr-x. 1 acme acme 16368 Jul 22 15:37 /tmp/build/perf/libperf.so.0.0.1
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile    | 20 +++++++++++++++++---
 tools/perf/lib/libperf.map |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/lib/libperf.map

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 33046e7c6a2a..cd571ec648ad 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/bpf/Makefile
 
+LIBPERF_VERSION = 0
+LIBPERF_PATCHLEVEL = 0
+LIBPERF_EXTRAVERSION = 1
+
 MAKEFLAGS += --no-print-directory
 
 ifeq ($(srctree),)
@@ -47,7 +51,13 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-LIBPERF_SO := $(OUTPUT)libperf.so
+VERSION_SCRIPT := libperf.map
+
+PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
+EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
+VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
+
+LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
 
@@ -58,7 +68,11 @@ $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libperf.so
+	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
+
 
 libs: $(LIBPERF_A) $(LIBPERF_SO)
 
@@ -67,7 +81,7 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
new file mode 100644
index 000000000000..a8e913988edf
--- /dev/null
+++ b/tools/perf/lib/libperf.map
@@ -0,0 +1,4 @@
+LIBPERF_0.0.1 {
+	local:
+		*;
+};
-- 
2.21.0
