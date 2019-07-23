From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/10] perf tools: Fix proper buffer size for feature processing
Date: Tue, 23 Jul 2019 17:05:24 -0300
Message-ID: <20190723200530.14090-5-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Carrillo-Cisneros <davidcc@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

After Song Liu's segfault fix for pipe mode, Arnaldo reported following
error:

  # perf record -o - | perf script
  0x514 [0x1ac]: failed to process type: 80

It's caused by wrong buffer size setup in feature processing, which
makes cpu topology feature fail, because it's using buffer size to
recognize its header version.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: e9def1b2e74e ("perf tools: Add feature header record to pipe-mode")
Link: http://lkml.kernel.org/r/20190715140426.32509-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..20111f8da5cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3747,7 +3747,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
-- 
2.21.0
