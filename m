From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/9] perf tools: Open perf.data with O_CLOEXEC flag
Date: Tue, 12 Sep 2017 16:24:33 -0300
Message-ID: <20170912192438.1334-5-acme@kernel.org>
References: <20170912192438.1334-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Do not carry the perf.data file descriptor into the workload process and
close it when perf executes the workload.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908084621.31595-2-jolsa@kernel.org
[ Add definitions for O_CLOEXEC for older systems ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e84bbc8ec058..263f5a906ba5 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -10,6 +10,16 @@
 #include "util.h"
 #include "debug.h"
 
+#ifndef O_CLOEXEC
+#ifdef __sparc__
+#define O_CLOEXEC	0x400000
+#elif defined(__alpha__) || defined(__hppa__)
+#define O_CLOEXEC	010000000
+#else
+#define O_CLOEXEC	02000000
+#endif
+#endif
+
 static bool check_pipe(struct perf_data_file *file)
 {
 	struct stat st;
@@ -96,7 +106,8 @@ static int open_file_write(struct perf_data_file *file)
 	if (check_backup(file))
 		return -1;
 
-	fd = open(file->path, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
+	fd = open(file->path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
+		  S_IRUSR|S_IWUSR);
 
 	if (fd < 0)
 		pr_err("failed to open %s : %s\n", file->path,
-- 
2.13.5
