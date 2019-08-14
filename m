From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/28] perf evsel: Provide meaningful warning when trying to use 'aux_output' on older kernels
Date: Wed, 14 Aug 2019 15:40:47 -0300
Message-ID: <20190814184051.3125-25-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like we do with the 'write_backwards' feature:

Before:

  # perf record -e {intel_pt/branch=0/,cycles/aux-output/ppp} uname
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles/aux-output/ppp).
  /bin/dmesg | grep -i perf may provide additional information.

  #

After:

  # perf record -e {intel_pt/branch=0/,cycles/aux-output/ppp} uname
  Error:
  The 'aux_output' feature is not supported, update the kernel.
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-wgjsjroe1e150c0metgwmqwd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 11 +++++++++--
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5da40511546b..0a33f7322ecc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1738,7 +1738,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
-	if (perf_missing_features.write_backward && evsel->core.attr.write_backward)
+	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
+	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
 		return -EINVAL;
 
 	if (cpus == NULL) {
@@ -1912,7 +1913,11 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
+	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+		perf_missing_features.aux_output = true;
+		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
 		perf_missing_features.bpf_event = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
@@ -2926,6 +2931,8 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_output)
+			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8a316dd54cd0..9cd6e3ae479a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -184,6 +184,7 @@ struct perf_missing_features {
 	bool group_read;
 	bool ksymbol;
 	bool bpf_event;
+	bool aux_output;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.21.0
