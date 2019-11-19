From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/25] perf probe: Verify given line is a representive line
Date: Tue, 19 Nov 2019 08:32:39 -0300
Message-ID: <20191119113245.19593-20-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Verify user given probe line is a representive line (which doesn't share
the address with other lines or the line is the least line among the
lines which shares same address), and if not, it shows what is the
representive line.

Without this fix, user can put a probe on the lines which is not a a
representive line. But since this is not a representive line, perf probe
-l shows a representive line number instead of user given line number.
e.g. (put kernel_read:3, but listed as kernel_read:2)

  # perf probe -a kernel_read:3
  Added new event:
    probe:kernel_read    (on kernel_read:3)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

With this fix, perf probe doesn't allow user to put a probe on a
representive line, and tell what is the representive line.

  # perf probe -a kernel_read:3
  This line is sharing the addrees with other lines.
  Please try to probe at kernel_read:2 instead.
    Error: Failed to add events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406472071.24476.14915451439785001021.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 9ecea45da4ca..ef1b320cedf8 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -776,6 +776,39 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 	return fsp.found ? die_mem : NULL;
 }
 
+static int verify_representive_line(struct probe_finder *pf, const char *fname,
+				int lineno, Dwarf_Addr addr)
+{
+	const char *__fname, *__func = NULL;
+	Dwarf_Die die_mem;
+	int __lineno;
+
+	/* Verify line number and address by reverse search */
+	if (cu_find_lineinfo(&pf->cu_die, addr, &__fname, &__lineno) < 0)
+		return 0;
+
+	pr_debug2("Reversed line: %s:%d\n", __fname, __lineno);
+	if (strcmp(fname, __fname) || lineno == __lineno)
+		return 0;
+
+	pr_warning("This line is sharing the addrees with other lines.\n");
+
+	if (pf->pev->point.function) {
+		/* Find best match function name and lines */
+		pf->addr = addr;
+		if (find_best_scope(pf, &die_mem)
+		    && die_match_name(&die_mem, pf->pev->point.function)
+		    && dwarf_decl_line(&die_mem, &lineno) == 0) {
+			__func = dwarf_diename(&die_mem);
+			__lineno -= lineno;
+		}
+	}
+	pr_warning("Please try to probe at %s:%d instead.\n",
+		   __func ? : __fname, __lineno);
+
+	return -ENOENT;
+}
+
 static int probe_point_line_walker(const char *fname, int lineno,
 				   Dwarf_Addr addr, void *data)
 {
@@ -786,6 +819,9 @@ static int probe_point_line_walker(const char *fname, int lineno,
 	if (lineno != pf->lno || strtailcmp(fname, pf->fname) != 0)
 		return 0;
 
+	if (verify_representive_line(pf, fname, lineno, addr))
+		return -ENOENT;
+
 	pf->addr = addr;
 	sc_die = find_best_scope(pf, &die_mem);
 	if (!sc_die) {
-- 
2.21.0
