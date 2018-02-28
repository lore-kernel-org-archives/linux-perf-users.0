From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf annotate: Remove s390 basr instruction from call table
Date: Wed, 28 Feb 2018 14:33:08 +0100
Message-ID: <20180228133309.15758-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf annotate displays function call assembler instructions
with a right arrow. Hitting enter on this line/instruction
causes the browser to disassemble this target function and
show it on the screen.

S390 assembler instruction 'basr %r1,%r2'
jumps to address stored in register 2. Since the
target address is unknown to perf it can not be handled.

Therefore remove the right arrow from such an instruction
as the target function can not be identified.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..05f53bd092d4 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -12,8 +12,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 		ops = &jump_ops;
 	/* override call/returns */
 	if (!strcmp(name, "bras") ||
-	    !strcmp(name, "brasl") ||
-	    !strcmp(name, "basr"))
+	    !strcmp(name, "brasl"))
 		ops = &call_ops;
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
-- 
2.14.3
