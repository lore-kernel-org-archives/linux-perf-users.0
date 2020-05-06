From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/91] perf evsel: Rename *perf_evsel__*set_sample_*() to *evsel__*set_sample_*()
Date: Wed,  6 May 2020 12:22:02 -0300
Message-ID: <20200506152234.21977-60-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As they are not 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    |  4 +-
 tools/perf/arch/arm64/util/arm-spe.c | 12 ++--
 tools/perf/arch/x86/util/intel-bts.c |  2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 20 +++----
 tools/perf/builtin-annotate.c        |  2 +-
 tools/perf/builtin-diff.c            |  2 +-
 tools/perf/builtin-kvm.c             | 18 +++---
 tools/perf/tests/hists_cumulate.c    |  8 +--
 tools/perf/tests/mmap-basic.c        |  2 +-
 tools/perf/tests/perf-record.c       |  6 +-
 tools/perf/tests/switch-tracking.c   | 10 ++--
 tools/perf/util/auxtrace.c           |  4 +-
 tools/perf/util/evlist.c             |  4 +-
 tools/perf/util/evsel.c              | 88 ++++++++++++++--------------
 tools/perf/util/evsel.h              | 17 +++---
 tools/perf/util/record.c             |  2 +-
 tools/perf/util/sideband_evlist.c    |  2 +-
 17 files changed, 100 insertions(+), 103 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 53db3c20225b..97aa02c4491d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -402,7 +402,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
+		evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 		err = cs_etm_set_option(itr, cs_etm_evsel,
 					ETM_OPT_CTXTID | ETM_OPT_TS);
@@ -426,7 +426,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 		/* In per-cpu case, always need the time of mmap events etc */
 		if (!perf_cpu_map__empty(cpus))
-			perf_evsel__set_sample_bit(tracking_evsel, TIME);
+			evsel__set_sample_bit(tracking_evsel, TIME);
 	}
 
 out:
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 27653be24447..e3593063b3d1 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -120,9 +120,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	perf_evlist__to_front(evlist, arm_spe_evsel);
 
-	perf_evsel__set_sample_bit(arm_spe_evsel, CPU);
-	perf_evsel__set_sample_bit(arm_spe_evsel, TIME);
-	perf_evsel__set_sample_bit(arm_spe_evsel, TID);
+	evsel__set_sample_bit(arm_spe_evsel, CPU);
+	evsel__set_sample_bit(arm_spe_evsel, TIME);
+	evsel__set_sample_bit(arm_spe_evsel, TID);
 
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
@@ -134,9 +134,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 
 	tracking_evsel->core.attr.freq = 0;
 	tracking_evsel->core.attr.sample_period = 1;
-	perf_evsel__set_sample_bit(tracking_evsel, TIME);
-	perf_evsel__set_sample_bit(tracking_evsel, CPU);
-	perf_evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
+	evsel__set_sample_bit(tracking_evsel, TIME);
+	evsel__set_sample_bit(tracking_evsel, CPU);
+	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
 
 	return 0;
 }
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 09f93800bffd..0dc09b5809c1 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -224,7 +224,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * AUX event.
 		 */
 		if (!perf_cpu_map__empty(cpus))
-			perf_evsel__set_sample_bit(intel_bts_evsel, CPU);
+			evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
 	/* Add dummy event to keep tracking */
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6b888963c21c..3f7c20cc7b79 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -421,8 +421,8 @@ static int intel_pt_track_switches(struct evlist *evlist)
 
 	evsel = evlist__last(evlist);
 
-	perf_evsel__set_sample_bit(evsel, CPU);
-	perf_evsel__set_sample_bit(evsel, TIME);
+	evsel__set_sample_bit(evsel, CPU);
+	evsel__set_sample_bit(evsel, TIME);
 
 	evsel->core.system_wide = true;
 	evsel->no_aux_samples = true;
@@ -802,10 +802,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				switch_evsel->no_aux_samples = true;
 				switch_evsel->immediate = true;
 
