From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v5 02/15] perf tools script: Support insn output for normal samples
Date: Fri,  8 Mar 2019 21:56:15 -0800
Message-ID: <20190309055628.21617-3-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

perf script -F +insn was only working for PT traces because
the PT instruction decoder was filling in the insn/insn_len
sample attributes. Support it for non PT samples too on x86
using the existing x86 instruction decoder.

This adds some extra checking to ensure that we don't try
to decode instructions when using perf.data from a different
architecture.

% perf record -a sleep 1
% perf script -F ip,sym,insn --xed
 ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
 ffffffff8100bb50 intel_bts_enable_local                retq
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
 ffffffff810f1f79 generic_exec_single           xor %eax, %eax
 ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
 ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
 ffffffff81048610 native_apic_mem_write                 mov %edi, %edi
...

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Avoid printing instruction when empty
Only decode when perf.data file was collected on same architecture
---
 tools/perf/arch/x86/util/Build      |  1 +
 tools/perf/arch/x86/util/archinsn.c | 28 ++++++++++++++++++++++++++++
 tools/perf/builtin-script.c         | 21 ++++++++++++++++++++-
 tools/perf/util/archinsn.h          | 12 ++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/x86/util/archinsn.c
 create mode 100644 tools/perf/util/archinsn.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 7aab0be5fc5f..7b8e69bbbdfe 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += group.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += archinsn.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
new file mode 100644
index 000000000000..10b3c2a08b8f
--- /dev/null
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "perf.h"
+#include "archinsn.h"
+#include "fetch.h"
+#include "util/intel-pt-decoder/insn.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine)
+{
+	struct insn insn;
+	int len;
+	bool is64bit = false;
+
+	if (!sample->ip)
+		return;
+	len = fetch_exe(sample->ip, thread, machine, sample->insn,
+			sizeof(sample->insn), &is64bit);
+	if (len <= 0)
+		return;
+	insn_init(&insn, sample->insn, len, is64bit);
+	insn_get_length(&insn);
+	if (insn_complete(&insn) && insn.length <= len)
+		sample->insn_len = insn.length;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2d8cb1d1682c..fbc440bdf880 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -29,10 +29,12 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "print_binary.h"
+#include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <sys/utsname.h>
 #include "asm/bug.h"
 #include "util/mem-events.h"
 #include "util/dump-insn.h"
@@ -63,6 +65,7 @@ static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
 static int			max_blocks;
+static bool			native_arch;
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
@@ -1227,6 +1230,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+			    struct thread *thread __maybe_unused,
+			    struct machine *machine __maybe_unused)
+{
+}
+
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
@@ -1234,9 +1243,12 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
-	if (PRINT_FIELD(INSN)) {
+	if (PRINT_FIELD(INSN) && sample->insn_len) {
 		int i;
 
 		printed += fprintf(fp, " insn:");
@@ -3277,6 +3289,7 @@ int cmd_script(int argc, const char **argv)
 		.set = false,
 		.default_no_sample = true,
 	};
+	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
 	int i, j, err = 0;
@@ -3615,6 +3628,12 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto out_delete;
 
+	uname(&uts);
+	if (!strcmp(uts.machine, session->header.env.arch) ||
+		(!strcmp(uts.machine, "x86_64") &&
+		 !strcmp(session->header.env.arch, "i386")))
+		native_arch = true;
+
 	script.session = session;
 	script__setup_sample_type(&script);
 
diff --git a/tools/perf/util/archinsn.h b/tools/perf/util/archinsn.h
new file mode 100644
index 000000000000..448cbb6b8d7e
--- /dev/null
+++ b/tools/perf/util/archinsn.h
@@ -0,0 +1,12 @@
+#ifndef INSN_H
+#define INSN_H 1
+
+struct perf_sample;
+struct machine;
+struct thread;
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine);
+
+#endif
-- 
2.20.1
