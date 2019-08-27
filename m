From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/33] perf report: Fix --ns time sort key output
Date: Mon, 26 Aug 2019 22:36:16 -0300
Message-ID: <20190827013634.3173-16-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

If the user specified --ns, the column to print the sort time stamp
wasn't wide enough to actually print the full nanoseconds.

Widen the time key column width when --ns is specified.

Before:

  % perf record -a sleep 1
  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.10000  [k] smp_call_function_single   -      -
       1.53%  187851.10000  [k] intel_idle                 -      -
       0.59%  187851.10000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.10000  [.] 0000000000000000           -      -
       0.28%  187851.10000  [k] cpuidle_enter_state        -      -

After:

  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.100000000  [k] smp_call_function_single   -      -
       1.53%  187851.100000000  [k] intel_idle                 -      -
       0.59%  187851.100000000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.100000000  [.] 0000000000000000           -      -
       0.28%  187851.100000000  [k] cpuidle_enter_state        -      -

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190823210338.12360-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8efbf58dc3d0..33702675073c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -193,7 +193,10 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
-	hists__new_col_len(hists, HISTC_TIME, 12);
+	if (symbol_conf.nanosecs)
+		hists__new_col_len(hists, HISTC_TIME, 16);
+	else
+		hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
-- 
2.21.0
