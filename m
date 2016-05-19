From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 3/7] pref annotate: Separate architecture specific annotation support
Date: Thu, 19 May 2016 17:59:47 +0100
Message-ID: <c7d0aa5a6a8579dc6960adbf9c9e5791a1596241.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36369 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbcESRAj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 13:00:39 -0400
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>

Currently the list of instructions recognised by perf annotate
contains an intermingled mix of x86 and ARM instructions, and the x86
instructions are unconditionally included on all platforms. This means
that perf attempts to parse x86 instructions on non-x86 platforms.
Refactor the instruction list into per-architecture header files so that
only the instructions applicable to the target architecture are parsed.

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
 tools/perf/arch/arm/include/annotate_ins.h |  25 +++++++
 tools/perf/arch/x86/include/annotate_ins.h |  82 ++++++++++++++++++++++
 tools/perf/config/Makefile                 |  11 +++
 tools/perf/util/annotate.c                 | 105 +++--------------------------
 tools/perf/util/annotate_ins.h             |  10 +++
 5 files changed, 136 insertions(+), 97 deletions(-)
 create mode 100644 tools/perf/arch/arm/include/annotate_ins.h
 create mode 100644 tools/perf/arch/x86/include/annotate_ins.h
 create mode 100644 tools/perf/util/annotate_ins.h

