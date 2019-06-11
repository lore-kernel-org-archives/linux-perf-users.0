From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/85] perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
Date: Tue, 11 Jun 2019 15:57:48 -0300
Message-ID: <20190611185911.11645-3-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Chong Jiang <chongjiang@chromium.org>, Simon Que <sque@chromium.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We forgot to update the perf.data file format document for the
HEADER_MEM_TOPOLOGY header, do it now from comments in the patch
introducing it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Simon Que <sque@chromium.org>
Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
Link: https://lkml.kernel.org/n/tip-h5lcm1nbe9ztxwm61gmadd56@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 022bb8b1c84a..99733751695b 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,30 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+	HEADER_SAMPLE_TOPOLOGY = 22,
+
+Physical memory map and its node assignments.
+
+The format of data in MEM_TOPOLOGY is as follows:
+
+   0 - version          | for future changes
+   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
+  16 - count            | number of nodes
+
+For each node we store map of physical indexes:
+
+  32 - node id          | node index
+  40 - size             | size of bitmap
+  48 - bitmap           | bitmap of memory indexes that belongs to node
+                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+
+The MEM_TOPOLOGY can be displayed with following command:
+
+$ perf report --header-only -I
+...
+# memory nodes (nr 1, block size 0x8000000):
+#    0 [7G]: 0-23,32-69
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
-- 
2.20.1
