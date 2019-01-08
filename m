From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/16] perf top: Lift restriction on using callchains without "sym" in --sort
Date: Tue,  8 Jan 2019 16:59:06 -0300
Message-ID: <20190108195910.17726-13-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This restriction is not present in 'perf report' and since 'perf top'
uses the same hists browser, remove it from it as well.

With this we create per event buckets with callchain trees, so that

  # perf top --sort dso -g --no-children

Bucketizes samples by DSO and below it shows the callchains leading to
functions in this DSO.

Try also:

  # perf top -e sched:*switch -g --no-children

To see the callchains leading to sched switches, pressing 'E' to expand
all one can quickly see the most common scheduler switches and what
leads to them, for instance, calls to IO, futexes, etc.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190107140854.GA28965@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fe3ecfb2e64b..f64e312db787 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1028,12 +1028,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 {
-	if (!perf_hpp_list.sym) {
-		if (callchain->enabled) {
-			ui__error("Selected -g but \"sym\" not present in --sort/-s.");
-			return -EINVAL;
-		}
-	} else if (callchain->mode != CHAIN_NONE) {
+	if (callchain->mode != CHAIN_NONE) {
 		if (callchain_register_param(callchain) < 0) {
 			ui__error("Can't register callchain params.\n");
 			return -EINVAL;
-- 
2.20.1
