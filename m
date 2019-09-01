From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/47] perf tools: Remove needless perf.h include directive from headers
Date: Sun,  1 Sep 2019 09:22:52 -0300
Message-ID: <20190901122326.5793-14-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its not needed there, add it to the places that need it and were getting
it via those headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5yulx1u16vyd0zmrbg1tjhju@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c            | 1 +
 tools/perf/builtin-diff.c           | 1 +
 tools/perf/builtin-record.c         | 1 +
 tools/perf/builtin-script.c         | 1 +
 tools/perf/builtin-stat.c           | 1 +
 tools/perf/builtin-trace.c          | 1 +
 tools/perf/perf.c                   | 1 +
 tools/perf/ui/browsers/hists.c      | 1 +
 tools/perf/ui/browsers/res_sample.c | 1 +
 tools/perf/ui/browsers/scripts.c    | 1 +
 tools/perf/ui/hist.c                | 1 +
 tools/perf/ui/tui/setup.c           | 1 +
 tools/perf/util/auxtrace.h          | 1 -
 tools/perf/util/callchain.c         | 1 +
 tools/perf/util/event.c             | 1 +
 tools/perf/util/event.h             | 1 -
 tools/perf/util/evlist.c            | 1 +
 tools/perf/util/evlist.h            | 1 -
 tools/perf/util/mmap.c              | 1 +
 tools/perf/util/session.c           | 1 +
 tools/perf/util/top.c               | 1 +
 21 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8335a4076a5a..25a5f186dfde 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -35,6 +35,7 @@
 #include "thread.h"
 #include "mem2node.h"
 #include "symbol.h"
+#include "../perf.h"
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 51c37e53b3d8..ae4a8ebf90d2 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -6,6 +6,7 @@
  * DSOs and symbol information, sort them and produce a diff.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/debug.h"
 #include "util/event.h"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bd2a0cc6eb52..56705d2a6bec 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -42,6 +42,7 @@
 #include "util/units.h"
 #include "util/bpf-event.h"
 #include "asm/bug.h"
+#include "perf.h"
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37297b67905d..f3b31c6ed15f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -53,6 +53,7 @@
 #include <perf/evlist.h>
 #include "util/record.h"
 #include "util/util.h"
+#include "perf.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2741bcb049fb..fa4212dac9bb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -41,6 +41,7 @@
  */
 
 #include "builtin.h"
+#include "perf.h"
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6d9805a8791b..105695033ebc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -51,6 +51,7 @@
 #include "string2.h"
 #include "syscalltbl.h"
 #include "rb_resort.h"
+#include "../perf.h"
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index a95a248a7421..237b9b3a1bf1 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -8,6 +8,7 @@
  * perf top, perf record, perf report, etc.) are started.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 30547fdb0787..ccc37284860b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -22,6 +22,7 @@
 #include "../../util/top.h"
 #include "../../util/thread.h"
 #include "../../arch/common.h"
+#include "../../perf.h"
 
 #include "../browsers/hists.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 41a9d8923ec4..db3954fea74c 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -8,6 +8,7 @@
 #include "time-utils.h"
 #include "../util.h"
 #include "../../util/util.h"
+#include "../../perf.h"
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 50e0c03171f2..e63f3778d75c 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
+#include "../../perf.h"
 #include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e5fb64347b2c..ae29f16979ac 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -9,6 +9,7 @@
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
+#include "../perf.h"
 
 /* hist period print (hpp) functions */
 
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 3ad0d3363ac6..2881982b483c 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -11,6 +11,7 @@
 #include "../../util/cache.h"
 #include "../../util/debug.h"
 #include "../../util/util.h"
+#include "../../perf.h"
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 1fa8a965b03f..bc39cc5610a8 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -17,7 +17,6 @@
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
-#include "../perf.h"
 #include "event.h"
 #include "session.h"
 #include "debug.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index dd6e01000385..a47d0e8c2434 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -28,6 +28,7 @@
 #include "callchain.h"
 #include "branch.h"
 #include "symbol.h"
+#include "../perf.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
 	.mode		= CHAIN_GRAPH_ABS,	\
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7fa7a303e476..ef7fc574f701 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -30,6 +30,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "../perf.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4c0c5232bd41..f56d268f06e3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -9,7 +9,6 @@
 #include <linux/perf_event.h>
 #include <perf/event.h>
 
-#include "../perf.h"
 #include "build-id.h"
 #include "perf_regs.h"
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 253dd8dd0e12..71b231c7097f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "units.h"
 #include "util.h"
+#include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <signal.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 16796de7af3f..ee288644e9e4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,7 +9,6 @@
 #include <api/fd/array.h>
 #include <stdio.h>
 #include <internal/evlist.h>
-#include "../perf.h"
 #include "event.h"
 #include "evsel.h"
 #include "mmap.h"
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5f3532e51ec9..28477ff5114e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "event.h"
 #include "mmap.h"
+#include "../perf.h"
 #include "util.h" /* page_size */
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9eb843e5e6f0..82bd5d4361f0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "util.h"
+#include "../perf.h"
 #include "arch/common.h"
 
 #ifdef HAVE_ZSTD_SUPPORT
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index e5b690cf2898..51fb574998bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -12,6 +12,7 @@
 #include "parse-events.h"
 #include "symbol.h"
 #include "top.h"
+#include "../perf.h"
 #include <inttypes.h>
 
 #define SNPRINTF(buf, size, fmt, args...) \
-- 
2.21.0
