From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/53] perf hist: Remove symbol.h from hist.h, just fwd decls are needed
Date: Wed,  6 Feb 2019 15:48:19 -0300
Message-ID: <20190206184903.24054-10-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce the includes dependencies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cmvg5ght75mmfg1efeyna9rn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c | 1 +
 tools/perf/util/auxtrace.c   | 1 +
 tools/perf/util/callchain.c  | 1 +
 tools/perf/util/hist.h       | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index f42666ee0672..df49c9ba1785 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -5,6 +5,7 @@
 #include "util/annotate.h"
 #include "util/evsel.h"
 #include "util/map.h"
+#include "util/symbol.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
 #include <signal.h>
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f69961c4a4f3..94a22cc8004c 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -41,6 +41,7 @@
 #include "pmu.h"
 #include "evsel.h"
 #include "cpumap.h"
+#include "symbol.h"
 #include "thread_map.h"
 #include "asm/bug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index cc47dba973f2..abb608b09269 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -26,6 +26,7 @@
 #include "map.h"
 #include "callchain.h"
 #include "branch.h"
+#include "symbol.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
 	.mode		= CHAIN_GRAPH_ABS,	\
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index f50aad24928e..38a72eb81427 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,12 +8,13 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
-#include "symbol.h"
 #include "ui/progress.h"
 
 struct hist_entry;
 struct hist_entry_ops;
 struct addr_location;
+struct mem_info;
+struct branch_info;
 struct symbol;
 
 enum hist_filter {
-- 
2.20.1
