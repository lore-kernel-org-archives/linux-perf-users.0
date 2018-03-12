From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf stat: Make function perf_stat_evsel_id_init static
Date: Mon, 12 Mar 2018 11:38:07 +0100
Message-ID: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Function perf_stat_evsel_id_init() has global linkage
but is only used in util/stat.c. Make it static.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/util/stat.c | 2 +-
 tools/perf/util/stat.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 32235657c1ac..a0061e0b0fad 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -92,7 +92,7 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 };
 #undef ID
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel)
+static void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 	int i;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index dbc6f7134f61..679994a5cd07 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -126,8 +126,6 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 #define perf_stat_evsel__is(evsel, id) \
 	__perf_evsel_stat__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel);
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
-- 
2.14.3
