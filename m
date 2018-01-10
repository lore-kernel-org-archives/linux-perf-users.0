From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/27] perf report: Fix a no annotate browser displayed issue
Date: Wed, 10 Jan 2018 18:28:23 -0300
Message-ID: <20180110212844.12441-7-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

When enabling '-b' option in perf record, for example,

  perf record -b ...
  perf report

and then browsing the annotate browser from perf report (press 'A'), it
would fail (annotate browser can't be displayed).

It's because the '.add_entry_cb' op of struct report is overwritten by
hist_iter__branch_callback() in builtin-report.c. But this function doesn't do
something like mapping symbols and sources. So next, do_annotate() will return
directly.

        notes = symbol__annotation(act->ms.sym);
        if (!notes->src)
                return 0;

This patch adds the lost code to hist_iter__branch_callback (refer to
hist_iter__report_callback).

v2:

Fix a crash bug when perform 'perf report --stdio'.

The reason is that we init the symbol annotation only in browser mode, it
doesn't allocate/init resources for stdio mode.

So now in hist_iter__branch_callback(), it will return directly if it's not in
browser mode.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1514284963-18587-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index eb9ce6327e71..07827cd51480 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -162,12 +162,28 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct hist_entry *he = iter->he;
 	struct report *rep = arg;
 	struct branch_info *bi;
+	struct perf_sample *sample = iter->sample;
+	struct perf_evsel *evsel = iter->evsel;
+	int err;
+
+	if (!ui__has_annotation())
+		return 0;
+
+	hist__account_cycles(sample->branch_stack, al, sample,
+			     rep->nonany_branch_mode);
 
 	bi = he->branch_info;
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	if (err)
+		goto out;
+
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
 
-	return 0;
+out:
+	return err;
 }
 
 static int process_sample_event(struct perf_tool *tool,
-- 
2.14.3