-				perf_evsel__set_sample_bit(switch_evsel, TID);
-				perf_evsel__set_sample_bit(switch_evsel, TIME);
-				perf_evsel__set_sample_bit(switch_evsel, CPU);
-				perf_evsel__reset_sample_bit(switch_evsel, BRANCH_STACK);
+				evsel__set_sample_bit(switch_evsel, TID);
+				evsel__set_sample_bit(switch_evsel, TIME);
+				evsel__set_sample_bit(switch_evsel, CPU);
+				evsel__reset_sample_bit(switch_evsel, BRANCH_STACK);
 
 				opts->record_switch_events = false;
 				ptr->have_sched_switch = 3;
@@ -839,7 +839,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * AUX event.
 		 */
 		if (!perf_cpu_map__empty(cpus))
-			perf_evsel__set_sample_bit(intel_pt_evsel, CPU);
+			evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
 	/* Add dummy event to keep tracking */
@@ -863,11 +863,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 
 		/* In per-cpu case, always need the time of mmap events etc */
 		if (!perf_cpu_map__empty(cpus)) {
-			perf_evsel__set_sample_bit(tracking_evsel, TIME);
+			evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
-			perf_evsel__set_sample_bit(tracking_evsel, CPU);
+			evsel__set_sample_bit(tracking_evsel, CPU);
 		}
-		perf_evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
+		evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
 	}
 
 	/*
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6c0a0412502e..e0fbc13884df 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -433,7 +433,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			total_nr_samples += nr_samples;
 			hists__collapse_resort(hists, NULL);
 			/* Don't sort callchain */
-			perf_evsel__reset_sample_bit(pos, CALLCHAIN);
+			evsel__reset_sample_bit(pos, CALLCHAIN);
 			perf_evsel__output_resort(pos, NULL);
 
 			if (symbol_conf.event_group &&
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index b74a60f5813a..67d3adadcd5b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -990,7 +990,7 @@ static void data_process(void)
 			data__fprintf();
 
 		/* Don't sort callchain for perf diff */
-		perf_evsel__reset_sample_bit(evsel_base, CALLCHAIN);
+		evsel__reset_sample_bit(evsel_base, CALLCHAIN);
 
 		hists__process(hists_base);
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 577af4f3297a..ff74a9a0bbaa 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1033,16 +1033,16 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 		struct perf_event_attr *attr = &pos->core.attr;
 
 		/* make sure these *are* set */
-		perf_evsel__set_sample_bit(pos, TID);
-		perf_evsel__set_sample_bit(pos, TIME);
-		perf_evsel__set_sample_bit(pos, CPU);
-		perf_evsel__set_sample_bit(pos, RAW);
+		evsel__set_sample_bit(pos, TID);
+		evsel__set_sample_bit(pos, TIME);
+		evsel__set_sample_bit(pos, CPU);
+		evsel__set_sample_bit(pos, RAW);
 		/* make sure these are *not*; want as small a sample as possible */
-		perf_evsel__reset_sample_bit(pos, PERIOD);
-		perf_evsel__reset_sample_bit(pos, IP);
-		perf_evsel__reset_sample_bit(pos, CALLCHAIN);
-		perf_evsel__reset_sample_bit(pos, ADDR);
-		perf_evsel__reset_sample_bit(pos, READ);
+		evsel__reset_sample_bit(pos, PERIOD);
+		evsel__reset_sample_bit(pos, IP);
+		evsel__reset_sample_bit(pos, CALLCHAIN);
+		evsel__reset_sample_bit(pos, ADDR);
+		evsel__reset_sample_bit(pos, READ);
 		attr->mmap = 0;
 		attr->comm = 0;
 		attr->task = 0;
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 6367c8f6ca22..7a542f1c1c78 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -280,7 +280,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
 
 	symbol_conf.use_callchain = false;
 	symbol_conf.cumulate_callchain = false;
-	perf_evsel__reset_sample_bit(evsel, CALLCHAIN);
+	evsel__reset_sample_bit(evsel, CALLCHAIN);
 
 	setup_sorting(NULL);
 	callchain_register_param(&callchain_param);
@@ -427,7 +427,7 @@ static int test2(struct evsel *evsel, struct machine *machine)
 
 	symbol_conf.use_callchain = true;
 	symbol_conf.cumulate_callchain = false;
-	perf_evsel__set_sample_bit(evsel, CALLCHAIN);
+	evsel__set_sample_bit(evsel, CALLCHAIN);
 
 	setup_sorting(NULL);
 	callchain_register_param(&callchain_param);
@@ -485,7 +485,7 @@ static int test3(struct evsel *evsel, struct machine *machine)
 
 	symbol_conf.use_callchain = false;
 	symbol_conf.cumulate_callchain = true;
-	perf_evsel__reset_sample_bit(evsel, CALLCHAIN);
+	evsel__reset_sample_bit(evsel, CALLCHAIN);
 
 	setup_sorting(NULL);
 	callchain_register_param(&callchain_param);
@@ -669,7 +669,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 
 	symbol_conf.use_callchain = true;
 	symbol_conf.cumulate_callchain = true;
-	perf_evsel__set_sample_bit(evsel, CALLCHAIN);
+	evsel__set_sample_bit(evsel, CALLCHAIN);
 
 	setup_sorting(NULL);
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index e9c0c6498704..d4b8eb6e337a 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -86,7 +86,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		}
 
 		evsels[i]->core.attr.wakeup_events = 1;
