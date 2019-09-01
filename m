From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/47] perf tools: Remove needless sort.h include directives
Date: Sun,  1 Sep 2019 09:23:08 -0300
Message-ID: <20190901122326.5793-30-acme@kernel.org>
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

Now that sort.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tom8k0lbsxd9joprr8zpu6w1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c         | 1 +
 tools/perf/ui/browsers/scripts.c | 1 -
 tools/perf/util/hist.c           | 1 +
 tools/perf/util/mem-events.c     | 1 -
 tools/perf/util/session.c        | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0b7b12cfdd63..0f0d96262d14 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -39,6 +39,7 @@
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
+#include "util/callchain.h"
 #include "util/cpumap.h"
 #include "util/sort.h"
 #include "util/string2.h"
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 77809c0fad02..bf1d9f9ec035 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
 #include "../../perf.h"
-#include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b526ef3ede98..0978dc4a33db 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -20,6 +20,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 42c3e5a229d2..3a8d38ce3b54 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -11,7 +11,6 @@
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
-#include "sort.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f166da76acf1..e5ac5f3c94d4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -20,7 +20,6 @@
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-#include "sort.h"
 #include "cpumap.h"
 #include "perf_regs.h"
 #include "asm/bug.h"
-- 
2.21.0
