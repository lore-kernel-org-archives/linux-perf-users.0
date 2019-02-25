From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/37] perf data: Make check_backup work over directories
Date: Mon, 25 Feb 2019 18:20:20 -0300
Message-ID: <20190225212035.24781-23-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Change check_backup() to call rm_rf_perf_data() instead of unlink() to
work over directory paths.

Also move the call earlier in the code, before we fork for file/dir, so
it can backup also directory data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e16d06ed1100..bbf9a299615e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -37,12 +37,15 @@ static int check_backup(struct perf_data *data)
 {
 	struct stat st;
 
+	if (perf_data__is_read(data))
+		return 0;
+
 	if (!stat(data->path, &st) && st.st_size) {
 		/* TODO check errors properly */
 		char oldname[PATH_MAX];
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		unlink(oldname);
+		rm_rf_perf_data(oldname);
 		rename(data->path, oldname);
 	}
 
@@ -95,9 +98,6 @@ static int open_file_write(struct perf_data *data)
 	int fd;
 	char sbuf[STRERR_BUFSIZE];
 
-	if (check_backup(data))
-		return -1;
-
 	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
 		  S_IRUSR|S_IWUSR);
 
@@ -141,6 +141,9 @@ int perf_data__open(struct perf_data *data)
 	if (!data->path)
 		data->path = "perf.data";
 
+	if (check_backup(data))
+		return -1;
+
 	return open_file_dup(data);
 }
 
-- 
2.20.1
