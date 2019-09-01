From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/47] perf hist: Remove needless ui/progress.h from hist.h
Date: Sun,  1 Sep 2019 09:23:06 -0300
Message-ID: <20190901122326.5793-28-acme@kernel.org>
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

We only need a forward declaration, add it and fixup all the files that
need ui_progress definitions but were wrongly getting it from hist.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-84a90o9jdxybffxo9jmouokw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    | 1 +
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/hist.h      | 2 +-
 tools/perf/util/session.c   | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d1ad694c67a2..0d76b2cb8c0a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -37,6 +37,7 @@
 #include "mem2node.h"
 #include "symbol.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 #include "../perf.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ba419ee40283..d7a345667945 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,6 +47,7 @@
 #include "util/branch.h"
 #include "util/util.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7b9267ebebeb..1c0a635e5e32 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,7 +8,6 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
-#include "ui/progress.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -18,6 +17,7 @@ struct mem_info;
 struct branch_info;
 struct block_info;
 struct symbol;
+struct ui_progress;
 
 enum hist_filter {
 	HIST_FILTER__DSO,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a72774e4463f..f166da76acf1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -30,6 +30,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "util.h"
+#include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
 
-- 
2.21.0
