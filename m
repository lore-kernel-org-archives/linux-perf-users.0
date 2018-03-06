From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/9] perf stat: Fix CVS output format for non-supported counters
Date: Tue,  6 Mar 2018 14:23:41 -0300
Message-ID: <20180306172343.16546-8-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ilya Pronin <ipronin@twitter.com>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ilya Pronin <ipronin@twitter.com>

When printing stats in CSV mode, 'perf stat' appends extra separators
when a counter is not supported:

<not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,

Which causes a failure when parsing fields. The numbers of separators
should be the same for each line, no matter if the counter is or not
supported.

Signed-off-by: Ilya Pronin <ipronin@twitter.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20180306064353.31930-1-xiyou.wangcong@gmail.com
Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..54a4c152edb3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -917,7 +917,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
-- 
2.14.3
