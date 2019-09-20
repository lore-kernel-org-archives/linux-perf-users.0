From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/31] perf callchain: Remove needless event.h include
Date: Fri, 20 Sep 2019 11:25:27 -0300
Message-ID: <20190920142542.12047-17-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All we need is a bunch of struct forward declarations and then add
event.h to the only place that was getting it indirectly via
callchain.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qq2xhyuxcvx5vmxha9otjd8d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
 tools/perf/util/callchain.h                       | 5 ++++-
 tools/perf/util/evsel_fprintf.c                   | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index fc9c2f5fcd52..3018a054526a 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -13,6 +13,7 @@
 #include "util/callchain.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/event.h" // struct ip_callchain
 #include "util/map.h"
 #include "util/symbol.h"
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b042ceef4114..83398e5bbe4b 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -4,12 +4,15 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include "event.h"
 #include "map_symbol.h"
 #include "branch.h"
 
+struct addr_location;
 struct evsel;
+struct ip_callchain;
 struct map;
+struct perf_sample;
+struct thread;
 
 #define HELP_PAD "\t\t\t\t"
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 496fec01f5d1..a8cbdf4c2753 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -4,6 +4,7 @@
 #include <stdbool.h>
 #include <traceevent/event-parse.h>
 #include "evsel.h"
+#include "util/event.h"
 #include "callchain.h"
 #include "map.h"
 #include "strlist.h"
-- 
2.21.0
