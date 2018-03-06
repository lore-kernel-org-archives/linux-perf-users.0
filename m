From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH Resent] perf annotate: Fix s390 target function disassembly
Date: Tue,  6 Mar 2018 13:39:55 +0100
Message-ID: <20180306123955.98802-1-tmricht@linux.vnet.ibm.com>
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

Fix this by skipping the first operand on s390.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 49ff825f745c..feb6006b676d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -192,6 +192,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
 	};
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
+	if (!strcmp(arch->name, "s390")) {
+		/* s390 function call 1st operand is register */
+		tok = strchr(ops->raw, ',');
+		if (tok)
+			ops->target.addr = strtoull(tok + 1, &endptr, 16);
+		else
+			ops->target.addr = 0;
+	} else
+		ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
 	name = strchr(endptr, '<');
 	if (name == NULL)
-- 
2.14.3
