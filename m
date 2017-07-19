From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 84/86] perf util: Create branch.c/.h for common branch functions
Date: Wed, 19 Jul 2017 11:29:48 -0300
Message-ID: <20170719142950.3747-85-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Create new util/branch.c and util/branch.h to contain the common branch
functions. Such as:

branch_type_count(): Count the numbers of branch types
branch_type_name() : Return the name of branch type
branch_type_stat_display(): Display branch type statistics info
branch_type_str(): Construct the branch type string.

The branch type is saved in branch_flags.

Change log:

v8: Change PERF_BR_NONE to PERF_BR_UNKNOWN.

v7: Since the common branch type name is changed (e.g. JCC->COND),
    this patch is performed the modification accordingly.

v6: Move that multiline conditional code inside {} brackets.
    Move branch_type_stat_display() from builtin-report.c to
      branch.c.
    Move branch_type_str() from callchain.c to branch.c.

v5: It's a new patch in v5 patch series.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500379995-6449-6-git-send-email-yao.jin@linux.intel.com
[ Don't use 'index' and 'stat' as names for variables, it shadows global decls in older distros ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build    |   1 +
 tools/perf/util/branch.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/branch.h |  24 ++++++++
 tools/perf/util/event.h  |   3 +-
 4 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/branch.c
 create mode 100644 tools/perf/util/branch.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7580fe4d5d30..8d49a989f193 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -93,6 +93,7 @@ libperf-y += drv_configs.o
 libperf-y += units.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
+libperf-y += branch.o
 
 libperf-$(CONFIG_LIBBPF) += bpf-loader.o
 libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
new file mode 100644
index 000000000000..a4fce2729e50
--- /dev/null
+++ b/tools/perf/util/branch.c
@@ -0,0 +1,147 @@
+#include "perf.h"
+#include "util/util.h"
+#include "util/debug.h"
+#include "util/branch.h"
+
+static bool cross_area(u64 addr1, u64 addr2, int size)
+{
+	u64 align1, align2;
+
+	align1 = addr1 & ~(size - 1);
+	align2 = addr2 & ~(size - 1);
+
+	return (align1 != align2) ? true : false;
+}
+
+#define AREA_4K		4096
+#define AREA_2M		(2 * 1024 * 1024)
+
+void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
+		       u64 from, u64 to)
+{
+	if (flags->type == PERF_BR_UNKNOWN || from == 0)
+		return;
+
+	st->counts[flags->type]++;
+
+	if (flags->type == PERF_BR_COND) {
+		if (to > from)
+			st->cond_fwd++;
+		else
+			st->cond_bwd++;
+	}
+
+	if (cross_area(from, to, AREA_2M))
+		st->cross_2m++;
+	else if (cross_area(from, to, AREA_4K))
+		st->cross_4k++;
+}
+
+const char *branch_type_name(int type)
+{
+	const char *branch_names[PERF_BR_MAX] = {
+		"N/A",
+		"COND",
+		"UNCOND",
+		"IND",
+		"CALL",
+		"IND_CALL",
+		"RET",
+		"SYSCALL",
+		"SYSRET",
+		"COND_CALL",
+		"COND_RET"
+	};
+
+	if (type >= 0 && type < PERF_BR_MAX)
+		return branch_names[type];
+
+	return NULL;
+}
+
+void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
+{
+	u64 total = 0;
+	int i;
+
+	for (i = 0; i < PERF_BR_MAX; i++)
+		total += st->counts[i];
+
+	if (total == 0)
+		return;
+
+	fprintf(fp, "\n#");
+	fprintf(fp, "\n# Branch Statistics:");
+	fprintf(fp, "\n#");
+
+	if (st->cond_fwd > 0) {
+		fprintf(fp, "\n%8s: %5.1f%%",
+			"COND_FWD",
+			100.0 * (double)st->cond_fwd / (double)total);
+	}
+
+	if (st->cond_bwd > 0) {
+		fprintf(fp, "\n%8s: %5.1f%%",
+			"COND_BWD",
+			100.0 * (double)st->cond_bwd / (double)total);
+	}
+
+	if (st->cross_4k > 0) {
+		fprintf(fp, "\n%8s: %5.1f%%",
+			"CROSS_4K",
+			100.0 * (double)st->cross_4k / (double)total);
+	}
+
+	if (st->cross_2m > 0) {
+		fprintf(fp, "\n%8s: %5.1f%%",
+			"CROSS_2M",
+			100.0 * (double)st->cross_2m / (double)total);
+	}
+
+	for (i = 0; i < PERF_BR_MAX; i++) {
+		if (st->counts[i] > 0)
+			fprintf(fp, "\n%8s: %5.1f%%",
+				branch_type_name(i),
+				100.0 *
+				(double)st->counts[i] / (double)total);
+	}
+}
+
+static int count_str_scnprintf(int idx, const char *str, char *bf, int size)
+{
+	return scnprintf(bf, size, "%s%s", (idx) ? " " : " (", str);
+}
+
+int branch_type_str(struct branch_type_stat *st, char *bf, int size)
+{
+	int i, j = 0, printed = 0;
+	u64 total = 0;
+
+	for (i = 0; i < PERF_BR_MAX; i++)
+		total += st->counts[i];
+
+	if (total == 0)
+		return 0;
+
+	if (st->cond_fwd > 0)
+		printed += count_str_scnprintf(j++, "COND_FWD", bf + printed, size - printed);
+
+	if (st->cond_bwd > 0)
+		printed += count_str_scnprintf(j++, "COND_BWD", bf + printed, size - printed);
+
+	for (i = 0; i < PERF_BR_MAX; i++) {
+		if (i == PERF_BR_COND)
+			continue;
+
+		if (st->counts[i] > 0)
+			printed += count_str_scnprintf(j++, branch_type_name(i), bf + printed, size - printed);
+	}
+
+	if (st->cross_4k > 0)
+		printed += count_str_scnprintf(j++, "CROSS_4K", bf + printed, size - printed);
+
+	if (st->cross_2m > 0)
+		printed += count_str_scnprintf(j++, "CROSS_2M", bf + printed, size - printed);
+
+	return printed;
+}
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
new file mode 100644
index 000000000000..686f2b65ba84
--- /dev/null
+++ b/tools/perf/util/branch.h
@@ -0,0 +1,24 @@
+#ifndef _PERF_BRANCH_H
+#define _PERF_BRANCH_H 1
+
+#include <stdint.h>
+#include "../perf.h"
+
+struct branch_type_stat {
+	u64 counts[PERF_BR_MAX];
+	u64 cond_fwd;
+	u64 cond_bwd;
+	u64 cross_4k;
+	u64 cross_2m;
+};
+
+struct branch_flags;
+
+void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
+		       u64 from, u64 to);
+
+const char *branch_type_name(int type);
+void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
+int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
+
+#endif /* _PERF_BRANCH_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 37c5fafb549c..423ac82605f3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -142,7 +142,8 @@ struct branch_flags {
 	u64 in_tx:1;
 	u64 abort:1;
 	u64 cycles:16;
-	u64 reserved:44;
+	u64 type:4;
+	u64 reserved:40;
 };
 
 struct branch_entry {
-- 
2.9.4
