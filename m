From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 70/77] perf annotate: Handle arm64 move instructions
Date: Wed,  5 Sep 2018 19:04:33 -0300
Message-ID: <20180905220440.20256-71-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Add default handler for non-jump instructions.  This really only has an
effect on instructions that compute a PC-relative address, such as
'adrp,' as seen in these couple of examples:

BEFORE: adrp   x0, ffff20000aa11000 <kallsyms_token_index+0xce000>
AFTER:  adrp   x0, kallsyms_token_index+0xce000

BEFORE: adrp   x23, ffff20000ae94000 <__per_cpu_load>
AFTER:  adrp   x23, __per_cpu_load

The implementation is identical to that of s390, but with a slight
adjustment for objdump whitespace propagation (arm64 objdump puts spaces
after commas, whereas s390's presumably doesn't).

The mov__scnprintf() declaration is moved from s390's to arm64's
instructions.c because arm64's gets included before s390's.

Committer testing:

Ran 'perf annotate --stdio2 > /tmp/{before,after}' no diff.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20180827150807.304110d2e9919a17c832ca48@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 59 ++++++++++++++++++++++++++-
 tools/perf/arch/s390/annotate/instructions.c  |  2 -
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 6688977e4ac7..76c6345a57d5 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -8,6 +8,63 @@ struct arm64_annotate {
 		jump_insn;
 };
 
+static int arm64_mov__parse(struct arch *arch __maybe_unused,
+			    struct ins_operands *ops,
+			    struct map_symbol *ms __maybe_unused)
+{
+	char *s = strchr(ops->raw, ','), *target, *endptr;
+
+	if (s == NULL)
+		return -1;
+
+	*s = '\0';
+	ops->source.raw = strdup(ops->raw);
+	*s = ',';
+
+	if (ops->source.raw == NULL)
+		return -1;
+
+	target = ++s;
+	ops->target.raw = strdup(target);
+	if (ops->target.raw == NULL)
+		goto out_free_source;
+
+	ops->target.addr = strtoull(target, &endptr, 16);
+	if (endptr == target)
+		goto out_free_target;
+
+	s = strchr(endptr, '<');
+	if (s == NULL)
+		goto out_free_target;
+	endptr = strchr(s + 1, '>');
+	if (endptr == NULL)
+		goto out_free_target;
+
+	*endptr = '\0';
+	*s = ' ';
+	ops->target.name = strdup(s);
+	*s = '<';
+	*endptr = '>';
+	if (ops->target.name == NULL)
+		goto out_free_target;
+
+	return 0;
+
+out_free_target:
+	zfree(&ops->target.raw);
+out_free_source:
+	zfree(&ops->source.raw);
+	return -1;
+}
+
+static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops);
+
+static struct ins_ops arm64_mov_ops = {
+	.parse	   = arm64_mov__parse,
+	.scnprintf = mov__scnprintf,
+};
+
 static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arm64_annotate *arm = arch->priv;
@@ -21,7 +78,7 @@ static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
-		return NULL;
+		ops = &arm64_mov_ops;
 
 	arch__associate_ins_ops(arch, name, ops);
 	return ops;
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index cee4e2f7c057..de0dd66dbb48 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -100,8 +100,6 @@ static int s390_mov__parse(struct arch *arch __maybe_unused,
 	return -1;
 }
 
-static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops);
 
 static struct ins_ops s390_mov_ops = {
 	.parse	   = s390_mov__parse,
-- 
2.14.4
