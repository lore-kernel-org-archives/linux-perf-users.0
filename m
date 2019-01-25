From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/29] perf symbols: Move symbol_conf to separate file
Date: Sat, 26 Jan 2019 00:18:15 +0100
Message-ID: <20190125231843.2895-2-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't drag all the headers included in symbol.h when needing
to access symbol_conf in another header, such as annotate.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rvo9dzflkneqmprb0dgbfybx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.h      | 64 +-----------------------------
 tools/perf/util/symbol_conf.h | 73 +++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 63 deletions(-)
 create mode 100644 tools/perf/util/symbol_conf.h

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 14d9d438e7e2..277841e3dbd1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -15,6 +15,7 @@
 #include "build-id.h"
 #include "event.h"
 #include "path.h"
+#include "symbol_conf.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -89,69 +90,6 @@ static inline size_t symbol__size(const struct symbol *sym)
 struct strlist;
 struct intlist;
 
-struct symbol_conf {
-	unsigned short	priv_size;
-	bool		try_vmlinux_path,
-			init_annotation,
-			force,
-			ignore_vmlinux,
-			ignore_vmlinux_buildid,
-			show_kernel_path,
-			use_modules,
-			allow_aliases,
-			sort_by_name,
-			show_nr_samples,
-			show_total_period,
-			use_callchain,
-			cumulate_callchain,
-			show_branchflag_count,
-			exclude_other,
-			show_cpu_utilization,
-			initialized,
-			kptr_restrict,
-			event_group,
-			demangle,
-			demangle_kernel,
-			filter_relative,
-			show_hist_headers,
-			branch_callstack,
-			has_filter,
-			show_ref_callgraph,
-			hide_unresolved,
-			raw_trace,
-			report_hierarchy,
-			inline_name;
-	const char	*vmlinux_name,
-			*kallsyms_name,
-			*source_prefix,
-			*field_sep,
-			*graph_function;
-	const char	*default_guest_vmlinux_name,
-			*default_guest_kallsyms,
-			*default_guest_modules;
-	const char	*guestmount;
-	const char	*dso_list_str,
-			*comm_list_str,
-			*pid_list_str,
-			*tid_list_str,
-			*sym_list_str,
-			*col_width_list_str,
-			*bt_stop_list_str;
-       struct strlist	*dso_list,
-			*comm_list,
-			*sym_list,
-			*dso_from_list,
-			*dso_to_list,
-			*sym_from_list,
-			*sym_to_list,
-			*bt_stop_list;
-	struct intlist	*pid_list,
-			*tid_list;
-	const char	*symfs;
-};
-
-extern struct symbol_conf symbol_conf;
-
 struct symbol_name_rb_node {
 	struct rb_node	rb_node;
 	struct symbol	sym;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
new file mode 100644
index 000000000000..fffea68c1203
--- /dev/null
+++ b/tools/perf/util/symbol_conf.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYMBOL_CONF
+#define __PERF_SYMBOL_CONF 1
+
+#include <stdbool.h>
+
+struct strlist;
+struct intlist;
+
+struct symbol_conf {
+	unsigned short	priv_size;
+	bool		try_vmlinux_path,
+			init_annotation,
+			force,
+			ignore_vmlinux,
+			ignore_vmlinux_buildid,
+			show_kernel_path,
+			use_modules,
+			allow_aliases,
+			sort_by_name,
+			show_nr_samples,
+			show_total_period,
+			use_callchain,
+			cumulate_callchain,
+			show_branchflag_count,
+			exclude_other,
+			show_cpu_utilization,
+			initialized,
+			kptr_restrict,
+			event_group,
+			demangle,
+			demangle_kernel,
+			filter_relative,
+			show_hist_headers,
+			branch_callstack,
+			has_filter,
+			show_ref_callgraph,
+			hide_unresolved,
+			raw_trace,
+			report_hierarchy,
+			inline_name;
+	const char	*vmlinux_name,
+			*kallsyms_name,
+			*source_prefix,
+			*field_sep,
+			*graph_function;
+	const char	*default_guest_vmlinux_name,
+			*default_guest_kallsyms,
+			*default_guest_modules;
+	const char	*guestmount;
+	const char	*dso_list_str,
+			*comm_list_str,
+			*pid_list_str,
+			*tid_list_str,
+			*sym_list_str,
+			*col_width_list_str,
+			*bt_stop_list_str;
+       struct strlist	*dso_list,
+			*comm_list,
+			*sym_list,
+			*dso_from_list,
+			*dso_to_list,
+			*sym_from_list,
+			*sym_to_list,
+			*bt_stop_list;
+	struct intlist	*pid_list,
+			*tid_list;
+	const char	*symfs;
+};
+
+extern struct symbol_conf symbol_conf;
+
+#endif // __PERF_SYMBOL_CONF
-- 
2.20.1
