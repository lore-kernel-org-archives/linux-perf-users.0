From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/41] perf stat: Update walltime_nsecs_stats in interval mode
Date: Tue, 12 Sep 2017 12:10:00 -0300
Message-ID: <20170912151029.6612-13-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Some metrics (like GFLOPs) need walltime_nsecs_stats for each interval.
Compute it for each interval instead of only at the end.

Pointed out by Jiri.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-12-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f783b498e5c5..2248ebe582ca 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -415,6 +415,8 @@ static void process_interval(void)
 			pr_err("failed to write stat round event\n");
 	}
 
+	init_stats(&walltime_nsecs_stats);
+	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
 	print_counters(&rs, 0, NULL);
 }
 
-- 
2.13.5
