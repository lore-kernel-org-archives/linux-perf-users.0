From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/6] perf report: Bail out --mem-mode if mem info is not available
Date: Thu,  5 Dec 2019 16:32:21 -0300
Message-ID: <20191205193224.24629-4-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

If perf.data is recorded without -d, don't allow user to use --mem-mode
with 'perf report'. symbol_daddr and phys_daddr can be recorded
separately and may be present in the perf.data but at the report time
they are associated with mem-mode fields and thus this restriction
applies to them as well.

Before:
  $ perf record ls
  $ perf report --mem-mode --stdio
  # Overhead  Local Weight  Memory access  Symbol
  # ........  ............  .............  .......................
      55.56%  0             N/A            [k] 0xffffffff81a00ae7

After:
  $ perf report --mem-mode --stdio
  Error:
  Selected --mem-mode but no mem data. Did you call perf record without -d?

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 830d563de889..387311c67264 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -388,6 +388,14 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
+	if (sort__mode == SORT_MODE__MEMORY) {
+		if (!is_pipe && !(sample_type & PERF_SAMPLE_DATA_SRC)) {
+			ui__error("Selected --mem-mode but no mem data. "
+				  "Did you call perf record without -d?\n");
+			return -1;
+		}
+	}
+
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
 		    (sample_type & PERF_SAMPLE_STACK_USER)) {
-- 
2.21.0
