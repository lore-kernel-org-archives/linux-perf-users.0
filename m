From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/18] perf diff: Check if all data files with branch stacks
Date: Wed,  3 Jul 2019 00:27:32 -0300
Message-ID: <20190703032746.21692-5-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We will expand perf diff to support diff cycles of individual programs
blocks, so it requires all data files having branch stacks.

This patch checks HEADER_BRANCH_STACK in header, and only set the flag
has_br_stack when HEADER_BRANCH_STACK are set in all data files.

 v2:
 ---
 Move check_file_brstack() from __cmd_diff() to cmd_diff().
 Because later patch will check flag 'has_br_stack' before
 ui_init().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 6e7920793729..a7e04202955c 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -32,6 +32,7 @@ struct perf_diff {
 	struct perf_time_interval	*ptime_range;
 	int				 range_size;
 	int				 range_num;
+	bool				 has_br_stack;
 };
 
 /* Diff command specific HPP columns. */
@@ -873,6 +874,31 @@ static int parse_time_str(struct data__file *d, char *abstime_ostr,
 	return ret;
 }
 
+static int check_file_brstack(void)
+{
+	struct data__file *d;
+	bool has_br_stack;
+	int i;
+
+	data__for_each_file(i, d) {
+		d->session = perf_session__new(&d->data, false, &pdiff.tool);
+		if (!d->session) {
+			pr_err("Failed to open %s\n", d->data.path);
+			return -1;
+		}
+
+		has_br_stack = perf_header__has_feat(&d->session->header,
+						     HEADER_BRANCH_STACK);
+		perf_session__delete(d->session);
+		if (!has_br_stack)
+			return 0;
+	}
+
+	/* Set only all files having branch stacks */
+	pdiff.has_br_stack = true;
+	return 0;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1487,6 +1513,9 @@ int cmd_diff(int argc, const char **argv)
 	if (data_init(argc, argv) < 0)
 		return -1;
 
+	if (check_file_brstack() < 0)
+		return -1;
+
 	if (ui_init() < 0)
 		return -1;
 
-- 
2.20.1
