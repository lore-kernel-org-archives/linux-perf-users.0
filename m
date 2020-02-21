From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/8] perf auxtrace: Add auxtrace_record__read_finish()
Date: Thu, 20 Feb 2020 22:53:09 -0300
Message-ID: <20200221015310.16914-8-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Wei Li <liwei391@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

All ->read_finish() implementations are doing the same thing. Add a
helper function so that they can share the same implementation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Wei Li <liwei391@huawei.com>
Link: http://lore.kernel.org/lkml/20200217082300.6301-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 21 ++-------------------
 tools/perf/arch/arm64/util/arm-spe.c | 20 ++------------------
 tools/perf/arch/x86/util/intel-bts.c | 20 ++------------------
 tools/perf/arch/x86/util/intel-pt.c  | 20 ++------------------
 tools/perf/util/auxtrace.c           | 22 +++++++++++++++++++++-
 tools/perf/util/auxtrace.h           |  6 ++++++
 6 files changed, 35 insertions(+), 74 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 60141c3007a9..941f814820b8 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -858,24 +858,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 	free(ptr);
 }
 
-static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(ptr->evlist,
-							     evsel, idx);
-		}
-	}
-
-	return -EINVAL;
-}
-
 struct auxtrace_record *cs_etm_record_init(int *err)
 {
 	struct perf_pmu *cs_etm_pmu;
@@ -895,6 +877,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	}
 
 	ptr->cs_etm_pmu			= cs_etm_pmu;
+	ptr->itr.pmu			= cs_etm_pmu;
 	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
@@ -904,7 +887,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
 	ptr->itr.reference		= cs_etm_reference;
 	ptr->itr.free			= cs_etm_recording_free;
-	ptr->itr.read_finish		= cs_etm_read_finish;
+	ptr->itr.read_finish		= auxtrace_record__read_finish;
 
 	*err = 0;
 	return &ptr->itr;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1d993c27242b..8d6821d9c3f6 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -158,23 +158,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	free(sper);
 }
 
-static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *arm_spe_recording_init(int *err,
 					       struct perf_pmu *arm_spe_pmu)
 {
@@ -192,12 +175,13 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	}
 
 	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
 	sper->itr.info_fill = arm_spe_info_fill;
 	sper->itr.free = arm_spe_recording_free;
 	sper->itr.reference = arm_spe_reference;
-	sper->itr.read_finish = arm_spe_read_finish;
+	sper->itr.read_finish = auxtrace_record__read_finish;
 	sper->itr.alignment = 0;
 
 	*err = 0;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 39e363151ad7..26cee1052179 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -413,23 +413,6 @@ static int intel_bts_find_snapshot(struct auxtrace_record *itr, int idx,
 	return err;
 }
 
-static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_bts_recording *btsr =
-			container_of(itr, struct intel_bts_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(btsr->evlist, evsel) {
-		if (evsel->core.attr.type == btsr->intel_bts_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(btsr->evlist,
-							     evsel, idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_bts_recording_init(int *err)
 {
 	struct perf_pmu *intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
@@ -450,6 +433,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	}
 
 	btsr->intel_bts_pmu = intel_bts_pmu;
+	btsr->itr.pmu = intel_bts_pmu;
 	btsr->itr.recording_options = intel_bts_recording_options;
 	btsr->itr.info_priv_size = intel_bts_info_priv_size;
 	btsr->itr.info_fill = intel_bts_info_fill;
@@ -459,7 +443,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	btsr->itr.find_snapshot = intel_bts_find_snapshot;
 	btsr->itr.parse_snapshot_options = intel_bts_parse_snapshot_options;
 	btsr->itr.reference = intel_bts_reference;
-	btsr->itr.read_finish = intel_bts_read_finish;
+	btsr->itr.read_finish = auxtrace_record__read_finish;
 	btsr->itr.alignment = sizeof(struct branch);
 	return &btsr->itr;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index be07d6886256..7eea4fd7ce58 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1166,23 +1166,6 @@ static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
 	return rdtsc();
 }
 
-static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_pt_recording *ptr =
-			container_of(itr, struct intel_pt_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
-							     idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_pt_recording_init(int *err)
 {
 	struct perf_pmu *intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
@@ -1203,6 +1186,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	}
 
 	ptr->intel_pt_pmu = intel_pt_pmu;
+	ptr->itr.pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
 	ptr->itr.info_fill = intel_pt_info_fill;
@@ -1212,7 +1196,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	ptr->itr.find_snapshot = intel_pt_find_snapshot;
 	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
 	ptr->itr.reference = intel_pt_reference;
-	ptr->itr.read_finish = intel_pt_read_finish;
+	ptr->itr.read_finish = auxtrace_record__read_finish;
 	/*
 	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
 	 * should give at least 1 PSB per sample.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eb087e7df6f4..3571ce72ca28 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -629,8 +629,10 @@ int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts)
 {
-	if (itr)
+	if (itr) {
+		itr->evlist = evlist;
 		return itr->recording_options(itr, evlist, opts);
+	}
 	return 0;
 }
 
@@ -664,6 +666,24 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
+{
+	struct evsel *evsel;
+
+	if (!itr->evlist || !itr->pmu)
+		return -EINVAL;
+
+	evlist__for_each_entry(itr->evlist, evsel) {
+		if (evsel->core.attr.type == itr->pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			return perf_evlist__enable_event_idx(itr->evlist, evsel,
+							     idx);
+		}
+	}
+	return -EINVAL;
+}
+
 /*
  * Event record size is 16-bit which results in a maximum size of about 64KiB.
  * Allow about 4KiB for the rest of the sample record, to give a maximum
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 749d72cd9c7b..e58ef160b599 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -29,6 +29,7 @@ struct record_opts;
 struct perf_record_auxtrace_error;
 struct perf_record_auxtrace_info;
 struct events_stats;
+struct perf_pmu;
 
 enum auxtrace_error_type {
        PERF_AUXTRACE_ERROR_ITRACE  = 1,
@@ -322,6 +323,8 @@ struct auxtrace_mmap_params {
  * @read_finish: called after reading from an auxtrace mmap
  * @alignment: alignment (if any) for AUX area data
  * @default_aux_sample_size: default sample size for --aux sample option
+ * @pmu: associated pmu
+ * @evlist: selected events list
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
@@ -346,6 +349,8 @@ struct auxtrace_record {
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
 	unsigned int default_aux_sample_size;
+	struct perf_pmu *pmu;
+	struct evlist *evlist;
 };
 
 /**
@@ -537,6 +542,7 @@ int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 				   struct auxtrace_mmap *mm,
 				   unsigned char *data, u64 *head, u64 *old);
 u64 auxtrace_record__reference(struct auxtrace_record *itr);
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx);
 
 int auxtrace_index__auxtrace_event(struct list_head *head, union perf_event *event,
 				   off_t file_offset);
-- 
2.21.1
