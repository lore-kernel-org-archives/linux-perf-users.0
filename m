From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/18] perf values: Fix allocation check
Date: Tue, 29 Aug 2017 16:42:43 -0300
Message-ID: <20170829194254.1338-8-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Bailing out in case the allocation failed, not the other way round.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824162737.7813-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/values.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index 9ac36bf2c438..2c4af02f08cd 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -131,7 +131,7 @@ static int perf_read_values__enlarge_counters(struct perf_read_values *values)
 	for (i = 0; i < values->threads; i++) {
 		u64 *value = realloc(values->value[i], counters_max * sizeof(**values->value));
 
-		if (value) {
+		if (!value) {
 			pr_debug("failed to enlarge read_values ->values array");
 			goto out_free_name;
 		}
-- 
2.13.5
