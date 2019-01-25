From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/29] perf annotate: Remove lots of headers from annotate.h
Date: Sat, 26 Jan 2019 00:18:16 +0100
Message-ID: <20190125231843.2895-3-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce the chances changes trigger tons of rebuilds, more to come.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ytbykaku63862guk7muflcy4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c   |  1 +
 tools/perf/util/annotate.h     | 14 +++++++++++---
 tools/perf/util/stat-display.c |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 48428c9acd89..f22a7d142ada 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "gtk.h"
+#include "util/sort.h"
 #include "util/debug.h"
 #include "util/annotate.h"
 #include "util/evsel.h"
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fb6463730ba4..95053cab41fe 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -4,16 +4,24 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <linux/types.h>
-#include "symbol.h"
-#include "hist.h"
-#include "sort.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <pthread.h>
 #include <asm/bug.h>
+#include "symbol_conf.h"
 
+struct hist_browser_timer;
+struct hist_entry;
 struct ins_ops;
+struct map;
+struct map_symbol;
+struct addr_map_symbol;
+struct option;
+struct perf_sample;
+struct perf_evsel;
+struct symbol;
 
 struct ins {
 	const char     *name;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 665ee374fc01..6d043c78f3c2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <linux/time64.h>
 #include <math.h>
+#include "color.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
-- 
2.20.1
