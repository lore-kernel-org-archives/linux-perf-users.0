From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/25] perf probe: Support DW_AT_const_value constant value
Date: Tue, 19 Nov 2019 08:32:43 -0300
Message-ID: <20191119113245.19593-24-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support DW_AT_const_value for variable assignment instead of location.
Note that this requires ftrace supporting immediate value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406476012.24476.16096289871757175775.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c   |  7 +++++++
 tools/perf/util/probe-file.h   |  1 +
 tools/perf/util/probe-finder.c | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index a63f1a19b0e8..5003ba403345 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1008,6 +1008,7 @@ enum ftrace_readme {
 	FTRACE_README_UPROBE_REF_CTR,
 	FTRACE_README_USER_ACCESS,
 	FTRACE_README_MULTIPROBE_EVENT,
+	FTRACE_README_IMMEDIATE_VALUE,
 	FTRACE_README_END,
 };
 
@@ -1022,6 +1023,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
 	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
 	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
+	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1092,3 +1094,8 @@ bool multiprobe_event_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
 }
+
+bool immediate_value_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_IMMEDIATE_VALUE);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 850d1b52d60a..0dba88c0f5f0 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -72,6 +72,7 @@ bool kretprobe_offset_is_supported(void);
 bool uprobe_ref_ctr_is_supported(void);
 bool user_access_is_supported(void);
 bool multiprobe_event_is_supported(void);
+bool immediate_value_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index f12ad507a822..33e90054ad84 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -177,6 +177,17 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	if (dwarf_attr(vr_die, DW_AT_external, &attr) != NULL)
 		goto static_var;
 
+	/* Constant value */
+	if (dwarf_attr(vr_die, DW_AT_const_value, &attr) &&
+	    immediate_value_is_supported()) {
+		Dwarf_Sword snum;
+
+		dwarf_formsdata(&attr, &snum);
+		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
+
+		return ret < 0 ? -ENOMEM : 0;
+	}
+
 	/* TODO: handle more than 1 exprs */
 	if (dwarf_attr(vr_die, DW_AT_location, &attr) == NULL)
 		return -EINVAL;	/* Broken DIE ? */
-- 
2.21.0
