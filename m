From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/37] libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:38:59 -0300
Message-ID: <20190829143917.29745-20-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_AUXTRACE_INFO event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-9-jolsa@kernel.org
[ Fix cs_etm__print_auxtrace_info() arg to be __u64 too to fix the CORESIGHT=1 build ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/arm-spe.c           | 2 +-
 tools/perf/util/cs-etm.c            | 2 +-
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/intel-bts.c         | 2 +-
 tools/perf/util/intel-pt.c          | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 04b424ad4d99..89fe30d3310f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -328,7 +328,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	unsigned long max_non_turbo_ratio;
 	size_t filter_str_len;
 	const char *filter;
-	u64 *info;
+	__u64 *info;
 	int err;
 
 	if (priv_size != ptr->priv_size)
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c68523c4fa01..02da73491451 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -201,4 +201,11 @@ struct id_index_event {
 	struct id_index_entry	 entries[0];
 };
 
+struct auxtrace_info_event {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 reserved__; /* For alignment */
+	__u64			 priv[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index a314e5b26e9d..cd26315bc9aa 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -181,7 +181,7 @@ static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
 
-static void arm_spe_print_info(u64 *arr)
+static void arm_spe_print_info(__u64 *arr)
 {
 	if (!dump_trace)
 		return;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b3a5daaf1a8f..e210c1dde964 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2370,7 +2370,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
 };
 
-static void cs_etm__print_auxtrace_info(u64 *val, int num)
+static void cs_etm__print_auxtrace_info(__u64 *val, int num)
 {
 	int i, j, cpu = 0;
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 82315d2845fe..ca2cae332c43 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,13 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct auxtrace_info_event {
-	struct perf_event_header header;
-	u32 type;
-	u32 reserved__; /* For alignment */
-	u64 priv[];
-};
-
 struct auxtrace_event {
 	struct perf_event_header header;
 	u64 size;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 8dc6408206b9..03c581a0d5d0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -834,7 +834,7 @@ static const char * const intel_bts_info_fmts[] = {
 	[INTEL_BTS_SNAPSHOT_MODE]	= "  Snapshot mode      %"PRId64"\n",
 };
 
-static void intel_bts_print_info(u64 *arr, int start, int finish)
+static void intel_bts_print_info(__u64 *arr, int start, int finish)
 {
 	int i;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ea504fa9b623..c83a9a718c03 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3044,7 +3044,7 @@ static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_FILTER_STR_LEN]	= "  Filter string len.  %"PRIu64"\n",
 };
 
-static void intel_pt_print_info(u64 *arr, int start, int finish)
+static void intel_pt_print_info(__u64 *arr, int start, int finish)
 {
 	int i;
 
@@ -3076,7 +3076,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	size_t min_sz = sizeof(u64) * INTEL_PT_PER_CPU_MMAPS;
 	struct intel_pt *pt;
 	void *info_end;
-	u64 *info;
+	__u64 *info;
 	int err;
 
 	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
-- 
2.21.0
