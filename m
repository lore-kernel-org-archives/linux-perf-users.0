From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/25] perf metricgroup: Remove needless includes from metricgroup.h
Date: Thu, 22 Aug 2019 18:00:42 -0300
Message-ID: <20190822210100.3461-8-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There we need just some struct forward declarations, do that instead and
add the includes needed by metricgroup.c.

That should help with needless rebuilds when changing the removed
headers from metricgroup.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1fkskjws6imir2hhztqhdyb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/metricgroup.h | 13 ++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fdb0d1c5c5cf..aaf55444f81b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -7,18 +7,19 @@
 
 #include "metricgroup.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 500e828533f8..e5092f6404ae 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -1,11 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef METRICGROUP_H
 #define METRICGROUP_H 1
 
-#include "linux/list.h"
-#include "rblist.h"
-#include <subcmd/parse-options.h>
-#include "evlist.h"
-#include "strbuf.h"
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <stdbool.h>
+
+struct evsel;
+struct option;
+struct rblist;
 
 struct metric_event {
 	struct rb_node nd;
-- 
2.21.0
