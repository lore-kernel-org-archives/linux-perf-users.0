Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471258;
	b=45HvCfEj+xn0jMJJi10irE0GOhn5opzMqR2eWZWwzIZg9+sEv/+QPqKWPQX/A1QI1TNK
	 B26ikC8Xl+vRbYO4uhBcwbg3F+mW0gFsypk4/1jpmw7iv3xcpnDSLBwlI3XU6VFUwCIqi
	 SjyVlJVJa0Yz6YgK/iWGJXCdVK6c6duhz8bBlw+mgMneVUUuj8BtQ0YQPskmaoGgB1fQ2
	 Y7jNqzdq5t6c5cllqkiUn95HRtHs+9dzIL/HFnwOYZek4nEcTYfKKSNZkjz1K57JkiNKR
	 BIhzVVyYjlTiP2Fa0vaiswPv/E4rmYn13UW6P0tfZnQdz7YOi1WVsD5DsY5ovttP8qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471258;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qH7xXsAwU9CECAgj7c7iuRWnGoutWALTqN+OXYtTjXc=;
	b=gIHdRDj+M91zw8egqPSkbUJgHwvrg97sd7wqDJvs032sN4nCUczDCY3EjZkyg5uoFaci
	 ZqylY2IT7rWif/3E7jNcKTyFbiFb5ODnBcduJFxJdM4NbepQdH4k4pYuUQtoPA/wXgjAw
	 DWEDrhuTU0Rvnj6PcTqiNEU/g2L5BRloW+bTS/6NehtKn92HZ59H/WBDoYy+Q8kndVgcM
	 3BlgLGmux77ySWl6YXtWrZgr3ujlaMDpukNQ71bgkMPPGzLaxMgSO+j3pHYnoOd0I7hRe
	 dG+GLR+/AQwgJm5L4y+K43Z9AvMGeiprE76uZtGZpQjodLOoI5uWf2/W0xxjaV609jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oThvgs2E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B8606A332;
	Mon, 23 Nov 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oThvgs2E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43231F000CA;
	Mon, 23 Nov 2026 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471258;
	bh=qH7xXsAwU9CECAgj7c7iuRWnGoutWALTqN+OXYtTjXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oThvgs2EZgV9vQN72S0Y5HNeH0n3rWDWN8sufuLtKQWm0KUWzCBwiyaYNstoWy24U
	 yOQYSF6cnL006rr6NzWXJYPdAanwvxkurGzAoNVrOpzJ7nWSHaI3QQZrIbT+YawQHo
	 wo2JHzhsqZDCLcBHV+UIyvg35qNrJgIfYPE+nb3JtnzfzQtgPkhO7UvhpYLUaDNXdq
	 WAlGXSWM+UCqxSO2jaZYWETB/8+tcX+1EtjG3Ol2P0MuRrEV4EFbBmzLpqcJPvRcsV
	 e7TNWPZkoqgfsvNF9+ihq8tcDCKmQ+YN6A+wDNn/D38syO/tFZvDuZqgFE2+BW0EG4
	 JuaD02xMy3A8Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 08/19] perf test: Exercise the x86 operand parser
Date: Mon, 23 Nov 2026 19:00:13 -0300
Message-ID: <20261123220024.14891-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

