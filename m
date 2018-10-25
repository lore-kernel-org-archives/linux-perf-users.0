From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/37] perf script: Add --insn-trace for instruction decoding
Date: Thu, 25 Oct 2018 08:10:27 -0300
Message-ID: <20181025111031.3440-34-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a --insn-trace short hand option for decoding and disassembling
instruction streams for intel_pt. This automatically pipes the output
into the xed disassembler to generate disassembled instructions.  This
just makes this use model much nicer to use.

Before

  % perf record -e intel_pt// ...
  % perf script --itrace=i0ns --ns -F +insn,-event,-period | xed -F insn: -A -64
   swapper 0 [000] 17276.429606186: ffffffff81010486 pt_config ([kernel.kallsyms])    nopl  %eax, (%rax,%rax,1)
   swapper 0 [000] 17276.429606186: ffffffff8101048b pt_config ([kernel.kallsyms])    add $0x10, %rsp
   swapper 0 [000] 17276.429606186: ffffffff8101048f pt_config ([kernel.kallsyms])    popq  %rbx
   swapper 0 [000] 17276.429606186: ffffffff81010490 pt_config ([kernel.kallsyms])    popq  %rbp
   swapper 0 [000] 17276.429606186: ffffffff81010491 pt_config ([kernel.kallsyms])    popq  %r12
   swapper 0 [000] 17276.429606186: ffffffff81010493 pt_config ([kernel.kallsyms])    popq  %r13
   swapper 0 [000] 17276.429606186: ffffffff81010495 pt_config ([kernel.kallsyms])    popq  %r14
   swapper 0 [000] 17276.429606186: ffffffff81010497 pt_config ([kernel.kallsyms])    popq  %r15
   swapper 0 [000] 17276.429606186: ffffffff81010499 pt_config ([kernel.kallsyms])    retq
   swapper 0 [000] 17276.429606186: ffffffff8101063e pt_event_add ([kernel.kallsyms])         cmpl  $0x1, 0x1b0(%rbx)
   swapper 0 [000] 17276.429606186: ffffffff81010645 pt_event_add ([kernel.kallsyms])         mov $0xffffffea, %eax
   swapper 0 [000] 17276.429606186: ffffffff8101064a pt_event_add ([kernel.kallsyms])         mov $0x0, %edx
   swapper 0 [000] 17276.429606186: ffffffff8101064f pt_event_add ([kernel.kallsyms])         popq  %rbx
   swapper 0 [000] 17276.429606186: ffffffff81010650 pt_event_add ([kernel.kallsyms])         cmovnz %edx, %eax
   swapper 0 [000] 17276.429606186: ffffffff81010653 pt_event_add ([kernel.kallsyms])         jmp 0xffffffff81010635
   swapper 0 [000] 17276.429606186: ffffffff81010635 pt_event_add ([kernel.kallsyms])         retq
   swapper 0 [000] 17276.429606186: ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])       test %eax, %eax

Now:

  % perf record -e intel_pt// ...
  % perf script --insn-trace --xed
  ... same output ...

XED needs to be installed with:

  $ git clone https://github.com/intelxed/mbuild.git mbuild
  $ git clone https://github.com/intelxed/xed
  $ cd xed
  $ ./mfile.py
  $ ./mfile.py examples
  $ sudo ./mfile.py --prefix=/usr/local install
  $ sudo cp obj/examples/xed /usr/local/bin
  $ xed | head -3
  ERROR: required argument(s) were missing
  Copyright (C) 2017, Intel Corporation. All rights reserved.
  XED version: [v10.0-328-g7d62c8c49b7b]
  $

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180920180540.14039-2-andi@firstfloor.org
[ Fixed up whitespace damage, added the 'mfile.py examples + cp obj/examples/xed ... ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/build-xed.txt   | 19 +++++++++++++++++++
 tools/perf/Documentation/perf-script.txt |  7 +++++++
 tools/perf/builtin-script.c              | 23 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 tools/perf/Documentation/build-xed.txt

diff --git a/tools/perf/Documentation/build-xed.txt b/tools/perf/Documentation/build-xed.txt
new file mode 100644
index 000000000000..6222c1e7231f
--- /dev/null
+++ b/tools/perf/Documentation/build-xed.txt
@@ -0,0 +1,19 @@
+
+For --xed the xed tool is needed. Here is how to install it:
+
+  $ git clone https://github.com/intelxed/mbuild.git mbuild
+  $ git clone https://github.com/intelxed/xed
+  $ cd xed
+  $ ./mfile.py --share
+  $ ./mfile.py examples
+  $ sudo ./mfile.py --prefix=/usr/local install
+  $ sudo ldconfig
+  $ sudo cp obj/examples/xed /usr/local/bin
+
+Basic xed testing:
+
+  $ xed | head -3
+  ERROR: required argument(s) were missing
+  Copyright (C) 2017, Intel Corporation. All rights reserved.
+  XED version: [v10.0-328-g7d62c8c49b7b]
+  $
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index afdafe2110a1..00c655ab4968 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -383,6 +383,13 @@ include::itrace.txt[]
 	will be printed. Each entry has function name and file/line. Enabled by
 	default, disable with --no-inline.
 
+--insn-trace::
+	Show instruction stream for intel_pt traces. Combine with --xed to
+	show disassembly.
+
+--xed::
+	Run xed disassembler on output. Requires installing the xed disassembler.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ca09b7d2adb7..411ea175bcaf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -44,6 +44,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <subcmd/pager.h>
 
 #include "sane_ctype.h"
 
@@ -3103,6 +3104,24 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
 #define perf_script__process_auxtrace_info 0
 #endif
 
+static int parse_insn_trace(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	parse_output_fields(NULL, "+insn,-event,-period", 0);
+	itrace_parse_synth_opts(opt, "i0ns", 0);
+	nanosecs = true;
+	return 0;
+}
+
+static int parse_xed(const struct option *opt __maybe_unused,
+		     const char *str __maybe_unused,
+		     int unset __maybe_unused)
+{
+	force_pager("xed -F insn: -A -64 | less");
+	return 0;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -3187,6 +3206,10 @@ int cmd_script(int argc, const char **argv)
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
+	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
+			"Decode instructions from itrace", parse_insn_trace),
+	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
+			"Run xed disassembler on output", parse_xed),
 	OPT_STRING(0, "stop-bt", &symbol_conf.bt_stop_list_str, "symbol[,symbol...]",
 		   "Stop display of callgraph at these symbols"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
-- 
2.14.4
