From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/43] perf tools: Add missing util.h to pick up 'page_size' variable
Date: Mon,  1 Jul 2019 23:25:53 -0300
Message-ID: <20190702022616.1259-21-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Not to depend of getting it indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tirjsmvu4ektw0k7lm8k9lhu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c     | 1 +
 tools/perf/arch/x86/tests/intel-cqm.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c   | 1 +
 tools/perf/perf.c                     | 1 +
 tools/perf/util/machine.c             | 1 +
 tools/perf/util/python.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c6f1ab5499b5..2b83cc8e4796 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,6 +22,7 @@
 #include "../../util/pmu.h"
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
+#include "../../util/util.h"
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 90a4a8c58a62..94aa0b673b7f 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -6,6 +6,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "arch-tests.h"
+#include "util.h"
 
 #include <signal.h>
 #include <sys/mman.h>
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1869f62a10cd..9804098dcefb 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -25,6 +25,7 @@
 #include "../../util/auxtrace.h"
 #include "../../util/tsc.h"
 #include "../../util/intel-pt.h"
+#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 72df4b6fa36f..2123b3cc4dcf 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,6 +18,7 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/util.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <errno.h>
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 17eec39e775e..a0bb05dd008f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -15,6 +15,7 @@
 #include "strlist.h"
 #include "thread.h"
 #include "vdso.h"
+#include "util.h"
 #include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6aa7e2352e16..1e5b6718dcea 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "print_binary.h"
 #include "thread_map.h"
 #include "mmap.h"
+#include "util.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
-- 
2.20.1
