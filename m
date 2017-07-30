From: Ingo Molnar <mingo@kernel.org>
Subject: perf build: Clarify open-coded header version warning message
Date: Sun, 30 Jul 2017 11:51:30 +0200
Message-ID: <20170730095130.bblldwxjz5hamybb@gmail.com>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eran>
List-Id: linux-perf-users.vger.kernel.org

In this patch we changed the header checks:

  perf build: Clarify header version warning message

Unfortunately the header checks were copied to various places and thus the message got
out of sync. Fix some of them here.

Note that there's still old, misleading messages remaining in:

  tools/objtool/Makefile: || echo "warning: objtool: x86 instruction decoder differs from kernel" >&2 )) || true
  tools/objtool/Makefile: || echo "warning: objtool: orc_types.h differs from kernel" >&2 )) || true

here objtool copied the perf message, plus:

 tools/perf/util/intel-pt-decoder/Build: || echo "Warning: Intel PT: x86 instruction decoder differs from kernel" >&2 )) || true

here the PT code regressed over the original message and only emits a vague warning
instead of specific file names...

All of this should be consolidated into tools/Build/ and used in a consistent 
manner.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/bpf/Makefile       | 4 ++--
 tools/perf/arch/x86/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 1f5300e56b44..e87b5903f4bb 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -156,10 +156,10 @@ all_cmd: $(CMD_TARGETS)
 $(BPF_IN): force elfdep bpfdep
 	@(test -f ../../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
-	echo "Warning: tools/include/uapi/linux/bpf.h differs from kernel" >&2 )) || true
+	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
 	@(test -f ../../../include/uapi/linux/bpf_common.h -a -f ../../../include/uapi/linux/bpf_common.h && ( \
 	(diff -B ../../include/uapi/linux/bpf_common.h ../../../include/uapi/linux/bpf_common.h >/dev/null) || \
-	echo "Warning: tools/include/uapi/linux/bpf_common.h differs from kernel" >&2 )) || true
+	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf_common.h' differs from latest version at 'include/uapi/linux/bpf_common.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf
 
 $(OUTPUT)libbpf.so: $(BPF_IN)
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 6c9211b18ec0..9a628a24c5c9 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -20,7 +20,7 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 $(header): $(sys)/syscall_64.tbl $(systbl)
 	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
         (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: x86_64's syscall_64.tbl differs from kernel" >&2 )) || true
+        || echo "Warning: Kernel ABI header at 'tools/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
