From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/18] perf record: Support weak groups
Date: Tue,  6 Nov 2018 09:06:01 -0300
Message-ID: <20181106120612.8262-8-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement a weak group fallback for 'perf record', similar to the
existing 'perf stat' support.  This allows to use groups that might be
longer than the available counters without failing.

Before:

  $ perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}' -a sleep 1
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
  /bin/dmesg | grep -i perf may provide additional information.

After:

  $ ./perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}:W' -a sleep 1
  WARNING: No sample_id_all support, falling back to unordered processing
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 8.136 MB perf.data (134069 samples) ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181001195927.14211-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 1 -
 tools/perf/builtin-record.c            | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 236b9b97dfdb..667c14e56031 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -55,7 +55,6 @@ counted. The following modifiers exist:
  S - read sample value (PERF_SAMPLE_READ)
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
-     only supported in 'perf stat' for now.
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 10cf889c6d75..488779bc4c8d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -391,7 +391,12 @@ static int record__open(struct record *rec)
 					ui__warning("%s\n", msg);
 				goto try_again;
 			}
-
+			if ((errno == EINVAL || errno == EBADF) &&
+			    pos->leader != pos &&
+			    pos->weak_group) {
+			        pos = perf_evlist__reset_weak_group(evlist, pos);
+				goto try_again;
+			}
 			rc = -errno;
 			perf_evsel__open_strerror(pos, &opts->target,
 						  errno, msg, sizeof(msg));
-- 
2.14.4
