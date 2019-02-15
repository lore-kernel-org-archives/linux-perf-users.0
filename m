From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH] perf: update perf.data file format documentation
Date: Fri, 15 Feb 2019 19:28:23 +0100
Message-ID: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

I found that the documentation of the flags section is some how
different from the actual format used and expected by the perf
tools. In this patch the according section of the file format
documentation is updated to conform to the expectations of the
perf tool suite.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 .../perf/Documentation/perf.data-file-format.txt  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index dfb218feaad9..6ea199f28330 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,13 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
-
-Some headers consist of strings, which are defined like this:
+The Flags section is placed directly after the data section and consists of a
+variable amount of information described by the flags-bitset in the perf_header.
+A lot of the headers in the Flags section are simple strings and are represented
+like this:
 
 struct perf_header_string {
        uint32_t len;
@@ -82,7 +79,7 @@ assigned by the linker to an executable.
 struct build_id_event {
 	struct perf_event_header header;
 	pid_t			 pid;
-	uint8_t			 build_id[24];
+	uint8_t			 build_id[PERF_ALIGN(24, sizeof(u64))];
 	char			 filename[header.size - offsetof(struct build_id_event, filename)];
 };
 
@@ -131,7 +128,7 @@ An uint64_t with the total memory in bytes.
 
 	HEADER_CMDLINE = 11,
 
-A perf_header_string with the perf command line used to collect the data.
+A perf_header_string_list with the perf arg-vector used to collect the data.
 
 	HEADER_EVENT_DESC = 12,
 
-- 
2.17.1
