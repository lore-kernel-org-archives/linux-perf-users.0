Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138358;
	b=TXxyWLExSH4fuJpgxkyuh3MCSaIRAKx/vz77SBUGOcfFyW8fkx7uBU6wHpcP6ZgfYV1q
	 m7WZydhvsJ4mi7/6YCi8hXz/jev5aRBWG71KvPApKZjSNhEgOfe/oIctAu2wuSeGKcZBB
	 8xsPo5D06Cg2JoMIGUOKtt4duYoXAoSbkiJT4fVDhkIuIq/bnUt+Pms59w/J3trp2Bgel
	 M2HTZKMvsmXCHiT+qoLDW1rXZbl/EJ6GeLXd4ktVxX5KQmcYvTZn6zDrR23E/mWU1xQ8f
	 R0wL2fW3jwVcLRDexy58DBzkDHVYE5dgeBoy787fR0ViJn/AjlWbH+xYJ53Idy4+Bzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pKM2Cj4pXtJz2GbRPk5FCCusCrCaLFSUzIN0+g/j7Nw=;
	b=JMXR8nsIpBdOi3kP1Z9Zvz+/XDc0JZedhRxoAOHakkNx24noShGRA83d5A545gk2Wx4T
	 LKZkP+YA++bIIWnL47mG67cjSA5Cyn82MKHucGSFFz7yDHEsBYnA5iPPPCLy9+qeezYbR
	 wKmGK089T2SMScVBlBjHaovW5qacuQ+4219n1WkrGqf500TzFrgnGiV8cBYtri/UHyIQ1
	 53l6fbKB/TJUvZIWBc2Zzwk267TN3EJqtuW0hWd/5q7RB1AexoVfTZ0W5CXbSW9GQ8CTZ
	 wGXR1L6oX6SVOkHil/TNWAHgupmoq21oG8VtlIWeiNLIzjUwCpMN1DVuEBkM50kM7Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBY+M8Jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F7606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBY+M8Jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274601F000C4;
	Fri, 20 Nov 2026 01:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138358;
	bh=pKM2Cj4pXtJz2GbRPk5FCCusCrCaLFSUzIN0+g/j7Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBY+M8JcPlD1o1VM4uxr9/wSYOTb5i9YS4Ht+UAOC4oReSX/RwNnPwaTI4ThEeV1D
	 6+CWl4ERaIN3stGPzBetvaEsBdEz9yyy83K8H6+4Bgi8q6OBVoJ2lfISgHT6b05GMf
	 yhGhc0tdjdeLxhLBrnFJ2MbPQUh8oopoLoDLXrFXSih6hBzYHhQaA9dK9ue4Fya1J5
	 DDGxmlFOBmTPphXXLjk/e+gQIF+34zcefrEyOGCPswYrbwSmYhUgf7AMzi1gs74FOo
	 SMR1vNzOYOQFtvufacljLHICP59o89sPD+8SQ4AobdIr9Jp9SAdb6dTE/KzWoLia+0
	 jGz4Oyyp+XSng==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 03/13] perf annotate: Handle absolute addressing in data type profiling
Date: Thu, 19 Nov 2026 22:31:58 -0300
Message-ID: <20261120013211.1510-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

x86 accesses globals with absolute addresses, and not only in 32-bit
builds: the 64-bit kernel's __default_send_IPI_dest_field does it with a
disp32 that the CPU sign extends, an absolute SIB with no base and no
index, not a RIP-relative access.  From an allmodconfig clang build,
arch/x86/kernel/ipi.o:

  890:	8b 04 25 00 c3 5f ff	mov    0xffffffffff5fc300,%eax
  8b1:	89 3c 25 10 c3 5f ff	mov    %edi,0xffffffffff5fc310

llvm-objdump prints the same two displacements as -0xa03d00 and
-0xa03cf0.

The operand parser only recognized the offset(reg) forms, so such an
operand had no memory reference and the resolver skipped it as not a
memory access.

Parse a bare hex number as an absolute memory operand, including the
negative disp32 the LLVM disassembler prints for values that do not fit
an int, and use the address in the resolver.  Direct jump and call
targets are left out, as LLVM prints their address with the same 0x;
loop* is not a jump in the instruction table, so it is left out by name.
A movabs takes a full 64-bit address and is kept only when the sign
extended int offset gives it back exactly.  The displacement is sign
extended for 64-bit objects, as the CPU does, and zero extended for
32-bit ones.  Values that do not fit, zero and the operands of
relocatable objects, which are unrelocated addends, are skipped.

