From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/44] perf stat: Print generic metric header even for failed expressions
Date: Fri, 22 Sep 2017 11:41:41 -0300
Message-ID: <20170922144220.9411-6-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Print the generic metric header even when the expression evaluation
failed. Otherwise an expression that fails on the first collections due
to division by zero may suddenly reappear later without an header.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 96aa6cbf24d6..8c7ab29169b9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -662,7 +662,9 @@ static void generic_metric(const char *metric_expr,
 				out->force_header ?  name : "",
 				ratio);
 		else
-			print_metric(ctxp, NULL, NULL, "", 0);
+			print_metric(ctxp, NULL, NULL,
+				     out->force_header ?
+				     (metric_name ? metric_name : name) : "", 0);
 	} else
 		print_metric(ctxp, NULL, NULL, "", 0);
 }
-- 
2.13.5
