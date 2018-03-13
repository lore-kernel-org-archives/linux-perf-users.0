From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/31] perf stat: Make function perf_stat_evsel_id_init static
Date: Tue, 13 Mar 2018 09:05:06 -0300
Message-ID: <20180313120508.29327-30-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Function perf_stat_evsel_id_init() has global linkage but is only used
in util/stat.c. Make it static.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180312103807.45069-2-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 2f44e386a0e8..8f56ba4fd258 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -128,8 +128,6 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 #define perf_stat_evsel__is(evsel, id) \
 	__perf_evsel_stat__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel);
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
-- 
2.14.3