-		perf_evsel__set_sample_id(evsels[i], false);
+		evsel__set_sample_id(evsels[i], false);
 
 		evlist__add(evlist, evsels[i]);
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 2195fc205e72..83adfd846ccd 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -106,9 +106,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * Config the evsels, setting attr->comm on the first one, etc.
 	 */
 	evsel = evlist__first(evlist);
-	perf_evsel__set_sample_bit(evsel, CPU);
-	perf_evsel__set_sample_bit(evsel, TID);
-	perf_evsel__set_sample_bit(evsel, TIME);
+	evsel__set_sample_bit(evsel, CPU);
+	evsel__set_sample_bit(evsel, TID);
+	evsel__set_sample_bit(evsel, TIME);
 	perf_evlist__config(evlist, &opts, NULL);
 
 	err = sched__get_first_possible_cpu(evlist->workload.pid, &cpu_mask);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index fcb0d03dba4e..b08c8a0898d3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -394,8 +394,8 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 
 	switch_evsel = evlist__last(evlist);
 
-	perf_evsel__set_sample_bit(switch_evsel, CPU);
-	perf_evsel__set_sample_bit(switch_evsel, TIME);
+	evsel__set_sample_bit(switch_evsel, CPU);
+	evsel__set_sample_bit(switch_evsel, TIME);
 
 	switch_evsel->core.system_wide = true;
 	switch_evsel->no_aux_samples = true;
@@ -412,8 +412,8 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evsel__set_sample_bit(cycles_evsel, CPU);
-	perf_evsel__set_sample_bit(cycles_evsel, TIME);
+	evsel__set_sample_bit(cycles_evsel, CPU);
+	evsel__set_sample_bit(cycles_evsel, TIME);
 
 	/* Fourth event */
 	err = parse_events(evlist, "dummy:u", NULL);
@@ -429,7 +429,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	tracking_evsel->core.attr.freq = 0;
 	tracking_evsel->core.attr.sample_period = 1;
 
-	perf_evsel__set_sample_bit(tracking_evsel, TIME);
+	evsel__set_sample_bit(tracking_evsel, TIME);
 
 	/* Config events */
 	perf_evlist__config(evlist, &opts, NULL);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index bd27f73b6d60..e12696fe6f65 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -705,10 +705,10 @@ static int auxtrace_validate_aux_sample_size(struct evlist *evlist,
 				pr_err("Cannot add AUX area sampling because group leader is not an AUX area event\n");
 				return -EINVAL;
 			}
-			perf_evsel__set_sample_bit(evsel, AUX);
+			evsel__set_sample_bit(evsel, AUX);
 			opts->auxtrace_sample_mode = true;
 		} else {
-			perf_evsel__reset_sample_bit(evsel, AUX);
+			evsel__reset_sample_bit(evsel, AUX);
 		}
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8b691151bae3..58228a54ecd7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -948,7 +948,7 @@ void __perf_evlist__set_sample_bit(struct evlist *evlist,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
-		__perf_evsel__set_sample_bit(evsel, bit);
+		__evsel__set_sample_bit(evsel, bit);
 }
 
 void __perf_evlist__reset_sample_bit(struct evlist *evlist,
@@ -957,7 +957,7 @@ void __perf_evlist__reset_sample_bit(struct evlist *evlist,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
-		__perf_evsel__reset_sample_bit(evsel, bit);
+		__evsel__reset_sample_bit(evsel, bit);
 }
 
 int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9b3db6d34d37..4f03500253e3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -184,7 +184,7 @@ void evsel__calc_id_pos(struct evsel *evsel)
 	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->core.attr.sample_type);
 }
 
