From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/19] perf expr: Increase EXPR_MAX_OTHER to support metrics with more than 15 variables
Date: Tue, 10 Mar 2020 08:15:45 -0300
Message-ID: <20200310111551.25160-14-acme@kernel.org>
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

We have metrics that define more than 15 variables, like
Branch_Misprediction_Cost. Increasing the allowed variables count to 20.

As Andy pointed out, we can't go too high in here, because some of the
code has O(n^2) complexity (already_seen) and we might want to do some
other changes (like using hash tables) before increasing the maximum
even more.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9332796e6649..df0a17df0cef 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 15
+#define EXPR_MAX_OTHER 20
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct parse_id {
-- 
2.21.1
