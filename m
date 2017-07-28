From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/15] perf sort: Use default sort if evlist is empty
Date: Fri, 28 Jul 2017 17:00:11 -0300
Message-ID: <20170728200021.11389-6-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Fixes bug noted by Jiri in https://lkml.org/lkml/2017/6/13/755 and
caused by commit d49dadea7862 ("perf tools: Make 'trace' or
'trace_fields' sort key default for tracepoint events") not taking into
account that evlist is empty in pipe-mode.

Before this commit, pipe mode will only show bogus "100.00%  N/A"
instead of correct output as follows:

  $ perf record -o - sleep 1 | perf report -i -
  # To display the perf.data header info, please use --header/--header-only options.
  #
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  #
  # Total Lost Samples: 0
  #
  # Samples: 8  of event 'cycles:ppH'
  # Event count (approx.): 145658
  #
  # Overhead  Trace output
  # ........  ............
  #
     100.00%  N/A

Correct output, after patch:

  $ perf record -o - sleep 1 | perf report -i -
  # To display the perf.data header info, please use --header/--header-only options.
  #
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  #
  # Total Lost Samples: 0
  #
  # Samples: 8  of event 'cycles:ppH'
  # Event count (approx.): 191331
  #
  # Overhead  Command  Shared Object      Symbol
  # ........  .......  .................  .................................
  #
      81.63%  sleep    libc-2.19.so       [.] _exit
      13.58%  sleep    ld-2.19.so         [.] do_lookup_x
       2.34%  sleep    [kernel.kallsyms]  [k] context_switch
       2.34%  sleep    libc-2.19.so       [.] __GI___libc_nanosleep
       0.11%  perf     [kernel.kallsyms]  [k] __intel_pmu_enable_a

Reported-by: Jiri Olsa <jolsa@kernel.org>
Report-Link: https://lkml.kernel.org/r/20170613185422.GA6092@krava
Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: d49dadea7862 ("perf tools: Make 'trace' or 'trace_fields' sort key default for tracepoint events")
Link: https://lkml.kernel.org/r/20170721051157.47331-1-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h | 5 +++++
 tools/perf/util/sort.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0843746bc389..bf2c4936e35f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -265,6 +265,11 @@ bool perf_evlist__valid_read_format(struct perf_evlist *evlist);
 void perf_evlist__splice_list_tail(struct perf_evlist *evlist,
 				   struct list_head *list);
 
+static inline bool perf_evlist__empty(struct perf_evlist *evlist)
+{
+	return list_empty(&evlist->entries);
+}
+
 static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
 {
 	return list_entry(evlist->entries.next, struct perf_evsel, node);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 8b327c955a4f..12359bd986db 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2563,7 +2563,7 @@ static const char *get_default_sort_order(struct perf_evlist *evlist)
 
 	BUG_ON(sort__mode >= ARRAY_SIZE(default_sort_orders));
 
-	if (evlist == NULL)
+	if (evlist == NULL || perf_evlist__empty(evlist))
 		goto out_no_evlist;
 
 	evlist__for_each_entry(evlist, evsel) {
-- 
2.9.4