diff --git a/tools/perf/arch/arm/include/annotate_ins.h b/tools/perf/arch/arm/include/annotate_ins.h
new file mode 100644
index 0000000..e8ea98d
--- /dev/null
+++ b/tools/perf/arch/arm/include/annotate_ins.h
@@ -0,0 +1,25 @@
+#ifndef ARCH_ANNOTATE_INS_H
+#define ARCH_ANNOTATE_INS_H
+
+#define ARCH_INSTRUCTIONS { \
+	{ .name = "add",   .ops  = &mov_ops, }, \
+	{ .name = "and",   .ops  = &mov_ops, }, \
+	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */ \
+	{ .name = "bcc",   .ops  = &jump_ops, }, \
+	{ .name = "bcs",   .ops  = &jump_ops, }, \
+	{ .name = "beq",   .ops  = &jump_ops, }, \
+	{ .name = "bge",   .ops  = &jump_ops, }, \
+	{ .name = "bgt",   .ops  = &jump_ops, }, \
+	{ .name = "bhi",   .ops  = &jump_ops, }, \
+	{ .name = "bl",    .ops  = &call_ops, }, \
+	{ .name = "bls",   .ops  = &jump_ops, }, \
+	{ .name = "blt",   .ops  = &jump_ops, }, \
+	{ .name = "blx",   .ops  = &call_ops, }, \
+	{ .name = "bne",   .ops  = &jump_ops, }, \
+	{ .name = "cmp",   .ops  = &mov_ops, }, \
+	{ .name = "mov",   .ops  = &mov_ops, }, \
+	{ .name = "nop",   .ops  = &nop_ops, }, \
+	{ .name = "orr",   .ops  = &mov_ops, }, \
+	}
+
+#endif /* ARCH_ANNOTATE_INS_H */
diff --git a/tools/perf/arch/x86/include/annotate_ins.h b/tools/perf/arch/x86/include/annotate_ins.h
new file mode 100644
index 0000000..179b50e
--- /dev/null
+++ b/tools/perf/arch/x86/include/annotate_ins.h
@@ -0,0 +1,82 @@
+#ifndef ARCH_ANNOTATE_INS_H
+#define ARCH_ANNOTATE_INS_H
+
+#define ARCH_INSTRUCTIONS { \
+	{ .name = "add",     .ops  = &mov_ops, }, \
+	{ .name = "addl",    .ops  = &mov_ops, }, \
+	{ .name = "addq",    .ops  = &mov_ops, }, \
+	{ .name = "addw",    .ops  = &mov_ops, }, \
+	{ .name = "and",     .ops  = &mov_ops, }, \
+	{ .name = "bts",     .ops  = &mov_ops, }, \
+	{ .name = "call",    .ops  = &call_ops, }, \
+	{ .name = "callq",   .ops  = &call_ops, }, \
+	{ .name = "cmp",     .ops  = &mov_ops, }, \
+	{ .name = "cmpb",    .ops  = &mov_ops, }, \
+	{ .name = "cmpl",    .ops  = &mov_ops, }, \
+	{ .name = "cmpq",    .ops  = &mov_ops, }, \
+	{ .name = "cmpw",    .ops  = &mov_ops, }, \
+	{ .name = "cmpxch",  .ops  = &mov_ops, }, \
+	{ .name = "dec",     .ops  = &dec_ops, }, \
+	{ .name = "decl",    .ops  = &dec_ops, }, \
+	{ .name = "imul",    .ops  = &mov_ops, }, \
+	{ .name = "inc",     .ops  = &dec_ops, }, \
+	{ .name = "incl",    .ops  = &dec_ops, }, \
+	{ .name = "ja",	     .ops  = &jump_ops, }, \
+	{ .name = "jae",     .ops  = &jump_ops, }, \
+	{ .name = "jb",	     .ops  = &jump_ops, }, \
+	{ .name = "jbe",     .ops  = &jump_ops, }, \
+	{ .name = "jc",	     .ops  = &jump_ops, }, \
+	{ .name = "jcxz",    .ops  = &jump_ops, }, \
+	{ .name = "je",	     .ops  = &jump_ops, }, \
+	{ .name = "jecxz",   .ops  = &jump_ops, }, \
+	{ .name = "jg",	     .ops  = &jump_ops, }, \
+	{ .name = "jge",     .ops  = &jump_ops, }, \
+	{ .name = "jl",      .ops  = &jump_ops, }, \
+	{ .name = "jle",     .ops  = &jump_ops, }, \
+	{ .name = "jmp",     .ops  = &jump_ops, }, \
+	{ .name = "jmpq",    .ops  = &jump_ops, }, \
+	{ .name = "jna",     .ops  = &jump_ops, }, \
+	{ .name = "jnae",    .ops  = &jump_ops, }, \
+	{ .name = "jnb",     .ops  = &jump_ops, }, \
+	{ .name = "jnbe",    .ops  = &jump_ops, }, \
+	{ .name = "jnc",     .ops  = &jump_ops, }, \
+	{ .name = "jne",     .ops  = &jump_ops, }, \
+	{ .name = "jng",     .ops  = &jump_ops, }, \
+	{ .name = "jnge",    .ops  = &jump_ops, }, \
+	{ .name = "jnl",     .ops  = &jump_ops, }, \
+	{ .name = "jnle",    .ops  = &jump_ops, }, \
+	{ .name = "jno",     .ops  = &jump_ops, }, \
+	{ .name = "jnp",     .ops  = &jump_ops, }, \
+	{ .name = "jns",     .ops  = &jump_ops, }, \
+	{ .name = "jnz",     .ops  = &jump_ops, }, \
+	{ .name = "jo",	     .ops  = &jump_ops, }, \
+	{ .name = "jp",	     .ops  = &jump_ops, }, \
+	{ .name = "jpe",     .ops  = &jump_ops, }, \
+	{ .name = "jpo",     .ops  = &jump_ops, }, \
+	{ .name = "jrcxz",   .ops  = &jump_ops, }, \
+	{ .name = "js",	     .ops  = &jump_ops, }, \
+	{ .name = "jz",	     .ops  = &jump_ops, }, \
+	{ .name = "lea",     .ops  = &mov_ops, }, \
+	{ .name = "lock",    .ops  = &lock_ops, }, \
+	{ .name = "mov",     .ops  = &mov_ops, }, \
+	{ .name = "movb",    .ops  = &mov_ops, }, \
+	{ .name = "movdqa",  .ops  = &mov_ops, }, \
+	{ .name = "movl",    .ops  = &mov_ops, }, \
+	{ .name = "movq",    .ops  = &mov_ops, }, \
+	{ .name = "movslq",  .ops  = &mov_ops, }, \
+	{ .name = "movzbl",  .ops  = &mov_ops, }, \
+	{ .name = "movzwl",  .ops  = &mov_ops, }, \
+	{ .name = "nop",     .ops  = &nop_ops, }, \
+	{ .name = "nopl",    .ops  = &nop_ops, }, \
+	{ .name = "nopw",    .ops  = &nop_ops, }, \
+	{ .name = "or",      .ops  = &mov_ops, }, \
+	{ .name = "orl",     .ops  = &mov_ops, }, \
+	{ .name = "test",    .ops  = &mov_ops, }, \
+	{ .name = "testb",   .ops  = &mov_ops, }, \
+	{ .name = "testl",   .ops  = &mov_ops, }, \
+	{ .name = "xadd",    .ops  = &mov_ops, }, \
+	{ .name = "xbeginl", .ops  = &jump_ops, }, \
+	{ .name = "xbeginq", .ops  = &jump_ops, }, \
+	}
+
+#endif /* ARCH_ANNOTATE_INS_H */
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 1e46277..d3eba89 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -22,6 +22,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,ARCH)
 
 NO_PERF_REGS := 1
+NO_ANNOTATE_INS := 1
 
 # Additional ARCH settings for x86
 ifeq ($(ARCH),x86)