Let the instruction tracking record the type of an absolute global load
in the destination register: with a variable at the address the type
resolves, and the register gets its value, not its address:

  401196:	movq	0x404078, %rax		# data-type: struct conn +0x8 (bytes)

so the state is TSR_KIND_TYPE; a POINTER state records the address
itself.

With bare numbers being memory operands, a frame base register of -1,
"none", would also compare equal to the -1 "no register" of an absolute
operand and take it for a stack access, so guard those comparisons.
Operands left with no register, like a user space "%gs:imm", are no
longer looked up as variables, which can change the data type stats of
those samples.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                       |  1 +
 tools/perf/tests/annotate-ops.c              | 93 ++++++++++++++++++++
 tools/perf/tests/builtin-test.c              |  1 +
 tools/perf/tests/tests.h                     |  1 +
 tools/perf/util/annotate-arch/annotate-x86.c | 48 ++++++++--
 tools/perf/util/annotate.c                   | 27 +++++-
 tools/perf/util/annotate.h                   |  7 ++
 7 files changed, 170 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/tests/annotate-ops.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5eebb2ec5ddefcfd..c7edd8569bbccb06 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -2,6 +2,7 @@
 
 perf-test-y += builtin-test.o
 perf-test-y += tests-scripts.o
+perf-test-y += annotate-ops.o
 perf-test-y += parse-events.o
 perf-test-y += uncore-event-sorting.o
 perf-test-y += dso-data.o
diff --git a/tools/perf/tests/annotate-ops.c b/tools/perf/tests/annotate-ops.c
new file mode 100644
index 0000000000000000..9a5222b1ceceaa47
--- /dev/null
+++ b/tools/perf/tests/annotate-ops.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The x86 operand parser: what is a memory reference and where it points.
+ *
+ * The absolute addressing forms are the ones perf annotate's data type
+ * resolver has to follow, and the ones it must not mistake for a data
+ * access: a direct branch target, an immediate and a 64-bit movabs that
+ * does not survive the int offset.
+ */
+#include <elf.h>
+#include <linux/compiler.h>
+#include <stdlib.h>
+#include <string.h>
+#include "annotate.h"
+#include "debug.h"
+#include "disasm.h"
+#include "tests.h"
+
+struct op_case {
+	const char		*insn;
+	const struct ins_ops	*ops;
+	const char		*operand;
+	enum annotated_insn_ops	which;
+	bool			mem_ref;
+	int			offset;
+};
+
+static struct op_case op_cases[] = {
+	/* 32-bit absolute, and the 64-bit sign extended disp32 both ways */
+	{ "mov",    &mov_ops,  "0x8c73448",		INSN_OP_SOURCE, true,  0x8c73448 },
+	{ "mov",    &mov_ops,  "0xffffffffff5fc300",	INSN_OP_SOURCE, true,  -0xa03d00 },
+	{ "mov",    &mov_ops,  "-0xa03d00",		INSN_OP_SOURCE, true,  -0xa03d00 },
+	/* An immediate and a direct branch target, with the same 0x */
+	{ "mov",    &mov_ops,  "$0x10",			INSN_OP_SOURCE, false, 0 },
+	{ "call",   &call_ops, "0x401020",		INSN_OP_TARGET, false, 0 },
+	{ "jmp",    &jump_ops, "0x401020",		INSN_OP_TARGET, false, 0 },
+	{ "loop",   NULL,      "0x401020",		INSN_OP_TARGET, false, 0 },
+	/* A 64-bit absolute: kept only when the int offset is exact */
+	{ "movabs", NULL,      "0x80001000",		INSN_OP_SOURCE, false, 0 },
+	{ "movabs", NULL,      "0x1000",		INSN_OP_SOURCE, true,  0x1000 },
+};
+
+static int check_operand(const struct arch *arch, const struct op_case *c)
+{
+	struct disasm_line dl = {
+		.ins = { .name = c->insn, .ops = c->ops },
+	};
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *op;
+	int ret = 0;
+
+	if (c->which == INSN_OP_TARGET)
+		dl.ops.target.raw = (char *)c->operand;
+	else
+		dl.ops.source.raw = (char *)c->operand;
+
+	if (annotate_get_insn_location(arch, &dl, &loc) < 0)
+		return TEST_FAIL;
+
+	op = &loc.ops[c->which];
+	if (op->mem_ref != c->mem_ref) {
+		pr_debug("'%s %s': mem_ref %d, expected %d\n", c->insn,
+			 c->operand, op->mem_ref, c->mem_ref);
+		ret = TEST_FAIL;
+	}
+	if (op->mem_ref && op->offset != c->offset) {
+		pr_debug("'%s %s': offset %#x, expected %#x\n", c->insn,
+			 c->operand, op->offset, c->offset);
+		ret = TEST_FAIL;
+	}
+
+	return ret;
+}
+
+static int test__annotate_ops(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	struct e_machine_and_e_flags id = { .e_machine = EM_X86_64, };
+	const struct arch *arch = arch__new_x86(&id, NULL);
+	size_t i;
+	int ret = 0;
+
+	if (arch == NULL)
+		return TEST_FAIL;
+
+	for (i = 0; i < ARRAY_SIZE(op_cases); i++)
+		ret |= check_operand(arch, &op_cases[i]);
+
+	free((void *)arch);
+	return ret;
+}
+
+DEFINE_SUITE("Annotate operand parsing", annotate_ops);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 01c78ef20b97dec9..a27baf3a819ccf36 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -117,6 +117,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__openat_syscall_event_on_all_cpus,
 	&suite__basic_mmap,
 	&suite__mem,
