From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/75] perf tools: Fix diverse comment typos
Date: Thu,  6 Dec 2018 18:25:28 -0300
Message-ID: <20181206212602.20474-42-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease
cherry-picking and/or backporting, split this into multiple patches.

Just typos in comments, no need to backport, reducing the possibility of
possible backporting artifacts.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86.c | 2 +-
 tools/perf/builtin-top.c             | 2 +-
 tools/perf/builtin-trace.c           | 2 +-
 tools/perf/tests/attr.c              | 2 +-
 tools/perf/util/annotate.c           | 2 +-
 tools/perf/util/header.c             | 2 +-
 tools/perf/util/hist.c               | 2 +-
 tools/perf/util/jitdump.c            | 2 +-
 tools/perf/util/machine.c            | 2 +-
 tools/perf/util/probe-event.c        | 4 ++--
 tools/perf/util/sort.c               | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index a5d24ae5810d..c3e5f4ab0d3e 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -170,7 +170,7 @@ static int test_data_set(struct test_data *dat_set, int x86_64)
  *
  * If the test passes %0 is returned, otherwise %-1 is returned.  Use the
  * verbose (-v) option to see all the instructions and whether or not they
- * decoded successfuly.
+ * decoded successfully.
  */
 int test__insn_x86(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1252d1759064..c59a3eb0d697 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -595,7 +595,7 @@ static void *display_thread_tui(void *arg)
 
 	/*
 	 * Initialize the uid_filter_str, in the future the TUI will allow
-	 * Zooming in/out UIDs. For now juse use whatever the user passed
+	 * Zooming in/out UIDs. For now just use whatever the user passed
 	 * via --uid.
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a57a9ae1fd4b..a6aa4589ad50 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2782,7 +2782,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * Now that we already used evsel->attr to ask the kernel to setup the
 	 * events, lets reuse evsel->attr.sample_max_stack as the limit in
 	 * trace__resolve_callchain(), allowing per-event max-stack settings
-	 * to override an explicitely set --max-stack global setting.
+	 * to override an explicitly set --max-stack global setting.
 	 */
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__has_callchain(evsel) &&
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 05dfe11c2f9e..d8426547219b 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -182,7 +182,7 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 	char path_perf[PATH_MAX];
 	char path_dir[PATH_MAX];
 
-	/* First try developement tree tests. */
+	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f69d8e177fa3..51d291b0b81f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1772,7 +1772,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	while (!feof(file)) {
 		/*
 		 * The source code line number (lineno) needs to be kept in
-		 * accross calls to symbol__parse_objdump_line(), so that it
+		 * across calls to symbol__parse_objdump_line(), so that it
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9cc81d48a908..4a64739c67e7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2798,7 +2798,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	lseek(fd, sec_start, SEEK_SET);
 	/*
 	 * may write more than needed due to dropped feature, but
-	 * this is okay, reader will skip the mising entries
+	 * this is okay, reader will skip the missing entries
 	 */
 	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 828cb9794c76..8aad8330e392 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1160,7 +1160,7 @@ void hist_entry__delete(struct hist_entry *he)
 
 /*
  * If this is not the last column, then we need to pad it according to the
- * pre-calculated max lenght for this column, otherwise don't bother adding
+ * pre-calculated max length for this column, otherwise don't bother adding
  * spaces because that would break viewing this with, for instance, 'less',
  * that would show tons of trailing spaces when a long C++ demangled method
  * names is sampled.
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index a1863000e972..bf249552a9b0 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -38,7 +38,7 @@ struct jit_buf_desc {
 	uint64_t	 sample_type;
 	size_t           bufsize;
 	FILE             *in;
-	bool		 needs_bswap; /* handles cross-endianess */
+	bool		 needs_bswap; /* handles cross-endianness */
 	bool		 use_arch_timestamp;
 	void		 *debug_data;
 	void		 *unwinding_data;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9397e3f2444d..d1309201c1d2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -137,7 +137,7 @@ struct machine *machine__new_kallsyms(void)
 	struct machine *machine = machine__new_host();
 	/*
 	 * FIXME:
-	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitely
+	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
 	 *    ask for not using the kcore parsing code, once this one is fixed
 	 *    to create a map per module.
 	 */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e86f8be89157..18a59fba97ff 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -692,7 +692,7 @@ static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
 		return ret;
 
 	for (i = 0; i < ntevs && ret >= 0; i++) {
-		/* point.address is the addres of point.symbol + point.offset */
+		/* point.address is the address of point.symbol + point.offset */
 		tevs[i].point.address -= stext;
 		tevs[i].point.module = strdup(exec);
 		if (!tevs[i].point.module) {
@@ -3062,7 +3062,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 	/*
 	 * Give it a '0x' leading symbol name.
 	 * In __add_probe_trace_events, a NULL symbol is interpreted as
-	 * invalud.
+	 * invalid.
 	 */
 	if (asprintf(&tp->symbol, "0x%lx", tp->address) < 0)
 		goto errout;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 047793528919..6c1a83768eb0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -37,7 +37,7 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
  * -t, --field-separator
  *
  * option, that uses a special separator character and don't pad with spaces,
- * replacing all occurances of this separator in symbol names (and other
+ * replacing all occurrences of this separator in symbol names (and other
  * output) with a '.' character, that thus it's the only non valid separator.
 */
 static int repsep_snprintf(char *bf, size_t size, const char *fmt, ...)
-- 
2.19.2
