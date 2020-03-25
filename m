From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/24] perf report: Support interactive annotation of code without symbols
Date: Wed, 25 Mar 2020 09:41:04 -0300
Message-ID: <20200325124124.32648-5-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For perf report on stripped binaries it is currently impossible to do
annotation. The annotation state is all tied to symbols, but there are
either no symbols, or symbols are not covering all the code.

We should support the annotation functionality even without symbols.

This patch fakes a symbol and the symbol name is the string of address.
After that, we just follow current annotation working flow.

For example,

1. perf report

  Overhead  Command  Shared Object     Symbol
    20.67%  div      libc-2.27.so      [.] __random_r
    17.29%  div      libc-2.27.so      [.] __random
    10.59%  div      div               [.] 0x0000000000000628
     9.25%  div      div               [.] 0x0000000000000612
     6.11%  div      div               [.] 0x0000000000000645

2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.

  Annotate 0x0000000000000628
  Zoom into div thread
  Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
  Browse map details
  Run scripts for samples of symbol [0x0000000000000628]
  Run scripts for all samples
  Switch to another data file in PWD
  Exit

3. Select the "Annotate 0x0000000000000628" and ENTER.

Percent│
       │
       │
       │     Disassembly of section .text:
       │
       │     0000000000000628 <.text+0x68>:
       │       divsd %xmm4,%xmm0
       │       divsd %xmm3,%xmm1
       │       movsd (%rsp),%xmm2
       │       addsd %xmm1,%xmm0
       │       addsd %xmm2,%xmm0
       │       movsd %xmm0,(%rsp)

Now we can see the dump of object starting from 0x628.

 v5:
 ---
 Remove the hotkey 'a' implementation from this patch. It
 will be moved to a separate patch.

 v4:
 ---
 1. Support the hotkey 'a'. When we press 'a' on address,
    now it supports the annotation.

 2. Change the patch title from
    "Support interactive annotation of code without symbols" to
    "perf report: Support interactive annotation of code without symbols"

 v3:
 ---
 Keep just the ANNOTATION_DUMMY_LEN, and remove the
 opts->annotate_dummy_len since it's the "maybe in future
 we will provide" feature.

 v2:
 ---
 Fix a crash issue when annotating an address in "unknown" object.

 The steps to reproduce this issue:

 perf record -e cycles:u ls
 perf report

    75.29%  ls       ld-2.27.so        [.] do_lookup_x
    23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
     1.04%  ls       [unknown]         [k] 0xffffffff85c01210
     0.03%  ls       ld-2.27.so        [.] _start

 When annotating 0xffffffff85c01210, the crash happens.

 v2 adds checking for ms->map in add_annotate_opt(). If the object is
 "unknown", ms->map is NULL.

Committer notes:

Renamed new_annotate_sym() to symbol__new_unresolved().

Use PRIx64 to fix this issue in some 32-bit arches:

  ui/browsers/hists.c: In function 'symbol__new_unresolved':
  ui/browsers/hists.c:2474:38: error: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
    snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
                                  ~~~~~~^                      ~~~~
                                  %-#.*llx

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200227043939.4403-3-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h     |  1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f36dee499320..d0f9745856fd 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,13 +2465,41 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
+static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
+{
+	struct annotated_source *src;
+	struct symbol *sym;
+	char name[64];
+
+	snprintf(name, sizeof(name), "%.*" PRIx64, BITS_PER_LONG / 4, addr);
+
+	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
+	if (sym) {
+		src = symbol__hists(sym, 1);
+		if (!src) {
+			symbol__delete(sym);
+			return NULL;
+		}
+
+		dso__insert_symbol(map->dso, sym);
+	}
+
+	return sym;
+}
+
 static int
 add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
-		 struct map_symbol *ms)
+		 struct map_symbol *ms,
+		 u64 addr)
 {
-	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
-	    symbol__annotation(ms->sym)->src == NULL)
+	if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
+		return 0;
+
+	if (!ms->sym)
+		ms->sym = symbol__new_unresolved(addr, ms->map);
+
+	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3219,17 +3247,20 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       &bi->from.ms);
+						       &bi->from.ms,
+						       bi->from.al_addr);
 			if (bi->to.ms.sym != bi->from.ms.sym)
 				nr_options += add_annotate_opt(browser,
 							&actions[nr_options],
 							&options[nr_options],
-							&bi->to.ms);
+							&bi->to.ms,
+							bi->to.al_addr);
 		} else {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       browser->selection);
+						       browser->selection,
+						       browser->he_selection->ip);
 		}
 skip_annotation:
 		nr_options += add_thread_opt(browser, &actions[nr_options],
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 07c775938d46..2d88069d6428 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -74,6 +74,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 #define ANNOTATION__CYCLES_WIDTH 6
 #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
 #define ANNOTATION__AVG_IPC_WIDTH 36
+#define ANNOTATION_DUMMY_LEN	256
 
 struct annotation_options {
 	bool hide_src_code,
-- 
2.21.1
