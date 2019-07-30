From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 025/107] perf trace: Preallocate the syscall table
Date: Mon, 29 Jul 2019 23:54:48 -0300
Message-ID: <20190730025610.22603-26-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll continue reading its details from tracefs as we need it, but
preallocate the whole thing otherwise we may realloc and end up with
pointers to the previous buffer.

I.e. in an upcoming algorithm we'll look for syscalls that have function
signatures that are similar to a given syscall to see if we can reuse
its BPF augmenter, so we may be at syscall 42, having a 'struct syscall'
pointing to that slot in trace->syscalls.table[] and try to read the
slot for an yet unread syscall, which would realloc that table to read
the info for syscall 43, say, which would trigger a realoc of
trace->syscalls.table[], and then the pointer we had for syscall 42
would be pointing to the previous block of memory. b00m.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-m3cjzzifibs13imafhkk77a0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c   | 29 +++++++----------------------
 tools/perf/util/syscalltbl.c |  1 +
 tools/perf/util/syscalltbl.h |  1 +
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 765b998755ce..d8565c9a18a2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -79,7 +79,6 @@ struct trace {
 	struct perf_tool	tool;
 	struct syscalltbl	*sctbl;
 	struct {
-		int		max;
 		struct syscall  *table;
 		struct bpf_map  *map;
 		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
@@ -1493,21 +1492,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (id > trace->syscalls.max) {
-		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
-
-		if (nsyscalls == NULL)
+	if (trace->syscalls.table == NULL) {
+		trace->syscalls.table = calloc(trace->sctbl->syscalls.nr_entries, sizeof(*sc));
+		if (trace->syscalls.table == NULL)
 			return -ENOMEM;
-
-		if (trace->syscalls.max != -1) {
-			memset(nsyscalls + trace->syscalls.max + 1, 0,
-			       (id - trace->syscalls.max) * sizeof(*sc));
-		} else {
-			memset(nsyscalls, 0, (id + 1) * sizeof(*sc));
-		}
-
-		trace->syscalls.table = nsyscalls;
-		trace->syscalls.max   = id;
 	}
 
 	sc = trace->syscalls.table + id;
@@ -1819,11 +1807,11 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 	err = -EINVAL;
 
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
-	    (err = trace__read_syscall_info(trace, id)) != 0)
+	if (id > trace->sctbl->syscalls.max_id)
 		goto out_cant_read;
 
-	if (id > trace->syscalls.max)
+	if ((trace->syscalls.table == NULL || trace->syscalls.table[id].name == NULL) &&
+	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
 	if (trace->syscalls.table[id].name == NULL) {
@@ -1838,7 +1826,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 	if (verbose > 0) {
 		char sbuf[STRERR_BUFSIZE];
 		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
-		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
+		if (id <= trace->sctbl->syscalls.max_id && trace->syscalls.table[id].name != NULL)
 			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
 		fputs(" information\n", trace->output);
 	}
@@ -3922,9 +3910,6 @@ int cmd_trace(int argc, const char **argv)
 		NULL
 	};
 	struct trace trace = {
-		.syscalls = {
-			. max = -1,
-		},
 		.opts = {
 			.target = {
 				.uid	   = UINT_MAX,
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 022a9c670338..820fceeb19a9 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -79,6 +79,7 @@ static int syscalltbl__init_native(struct syscalltbl *tbl)
 
 	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), syscallcmp);
 	tbl->syscalls.nr_entries = nr_entries;
+	tbl->syscalls.max_id	 = syscalltbl_native_max_id;
 	return 0;
 }
 
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index c8e7e9ce0f01..9172613028d0 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -6,6 +6,7 @@ struct syscalltbl {
 	union {
 		int audit_machine;
 		struct {
+			int max_id;
 			int nr_entries;
 			void *entries;
 		} syscalls;
-- 
2.21.0
