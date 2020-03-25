From: Tony Jones <tonyj@suse.de>
Subject: [PATCH] perf tools: update docs regarding kernel/user space unwinding
Date: Wed, 25 Mar 2020 09:40:53 -0700
Message-ID: <20200325164053.10177-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The method of unwinding for kernel space is defined by the kernel config, 
not by the value of --call-graph.   Improve the documentation to reflect 
this.

Signed-off-by: Tony Jones <tonyj@suse.de>

---
 tools/perf/Documentation/perf-config.txt | 14 ++++++++------
 tools/perf/Documentation/perf-record.txt | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 8ead55593984..88cf35fbedc5 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -405,14 +405,16 @@ ui.*::
 		This option is only applied to TUI.
 
 call-graph.*::
-	When sub-commands 'top' and 'report' work with -g/—-children
-	there're options in control of call-graph.
+	The following controls the handling of call-graphs (obtained via the
+	-g/--callgraph options).
 
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
2.25.0
