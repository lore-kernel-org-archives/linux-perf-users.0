From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/63] perf probe: Return a better scope DIE if there is no best scope
Date: Thu,  7 Nov 2019 15:59:58 -0300
Message-ID: <20191107190011.23924-51-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Make find_best_scope() returns innermost DIE at given address if there
is no best matched scope DIE. Since Gcc sometimes generates intuitively
strange line info which is out of inlined function address range, we
need this fixup.

Without this, sometimes perf probe failed to probe on a line inside an
inlined function:

  # perf probe -D ksys_open:3
  Failed to find scope of probe point.
    Error: Failed to add events.

With this fix, 'perf probe' can probe it:

  # perf probe -D ksys_open:3
  p:probe/ksys_open _text+25707308
  p:probe/ksys_open_1 _text+25710596
  p:probe/ksys_open_2 _text+25711114
  p:probe/ksys_open_3 _text+25711343
  p:probe/ksys_open_4 _text+25714058
  p:probe/ksys_open_5 _text+2819653
  p:probe/ksys_open_6 _text+2819701

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157291300887.19771.14936015360963292236.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 88e17a4f5ac3..582f8c34d93a 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -744,6 +744,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 	return 0;
 }
 
+/* Return innermost DIE */
+static int find_inner_scope_cb(Dwarf_Die *fn_die, void *data)
+{
+	struct find_scope_param *fsp = data;
+
+	memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
+	fsp->found = true;
+	return 1;
+}
+
 /* Find an appropriate scope fits to given conditions */
 static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 {
@@ -755,8 +765,13 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 		.die_mem = die_mem,
 		.found = false,
 	};
+	int ret;
 
-	cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb, &fsp);
+	ret = cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb,
+				   &fsp);
+	if (!ret && !fsp.found)
+		cu_walk_functions_at(&pf->cu_die, pf->addr,
+				     find_inner_scope_cb, &fsp);
 
 	return fsp.found ? die_mem : NULL;
 }
-- 
2.21.0
