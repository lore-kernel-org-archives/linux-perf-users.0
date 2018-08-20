From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/21] perf tools: Get rid of dso__needs_decompress() call in symbol__disassemble()
Date: Mon, 20 Aug 2018 13:15:47 -0300
Message-ID: <20180820161602.6830-7-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..20061cf42288 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1629,6 +1629,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
 	bool delete_extract = false;
+	bool decomp = false;
 	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
@@ -1662,6 +1663,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 						 tmp, sizeof(tmp)) < 0)
 			goto out;
 
+		decomp = true;
 		strcpy(symfs_filename, tmp);
 	}
 
@@ -1748,7 +1750,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 out_remove_tmp:
 	close(stdout_fd[0]);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)
-- 
2.14.4