-void __perf_evsel__set_sample_bit(struct evsel *evsel,
+void __evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit)
 {
 	if (!(evsel->core.attr.sample_type & bit)) {
@@ -194,7 +194,7 @@ void __perf_evsel__set_sample_bit(struct evsel *evsel,
 	}
 }
 
-void __perf_evsel__reset_sample_bit(struct evsel *evsel,
+void __evsel__reset_sample_bit(struct evsel *evsel,
 				    enum perf_event_sample_format bit)
 {
 	if (evsel->core.attr.sample_type & bit) {
@@ -204,14 +204,14 @@ void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 	}
 }
 
-void perf_evsel__set_sample_id(struct evsel *evsel,
+void evsel__set_sample_id(struct evsel *evsel,
 			       bool can_sample_identifier)
 {
 	if (can_sample_identifier) {
-		perf_evsel__reset_sample_bit(evsel, ID);
-		perf_evsel__set_sample_bit(evsel, IDENTIFIER);
+		evsel__reset_sample_bit(evsel, ID);
+		evsel__set_sample_bit(evsel, IDENTIFIER);
 	} else {
-		perf_evsel__set_sample_bit(evsel, ID);
+		evsel__set_sample_bit(evsel, ID);
 	}
 	evsel->core.attr.read_format |= PERF_FORMAT_ID;
 }
@@ -689,7 +689,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 	bool function = perf_evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
-	perf_evsel__set_sample_bit(evsel, CALLCHAIN);
+	evsel__set_sample_bit(evsel, CALLCHAIN);
 
 	attr->sample_max_stack = param->max_stack;
 
@@ -704,7 +704,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 					   "to get user callchain information. "
 					   "Falling back to framepointers.\n");
 			} else {
-				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
+				evsel__set_sample_bit(evsel, BRANCH_STACK);
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
 							PERF_SAMPLE_BRANCH_CALL_STACK |
 							PERF_SAMPLE_BRANCH_NO_CYCLES |
@@ -718,8 +718,8 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
-			perf_evsel__set_sample_bit(evsel, REGS_USER);
-			perf_evsel__set_sample_bit(evsel, STACK_USER);
+			evsel__set_sample_bit(evsel, REGS_USER);
+			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
@@ -755,16 +755,16 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 
-	perf_evsel__reset_sample_bit(evsel, CALLCHAIN);
+	evsel__reset_sample_bit(evsel, CALLCHAIN);
 	if (param->record_mode == CALLCHAIN_LBR) {
-		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
+		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
 					      PERF_SAMPLE_BRANCH_CALL_STACK |
 					      PERF_SAMPLE_BRANCH_HW_INDEX);
 	}
 	if (param->record_mode == CALLCHAIN_DWARF) {
-		perf_evsel__reset_sample_bit(evsel, REGS_USER);
-		perf_evsel__reset_sample_bit(evsel, STACK_USER);
+		evsel__reset_sample_bit(evsel, REGS_USER);
+		evsel__reset_sample_bit(evsel, STACK_USER);
 	}
 }
 
