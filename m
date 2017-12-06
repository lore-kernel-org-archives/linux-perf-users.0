From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/36] perf intel-pt: Improve build messages for files that differ from the kernel
Date: Wed,  6 Dec 2017 11:40:47 -0300
Message-ID: <20171206144115.15097-9-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Print file names of files that differ. For example, instead of:

  Warning: Intel PT: x86 instruction decoder differs from kernel

print:

  Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/inat.h' differs from latest version at 'arch/x86/include/asm/inat.h'

Reported-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/1511253326-22308-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/Build | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 10e0814bb8d2..1b704fbea9de 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -11,15 +11,21 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 $(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c util/intel-pt-decoder/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	@(diff -I 2>&1 | grep -q 'option requires an argument' && \
-	test -d ../../kernel -a -d ../../tools -a -d ../perf && (( \
-	diff -B -I'^#include' util/intel-pt-decoder/insn.c ../../arch/x86/lib/insn.c >/dev/null && \
-	diff -B -I'^#include' util/intel-pt-decoder/inat.c ../../arch/x86/lib/inat.c >/dev/null && \
-	diff -B util/intel-pt-decoder/x86-opcode-map.txt ../../arch/x86/lib/x86-opcode-map.txt >/dev/null && \
-	diff -B util/intel-pt-decoder/gen-insn-attr-x86.awk ../../arch/x86/tools/gen-insn-attr-x86.awk >/dev/null && \
-	diff -B -I'^#include' util/intel-pt-decoder/insn.h ../../arch/x86/include/asm/insn.h >/dev/null && \
-	diff -B -I'^#include' util/intel-pt-decoder/inat.h ../../arch/x86/include/asm/inat.h >/dev/null && \
-	diff -B -I'^#include' util/intel-pt-decoder/inat_types.h ../../arch/x86/include/asm/inat_types.h >/dev/null) \
-	|| echo "Warning: Intel PT: x86 instruction decoder differs from kernel" >&2 )) || true
+	test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+	((diff -B -I'^#include' util/intel-pt-decoder/insn.c ../../arch/x86/lib/insn.c >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder C file at 'tools/perf/util/intel-pt-decoder/insn.c' differs from latest version at 'arch/x86/lib/insn.c'" >&2)) && \
+	((diff -B -I'^#include' util/intel-pt-decoder/inat.c ../../arch/x86/lib/inat.c >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder C file at 'tools/perf/util/intel-pt-decoder/inat.c' differs from latest version at 'arch/x86/lib/inat.c'" >&2)) && \
+	((diff -B util/intel-pt-decoder/x86-opcode-map.txt ../../arch/x86/lib/x86-opcode-map.txt >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder map file at 'tools/perf/util/intel-pt-decoder/x86-opcode-map.txt' differs from latest version at 'arch/x86/lib/x86-opcode-map.txt'" >&2)) && \
+	((diff -B util/intel-pt-decoder/gen-insn-attr-x86.awk ../../arch/x86/tools/gen-insn-attr-x86.awk >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder script at 'tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk' differs from latest version at 'arch/x86/tools/gen-insn-attr-x86.awk'" >&2)) && \
+	((diff -B -I'^#include' util/intel-pt-decoder/insn.h ../../arch/x86/include/asm/insn.h >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'" >&2)) && \
+	((diff -B -I'^#include' util/intel-pt-decoder/inat.h ../../arch/x86/include/asm/inat.h >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/inat.h' differs from latest version at 'arch/x86/include/asm/inat.h'" >&2)) && \
+	((diff -B -I'^#include' util/intel-pt-decoder/inat_types.h ../../arch/x86/include/asm/inat_types.h >/dev/null) || \
+	(echo "Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/inat_types.h' differs from latest version at 'arch/x86/include/asm/inat_types.h'" >&2)))) || true
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-- 
2.13.6
