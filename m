From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 5/7] perf annotate: Architecture neutral handling of return instruction
Date: Thu, 19 May 2016 17:59:49 +0100
Message-ID: <1ba05f8c702e41157a270889126cc012cc7d96e6.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Currently perf annotate is hard coded to look for the x86 'retq'
instruction when annotating disassembly, regardless of the target
architecture. Move architecture specific processing of return
instructions into per-architecture header files.

Signed-off-by: Chris Ryder <chris.ryder@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/perf/arch/arm/util/annotate_ins.c |  7 +++++++
 tools/perf/arch/x86/util/annotate_ins.c |  5 +++++
 tools/perf/ui/browsers/annotate.c       | 13 +++++++------
 tools/perf/util/annotate_ins.c          |  5 +++++
 tools/perf/util/annotate_ins.h          |  3 +++
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/annotate_ins.c b/tools/perf/arch/arm/util/annotate_ins.c
index 87fc691..7ed4603 100644
--- a/tools/perf/arch/arm/util/annotate_ins.c
+++ b/tools/perf/arch/arm/util/annotate_ins.c
@@ -1,6 +1,13 @@
 #include <string.h>
 #include <util/annotate_ins.h>
 
+#include <linux/compiler.h>
+
+bool arch_is_return_ins(const char *s __maybe_unused)
+{
+	return false;
+}
+
 char *arch_parse_mov_comment(const char *s)
 {
 	return strchr(s, ';');
diff --git a/tools/perf/arch/x86/util/annotate_ins.c b/tools/perf/arch/x86/util/annotate_ins.c
index b007cd3..58aa4fa 100644
--- a/tools/perf/arch/x86/util/annotate_ins.c
+++ b/tools/perf/arch/x86/util/annotate_ins.c
@@ -1,6 +1,11 @@
 #include <string.h>
 #include <util/annotate_ins.h>
 
+bool arch_is_return_ins(const char *s)
+{
+	return !strcmp(s, "retq");
+}
+
 char *arch_parse_mov_comment(const char *s)
 {
 	return strchr(s, '#');
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4fc208e..6816faf 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -8,6 +8,7 @@
 #include "../../util/sort.h"
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
+#include "../../util/annotate_ins.h"
 #include <pthread.h>
 
 struct disasm_line_samples {
@@ -226,11 +227,11 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 				ui_browser__write_nstring(browser, " ", 2);
 			}
 		} else {
-			if (strcmp(dl->name, "retq")) {
-				ui_browser__write_nstring(browser, " ", 2);
-			} else {
+			if (arch_is_return_ins(dl->name)) {
 				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
 				SLsmg_write_char(' ');
+			} else {
+				ui_browser__write_nstring(browser, " ", 2);
 			}
 		}
 
@@ -843,9 +844,9 @@ show_help:
 			else if (browser->selection->offset == -1)
 				ui_helpline__puts("Actions are only available for assembly lines.");
 			else if (!browser->selection->ins) {
-				if (strcmp(browser->selection->name, "retq"))
-					goto show_sup_ins;
-				goto out;
+				if (arch_is_return_ins(browser->selection->name))
+					goto out;
+				goto show_sup_ins;
 			} else if (!(annotate_browser__jump(browser) ||
 				     annotate_browser__callq(browser, evsel, hbt))) {
 show_sup_ins:
diff --git a/tools/perf/util/annotate_ins.c b/tools/perf/util/annotate_ins.c
index 3867545..bb8fd01 100644
--- a/tools/perf/util/annotate_ins.c
+++ b/tools/perf/util/annotate_ins.c
@@ -3,6 +3,11 @@
 #include <linux/compiler.h>
 #include <util/annotate_ins.h>
 
+bool arch_is_return_ins(const char *s __maybe_unused)
+{
+	return false;
+}
+
 char *arch_parse_mov_comment(const char *s __maybe_unused)
 {
 	return NULL;
diff --git a/tools/perf/util/annotate_ins.h b/tools/perf/util/annotate_ins.h
index a80f493..15ac482 100644
--- a/tools/perf/util/annotate_ins.h
+++ b/tools/perf/util/annotate_ins.h
@@ -1,6 +1,9 @@
 #ifndef __ANNOTATE_INS_H
 #define __ANNOTATE_INS_H
 
+#include <linux/types.h>
+
+extern bool arch_is_return_ins(const char *s);
 extern char *arch_parse_mov_comment(const char *s);
 extern char *arch_parse_call_target(char *t);
 
-- 
2.1.4
