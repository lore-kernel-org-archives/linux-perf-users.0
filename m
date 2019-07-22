From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/37] perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
Date: Mon, 22 Jul 2019 14:38:33 -0300
Message-ID: <20190722173839.22898-32-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are holes in syscall tables with IDs not associated with any
syscall, mark those when trying to read information for syscalls, which
could happen when iterating thru all syscalls from 0 to the highest
numbered syscall id.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cku9mpcrcsqaiq0jepu86r68@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5dae7b172291..765b998755ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -976,6 +976,7 @@ static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
  * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
+ * nonexistent: Just a hole in the syscall table, syscall id not allocated
  */
 struct syscall {
 	struct tep_event    *tp_format;
@@ -987,6 +988,7 @@ struct syscall {
 	}		    bpf_prog;
 	bool		    is_exit;
 	bool		    is_open;
+	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
 	struct syscall_fmt  *fmt;
@@ -1491,9 +1493,6 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (name == NULL)
-		return -EINVAL;
-
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
@@ -1512,8 +1511,15 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc = trace->syscalls.table + id;
-	sc->name = name;
+	if (sc->nonexistent)
+		return 0;
 
+	if (name == NULL) {
+		sc->nonexistent = true;
+		return 0;
+	}
+
+	sc->name = name;
 	sc->fmt  = syscall_fmt__find(sc->name);
 
 	snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->name);
@@ -1811,14 +1817,21 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		return NULL;
 	}
 
+	err = -EINVAL;
+
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
 	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
-	err = -EINVAL;
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
+	if (id > trace->syscalls.max)
 		goto out_cant_read;
 
+	if (trace->syscalls.table[id].name == NULL) {
+		if (trace->syscalls.table[id].nonexistent)
+			return NULL;
+		goto out_cant_read;
+	}
+
 	return &trace->syscalls.table[id];
 
 out_cant_read:
-- 
2.21.0
