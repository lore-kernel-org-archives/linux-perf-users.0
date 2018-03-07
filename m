From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH v2] perf annotate: Fix s390 target function disassembly
Date: Wed,  7 Mar 2018 14:43:25 +0100
Message-ID: <20180307134325.96106-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.  On s390 this results in an error
message 'The called function was not found.'

The function call assembly line parsing does not handle
the s390 bras and brasl instructions. Function call__parse
expects the target as first operand:
	callq	e9140 <__fxstat>
S390 has a register number as first operand:
	brasl	%r14,41d60 <abort>
Therefore the target addresses on s390 are always zero
which is an invalid address.

Introduce a s390 specific call parsing function which skips
the first operand on s390.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 53 +++++++++++++++++++++++++++-
 tools/perf/util/annotate.c                   |  2 +-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..0a3e39b5143d 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -1,6 +1,57 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 
+static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
+			    struct map *map)
+{
+	char *endptr, *tok, *name;
+	struct addr_map_symbol target = {
+		.map = map,
+	};
+
+	tok = strchr(ops->raw, ',');
+	if (!tok)
+		return -1;
+
+	ops->target.addr = strtoull(tok + 1, &endptr, 16);
+
+	name = strchr(endptr, '<');
+	if (name == NULL)
+		return -1;
+
+	name++;
+
+	if (arch->objdump.skip_functions_char &&
+	    strchr(name, arch->objdump.skip_functions_char))
+		return -1;
+
+	tok = strchr(name, '>');
+	if (tok == NULL)
+		return -1;
+
+	*tok = '\0';
+	ops->target.name = strdup(name);
+	*tok = '>';
+
+	if (ops->target.name == NULL)
+		return -1;
+	target.addr = map__objdump_2mem(map, ops->target.addr);
+
+	if (map_groups__find_ams(&target) == 0 &&
+	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.sym;
+
+	return 0;
+}
+
+static int call__scnprintf(struct ins *ins, char *bf, size_t size,
+			   struct ins_operands *ops);
+
+static struct ins_ops s390_call_ops = {
+	.parse	   = s390_call__parse,
+	.scnprintf = call__scnprintf,
+};
+
 static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
 {
 	struct ins_ops *ops = NULL;
@@ -14,7 +65,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	if (!strcmp(name, "bras") ||
 	    !strcmp(name, "brasl") ||
 	    !strcmp(name, "basr"))
-		ops = &call_ops;
+		ops = &s390_call_ops;
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 49ff825f745c..bc3302da702b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -248,7 +248,7 @@ static struct ins_ops call_ops = {
 
 bool ins__is_call(const struct ins *ins)
 {
-	return ins->ops == &call_ops;
+	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
 static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
-- 
2.14.3
