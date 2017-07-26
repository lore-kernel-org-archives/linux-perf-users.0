From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/40] perf evsel: Add verbose output for sys_perf_event_open fallback
Date: Wed, 26 Jul 2017 11:17:18 -0300
Message-ID: <20170726141730.30750-29-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding info about what is being switched off in the sys_perf_event_open
fallback.

New output (notice the 'switching off' lines):

  $ perf stat -e '{cycles,instructions}' -vvv ls
  Using CPUID GenuineIntel-6-3D
  intel_pt default config: tsc
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 3591  cpu -1  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off cloexec flag
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 3591  cpu -1  group_fd -1  flags 0
  sys_perf_event_open failed, error -22
  switching off exclude_guest, exclude_host
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
    disabled                         1
    inherit                          1
    enable_on_exec                   1
  ------------------------------------------------------------
  sys_perf_event_open: pid 3591  cpu -1  group_fd -1  flags 0
  sys_perf_event_open failed, error -22
  switching off sample_id_all
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
    disabled                         1
    inherit                          1
    enable_on_exec                   1
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170721121212.21414-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6dd069a41ac3..450b5fadf8cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1671,31 +1671,39 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	 */
 	if (!perf_missing_features.write_backward && evsel->attr.write_backward) {
 		perf_missing_features.write_backward = true;
+		pr_debug2("switching off write_backward\n");
 		goto out_close;
 	} else if (!perf_missing_features.clockid_wrong && evsel->attr.use_clockid) {
 		perf_missing_features.clockid_wrong = true;
+		pr_debug2("switching off clockid\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.clockid && evsel->attr.use_clockid) {
 		perf_missing_features.clockid = true;
+		pr_debug2("switching off use_clockid\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.cloexec && (flags & PERF_FLAG_FD_CLOEXEC)) {
 		perf_missing_features.cloexec = true;
+		pr_debug2("switching off cloexec flag\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.mmap2 && evsel->attr.mmap2) {
 		perf_missing_features.mmap2 = true;
+		pr_debug2("switching off mmap2\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.exclude_guest &&
 		   (evsel->attr.exclude_guest || evsel->attr.exclude_host)) {
 		perf_missing_features.exclude_guest = true;
+		pr_debug2("switching off exclude_guest, exclude_host\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
+		pr_debug2("switching off sample_id_all\n");
 		goto retry_sample_id;
 	} else if (!perf_missing_features.lbr_flags &&
 			(evsel->attr.branch_sample_type &
 			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
 			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
 		perf_missing_features.lbr_flags = true;
+		pr_debug2("switching off branch sample type no (cycles/flags)\n");
 		goto fallback_missing_features;
 	}
 out_close:
-- 
2.9.4
