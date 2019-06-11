From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/85] perf data: Document directory format header: HEADER_DIR_FORMAT
Date: Tue, 11 Jun 2019 15:57:50 -0300
Message-ID: <20190611185911.11645-5-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Chong Jiang <chongjiang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We forgot to update the perf.data file format document for the
HEADER_DIR_FORMAT header, do it now from comments in the patch
introducing it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")
Link: https://lkml.kernel.org/n/tip-jbrzb7ijb5al33gi8br6f9rr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 600999f89c6d..6375e6fb8bac 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -302,6 +302,23 @@ One uint64_t for the clockid frequency, specified, for instance, via 'perf
 record -k' (see clock_gettime()), to enable timestamps derived metrics
 conversion into wall clock time on the reporting stage.
 
+	HEADER_DIR_FORMAT = 24,
+
+The data files layout is described by HEADER_DIR_FORMAT feature.  Currently it
+holds only version number (1):
+
+  uint64_t version;
+
+The current version holds only version value (1) means that data files:
+
+- Follow the 'data.*' name format.
+
+- Contain raw events data in standard perf format as read from kernel (and need
+  to be sorted)
+
+Future versions are expected to describe different data files layout according
+to special needs.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
-- 
2.20.1
