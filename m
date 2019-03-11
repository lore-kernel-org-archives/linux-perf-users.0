From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v1 10/10] perf, tools, stat: Improve scaling
Date: Mon, 11 Mar 2019 13:24:46 -0700
Message-ID: <20190311202446.10210-11-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The multiplexing scaling in perf stat mysteriously adds 0.5 to the
value. This dates back to the original perf tool. Other scaling
code doesn't use that strange convention. Remove the extra 0.5.

Before:

$ perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,403,580      cycles                                                        (81.62%)
         6,404,341      cycles                                                        (81.64%)
         6,402,983      cycles                                                        (81.62%)
         6,399,941      cycles                                                        (81.63%)
         6,399,451      cycles                                                        (81.62%)
         6,436,105      cycles                                                        (91.87%)

       0.005843799 seconds time elapsed

       0.002905000 seconds user
       0.002902000 seconds sys

After:

$ ./perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,422,704      cycles                                                        (81.68%)
         6,401,842      cycles                                                        (81.68%)
         6,398,432      cycles                                                        (81.68%)
         6,397,098      cycles                                                        (81.68%)
         6,396,074      cycles                                                        (81.67%)
         6,434,980      cycles                                                        (91.62%)

       0.005884437 seconds time elapsed

       0.003580000 seconds user
       0.002356000 seconds sys

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 60450087f198..e425f342fe81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1342,7 +1342,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 			count->val = 0;
 		} else if (count->run < count->ena) {
 			scaled = 1;
-			count->val = (u64)((double) count->val * count->ena / count->run + 0.5);
+			count->val = (u64)((double) count->val * count->ena / count->run);
 		}
 	}
 
-- 
2.20.1
