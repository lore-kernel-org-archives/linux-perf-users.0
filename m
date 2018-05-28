From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Update section on cpu topology
Date: Mon, 28 May 2018 09:44:33 +0200
Message-ID: <20180528074433.16652-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Add an explanation of each cpu's core and socket
identifier to the documentation.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..c57904a526ce 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -153,10 +153,18 @@ struct {
 	HEADER_CPU_TOPOLOGY = 13,
 
 String lists defining the core and CPU threads topology.
+The string lists are followed by a variable length array
+which contains core_id and socket_id of each cpu.
+The number of entries can be determined by the size of the
+section minus the sizes of both string lists.
 
 struct {
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+       struct {
+	      uint32_t core_id;
+	      uint32_t socket_id;
+       } cpus[nr]; /* Variable length records */
 };
 
 Example:
-- 
2.14.3
