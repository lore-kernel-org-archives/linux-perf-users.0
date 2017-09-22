From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/44] perf stat: Update walltime_nsecs_stats in interval mode
Date: Fri, 22 Sep 2017 11:41:48 -0300
Message-ID: <20170922144220.9411-13-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752694AbdIVOnk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:43:40 -0400
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 855890e0b70b..88f1d5fbdb48 100644
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
