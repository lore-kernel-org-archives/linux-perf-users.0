From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/28] perf.data documentation: Clarify HEADER_SAMPLE_TOPOLOGY format
Date: Wed, 14 Aug 2019 15:40:49 -0300
Message-ID: <20190814184051.3125-27-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Chong Jiang <chongjiang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Vince Weaver <vincent.weaver@maine.edu>

The perf.data file format documentation for HEADER_SAMPLE_TOPOLOGY
specifies the layout in a confusing manner that doesn't match the rest
of the document.  This patch attempts to describe things consistent with
the rest of the file.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1908011425240.14303@macbook-air
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d030c87ed9f5..b0152e1095c5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -298,16 +298,21 @@ Physical memory map and its node assignments.
 
 The format of data in MEM_TOPOLOGY is as follows:
 
-   0 - version          | for future changes
-   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
-  16 - count            | number of nodes
-
-For each node we store map of physical indexes:
-
-  32 - node id          | node index
-  40 - size             | size of bitmap
-  48 - bitmap           | bitmap of memory indexes that belongs to node
-                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+	u64 version;            // Currently 1
+	u64 block_size_bytes;   // /sys/devices/system/memory/block_size_bytes
+	u64 count;              // number of nodes
+
+struct memory_node {
+        u64 node_id;            // node index
+        u64 size;               // size of bitmap
+        struct bitmap {
+		/* size of bitmap again */
+                u64 bitmapsize;
+		/* bitmap of memory indexes that belongs to node     */
+		/* /sys/devices/system/node/node<NODE>/memory<INDEX> */
+                u64 entries[(bitmapsize/64)+1];
+        }
+}[count];
 
 The MEM_TOPOLOGY can be displayed with following command:
 
-- 
2.21.0
