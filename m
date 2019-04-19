From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/7] perf evlist: Fix side band thread draining
Date: Fri, 19 Apr 2019 09:30:27 -0300
Message-ID: <20190419123029.11328-6-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Current perf_evlist__poll_thread() code could finish without draining
the data. Adding the logic that makes sure we won't finish before the
drain.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Link: http://lkml.kernel.org/r/20190416160127.30203-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6689378ee577..51ead577533f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
 {
 	struct perf_evlist *evlist = arg;
 	bool draining = false;
-	int i;
+	int i, done = 0;
+
+	while (!done) {
+		bool got_data = false;
 
-	while (draining || !(evlist->thread.done)) {
-		if (draining)
-			draining = false;
-		else if (evlist->thread.done)
+		if (evlist->thread.done)
 			draining = true;
 
 		if (!draining)
@@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
 					pr_warning("cannot locate proper evsel for the side band event\n");
 
 				perf_mmap__consume(map);
+				got_data = true;
 			}
 			perf_mmap__read_done(map);
 		}
+
+		if (draining && !got_data)
+			break;
 	}
 	return NULL;
 }
-- 
2.20.1