Add a unit test for x86 operand parsing.  The 64-bit absolute disp32
and movabs cases are from the allmodconfig clang build in the preceding
changes.  Also check a 32-bit absolute address, an immediate, and
values that should not become absolute addresses.  Both objdump
spellings of the movabs instruction must yield the KASAN shadow offset.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/annotate-ops.c | 172 ++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 175 insertions(+)
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
index 0000000000000000..766126fc2e2f5e98
--- /dev/null
+++ b/tools/perf/tests/annotate-ops.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The x86 operand parser: what is a memory reference and where it points.
+ *
+ * The data type resolver follows absolute memory operands; an immediate
+ * is not a memory reference.
+ */
+#include <elf.h>
+#include <linux/compiler.h>
+#include <stdlib.h>
+#include <string.h>
+#include "annotate.h"
+#include "debug.h"
+#include "dso.h"
+#include "disasm.h"
+#include "tests.h"
+
+struct op_case {
+	const char		*insn;
+	const struct ins_ops	*ops;
+	const char		*operand;
+	bool			mem_ref;
+	int			offset;
+};
+
+static struct op_case op_cases[] = {
+	/* 32-bit absolute, and the 64-bit sign extended disp32 both ways */
+	{ "mov",    &mov_ops,  "0x8c73448",		true,  0x8c73448 },
+	{ "mov",    &mov_ops,  "0xffffffffff5fc300",	true,  -0xa03d00 },
+	{ "mov",    &mov_ops,  "-0xa03d00",		true,  -0xa03d00 },
+	/* An immediate is not a memory reference */
+	{ "mov",    &mov_ops,  "$0x10",			false, 0 },
+	/* Zero and values wider than a disp32 are not absolute addresses. */
+	{ "mov",    &mov_ops,  "0x0",			false, 0 },
+	{ "mov",    &mov_ops,  "0x100000000",		false, 0 },
+};
+
+static int check_operand(const struct arch *arch, const struct op_case *c,
+			 struct dso *dso64, struct dso *dso32, struct dso *dsorel)
+{
+	struct disasm_line dl = {
+		.ins = { .name = c->insn, .ops = c->ops },
+	};
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *op;
+	int ret = 0;
+
+	dl.ops.source.raw = (char *)c->operand;
+
+	if (annotate_get_insn_location(arch, &dl, &loc) < 0)
+		return TEST_FAIL;
+
+	op = &loc.ops[INSN_OP_SOURCE];
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
+	if (c->mem_ref &&
+	    (!annotated_op_loc__is_abs(op, dso64) ||
+	     !annotated_op_loc__is_abs(op, dso32) ||
+	     annotated_op_loc__abs_addr(op, dso64) != (u64)(s64)c->offset ||
+	     annotated_op_loc__abs_addr(op, dso32) != (u32)c->offset)) {
+		pr_debug("'%s %s': wrong absolute address\n", c->insn, c->operand);
+		ret = TEST_FAIL;
+	}
+	/* The same operand in a relocatable object is an addend, not an address */
+	if (c->mem_ref && annotated_op_loc__is_abs(op, dsorel)) {
+		pr_debug("'%s %s': absolute address in a relocatable object\n",
+			 c->insn, c->operand);
+		ret = TEST_FAIL;
+	}
+
+	return ret;
+}
+
+struct movabs_case {
+	const char	*name;
+	const char	*operand;
+	s64		imm;
+};
+
+/* The KASAN shadow offset movabs, as both disassemblers print it */
+static const struct movabs_case movabs_cases[] = {
+	{ "movabsq", "$-0x2000040000000000, %r15 # imm = 0xDFFFFC0000000000",
+	  -0x2000040000000000LL },
+	{ "movabs",  "$0xdffffc0000000000,%r15", -0x2000040000000000LL },
+};
+
+static int check_movabs(const struct arch *arch, const struct movabs_case *c)
+{
+	struct disasm_line dl = { .ins = { .name = c->name } };
+	struct annotated_insn_loc loc;
+	int ret = TEST_FAIL;
+
+	dl.ops.raw = strdup(c->operand);
+	if (dl.ops.raw == NULL)
+		return TEST_FAIL;
+
+	dl.ins.ops = ins__find(arch, c->name, &dl);
+	if (dl.ins.ops != &mov_ops || dl.ins.ops->parse(arch, &dl.ops, NULL, &dl) < 0) {
+		pr_debug("'%s %s': not parsed as a mov\n", c->name, c->operand);
+		goto out;
+	}
+
+	/*
+	 * get_dwarf_regnum() is a stub returning -1 when perf is built
+	 * without libdw, the target register cannot be resolved then.
+	 */
+#ifdef HAVE_LIBDW_SUPPORT
+	if (annotate_get_insn_location(arch, &dl, &loc) == 0 &&
+	    !loc.ops[INSN_OP_SOURCE].mem_ref && loc.ops[INSN_OP_SOURCE].imm &&
+	    loc.ops[INSN_OP_SOURCE].imm_value == c->imm &&
+	    loc.ops[INSN_OP_TARGET].reg1 != -1)
+#else
+	if (annotate_get_insn_location(arch, &dl, &loc) == 0 &&
+	    !loc.ops[INSN_OP_SOURCE].mem_ref && loc.ops[INSN_OP_SOURCE].imm &&
+	    loc.ops[INSN_OP_SOURCE].imm_value == c->imm)
+#endif
+		ret = TEST_OK;
+	else
+		pr_debug("'%s %s': not an immediate to a register\n",
+			 c->name, c->operand);
+out:
+	free(dl.ops.source.raw);
+	free(dl.ops.target.raw);
+	free(dl.ops.raw);
+	return ret;
+}
+
+static int test__annotate_ops(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	struct e_machine_and_e_flags id = { .e_machine = EM_X86_64, };
+	const struct arch *arch = arch__new_x86(&id, NULL);
+	struct dso *dso64 = dso__new("annotate-ops-64");
+	struct dso *dso32 = dso__new("annotate-ops-32");
+	struct dso *dsorel = dso__new("annotate-ops-rel");
+	size_t i;
+	int ret = 0;
+
+	if (arch == NULL || dso64 == NULL || dso32 == NULL || dsorel == NULL) {
+		dso__put(dso64);
+		dso__put(dso32);
+		dso__put(dsorel);
+		free((void *)arch);
+		return TEST_FAIL;
+	}
+
+	dso__set_is_64_bit(dso64, true);
+	dso__set_is_64_bit(dso32, false);
+	dso__set_rel(dsorel, ET_REL);
+
+	for (i = 0; i < ARRAY_SIZE(op_cases); i++)
+		ret |= check_operand(arch, &op_cases[i], dso64, dso32, dsorel);
+
+	for (i = 0; i < ARRAY_SIZE(movabs_cases); i++)
+		ret |= check_movabs(arch, &movabs_cases[i]);
+
+	dso__put(dso64);
+	dso__put(dso32);
+	dso__put(dsorel);
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
-- 
2.56.0

