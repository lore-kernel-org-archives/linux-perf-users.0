From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/31] perf callchain: Update docs regarding kernel/user space unwinding
Date: Fri,  3 Apr 2020 11:54:13 -0300
Message-ID: <20200403145443.24774-2-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

The method of unwinding for kernel space is defined by the kernel
config, not by the value of --call-graph.   Improve the documentation to
reflect this.

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lore.kernel.org/lkml/20200325164053.10177-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 14 ++++++++------
 tools/perf/Documentation/perf-record.txt | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 8ead55593984..f16d8a71d3f5 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -405,14 +405,16 @@ ui.*::
 		This option is only applied to TUI.
 
 call-graph.*::
-	When sub-commands 'top' and 'report' work with -g/—-children
-	there're options in control of call-graph.
+	The following controls the handling of call-graphs (obtained via the
+	-g/--call-graph options).
 
 	call-graph.record-mode::
-		The record-mode can be 'fp' (frame pointer), 'dwarf' and 'lbr'.
-		The value of 'dwarf' is effective only if perf detect needed library
-		(libunwind or a recent version of libdw).
-		'lbr' only work for cpus that support it.
+		The mode for user space can be 'fp' (frame pointer), 'dwarf'
+		and 'lbr'.  The value 'dwarf' is effective only if libunwind
+		(or a recent version of libdw) is present on the system;
+		the value 'lbr' only works for certain cpus. The method for
+		kernel space is controlled not by this option but by the
+		kernel config (CONFIG_UNWINDER_*).
 
 	call-graph.dump-size::
 		The size of stack to dump in order to do post-unwinding. Default is 8192 (byte).
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 7f4db7592467..b25e028458e2 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -237,16 +237,22 @@ OPTIONS
 	option and remains only for backward compatibility.  See --event.
 
 -g::
-	Enables call-graph (stack chain/backtrace) recording.
+	Enables call-graph (stack chain/backtrace) recording for both
+	kernel space and user space.
 
 --call-graph::
 	Setup and enable call-graph (stack chain/backtrace) recording,
-	implies -g.  Default is "fp".
+	implies -g.  Default is "fp" (for user space).
 
-	Allows specifying "fp" (frame pointer) or "dwarf"
-	(DWARF's CFI - Call Frame Information) or "lbr"
-	(Hardware Last Branch Record facility) as the method to collect
-	the information used to show the call graphs.
+	The unwinding method used for kernel space is dependent on the
+	unwinder used by the active kernel configuration, i.e
+	CONFIG_UNWINDER_FRAME_POINTER (fp) or CONFIG_UNWINDER_ORC (orc)
+
+	Any option specified here controls the method used for user space.
+
+	Valid options are "fp" (frame pointer), "dwarf" (DWARF's CFI -
+	Call Frame Information) or "lbr" (Hardware Last Branch Record
+	facility).
 
 	In some systems, where binaries are build with gcc
 	--fomit-frame-pointer, using the "fp" method will produce bogus
-- 
2.21.1