@@ -35,10 +36,12 @@ ifeq ($(ARCH),x86)
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
   endif
   NO_PERF_REGS := 0
+  NO_ANNOTATE_INS := 0
 endif
 
 ifeq ($(ARCH),arm)
   NO_PERF_REGS := 0
+  NO_ANNOTATE_INS := 0
   LIBUNWIND_LIBS = -lunwind -lunwind-arm
 endif
 
@@ -51,6 +54,10 @@ ifeq ($(NO_PERF_REGS),0)
   $(call detected,CONFIG_PERF_REGS)
 endif
 
+ifeq ($(NO_ANNOTATE_INS),0)
+  $(call detected,CONFIG_ANNOTATE_INS)
+endif
+
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
@@ -83,6 +90,10 @@ ifeq ($(NO_PERF_REGS),0)
   CFLAGS += -DHAVE_PERF_REGS_SUPPORT
 endif
 
+ifeq ($(NO_ANNOTATE_INS),0)
+  CFLAGS += -DHAVE_ANNOTATE_INS_SUPPORT
+endif
+
 # for linking with debug library, run like:
 # make DEBUG=1 LIBDW_DIR=/opt/libdw/
 ifdef LIBDW_DIR
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 619bc27..71c1dd5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -20,6 +20,7 @@
 #include <regex.h>
 #include <pthread.h>
 #include <linux/bitops.h>
+#include "annotate_ins.h"
 
 const char 	*disassembler_style;
 const char	*objdump_path;
@@ -107,7 +108,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s *%" PRIx64, ins->name, ops->target.addr);
 }
 
