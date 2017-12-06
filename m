From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/36] perf annotate: Fix unnecessary memory allocation for s390x
Date: Wed,  6 Dec 2017 11:40:52 -0300
Message-ID: <20171206144115.15097-14-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

This patch fixes a bug introduced with commit d9f8dfa9baf9 ("perf
annotate s390: Implement jump types for perf annotate").

'perf annotate' displays annotated assembler output by reading output of
command objdump and parsing the disassembled lines. For each shown
mnemonic this function sequence is executed:

  disasm_line__new()
  |
  +--> disasm_line__init_ins()
       |
       +--> ins__find()
            |
            +--> arch->associate_instruction_ops()

The s390x specific function assigned to function pointer
associate_instruction_ops refers to function s390__associate_ins_ops().

This function checks for supported mnemonics and assigns a NULL pointer
to unsupported mnemonics.  However even the NULL pointer is added to the
architecture dependend instruction array.

This leads to an extremely large architecture instruction array
(due to array resize logic in function arch__grow_instructions()).

Depending on the objdump output being parsed the array can end up
with several ten-thousand elements.

This patch checks if a mnemonic is supported and only adds supported
ones into the architecture instruction array. The array does not contain
elements with NULL pointers anymore.

Before the patch (With some debug printf output):

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxbb

real	8m49.679s
user	7m13.008s
sys	0m1.649s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxbb | tail -1
__ins__find sorted:1 nr_instructions:87433 ins:0x341583c0
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 87433.

After the patch (With some printf debug output:)

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxaa

real	1m24.553s
user	0m0.587s
sys	0m1.530s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxaa | tail -1
__ins__find sorted:1 nr_instructions:56 ins:0x3f406570
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 56 which is sensible.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20171124094637.55558-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index e0e466c650df..8c72b44444cb 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -18,7 +18,8 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
 
-	arch__associate_ins_ops(arch, name, ops);
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
 	return ops;
 }
 
-- 
2.13.6
