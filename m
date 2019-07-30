From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 099/107] libperf: Add tests support
Date: Mon, 29 Jul 2019 23:56:02 -0300
Message-ID: <20190730025610.22603-100-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding simple test framework, now empty.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-73-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile                 |  7 ++++-
 tools/perf/lib/include/internal/tests.h | 19 +++++++++++++
 tools/perf/lib/tests/Makefile           | 38 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/tests/Makefile

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index f1b3d4c6d5f0..8a9ae50818e4 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -109,6 +109,11 @@ all: fixdep
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+	$(Q)$(MAKE) -C tests clean
+
+tests:
+	$(Q)$(MAKE) -C tests
+	$(Q)$(MAKE) -C tests run
 
 $(LIBPERF_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
@@ -150,4 +155,4 @@ install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
-.PHONY: all install clean FORCE
+.PHONY: all install clean tests FORCE
diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
new file mode 100644
index 000000000000..b7a20cd24ee1
--- /dev/null
+++ b/tools/perf/lib/include/internal/tests.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_TESTS_H
+#define __LIBPERF_INTERNAL_TESTS_H
+
+#include <stdio.h>
+
+#define __T_START fprintf(stdout, "- running %s...", __FILE__)
+#define __T_OK    fprintf(stdout, "OK\n")
+#define __T_FAIL  fprintf(stdout, "FAIL\n")
+
+#define __T(text, cond)                                                          \
+do {                                                                             \
+	if (!(cond)) {                                                           \
+		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		return -1;                                                       \
+	}                                                                        \
+} while (0)
+
+#endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
new file mode 100644
index 000000000000..de951ae38dea
--- /dev/null
+++ b/tools/perf/lib/tests/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+TESTS =
+
+TESTS_SO := $(addsuffix -so,$(TESTS))
+TESTS_A  := $(addsuffix -a,$(TESTS))
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+all:
+
+include $(srctree)/tools/scripts/Makefile.include
+
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+
+$(TESTS_A): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+
+$(TESTS_SO): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+
+all: $(TESTS_A) $(TESTS_SO)
+
+run:
+	@echo "running static:"
+	@for i in $(TESTS_A); do ./$$i; done
+	@echo "running dynamic:"
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+
+clean:
+	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
+
+.PHONY: all clean FORCE
-- 
2.21.0
