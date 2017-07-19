From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/86] perf annotate: Implement visual marker for macro fusion
Date: Wed, 19 Jul 2017 10:55:53 -0300
Message-ID: <20170719135717.1285-3-acme@kernel.org>
References: <20170719135717.1285-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719135717.1285-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For marking fused instructions clearly this patch adds a line before the
first instruction of pair and joins it with the arrow of the jump to its
target.

For example, when "je" is selected in annotate view, the line before
cmpl is displayed and joins the arrow of "je".

       │   ┌──cmpl   $0x0,argp_program_version_hook
 81.93 │   ├──je     20
       │   │  lock   cmpxchg %esi,0x38a9a4(%rip)
       │   │↓ jne    29
       │   │↓ jmp    43
 11.47 │20:└─→cmpxch %esi,0x38a999(%rip)

That means the cmpl+je is a fused instruction pair and they should be
considered together.

Changelog:

v3: Use Arnaldo's fix to improve the arrow origin rendering.  To get the
    evsel->evlist->env->cpuid, save the evsel in annotate_browser.

v2: new function "ins__is_fused" to check if the instructions are fused.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1499403995-19857-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c           | 29 +++++++++++++++++++++++++++++
 tools/perf/ui/browser.h           |  2 ++
 tools/perf/ui/browsers/annotate.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/annotate.c        |  5 +++++
 tools/perf/util/annotate.h        |  1 +
 5 files changed, 63 insertions(+)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 83874b0e266c..f73f3f13e01d 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -738,6 +738,35 @@ void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
 		__ui_browser__line_arrow_down(browser, column, start, end);
 }
 
+void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
+			    unsigned int row, bool arrow_down)
+{
+	unsigned int end_row;
+
+	if (row >= browser->top_idx)
+		end_row = row - browser->top_idx;
+	else
+		return;
+
+	SLsmg_set_char_set(1);
+
+	if (arrow_down) {
+		ui_browser__gotorc(browser, end_row, column - 1);
+		SLsmg_write_char(SLSMG_ULCORN_CHAR);
+		ui_browser__gotorc(browser, end_row, column);
+		SLsmg_draw_hline(2);
+		ui_browser__gotorc(browser, end_row + 1, column - 1);
+		SLsmg_write_char(SLSMG_LTEE_CHAR);
+	} else {
+		ui_browser__gotorc(browser, end_row, column - 1);
+		SLsmg_write_char(SLSMG_LTEE_CHAR);
+		ui_browser__gotorc(browser, end_row, column);
+		SLsmg_draw_hline(2);
+	}
+
+	SLsmg_set_char_set(0);
+}
+
 void ui_browser__init(void)
 {
 	int i = 0;
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index be3b70eb5fca..a12eff75638b 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -43,6 +43,8 @@ void ui_browser__printf(struct ui_browser *browser, const char *fmt, ...);
 void ui_browser__write_graph(struct ui_browser *browser, int graph);
 void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
 			      u64 start, u64 end);
+void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
+			    unsigned int row, bool arrow_down);
 void __ui_browser__show_title(struct ui_browser *browser, const char *title);
 void ui_browser__show_title(struct ui_browser *browser, const char *title);
 int ui_browser__show(struct ui_browser *browser, const char *title,
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c4336138b673..8d3f6f53c122 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -273,6 +273,25 @@ static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sy
 	return true;
 }
 
+static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
+{
+	struct disasm_line *pos = list_prev_entry(cursor, node);
+	const char *name;
+
+	if (!pos)
+		return false;
+
+	if (ins__is_lock(&pos->ins))
+		name = pos->ops.locked.ins.name;
+	else
+		name = pos->ins.name;
+
+	if (!name || !cursor->ins.name)
+		return false;
+
+	return ins__is_fused(ab->arch, name, cursor->ins.name);
+}
+
 static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
@@ -308,6 +327,13 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser, pcnt_width + 2 + ab->addr_width,
 				 from, to);
+
+	if (is_fused(ab, cursor)) {
+		ui_browser__mark_fused(browser,
+				       pcnt_width + 3 + ab->addr_width,
+				       from - 1,
+				       to > from ? true : false);
+	}
 }
 
 static unsigned int annotate_browser__refresh(struct ui_browser *browser)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8748ebb3f932..ef434b53d849 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -517,6 +517,11 @@ bool ins__is_ret(const struct ins *ins)
 	return ins->ops == &ret_ops;
 }
 
+bool ins__is_lock(const struct ins *ins)
+{
+	return ins->ops == &lock_ops;
+}
+
 static int ins__key_cmp(const void *name, const void *insp)
 {
 	const struct ins *ins = insp;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 72d72728a0fc..bac698d7cc6a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -52,6 +52,7 @@ struct ins_ops {
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
+bool ins__is_lock(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
-- 
2.9.4