-static struct ins_ops call_ops = {
+static struct ins_ops call_ops __maybe_unused = {
 	.parse	   = call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -137,7 +138,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
 }
 
-static struct ins_ops jump_ops = {
+static struct ins_ops jump_ops __maybe_unused = {
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
 };
@@ -230,7 +231,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static struct ins_ops lock_ops = {
+static struct ins_ops lock_ops __maybe_unused = {
 	.free	   = lock__delete,
 	.parse	   = lock__parse,
 	.scnprintf = lock__scnprintf,
@@ -298,7 +299,7 @@ static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops mov_ops = {
+static struct ins_ops mov_ops __maybe_unused = {
 	.parse	   = mov__parse,
 	.scnprintf = mov__scnprintf,
 };
@@ -339,7 +340,7 @@ static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops dec_ops = {
+static struct ins_ops dec_ops __maybe_unused = {
 	.parse	   = dec__parse,
 	.scnprintf = dec__scnprintf,
 };
@@ -350,101 +351,11 @@ static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s", "nop");
 }
 
-static struct ins_ops nop_ops = {
+static struct ins_ops nop_ops __maybe_unused = {
 	.scnprintf = nop__scnprintf,
 };
 
-static struct ins instructions[] = {
-	{ .name = "add",   .ops  = &mov_ops, },
-	{ .name = "addl",  .ops  = &mov_ops, },
-	{ .name = "addq",  .ops  = &mov_ops, },
-	{ .name = "addw",  .ops  = &mov_ops, },
-	{ .name = "and",   .ops  = &mov_ops, },
-#ifdef __arm__
-	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
-	{ .name = "bcc",   .ops  = &jump_ops, },
-	{ .name = "bcs",   .ops  = &jump_ops, },
-	{ .name = "beq",   .ops  = &jump_ops, },
-	{ .name = "bge",   .ops  = &jump_ops, },
-	{ .name = "bgt",   .ops  = &jump_ops, },
-	{ .name = "bhi",   .ops  = &jump_ops, },
-	{ .name = "bl",    .ops  = &call_ops, },
-	{ .name = "bls",   .ops  = &jump_ops, },
-	{ .name = "blt",   .ops  = &jump_ops, },
-	{ .name = "blx",   .ops  = &call_ops, },
-	{ .name = "bne",   .ops  = &jump_ops, },
-#endif
-	{ .name = "bts",   .ops  = &mov_ops, },
-	{ .name = "call",  .ops  = &call_ops, },
-	{ .name = "callq", .ops  = &call_ops, },
-	{ .name = "cmp",   .ops  = &mov_ops, },
-	{ .name = "cmpb",  .ops  = &mov_ops, },
-	{ .name = "cmpl",  .ops  = &mov_ops, },
-	{ .name = "cmpq",  .ops  = &mov_ops, },
-	{ .name = "cmpw",  .ops  = &mov_ops, },
-	{ .name = "cmpxch", .ops  = &mov_ops, },
-	{ .name = "dec",   .ops  = &dec_ops, },
-	{ .name = "decl",  .ops  = &dec_ops, },
-	{ .name = "imul",  .ops  = &mov_ops, },
-	{ .name = "inc",   .ops  = &dec_ops, },
-	{ .name = "incl",  .ops  = &dec_ops, },
-	{ .name = "ja",	   .ops  = &jump_ops, },
-	{ .name = "jae",   .ops  = &jump_ops, },
-	{ .name = "jb",	   .ops  = &jump_ops, },
-	{ .name = "jbe",   .ops  = &jump_ops, },
-	{ .name = "jc",	   .ops  = &jump_ops, },
-	{ .name = "jcxz",  .ops  = &jump_ops, },
-	{ .name = "je",	   .ops  = &jump_ops, },
-	{ .name = "jecxz", .ops  = &jump_ops, },
-	{ .name = "jg",	   .ops  = &jump_ops, },
-	{ .name = "jge",   .ops  = &jump_ops, },
-	{ .name = "jl",    .ops  = &jump_ops, },
-	{ .name = "jle",   .ops  = &jump_ops, },
-	{ .name = "jmp",   .ops  = &jump_ops, },
-	{ .name = "jmpq",  .ops  = &jump_ops, },
-	{ .name = "jna",   .ops  = &jump_ops, },
-	{ .name = "jnae",  .ops  = &jump_ops, },
-	{ .name = "jnb",   .ops  = &jump_ops, },
-	{ .name = "jnbe",  .ops  = &jump_ops, },
-	{ .name = "jnc",   .ops  = &jump_ops, },
-	{ .name = "jne",   .ops  = &jump_ops, },
-	{ .name = "jng",   .ops  = &jump_ops, },
-	{ .name = "jnge",  .ops  = &jump_ops, },
-	{ .name = "jnl",   .ops  = &jump_ops, },
-	{ .name = "jnle",  .ops  = &jump_ops, },
-	{ .name = "jno",   .ops  = &jump_ops, },
-	{ .name = "jnp",   .ops  = &jump_ops, },
-	{ .name = "jns",   .ops  = &jump_ops, },
-	{ .name = "jnz",   .ops  = &jump_ops, },
-	{ .name = "jo",	   .ops  = &jump_ops, },
-	{ .name = "jp",	   .ops  = &jump_ops, },
-	{ .name = "jpe",   .ops  = &jump_ops, },
-	{ .name = "jpo",   .ops  = &jump_ops, },
-	{ .name = "jrcxz", .ops  = &jump_ops, },
-	{ .name = "js",	   .ops  = &jump_ops, },
-	{ .name = "jz",	   .ops  = &jump_ops, },
-	{ .name = "lea",   .ops  = &mov_ops, },
-	{ .name = "lock",  .ops  = &lock_ops, },
-	{ .name = "mov",   .ops  = &mov_ops, },
-	{ .name = "movb",  .ops  = &mov_ops, },
-	{ .name = "movdqa",.ops  = &mov_ops, },
-	{ .name = "movl",  .ops  = &mov_ops, },
-	{ .name = "movq",  .ops  = &mov_ops, },
-	{ .name = "movslq", .ops  = &mov_ops, },
-	{ .name = "movzbl", .ops  = &mov_ops, },
-	{ .name = "movzwl", .ops  = &mov_ops, },
-	{ .name = "nop",   .ops  = &nop_ops, },
-	{ .name = "nopl",  .ops  = &nop_ops, },
-	{ .name = "nopw",  .ops  = &nop_ops, },
-	{ .name = "or",    .ops  = &mov_ops, },
-	{ .name = "orl",   .ops  = &mov_ops, },
-	{ .name = "test",  .ops  = &mov_ops, },
-	{ .name = "testb", .ops  = &mov_ops, },
-	{ .name = "testl", .ops  = &mov_ops, },
-	{ .name = "xadd",  .ops  = &mov_ops, },
-	{ .name = "xbeginl", .ops  = &jump_ops, },
-	{ .name = "xbeginq", .ops  = &jump_ops, },
-};
+static struct ins instructions[] = ARCH_INSTRUCTIONS;
 
 static int ins__key_cmp(const void *name, const void *insp)
 {
diff --git a/tools/perf/util/annotate_ins.h b/tools/perf/util/annotate_ins.h
new file mode 100644
index 0000000..2ec9a05
--- /dev/null
+++ b/tools/perf/util/annotate_ins.h
@@ -0,0 +1,10 @@
+#ifndef __ANNOTATE_INS_H
+#define __ANNOTATE_INS_H
+
+#ifdef HAVE_ANNOTATE_INS_SUPPORT
+#include <annotate_ins.h>
+#else
+#define ARCH_INSTRUCTIONS { }
+#endif
+
+#endif /* __ANNOTATE_INS_H */
-- 
2.1.4
