From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/17] perf bpf-event: Add missing new line into pr_debug call
Date: Wed, 20 Feb 2019 22:25:47 -0300
Message-ID: <20190221012549.4069-16-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a missing new line into pr_debug call in perf_event__synthesize_bpf_events(),
so that the error message does not screw the verbose output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/r/20190220122800.864-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 62dda96b0096..028c8ec1f62a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 				err = 0;
 				break;
 			}
-			pr_debug("%s: can't get next program: %s%s",
+			pr_debug("%s: can't get next program: %s%s\n",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
 			/* don't report error on old kernel or EPERM  */
-- 
2.19.1
