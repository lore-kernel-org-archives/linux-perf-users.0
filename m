From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 4/7] perf annotate: Separate out architecture specific parsing
Date: Thu, 19 May 2016 17:59:48 +0100
Message-ID: <feffa5182f3557fee56764f58def7ba1216bf6a2.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Currently call__parse and mov__parse contain #ifdefs for ARM specific
parsing. Move the architecture specific parsing into the
per-architecture annotate_ins.h files.

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
 tools/perf/arch/arm/util/Build          |  2 ++
 tools/perf/arch/arm/util/annotate_ins.c | 15 +++++++++++++++
 tools/perf/arch/x86/util/Build          |  1 +
 tools/perf/arch/x86/util/annotate_ins.c | 12 ++++++++++++
 tools/perf/util/Build                   |  1 +
 tools/perf/util/annotate.c              | 17 +++++++----------
 tools/perf/util/annotate_ins.c          | 16 ++++++++++++++++
 tools/perf/util/annotate_ins.h          |  3 +++
 8 files changed, 57 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/annotate_ins.c
 create mode 100644 tools/perf/arch/x86/util/annotate_ins.c
 create mode 100644 tools/perf/util/annotate_ins.c

diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index d22e3d0..61e4591 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,3 +1,5 @@
+libperf-y += annotate_ins.o
+
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 
 libperf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
diff --git a/tools/perf/arch/arm/util/annotate_ins.c b/tools/perf/arch/arm/util/annotate_ins.c
new file mode 100644
index 0000000..87fc691
--- /dev/null
+++ b/tools/perf/arch/arm/util/annotate_ins.c
@@ -0,0 +1,15 @@
+#include <string.h>
+#include <util/annotate_ins.h>
+
+char *arch_parse_mov_comment(const char *s)
+{
+	return strchr(s, ';');
+}
+
+char *arch_parse_call_target(char *t)
+{
+	if (strchr(t, '+'))
+		return NULL;
+
+	return t;
+}
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 4659703..b7e6dfe 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -3,6 +3,7 @@ libperf-y += tsc.o
 libperf-y += pmu.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += annotate_ins.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/annotate_ins.c b/tools/perf/arch/x86/util/annotate_ins.c
new file mode 100644
index 0000000..b007cd3
--- /dev/null
+++ b/tools/perf/arch/x86/util/annotate_ins.c
@@ -0,0 +1,12 @@
+#include <string.h>
+#include <util/annotate_ins.h>
+
+char *arch_parse_mov_comment(const char *s)
+{
+	return strchr(s, '#');
+}
+
+char *arch_parse_call_target(char *t)
+{
+	return t;
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8c6c8a0..8a1dd33 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,5 +1,6 @@
 libperf-y += alias.o
 libperf-y += annotate.o
+libperf-y += annotate_ins.o
 libperf-y += build-id.o
 libperf-y += config.o
 libperf-y += ctype.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 71c1dd5..ba04704 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -66,16 +66,16 @@ static int call__parse(struct ins_operands *ops)
 
 	name++;
 
-#ifdef __arm__
-	if (strchr(name, '+'))
-		return -1;
-#endif
-
 	tok = strchr(name, '>');
 	if (tok == NULL)
 		return -1;
 
 	*tok = '\0';
+
+	name = arch_parse_call_target(name);
+	if (name == NULL)
+		return -1;
+
 	ops->target.name = strdup(name);
 	*tok = '>';
 
@@ -252,11 +252,8 @@ static int mov__parse(struct ins_operands *ops)
 		return -1;
 
 	target = ++s;
-#ifdef __arm__
-	comment = strchr(s, ';');
-#else
-	comment = strchr(s, '#');
-#endif
+
+	comment = arch_parse_mov_comment(s);
 
 	if (comment != NULL)
 		s = comment - 1;
diff --git a/tools/perf/util/annotate_ins.c b/tools/perf/util/annotate_ins.c
new file mode 100644
index 0000000..3867545
--- /dev/null
+++ b/tools/perf/util/annotate_ins.c
@@ -0,0 +1,16 @@
+#ifndef HAVE_ANNOTATE_INS_SUPPORT
+
+#include <linux/compiler.h>
+#include <util/annotate_ins.h>
+
+char *arch_parse_mov_comment(const char *s __maybe_unused)
+{
+	return NULL;
+}
+
+char *arch_parse_call_target(char *t)
+{
+	return t;
+}
+
+#endif /* !HAVE_ANNOTATE_INS_SUPPORT */
diff --git a/tools/perf/util/annotate_ins.h b/tools/perf/util/annotate_ins.h
index 2ec9a05..a80f493 100644
--- a/tools/perf/util/annotate_ins.h
+++ b/tools/perf/util/annotate_ins.h
@@ -1,6 +1,9 @@
 #ifndef __ANNOTATE_INS_H
 #define __ANNOTATE_INS_H
 
+extern char *arch_parse_mov_comment(const char *s);
+extern char *arch_parse_call_target(char *t);
+
 #ifdef HAVE_ANNOTATE_INS_SUPPORT
 #include <annotate_ins.h>
 #else
-- 
2.1.4
