From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/17] perf tools: Make rm_rf() remove single file
Date: Wed, 20 Feb 2019 22:25:49 -0300
Message-ID: <20190221012549.4069-18-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Let rm_rf() remove a file if it's provided by path, not just
directories.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 320b0fef249a..3ee410fc047a 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -120,16 +120,26 @@ int mkdir_p(char *path, mode_t mode)
 int rm_rf(const char *path)
 {
 	DIR *dir;
-	int ret = 0;
+	int ret;
 	struct dirent *d;
 	char namebuf[PATH_MAX];
+	struct stat statbuf;
 
+	/* Do not fail if there's no file. */
+	ret = lstat(path, &statbuf);
+	if (ret)
+		return 0;
+
+	/* Try to remove any file we get. */
+	if (!(statbuf.st_mode & S_IFDIR))
+		return unlink(path);
+
+	/* We have directory in path. */
 	dir = opendir(path);
 	if (dir == NULL)
-		return 0;
+		return -1;
 
 	while ((d = readdir(dir)) != NULL && !ret) {
-		struct stat statbuf;
 
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-- 
2.19.1
