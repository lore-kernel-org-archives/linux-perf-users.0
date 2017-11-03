From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/19] perf srcline: Fix memory leak in addr2inlines()
Date: Fri,  3 Nov 2017 10:55:02 -0300
Message-ID: <20171103135503.4921-19-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, kernel-team@lge.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

When libbfd is not used, addr2inlines() executes `addr2line -i` and
process output line by line.  But it resets filename to NULL in the loop
so getline() allocates additional memory everytime instead of realloc.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20171031020654.31163-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index c143c3bc1ef8..51dc49c65476 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -456,20 +456,17 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	while (getline(&filename, &len, fp) != -1) {
 		char *srcline;
 
-		if (filename_split(filename, &line_nr) != 1) {
-			free(filename);
+		if (filename_split(filename, &line_nr) != 1)
 			goto out;
-		}
 
 		srcline = srcline_from_fileline(filename, line_nr);
 		if (inline_list__append(sym, srcline, node) != 0)
 			goto out;
-
-		filename = NULL;
 	}
 
 out:
 	pclose(fp);
+	free(filename);
 
 	return node;
 }
-- 
2.13.6
