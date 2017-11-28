From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/30] perf annotate: Do not truncate instruction names at 6 chars
Date: Tue, 28 Nov 2017 12:01:59 -0300
Message-ID: <20171128150220.5064-10-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

There are many instructions, esp on PowerPC, whose mnemonics are longer
than 6 characters. Using precision limit causes truncation of such
mnemonics.

Fix this by removing precision limit. Note that, 'width' is still 6, so
alignment won't get affected for length <= 6.

Before:

   li     r11,-1
   xscvdp vs1,vs1
   add.   r10,r10,r11

After:

  li     r11,-1
  xscvdpsxds vs1,vs1
  add.   r10,r10,r11

Reported-by: Donald Stence <dstence@us.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/20171114032540.4564-1-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index da1c4c4a0dd8..3369c7830260 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -165,7 +165,7 @@ static void ins__delete(struct ins_operands *ops)
 static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 			      struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s", ins->name, ops->raw);
+	return scnprintf(bf, size, "%-6s %s", ins->name, ops->raw);
 }
 
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
@@ -230,12 +230,12 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
 	if (ops->target.name)
-		return scnprintf(bf, size, "%-6.6s %s", ins->name, ops->target.name);
+		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
 
 	if (ops->target.addr == 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
-	return scnprintf(bf, size, "%-6.6s *%" PRIx64, ins->name, ops->target.addr);
+	return scnprintf(bf, size, "%-6s *%" PRIx64, ins->name, ops->target.addr);
 }
 
 static struct ins_ops call_ops = {
@@ -299,7 +299,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			c++;
 	}
 
-	return scnprintf(bf, size, "%-6.6s %.*s%" PRIx64,
+	return scnprintf(bf, size, "%-6s %.*s%" PRIx64,
 			 ins->name, c ? c - ops->raw : 0, ops->raw,
 			 ops->target.offset);
 }
@@ -372,7 +372,7 @@ static int lock__scnprintf(struct ins *ins, char *bf, size_t size,
 	if (ops->locked.ins.ops == NULL)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
-	printed = scnprintf(bf, size, "%-6.6s ", ins->name);
+	printed = scnprintf(bf, size, "%-6s ", ins->name);
 	return printed + ins__scnprintf(&ops->locked.ins, bf + printed,
 					size - printed, ops->locked.ops);
 }
@@ -448,7 +448,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map *m
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s,%s", ins->name,
+	return scnprintf(bf, size, "%-6s %s,%s", ins->name,
 			 ops->source.name ?: ops->source.raw,
 			 ops->target.name ?: ops->target.raw);
 }
@@ -488,7 +488,7 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	return scnprintf(bf, size, "%-6.6s %s", ins->name,
+	return scnprintf(bf, size, "%-6s %s", ins->name,
 			 ops->target.name ?: ops->target.raw);
 }
 
@@ -500,7 +500,7 @@ static struct ins_ops dec_ops = {
 static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
 			  struct ins_operands *ops __maybe_unused)
 {
-	return scnprintf(bf, size, "%-6.6s", "nop");
+	return scnprintf(bf, size, "%-6s", "nop");
 }
 
 static struct ins_ops nop_ops = {
@@ -924,7 +924,7 @@ void disasm_line__free(struct disasm_line *dl)
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw)
 {
 	if (raw || !dl->ins.ops)
-		return scnprintf(bf, size, "%-6.6s %s", dl->ins.name, dl->ops.raw);
+		return scnprintf(bf, size, "%-6s %s", dl->ins.name, dl->ops.raw);
 
 	return ins__scnprintf(&dl->ins, bf, size, &dl->ops);
 }
-- 
2.13.6
