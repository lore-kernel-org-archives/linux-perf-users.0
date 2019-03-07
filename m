From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/35] perf tools: Read and store caps/max_precise in perf_pmu
Date: Thu,  7 Mar 2019 14:44:30 -0300
Message-ID: <20190307174433.28819-33-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, Nageswara R Sastry <nasastry@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Read the caps/max_precise value and store it in struct perf_pmu to be
used when setting the maximum precise_ip field in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 14 ++++++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 51d437f55d18..6199a3174ab9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -752,6 +752,19 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+static int pmu_max_precise(const char *name)
+{
+	char path[PATH_MAX];
+	int max_precise = -1;
+
+	scnprintf(path, PATH_MAX,
+		 "bus/event_source/devices/%s/caps/max_precise",
+		 name);
+
+	sysfs__read_int(path, &max_precise);
+	return max_precise;
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -784,6 +797,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 47253c3daf55..bd9ec2704a57 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	int max_precise;
 	struct perf_event_attr *default_config;
 	struct cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-- 
2.20.1
