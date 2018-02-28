From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf annotate: Fix s390 target function disassembly
Date: Wed, 28 Feb 2018 14:33:09 +0100
Message-ID: <20180228133309.15758-2-tmricht@linux.vnet.ibm.com>
References: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.  On s390 this results in an error
message 'symbol not found'.

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
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28b233c3dcbe..5a90aa88076d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -188,7 +188,13 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
 {
 	char *endptr, *tok, *name;
 
-	ops->target.addr = strtoull(ops->raw, &endptr, 16);
+	if (!strcmp(arch->name, "s390")) {
+		ops->target.addr =  0;
+		tok = strchr(ops->raw, ',');
+		if (tok)
+			ops->target.addr = strtoull(tok + 1, &endptr, 16);
+	} else
+		ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
 	name = strchr(endptr, '<');
 	if (name == NULL)
-- 
2.14.3
