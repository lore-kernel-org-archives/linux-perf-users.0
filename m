From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/44] perf hist: Add missing map__put() in error case
Date: Thu, 21 Mar 2019 15:51:16 -0300
Message-ID: <20190321185142.11441-19-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Krister Johansen <kjlx@templeofstupid.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

We need to map__put() before returning from failure of
sample__resolve_callchain().

Detected with gcc's ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 9c68ae98c6f7 ("perf callchain: Reference count maps")
Link: http://lkml.kernel.org/r/20190316080556.3075-10-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1f230285d78a..7ace7a10054d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1111,8 +1111,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
 					iter->evsel, al, max_stack_depth);
-	if (err)
+	if (err) {
+		map__put(alm);
 		return err;
+	}
 
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
-- 
2.20.1
