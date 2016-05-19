From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 7/7] perf annotate: AArch64 support
Date: Thu, 19 May 2016 17:59:51 +0100
Message-ID: <5f8ec2e742a7a8639152a59af1615a59dfe1a3bb.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Add basic support to recognise AArch64 assembly. This allows perf to
identify AArch64 instructions that branch to other parts within the
same function, thereby properly annotating them.

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
 tools/perf/arch/arm64/include/annotate_ins.h | 40 ++++++++++++++++++++++++++++
 tools/perf/arch/arm64/util/Build             |  2 ++
 tools/perf/arch/arm64/util/annotate_ins.c    | 21 +++++++++++++++
 tools/perf/config/Makefile                   |  1 +
 4 files changed, 64 insertions(+)
 create mode 100644 tools/perf/arch/arm64/include/annotate_ins.h
 create mode 100644 tools/perf/arch/arm64/util/annotate_ins.c

diff --git a/tools/perf/arch/arm64/include/annotate_ins.h b/tools/perf/arch/arm64/include/annotate_ins.h
new file mode 100644
index 0000000..50a5771
--- /dev/null
+++ b/tools/perf/arch/arm64/include/annotate_ins.h
@@ -0,0 +1,40 @@
+#ifndef ARCH_ANNOTATE_INS_H
+#define ARCH_ANNOTATE_INS_H
+
+#define ARCH_INSTRUCTIONS { \
+	{ .name = "add",   .ops  = &mov_ops, }, \
+	{ .name = "and",   .ops  = &mov_ops, }, \
+	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */ \
+	{ .name = "b.al",  .ops  = &jump_ops, }, \
+	{ .name = "b.cc",  .ops  = &jump_ops, }, \
+	{ .name = "b.cs",  .ops  = &jump_ops, }, \
+	{ .name = "b.eq",  .ops  = &jump_ops, }, \
+	{ .name = "b.ge",  .ops  = &jump_ops, }, \
+	{ .name = "b.gt",  .ops  = &jump_ops, }, \
+	{ .name = "b.hi",  .ops  = &jump_ops, }, \
+	{ .name = "b.hs",  .ops  = &jump_ops, }, \
+	{ .name = "b.le",  .ops  = &jump_ops, }, \
+	{ .name = "b.lo",  .ops  = &jump_ops, }, \
+	{ .name = "b.ls",  .ops  = &jump_ops, }, \
+	{ .name = "b.lt",  .ops  = &jump_ops, }, \
+	{ .name = "b.mi",  .ops  = &jump_ops, }, \
+	{ .name = "b.ne",  .ops  = &jump_ops, }, \
+	{ .name = "b.nv",  .ops  = &jump_ops, }, \
+	{ .name = "b.pl",  .ops  = &jump_ops, }, \
+	{ .name = "b.vc",  .ops  = &jump_ops, }, \
+	{ .name = "b.vs",  .ops  = &jump_ops, }, \
+	{ .name = "bl",    .ops  = &call_ops, }, \
+	{ .name = "blr",   .ops  = &call_ops, }, \
+	{ .name = "cbnz",  .ops  = &jump_ops, }, \
+	{ .name = "cbz",   .ops  = &jump_ops, }, \
+	{ .name = "cmp",   .ops  = &mov_ops, }, \
+	{ .name = "mov",   .ops  = &mov_ops, }, \
+	{ .name = "nop",   .ops  = &nop_ops, }, \
+	{ .name = "orr",   .ops  = &mov_ops, }, \
+	{ .name = "tbnz",  .ops  = &jump_ops, }, \
+	{ .name = "tbz",   .ops  = &jump_ops, }, \
+	}
+
+#define ARCH_ACTIONS "Actions are only available for 'ret' & branch instructions."
+
+#endif /* ARCH_ANNOTATE_INS_H */
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index e58123a8..10c78ba 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,2 +1,4 @@
+libperf-y     += annotate_ins.o
+
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/arm64/util/annotate_ins.c b/tools/perf/arch/arm64/util/annotate_ins.c
new file mode 100644
index 0000000..eba36b4
--- /dev/null
+++ b/tools/perf/arch/arm64/util/annotate_ins.c
@@ -0,0 +1,21 @@
+#include <string.h>
+#include <linux/compiler.h>
+#include <util/annotate_ins.h>
+
+bool arch_is_return_ins(const char *s __maybe_unused)
+{
+	return !strcmp(s, "ret");
+}
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
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index d3eba89..47b26c9 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -47,6 +47,7 @@ endif
 
 ifeq ($(ARCH),arm64)
   NO_PERF_REGS := 0
+  NO_ANNOTATE_INS := 0
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
-- 
2.1.4
