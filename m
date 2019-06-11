From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/85] perf data: Document clockid header: HEADER_CLOCKID
Date: Tue, 11 Jun 2019 15:57:49 -0300
Message-ID: <20190611185911.11645-4-acme@kernel.org>
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
HEADER_CLOCKID header, do it now from comments in the patch introducing
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: cf7905165fee ("perf record: Encode -k clockid frequency into Perf trace")
Link: https://lkml.kernel.org/n/tip-slhnjp06027j3ae17qqetzxj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 99733751695b..600999f89c6d 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -296,6 +296,12 @@ $ perf report --header-only -I
 # memory nodes (nr 1, block size 0x8000000):
 #    0 [7G]: 0-23,32-69
 
+	HEADER_CLOCKID = 23,
+
+One uint64_t for the clockid frequency, specified, for instance, via 'perf
+record -k' (see clock_gettime()), to enable timestamps derived metrics
+conversion into wall clock time on the reporting stage.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
-- 
2.20.1
