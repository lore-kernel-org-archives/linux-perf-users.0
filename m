From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/53] perf tools: Add documentation for BPF event selection
Date: Wed,  6 Feb 2019 15:48:45 -0300
Message-ID: <20190206184903.24054-36-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Add documentation for how to pass a BPF program as a perf event.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190201134651.12373-1-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 31 ++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt | 14 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 4ac7775fbc11..86f3dcc15f83 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -120,6 +120,10 @@ Given a $HOME/.perfconfig like this:
 		children = true
 		group = true
 
+	[llvm]
+		dump-obj = true
+		clang-opt = -g
+
 You can hide source code of annotate feature setting the config to false with
 
 	% perf config annotate.hide_src_code=true
@@ -553,6 +557,33 @@ trace.*::
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
+llvm.*::
+	llvm.clang-path::
+		Path to clang. If omit, search it from $PATH.
+
+	llvm.clang-bpf-cmd-template::
+		Cmdline template. Below lines show its default value. Environment
+		variable is used to pass options.
+		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
+		-Wno-unused-value -Wno-pointer-sign -working-directory \
+		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+
+	llvm.clang-opt::
+		Options passed to clang.
+
+	llvm.kbuild-dir::
+		kbuild directory. If not set, use /lib/modules/`uname -r`/build.
+		If set to "" deliberately, skip kernel header auto-detector.
+
+	llvm.kbuild-opts::
+		Options passed to 'make' when detecting kernel header options.
+
+	llvm.dump-obj::
+		Enable perf dump BPF object files compiled by LLVM.
+
+	llvm.opts::
+		Options passed to llc.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..02b4aa2621e7 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -88,6 +88,20 @@ OPTIONS
           If you want to profile write accesses in [0x1000~1008), just set
           'mem:0x1000/8:w'.
 
+        - a BPF source file (ending in .c) or a precompiled object file (ending
+          in .o) selects one or more BPF events.
+          The BPF program can attach to various perf events based on the ELF section
+          names.
+
+          When processing a '.c' file, perf searches an installed LLVM to compile it
+          into an object file first. Optional clang options can be passed via the
+          '--clang-opt' command line option, e.g.:
+
+            perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
+                        -e tests/bpf-script-example.c
+
+          Note: '--clang-opt' must be placed before '--event/-e'.
+
 	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
 	  Each event is separated by commas and the group should be quoted to
 	  prevent the shell interpretation.  You also need to use --group on
-- 
2.20.1