@@ -788,32 +788,32 @@ static void apply_config_terms(struct evsel *evsel,
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
 				attr->sample_period = term->val.period;
 				attr->freq = 0;
-				perf_evsel__reset_sample_bit(evsel, PERIOD);
+				evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
 				attr->sample_freq = term->val.freq;
 				attr->freq = 1;
-				perf_evsel__set_sample_bit(evsel, PERIOD);
+				evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
 			if (term->val.time)
-				perf_evsel__set_sample_bit(evsel, TIME);
+				evsel__set_sample_bit(evsel, TIME);
 			else
-				perf_evsel__reset_sample_bit(evsel, TIME);
+				evsel__reset_sample_bit(evsel, TIME);
 			break;
 		case PERF_EVSEL__CONFIG_TERM_CALLGRAPH:
 			callgraph_buf = term->val.str;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_BRANCH:
 			if (term->val.str && strcmp(term->val.str, "no")) {
-				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
+				evsel__set_sample_bit(evsel, BRANCH_STACK);
 				parse_branch_str(term->val.str,
 						 &attr->branch_sample_type);
 			} else
-				perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
+				evsel__reset_sample_bit(evsel, BRANCH_STACK);
 			break;
 		case PERF_EVSEL__CONFIG_TERM_STACK_USER:
 			dump_size = term->val.stack_user;
@@ -892,8 +892,8 @@ static void apply_config_terms(struct evsel *evsel,
 		/* set perf-event callgraph */
 		if (param.enabled) {
 			if (sample_address) {
-				perf_evsel__set_sample_bit(evsel, ADDR);
-				perf_evsel__set_sample_bit(evsel, DATA_SRC);
+				evsel__set_sample_bit(evsel, ADDR);
+				evsel__set_sample_bit(evsel, DATA_SRC);
 				evsel->core.attr.mmap_data = track;
 			}
 			evsel__config_callchain(evsel, opts, &param);
@@ -960,17 +960,17 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->inherit	    = !opts->no_inherit;
 	attr->write_backward = opts->overwrite ? 1 : 0;
 
-	perf_evsel__set_sample_bit(evsel, IP);
-	perf_evsel__set_sample_bit(evsel, TID);
+	evsel__set_sample_bit(evsel, IP);
+	evsel__set_sample_bit(evsel, TID);
 
 	if (evsel->sample_read) {
-		perf_evsel__set_sample_bit(evsel, READ);
+		evsel__set_sample_bit(evsel, READ);
 
 		/*
 		 * We need ID even in case of single event, because
 		 * PERF_SAMPLE_READ process ID specific data.
 		 */
-		perf_evsel__set_sample_id(evsel, false);
+		evsel__set_sample_id(evsel, false);
 
 		/*
 		 * Apply group format only if we belong to group
@@ -989,7 +989,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
 				     opts->user_interval != ULLONG_MAX)) {
 		if (opts->freq) {
-			perf_evsel__set_sample_bit(evsel, PERIOD);
+			evsel__set_sample_bit(evsel, PERIOD);
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
 		} else {
@@ -1009,7 +1009,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	}
 
 	if (opts->sample_address) {
-		perf_evsel__set_sample_bit(evsel, ADDR);
+		evsel__set_sample_bit(evsel, ADDR);
 		attr->mmap_data = track;
 	}
 
@@ -1026,16 +1026,16 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 
 	if (opts->sample_intr_regs) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
-		perf_evsel__set_sample_bit(evsel, REGS_INTR);
+		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
 	if (opts->sample_user_regs) {
 		attr->sample_regs_user |= opts->sample_user_regs;
-		perf_evsel__set_sample_bit(evsel, REGS_USER);
+		evsel__set_sample_bit(evsel, REGS_USER);
 	}
 
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
-		perf_evsel__set_sample_bit(evsel, CPU);
+		evsel__set_sample_bit(evsel, CPU);
 
 	/*
 	 * When the user explicitly disabled time don't force it here.
@@ -1044,31 +1044,31 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	    (!perf_missing_features.sample_id_all &&
 	    (!opts->no_inherit || target__has_cpu(&opts->target) || per_cpu ||
 	     opts->sample_time_set)))
-		perf_evsel__set_sample_bit(evsel, TIME);
+		evsel__set_sample_bit(evsel, TIME);
 
 	if (opts->raw_samples && !evsel->no_aux_samples) {
-		perf_evsel__set_sample_bit(evsel, TIME);
-		perf_evsel__set_sample_bit(evsel, RAW);
-		perf_evsel__set_sample_bit(evsel, CPU);
+		evsel__set_sample_bit(evsel, TIME);
+		evsel__set_sample_bit(evsel, RAW);
+		evsel__set_sample_bit(evsel, CPU);
 	}
 
 	if (opts->sample_address)
-		perf_evsel__set_sample_bit(evsel, DATA_SRC);
+		evsel__set_sample_bit(evsel, DATA_SRC);
 
 	if (opts->sample_phys_addr)
-		perf_evsel__set_sample_bit(evsel, PHYS_ADDR);
+		evsel__set_sample_bit(evsel, PHYS_ADDR);
 
 	if (opts->no_buffering) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
 	}
 	if (opts->branch_stack && !evsel->no_aux_samples) {
-		perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
+		evsel__set_sample_bit(evsel, BRANCH_STACK);
 		attr->branch_sample_type = opts->branch_stack;
 	}
 
 	if (opts->sample_weight)
-		perf_evsel__set_sample_bit(evsel, WEIGHT);
+		evsel__set_sample_bit(evsel, WEIGHT);
 
 	attr->task  = track;
 	attr->mmap  = track;
@@ -1082,14 +1082,14 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 
 	if (opts->record_cgroup) {
 		attr->cgroup = track && !perf_missing_features.cgroup;
-		perf_evsel__set_sample_bit(evsel, CGROUP);
+		evsel__set_sample_bit(evsel, CGROUP);
 	}
 
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
 	if (opts->sample_transaction)
-		perf_evsel__set_sample_bit(evsel, TRANSACTION);
+		evsel__set_sample_bit(evsel, TRANSACTION);
 
 	if (opts->running_time) {
 		evsel->core.attr.read_format |=
@@ -1152,9 +1152,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	/* The --period option takes the precedence. */
 	if (opts->period_set) {
 		if (opts->period)
-			perf_evsel__set_sample_bit(evsel, PERIOD);
+			evsel__set_sample_bit(evsel, PERIOD);
 		else
-			perf_evsel__reset_sample_bit(evsel, PERIOD);
+			evsel__reset_sample_bit(evsel, PERIOD);
 	}
 
 	/*
@@ -1163,7 +1163,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * if BRANCH_STACK bit is set.
 	 */
 	if (opts->initial_delay && is_dummy_event(evsel))
-		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
+		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
 int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 82d2d308fa33..ecd3ea89e12c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -214,19 +214,16 @@ const char *evsel__name(struct evsel *evsel);
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
-void __perf_evsel__set_sample_bit(struct evsel *evsel,
-				  enum perf_event_sample_format bit);
-void __perf_evsel__reset_sample_bit(struct evsel *evsel,
-				    enum perf_event_sample_format bit);
+void __evsel__set_sample_bit(struct evsel *evsel, enum perf_event_sample_format bit);
+void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_format bit);
 
-#define perf_evsel__set_sample_bit(evsel, bit) \
-	__perf_evsel__set_sample_bit(evsel, PERF_SAMPLE_##bit)
+#define evsel__set_sample_bit(evsel, bit) \
+	__evsel__set_sample_bit(evsel, PERF_SAMPLE_##bit)
 
-#define perf_evsel__reset_sample_bit(evsel, bit) \
-	__perf_evsel__reset_sample_bit(evsel, PERF_SAMPLE_##bit)
+#define evsel__reset_sample_bit(evsel, bit) \
+	__evsel__reset_sample_bit(evsel, PERF_SAMPLE_##bit)
 
-void perf_evsel__set_sample_id(struct evsel *evsel,
-			       bool use_sample_identifier);
+void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 18ce2cda462a..d297f4de253c 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -123,7 +123,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 
 	if (sample_id) {
 		evlist__for_each_entry(evlist, evsel)
-			perf_evsel__set_sample_id(evsel, use_sample_identifier);
+			evsel__set_sample_id(evsel, use_sample_identifier);
 	}
 
 	perf_evlist__set_id_pos(evlist);
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index bb3706fbcc0c..1580a3cbec2d 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -108,7 +108,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 		bool can_sample_identifier = perf_can_sample_identifier();
 
 		evlist__for_each_entry(evlist, counter)
-			perf_evsel__set_sample_id(counter, can_sample_identifier);
+			evsel__set_sample_id(counter, can_sample_identifier);
 
 		perf_evlist__set_id_pos(evlist);
 	}
-- 
2.21.1
