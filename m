From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/24] perf pmu: Add is_pmu_core()
Date: Wed, 25 Mar 2020 09:41:20 -0300
Message-ID: <20200325124124.32648-21-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@arm.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add a function to decide whether a PMU is a core PMU.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-6-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 5 +++++
 tools/perf/util/pmu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c616a06a34a8..55129d09f19d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1400,6 +1400,11 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
+bool is_pmu_core(const char *name)
+{
+	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
+}
+
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			bool long_desc, bool details_flag, bool deprecated)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0b4a0efae38e..b756946ae78d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -88,6 +88,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
+bool is_pmu_core(const char *name);
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
 		      bool long_desc, bool details_flag,
 		      bool deprecated);
-- 
2.21.1
