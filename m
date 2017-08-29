From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/18] perf c2c: Fix remote HITM detection for Skylake
Date: Tue, 29 Aug 2017 16:42:39 -0300
Message-ID: <20170829194254.1338-4-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Skylake introduced new mem_remote bit in union perf_mem_data_src [1].
It applies to any other memory level to express Remote unknown level, as
is reported by Skylake.

Adding this extra check to c2c_decode_stats to properly decode remote
HITMs on Skylake.

[1] http://lkml.kernel.org/r/20170816222156.19953-4-andi@firstfloor.org

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824085732.28481-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mem-events.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ced4f3fff035..28afe5fa84d6 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -316,6 +316,11 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
 	u64 lock   = data_src->mem_lock;
+	/*
+	 * Skylake might report unknown remote level via this
+	 * bit, consider it when evaluating remote HITMs.
+	 */
+	bool mrem  = data_src->mem_remote;
 	int err = 0;
 
 #define HITM_INC(__f)		\
@@ -361,7 +366,8 @@ do {				\
 			}
 
 			if ((lvl & P(LVL, REM_RAM1)) ||
-			    (lvl & P(LVL, REM_RAM2))) {
+			    (lvl & P(LVL, REM_RAM2)) ||
+			     mrem) {
 				stats->rmt_dram++;
 				if (snoop & P(SNOOP, HIT))
 					stats->ld_shared++;
@@ -371,7 +377,8 @@ do {				\
 		}
 
 		if ((lvl & P(LVL, REM_CCE1)) ||
-		    (lvl & P(LVL, REM_CCE2))) {
+		    (lvl & P(LVL, REM_CCE2)) ||
+		     mrem) {
 			if (snoop & P(SNOOP, HIT))
 				stats->rmt_hit++;
 			else if (snoop & P(SNOOP, HITM))
-- 
2.13.5
