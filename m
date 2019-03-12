From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 05/10] perf, report: Show all sort keys in help output
Date: Tue, 12 Mar 2019 09:43:49 -0700
Message-ID: <20190312164349.GA24002@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-6-andi@firstfloor.org>
 <20190312103027.GB13071@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312103027.GB13071@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> that line goes forever now, please provide some formating
> into multiple lines

Here's an updated patch with line wrapping.

---

perf report: Show all sort keys in help output

Show all the supported sort keys in the command line help output,
so that it's not needed to refer to the manpage.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Now line wrap output.
---
 tools/perf/builtin-report.c |  5 ++--
 tools/perf/util/sort.c      | 52 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1532ebde6c4b..6317c38762dd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1044,10 +1044,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
-		   "sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ..."
-		   " Please refer the man page for the complete list."),
+		   sort_help("sort by key(s):")),
 	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
-		   "output field(s): overhead, period, sample plus all of sort keys"),
+		   sort_help("output field(s): overhead, period, sample,")),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d2299e912e59..ea71d3732a50 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -12,6 +12,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "strlist.h"
+#include "strbuf.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
@@ -3068,3 +3069,54 @@ void reset_output_field(void)
 	reset_dimensions();
 	perf_hpp__reset_output_field(&perf_hpp_list);
 }
+
+#define INDENT (3*8 + 1)
+
+static void add_key(struct strbuf *sb, const char *str, int *llen)
+{
+	if (*llen >= 75) {
+		strbuf_addstr(sb, "\n\t\t\t ");
+		*llen = INDENT;
+	}
+	strbuf_addf(sb, " %s", str);
+	*llen += strlen(str) + 1;
+}
+
+static void add_sort_string(struct strbuf *sb, struct sort_dimension *s, int n,
+			    int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int n,
+				int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+const char *sort_help(const char *prefix)
+{
+	struct strbuf sb;
+	char *s;
+	int len = strlen(prefix) + INDENT;
+
+	strbuf_init(&sb, 300);
+	strbuf_addstr(&sb, prefix);
+	add_hpp_sort_string(&sb, hpp_sort_dimensions,
+			    ARRAY_SIZE(hpp_sort_dimensions), &len);
+	add_sort_string(&sb, common_sort_dimensions,
+			    ARRAY_SIZE(common_sort_dimensions), &len);
+	add_sort_string(&sb, bstack_sort_dimensions,
+			    ARRAY_SIZE(bstack_sort_dimensions), &len);
+	add_sort_string(&sb, memory_sort_dimensions,
+			    ARRAY_SIZE(memory_sort_dimensions), &len);
+	s = strbuf_detach(&sb, NULL);
+	strbuf_release(&sb);
+	return s;
+}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2fbee0b1011c..93d1b25da341 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -286,6 +286,8 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
+const char *sort_help(const char *prefix);
+
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
 bool is_strict_order(const char *order);
-- 
2.20.1