+	&suite__annotate_ops,
 	&suite__parse_events,
 	&suite__uncore_event_sorting,
 	&suite__expr,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af822885890dda73..963cb34acd345153 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -153,6 +153,7 @@ DECLARE_SUITE(sample_parsing);
 DECLARE_SUITE(keep_tracking);
 DECLARE_SUITE(parse_no_sample_id_all);
 DECLARE_SUITE(dwarf_unwind);
+DECLARE_SUITE(annotate_ops);
 DECLARE_SUITE(expr);
 DECLARE_SUITE(hists_filter);
 DECLARE_SUITE(mmap_thread_lookup);
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index e38a4e7a54d5585c..03c32032cde0c905 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <stdlib.h>
+#include <limits.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
@@ -230,6 +231,11 @@ static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
 	return die_get_real_type(&func_die, type_die) != NULL;
 }
 
+static bool is_stack_or_fb_reg(struct type_state *state, int fbreg, int reg)
+{
+	return (fbreg != -1 && reg == fbreg) || reg == state->stack_reg;
+}
+
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
@@ -437,7 +443,7 @@ static void update_insn_state_x86(struct type_state *state,
 		invalidate_reg_state(tsr);
 
 		/* Case 1: Based on stack pointer or frame pointer */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -626,7 +632,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 retry:
 		/* Check stack variables with offset */
-		if (sreg == fbreg || sreg == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -717,13 +723,17 @@ static void update_insn_state_x86(struct type_state *state,
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/* Or check if it's a global variable */
-		else if (sreg == DWARF_REG_PC) {
+		else if (sreg == DWARF_REG_PC ||
+			 annotated_op_loc__is_abs(src, map__dso(dloc->ms->map))) {
 			struct map_symbol *ms = dloc->ms;
 			u64 ip = ms->sym->start + dl->al.offset;
 			u64 addr;
 			int offset;
 
-			addr = annotate_calc_pcrel(ms, ip, src->offset, dl);
+			if (sreg == DWARF_REG_PC)
+				addr = annotate_calc_pcrel(ms, ip, src->offset, dl);
+			else
+				addr = annotated_op_loc__abs_addr(src, map__dso(ms->map));
 
 			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
 						 &type_die) ||
@@ -737,7 +747,7 @@ static void update_insn_state_x86(struct type_state *state,
 			tsr->offset = 0;
 			tsr->ok = true;
 
-			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
+			pr_debug_dtp("mov [%x] global addr=%#"PRIx64" -> reg%d",
 				     insn_offset, addr, dst->reg1);
 			pr_debug_type_name(&type_die, tsr->kind);
 		}
@@ -827,7 +837,7 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 3. register to memory transfers */
 	if (!src->mem_ref && dst->mem_ref) {
 		/* Check stack variables with offset */
-		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
+		if (is_stack_or_fb_reg(state, fbreg, dst->reg1)) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
@@ -931,7 +941,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 }
 
 static void extract_op_location_x86(const struct arch *arch,
-				    struct disasm_line *dl __maybe_unused,
+				    struct disasm_line *dl,
 				    const char *op_str, int op_idx __maybe_unused,
 				    struct annotated_op_loc *op_loc)
 {
@@ -960,6 +970,30 @@ static void extract_op_location_x86(const struct arch *arch,
 			op_loc->offset = strtol(s + 1, &p, 0);
 			if (p && p != s + 1)
 				op_loc->imm = true;
+		} else if ((*s == '-' || strstarts(s, "0x")) &&
+			   !ins__is_call(&dl->ins) && !ins__is_jump(&dl->ins) &&
+			   strncmp(dl->ins.name, "loop", 4)) {
+			bool neg = *s == '-';
+			bool movabs = !strncmp(dl->ins.name, "movabs", 6);
+			u64 offset = strtoull(s + neg, NULL, 0);
+			bool exact;
+
+			if (neg)
+				offset = -offset;
+			/*
+			 * The offset is an int: a disp32 fits it as a u32 or,
+			 * sign extended, as an int, which is how the LLVM
+			 * disassembler prints one that does not fit an int.
+			 * A movabs takes a full 64-bit address, keep only the
+			 * values the sign extension gives back exactly.
+			 */
+			exact = (s64)(int)offset == (s64)offset;
+			if (offset != 0 && (movabs ? exact :
+					    (offset <= UINT_MAX || exact))) {
+				/* An absolute address: 32-bit code, or a 64-bit disp32 */
+				op_loc->mem_ref = true;
+				op_loc->offset = offset;
+			}
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 66d3453e7ffd0d5d..61ee6a3b2fa91d57 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2755,6 +2755,21 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
 	return reg < 0 ? -1 : reg;
 }
 
+/* A relocatable object's operand is an unrelocated addend, not an address */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc,
+			      const struct dso *dso)
+{
+	return !dso__rel(dso) && op_loc->mem_ref && op_loc->reg1 == -1 && op_loc->reg2 == -1 &&
+	       op_loc->segment == INSN_SEG_NONE && op_loc->offset != 0;
+}
+
+/* The disp32 of a 64-bit object is sign extended, a 32-bit one is not */
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso)
+{
+	return dso__is_64_bit(dso) ? (u64)(s64)op_loc->offset : (u32)op_loc->offset;
+}
+
 /**
  * annotate_get_insn_location - Get location of instruction
  * @arch: the architecture info
@@ -2772,7 +2787,7 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str)
  *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
  *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 1, src_offset = 0x18
  *                       # dst_reg1 = r8, dst_mem = 0
  *
  *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, src_multi_regs = 0
@@ -3046,6 +3061,13 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
 							    op_loc->offset, dl);
 		}
+		/* An absolute address: 32-bit code, or a 64-bit disp32 */
+		else if (annotated_op_loc__is_abs(op_loc, map__dso(ms->map))) {
+			struct dso *dso = map__dso(ms->map);
+
+			dloc.var_addr = annotated_op_loc__abs_addr(op_loc, dso);
+			op_loc->reg1 = DWARF_REG_PC;
+		}
 
 		/* This CPU access in kernel - pretend PC-relative addressing */
 		if (dso__kernel(map__dso(ms->map)) && arch__is_x86(arch) &&
@@ -3054,6 +3076,9 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			op_loc->reg1 = DWARF_REG_PC;
 		}
 
+		if (op_loc->reg1 == -1)
+			continue;
+
 		mem_type = find_data_type(&dloc);
 
 		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index bc2237609d6e16e8..dc4fc8b1b320c1fb 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -18,6 +18,7 @@
 #include "branch.h"
 #include "evsel.h"
 
+struct dso;
 struct hist_browser_timer;
 struct hist_entry;
 struct map;
@@ -637,6 +638,12 @@ struct annotated_insn_loc {
 	     i < INSN_OP_MAX;						\
 	     i++, op_loc++)
 
+/* Bare number operand: an absolute address, as 32-bit code and the kernel use */
+bool annotated_op_loc__is_abs(const struct annotated_op_loc *op_loc,
+			      const struct dso *dso);
+u64 annotated_op_loc__abs_addr(const struct annotated_op_loc *op_loc,
+			       const struct dso *dso);
+
 /* Get detailed location info in the instruction */
 int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
-- 
2.56.1

