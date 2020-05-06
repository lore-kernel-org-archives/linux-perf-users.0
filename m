From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/91] perf evsel: Rename perf_evsel__config*() to evsel__config*()
Date: Wed,  6 May 2020 12:21:57 -0300
Message-ID: <20200506152234.21977-55-acme@kernel.org>
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

As they are all 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  |  8 ++++----
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/util/evsel.c                     | 22 ++++++++++-----------
 tools/perf/util/evsel.h                     | 10 ++++------
 tools/perf/util/evsel_config.h              |  2 +-
 tools/perf/util/record.c                    |  9 ++++-----
 6 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 01d542007c8b..f2e832572fce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3124,8 +3124,8 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	if (perf_evsel__init_sc_tp_uint_field(sys_exit, ret))
 		goto out_delete_sys_exit;
 
-	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
-	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
+	evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
+	evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
 
 	evlist__add(evlist, sys_enter);
 	evlist__add(evlist, sys_exit);
@@ -3849,7 +3849,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_maj = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
-		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
+		evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
 		evlist__add(evlist, pgfault_maj);
 	}
 
@@ -3857,7 +3857,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_min = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MIN);
 		if (pgfault_min == NULL)
 			goto out_error_mem;
-		perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
+		evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
 		evlist__add(evlist, pgfault_min);
 	}
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index c6b2d7aab608..a77492bcb4bc 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -60,7 +60,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evsel__config(evsel, &opts, NULL);
+	evsel__config(evsel, &opts, NULL);
 
 	perf_thread_map__set_pid(evlist->core.threads, 0, getpid());
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 11e754746984..f88cf7961d49 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -686,9 +686,8 @@ int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-static void __perf_evsel__config_callchain(struct evsel *evsel,
-					   struct record_opts *opts,
-					   struct callchain_param *param)
+static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+				      struct callchain_param *param)
 {
 	bool function = perf_evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -746,12 +745,11 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 	}
 }
 
-void perf_evsel__config_callchain(struct evsel *evsel,
-				  struct record_opts *opts,
-				  struct callchain_param *param)
+void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+			     struct callchain_param *param)
 {
 	if (param->enabled)
-		return __perf_evsel__config_callchain(evsel, opts, param);
+		return __evsel__config_callchain(evsel, opts, param);
 }
 
 static void
@@ -832,7 +830,7 @@ static void apply_config_terms(struct evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_INHERIT:
 			/*
 			 * attr->inherit should has already been set by
-			 * perf_evsel__config. If user explicitly set
+			 * evsel__config. If user explicitly set
 			 * inherit using config terms, override global
 			 * opt->no_inherit setting.
 			 */
@@ -901,7 +899,7 @@ static void apply_config_terms(struct evsel *evsel,
 				perf_evsel__set_sample_bit(evsel, DATA_SRC);
 				evsel->core.attr.mmap_data = track;
 			}
-			perf_evsel__config_callchain(evsel, opts, &param);
+			evsel__config_callchain(evsel, opts, &param);
 		}
 	}
 }
@@ -953,8 +951,8 @@ struct perf_evsel_config_term *__perf_evsel__get_config_term(struct evsel *evsel
  *     enable/disable events specifically, as there's no
  *     initial traced exec call.
  */
-void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
-			struct callchain_param *callchain)
+void evsel__config(struct evsel *evsel, struct record_opts *opts,
+		   struct callchain_param *callchain)
 {
 	struct evsel *leader = evsel->leader;
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -1027,7 +1025,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel->core.attr.exclude_callchain_user = 1;
 
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
-		perf_evsel__config_callchain(evsel, opts, callchain);
+		evsel__config_callchain(evsel, opts, callchain);
 
 	if (opts->sample_intr_regs) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2facb16e9f12..617cb3fa0353 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -188,12 +188,10 @@ void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
 
-void perf_evsel__config(struct evsel *evsel,
-			struct record_opts *opts,
-			struct callchain_param *callchain);
-void perf_evsel__config_callchain(struct evsel *evsel,
-				  struct record_opts *opts,
-				  struct callchain_param *callchain);
+void evsel__config(struct evsel *evsel, struct record_opts *opts,
+		   struct callchain_param *callchain);
+void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
+			     struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
 void perf_evsel__calc_id_pos(struct evsel *evsel);
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index e026ab67b008..f8938916577c 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -7,7 +7,7 @@
 
 /*
  * The 'struct perf_evsel_config_term' is used to pass event
- * specific configuration data to perf_evsel__config routine.
+ * specific configuration data to evsel__config routine.
  * It is allocated within event parsing and attached to
  * perf_evsel::config_terms list head.
 */
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 97e2c0cedc12..18ce2cda462a 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -15,7 +15,7 @@
 #include "../perf-sys.h"
 
 /*
- * perf_evsel__config_leader_sampling() uses special rules for leader sampling.
+ * evsel__config_leader_sampling() uses special rules for leader sampling.
  * However, if the leader is an AUX area event, then assume the event to sample
  * is the next event.
  */
@@ -34,8 +34,7 @@ static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
 	return leader;
 }
 
-static void perf_evsel__config_leader_sampling(struct evsel *evsel,
-					       struct evlist *evlist)
+static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
@@ -93,14 +92,14 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 	use_comm_exec = perf_can_comm_exec();
 
 	evlist__for_each_entry(evlist, evsel) {
-		perf_evsel__config(evsel, opts, callchain);
+		evsel__config(evsel, opts, callchain);
 		if (evsel->tracking && use_comm_exec)
 			evsel->core.attr.comm_exec = 1;
 	}
 
 	/* Configure leader sampling here now that the sample type is known */
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__config_leader_sampling(evsel, evlist);
+		evsel__config_leader_sampling(evsel, evlist);
 
 	if (opts->full_auxtrace) {
 		/*
-- 
2.21.1
