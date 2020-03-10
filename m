From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/19] perf expr: Add expr.c object
Date: Tue, 10 Mar 2020 08:15:43 -0300
Message-ID: <20200310111551.25160-12-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.garry@huawei.com>, Kajol Jain <kjain@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add generic expr code into new expr.c object.

The expr.c object will be mainly used in following change that will get
rid of the manual flex code,

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build  |  1 +
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 tools/perf/util/expr.y | 16 ----------------
 3 files changed, 20 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/util/expr.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 07da6c790b63..6fdf073093a6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,6 +122,7 @@ perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
 perf-y += expr-bison.o
+perf-y += expr.o
 perf-y += branch.o
 perf-y += mem2node.o
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
new file mode 100644
index 000000000000..816b23b2068a
--- /dev/null
+++ b/tools/perf/util/expr.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include "expr.h"
+
+/* Caller must make sure id is allocated */
+void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
+{
+	int idx;
+
+	assert(ctx->num_ids < MAX_PARSE_ID);
+	idx = ctx->num_ids++;
+	ctx->ids[idx].name = name;
+	ctx->ids[idx].val = val;
+}
+
+void expr__ctx_init(struct parse_ctx *ctx)
+{
+	ctx->num_ids = 0;
+}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7d226241f1d7..7cea8b7c3a5c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -6,7 +6,6 @@
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
-#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -169,21 +168,6 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 	return tok;
 }
 
-/* Caller must make sure id is allocated */
-void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
-{
-	int idx;
-	assert(ctx->num_ids < MAX_PARSE_ID);
-	idx = ctx->num_ids++;
-	ctx->ids[idx].name = name;
-	ctx->ids[idx].val = val;
-}
-
-void expr__ctx_init(struct parse_ctx *ctx)
-{
-	ctx->num_ids = 0;
-}
-
 static bool already_seen(const char *val, const char *one, const char **other,
 			 int num_other)
 {
-- 
2.21.1
