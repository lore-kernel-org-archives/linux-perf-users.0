From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] perf report: Fix debug messages with --call-graph option
Date: Fri, 29 Sep 2017 13:00:14 -0300
Message-ID: <20170929160017.29335-5-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mengting Zhang <zhangmengting@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Krister Johansen <kjlx@templeofstupid.com>, Li Bin <huawei.libin@huawei.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mengting Zhang <zhangmengting@huawei.com>

With --call-graph option, perf report can display call chains using
type, min percent threshold, optional print limit and order. And the
default call-graph parameter is 'graph,0.5,caller,function,percent'.

Before this patch, 'perf report --call-graph' shows incorrect debug
messages as below:

  # perf report --call-graph
  Invalid callchain mode: 0.5
  Invalid callchain order: 0.5
  Invalid callchain sort key: 0.5
  Invalid callchain config key: 0.5
  Invalid callchain mode: caller
  Invalid callchain mode: function
  Invalid callchain order: function
  Invalid callchain mode: percent
  Invalid callchain order: percent
  Invalid callchain sort key: percent

That is because in function __parse_callchain_report_opt(),each field of
the call-graph parameter is passed to parse_callchain_{mode,order,
sort_key,value} in turn until it meets the matching value.

For example, the order field "caller" is passed to
parse_callchain_mode() firstly and obviously it doesn't match any mode
field. Therefore parse_callchain_mode() will shows the debug message
"Invalid callchain mode: caller", which could confuse users.

The patch fixes this issue by moving the warning out of the function
parse_callchain_{mode,order,sort_key,value}.

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/1506154694-39691-1-git-send-email-zhangmengting@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 510b513e0f01..be09d77cade0 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -65,8 +65,6 @@ static int parse_callchain_mode(const char *value)
 		callchain_param.mode = CHAIN_FOLDED;
 		return 0;
 	}
-
-	pr_err("Invalid callchain mode: %s\n", value);
 	return -1;
 }
 
@@ -82,8 +80,6 @@ static int parse_callchain_order(const char *value)
 		callchain_param.order_set = true;
 		return 0;
 	}
-
-	pr_err("Invalid callchain order: %s\n", value);
 	return -1;
 }
 
@@ -105,8 +101,6 @@ static int parse_callchain_sort_key(const char *value)
 		callchain_param.branch_callstack = 1;
 		return 0;
 	}
-
-	pr_err("Invalid callchain sort key: %s\n", value);
 	return -1;
 }
 
@@ -124,8 +118,6 @@ static int parse_callchain_value(const char *value)
 		callchain_param.value = CCVAL_COUNT;
 		return 0;
 	}
-
-	pr_err("Invalid callchain config key: %s\n", value);
 	return -1;
 }
 
@@ -319,12 +311,27 @@ int perf_callchain_config(const char *var, const char *value)
 
 		return ret;
 	}
-	if (!strcmp(var, "print-type"))
-		return parse_callchain_mode(value);
-	if (!strcmp(var, "order"))
-		return parse_callchain_order(value);
-	if (!strcmp(var, "sort-key"))
-		return parse_callchain_sort_key(value);
+	if (!strcmp(var, "print-type")){
+		int ret;
+		ret = parse_callchain_mode(value);
+		if (ret == -1)
+			pr_err("Invalid callchain mode: %s\n", value);
+		return ret;
+	}
+	if (!strcmp(var, "order")){
+		int ret;
+		ret = parse_callchain_order(value);
+		if (ret == -1)
+			pr_err("Invalid callchain order: %s\n", value);
+		return ret;
+	}
+	if (!strcmp(var, "sort-key")){
+		int ret;
+		ret = parse_callchain_sort_key(value);
+		if (ret == -1)
+			pr_err("Invalid callchain sort key: %s\n", value);
+		return ret;
+	}
 	if (!strcmp(var, "threshold")) {
 		callchain_param.min_percent = strtod(value, &endptr);
 		if (value == endptr) {
-- 
2.13.5
