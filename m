From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/35] perf perf: Remove duplicate includes
Date: Thu, 28 Dec 2017 11:30:06 -0300
Message-ID: <20171228143027.30547-15-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Pravin Shedge <pravin.shedge4linux@gmail.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Pravin Shedge <pravin.shedge4linux@gmail.com>

These duplicate includes have been found with scripts/checkincludes.pl
but they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1512582204-6493-1-git-send-email-pravin.shedge4linux@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex-hash.c                          | 1 -
 tools/perf/builtin-c2c.c                               | 3 ---
 tools/perf/builtin-record.c                            | 1 -
 tools/perf/builtin-stat.c                              | 1 -
 tools/perf/tests/parse-events.c                        | 1 -
 tools/perf/util/auxtrace.c                             | 3 ---
 tools/perf/util/header.c                               | 2 --
 tools/perf/util/metricgroup.c                          | 2 --
 tools/perf/util/scripting-engines/trace-event-python.c | 1 -
 9 files changed, 15 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 2defb6df7fd0..9aa3a674829b 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -27,7 +27,6 @@
 #include "cpumap.h"
 
 #include <err.h>
-#include <sys/time.h>
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 10;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f1da9b0833c0..c0debc3f79b6 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -27,13 +27,10 @@
 #include "sort.h"
 #include "tool.h"
 #include "data.h"
-#include "sort.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include <asm/bug.h>
 #include "ui/browsers/hists.h"
-#include "evlist.h"
 #include "thread.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0a5749ef8b94..98da8cb8de93 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,7 +51,6 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
-#include <asm/bug.h>
 #include <linux/time64.h>
 
 struct switch_output {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 58d501d1f5fd..98bf9d32f222 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -63,7 +63,6 @@
 #include "util/group.h"
 #include "util/session.h"
 #include "util/tool.h"
-#include "util/group.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
 #include "asm/bug.h"
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index f0679613bd18..18b06444f230 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -13,7 +13,6 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 #include <linux/hw_breakpoint.h>
-#include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a33491416400..c76687e42344 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -31,9 +31,6 @@
 #include <sys/param.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <string.h>
-#include <limits.h>
-#include <errno.h>
 #include <linux/list.h>
 
 #include "../perf.h"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5890e08e0754..ca73aa7be708 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -15,9 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/stringify.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/utsname.h>
-#include <unistd.h>
 
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e48410c99b39..1ddc3d1d0147 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -20,12 +20,10 @@
 #include "pmu.h"
 #include "expr.h"
 #include "rblist.h"
-#include "pmu.h"
 #include <string.h>
 #include <stdbool.h>
 #include <errno.h>
 #include "pmu-events/pmu-events.h"
-#include "strbuf.h"
 #include "strlist.h"
 #include <assert.h>
 #include <ctype.h>
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c7187f067d31..c1848b543f27 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -43,7 +43,6 @@
 #include "../db-export.h"
 #include "../thread-stack.h"
 #include "../trace-event.h"
-#include "../machine.h"
 #include "../call-path.h"
 #include "thread_map.h"
 #include "cpumap.h"
-- 
2.13.6
