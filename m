From: Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH] perf annotate: fix parsing aarch64 branch instructions
 after objdump update
Date: Thu, 23 Aug 2018 19:10:47 -0500
Message-ID: <20180823191047.9260992844205984b75e6721@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Robin Murphy <robin.murphy@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Ingo Molnar <mingo@redhat.com>Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, perf group <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Starting with binutils 2.28, aarch64 objdump adds comments to the
disassembly output to show the alternative names of a condition code [1].

It is assumed that commas in objdump comments could occur in other arches
now or in the future, so this fix is arch-independent.

The fix could have been done with arm64 specific jump__parse and
jump__scnprintf functions, but the jump__scnprintf instruction would
have to have its comment character be a literal, since the scnprintf
functions cannot receive a struct arch easily.

This inconvenience also applies to the generic jump__scnprintf, which
is why we add a raw_comment pointer to struct ins_operands, so the
__parse function assigns it to be re-used by its corresponding __scnprintf
function.

Example differences in 'perf annotate --stdio2' output on an
aarch64 perf.data file:

BEFORE: → b.cs   ffff200008133d1c <unwind_frame+0x18c>  // b.hs, dffff7ecc47b
AFTER : ↓ b.cs   18c

BEFORE: → b.cc   ffff200008d8d9cc <get_alloc_profile+0x31c>  // b.lo, b.ul, dffff727295b
AFTER : ↓ b.cc   31c

The branch target labels 18c and 31c also now appear in the output:

BEFORE:        add    x26, x29, #0x80
AFTER : 18c:   add    x26, x29, #0x80

BEFORE:        add    x21, x21, #0x8
AFTER : 31c:   add    x21, x21, #0x8

The Fixes: tag below is added so stable branches will get the update; it
doesn't necessarily mean that commit was broken at the time, rather it
didn't withstand the aarch64 objdump update.

Tested no difference in output for sample x86_64, power arch perf.data files.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=bb7eff5206e4795ac79c177a80fe9f4630aaf730

Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: b13bbeee5ee6 ("perf annotate: Fix branch instruction with multiple operands")
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/util/annotate.c | 17 ++++++++++++++++-
 tools/perf/util/annotate.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e32ead4744bd..b83897dafbb0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -282,7 +282,8 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
-static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms)
+static int jump__parse(struct arch *arch, struct ins_operands *ops,
+		       struct map_symbol *ms)
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
@@ -291,6 +292,15 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 	};
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
+
+	/*
+	 * Prevent from matching commas in the comment section, e.g.:
+	 * ffff200008446e70:       b.cs    ffff2000084470f4 <generic_exec_single+0x314>  // b.hs, b.nlast
+	 */
+	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	if (c && ops->raw_comment && c > ops->raw_comment)
+		c = NULL;
+
 	/*
 	 * Examples of lines to parse for the _cpp_lex_token@@Base
 	 * function:
@@ -367,6 +377,11 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
 	c = strchr(ops->raw, ',');
+
+	/* Prevent from matching commas in the comment section */
+	if (ops->raw_comment && c && c > ops->raw_comment)
+		c = NULL;
+
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 005a5fe8a8c6..5399ba2321bb 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -22,6 +22,7 @@ struct ins {
 
 struct ins_operands {
 	char	*raw;
+	char	*raw_comment;
 	struct {
 		char	*raw;
 		char	*name;
-- 
2.17.1
