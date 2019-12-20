From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 7/9] perf record: Add --all-cgroups option
Date: Fri, 20 Dec 2019 13:32:51 +0900
Message-ID: <20191220043253.3278951-8-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 ++++-
 tools/perf/builtin-record.c              |  5 +++++
 tools/perf/util/evsel.c                  | 13 ++++++++++++-
 tools/perf/util/evsel.h                  |  1 +
 tools/perf/util/record.h                 |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b23a4012a606..6dd9d69d7dee 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -385,7 +385,10 @@ displayed with the weight and local_weight sort keys.  This currently works for
 abort events and some memory events in precise mode on modern Intel CPUs.
 
 --namespaces::
-Record events of type PERF_RECORD_NAMESPACES.
+Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
+
+--all-cgroups::
+Record events of type PERF_RECORD_CGROUP.  This enables 'cgroup' sort key.
 
 --transaction::
 Record transaction flags for transaction related events.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2802de9538ff..7d7912e121d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1433,6 +1433,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->opts.record_namespaces)
 		tool->namespace_events = true;
 
+	if (rec->opts.record_cgroup)
+		tool->cgroup_events = true;
+
 	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
 		signal(SIGUSR2, snapshot_sig_handler);
 		if (rec->opts.auxtrace_snapshot_mode)
@@ -2363,6 +2366,8 @@ static struct option __record_options[] = {
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &record.opts.record_cgroup,
+		    "Record cgroup events"),
 	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
 		    "Record context switch events"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &record.opts.all_kernel,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0f5a67603139..d649b5606178 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1102,6 +1102,11 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
 
+	if (opts->record_cgroup) {
+		attr->cgroup = track && !perf_missing_features.cgroup;
+		perf_evsel__set_sample_bit(evsel, CGROUP);
+	}
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -1671,6 +1676,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.cgroup)
+		evsel->core.attr.cgroup = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1782,7 +1789,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("switching off cgroup\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..df71b530740b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool cgroup;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 5421fd2ad383..24316458be20 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -34,6 +34,7 @@ struct record_opts {
 	bool	      auxtrace_snapshot_on_exit;
 	bool	      auxtrace_sample_mode;
 	bool	      record_namespaces;
+	bool	      record_cgroup;
 	bool	      record_switch_events;
 	bool	      all_kernel;
 	bool	      all_user;
-- 
2.24.1.735.g03f4e72817-goog
