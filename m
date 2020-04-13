From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/26] perf stat: Fix no metric header if --per-socket and --metric-only set
Date: Mon, 13 Apr 2020 13:51:59 -0300
Message-ID: <20200413165203.1816-23-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We received a report that was no metric header displayed if --per-socket
and --metric-only were both set.

It's hard for script to parse the perf-stat output. This patch fixes this
issue.

Before:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

  S0        8                  2.6

         2.215270071 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus
       1.000411692 S0        8                  2.2
       2.001547952 S0        8                  3.4
       3.002446511 S0        8                  3.4
       4.003346157 S0        8                  4.0
       5.004245736 S0        8                  0.3

After:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

                               CPI
  S0        8                  2.1

         1.813579830 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus                  CPI
       1.000415122 S0        8                  3.2
       2.001630051 S0        8                  2.9
       3.002612278 S0        8                  4.3
       4.003523594 S0        8                  3.0
       5.004504256 S0        8                  3.7

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200331180226.25915-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0fd713d3674f..03ecb8cd0eec 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -803,8 +803,11 @@ static void generic_metric(struct perf_stat_config *config,
 				     out->force_header ?
 				     (metric_name ? metric_name : name) : "", 0);
 		}
-	} else
-		print_metric(config, ctxp, NULL, NULL, "", 0);
+	} else {
+		print_metric(config, ctxp, NULL, NULL,
+			     out->force_header ?
+			     (metric_name ? metric_name : name) : "", 0);
+	}
 
 	for (i = 1; i < pctx.num_ids; i++)
 		zfree(&pctx.ids[i].name);
-- 
2.21.1
