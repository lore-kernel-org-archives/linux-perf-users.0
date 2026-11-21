Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231284;
	b=RVf1TCHn+SH8+jIw4n7ZdBeK5VCOX883Kelk+01ZSsRTgq9DoHr48WHFxeDlPLHJQyvd
	 D+NPN517IgNKPC3P6MMIkLeMvF317GVc3L6M4g7/QJSeiuJCOKS2gtHNrwBX/iBsrTrco
	 C+Y7LmZqQXWNzLr3M2XNJfhE+zXSV91ST3BBEk3xZtORcwB2fVHphlKF+HHzUs5jKiII4
	 0X6ERNui/4X+t0GqNv34LsEt/fEaBKT4pbweWXvMgrx/y6iNlflSJ6mJ5mfQMDXywTwTu
	 3Yt9ycnKZEx8cTGgVnYe7JDTnzmmflW/5i5AiiSmGRi5XvtxEeZqFckzLiXROflbFPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cJWLLDGUmQ/zxlJgI7yFqb8t2H+oNChikglabrFq4Fc=;
	b=otBPylz0h3NWX6dAimtmD7yg4S4hzBUnKi4XPd1HPgY5RxmmnybzKWR5tSZUaT+sYeTw
	 BS2vWxGLrOMe2uCI5DfR0DXCAAiar5mZYp0DlmtNCP+F9WjefNHibA1R694bWBUBPwCQu
	 1jNv8wldZkI3UfqhKwsLBUb32HISp4I9sVqqhfCbwztoZntwa+04+vez2iidZo0p4syV3
	 XRcWufsMj1hs6rqHJv826toOHu0DRB52wSt7bJBWSeboo4O5EKIyq0X1GMq7sJFhr74vg
	 FozBiLW22ZWSfq/wrePAInmkH6XRKLrbGN7iwIxQv2Nu3kpte3N9vZEcQOfyZQsMw1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwqMVAZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338560A2609;
	Sat, 21 Nov 2026 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwqMVAZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A521F000C6;
	Sat, 21 Nov 2026 03:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231283;
	bh=cJWLLDGUmQ/zxlJgI7yFqb8t2H+oNChikglabrFq4Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZwqMVAZqky6/HOHH0cURX2oqaeM40RL3Cb4ZDL86gVV6D583yZRTPBGl4YDS1L9pY
	 0hC/4Y1cW4T0RmWQdhiDwnZAQYOYl1eHA2c9/JQd5nE70BL7xvKenlrCsev4ldHNpW
	 zSmcXRR4c2OtxXLNa9fCjs2JewN4oLlk349AbWRToAWAprYKdS6ZJ7GGwGpP/6bp8S
	 /JhYyIw1q5lGOkhhI8+C46rmB9KdN+bI5hCpztvXoptmQJa5OjUINqfe7TWe/e7KE8
	 qIjMr4UaqtGsKqswmXw8R7CQjLYg+iHcq+/ans2pEIkUhwSAXto+aGoUDQxj3ic1Gm
	 7aexnOmwoL2qw==
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
Subject: [PATCH v10 07/16] perf tests: Exercise the x86 operand parser
Date: Sat, 21 Nov 2026 00:20:43 -0300
Message-ID: <20261121032052.1392234-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

Add a unit test for the x86 operand parser covering the absolute
addressing and movabs forms the data type resolver handles.  The cases
are the instructions from the allmodconfig clang build quoted in the two
fixes.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/annotate-ops.c | 127 ++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 130 insertions(+)
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
index 0000000000000000..1c73433fbac67d85
--- /dev/null
+++ b/tools/perf/tests/annotate-ops.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The x86 operand parser: what is a memory reference and where it points.
+ *
+ * The absolute addressing forms are the ones perf annotate's data type
+ * resolver has to follow, and the ones it must not mistake for a data
+ * access: a direct branch target and an immediate.
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
+/* Real disassembly of a movabs, through the instruction's own parser */
+static const char *movabs_lines[][2] = {
+	{ "movabsq", "$-0x2000040000000000, %r15 # imm = 0xDFFFFC0000000000" },
+	{ "movabs",  "$0xdfffffc000000000,%r15" },
+};
+
+static int check_movabs(const struct arch *arch, const char *name, const char *ops)
+{
+	struct disasm_line dl = { .ins = { .name = name } };
+	struct annotated_insn_loc loc;
+	int ret = TEST_FAIL;
+
+	dl.ops.raw = strdup(ops);
+	if (dl.ops.raw == NULL)
+		return TEST_FAIL;
+
+	dl.ins.ops = ins__find(arch, name, &dl);
+	if (dl.ins.ops != &mov_ops || dl.ins.ops->parse(arch, &dl.ops, NULL, &dl) < 0) {
+		pr_debug("'%s %s': not parsed as a mov\n", name, ops);
+		goto out;
+	}
+
+	if (annotate_get_insn_location(arch, &dl, &loc) == 0 &&
+	    !loc.ops[INSN_OP_SOURCE].mem_ref && loc.ops[INSN_OP_SOURCE].imm &&
+	    loc.ops[INSN_OP_TARGET].reg1 != -1)
+		ret = TEST_OK;
+	else
+		pr_debug("'%s %s': not an immediate to a register\n", name, ops);
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
+	size_t i;
+	int ret = 0;
+
+	if (arch == NULL)
+		return TEST_FAIL;
+
+	for (i = 0; i < ARRAY_SIZE(op_cases); i++)
+		ret |= check_operand(arch, &op_cases[i]);
+
+	for (i = 0; i < ARRAY_SIZE(movabs_lines); i++)
+		ret |= check_movabs(arch, movabs_lines[i][0], movabs_lines[i][1]);
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
-- 
2.56.0

