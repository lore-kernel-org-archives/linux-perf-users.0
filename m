From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/37] perf data: Fail check_backup in case of error
Date: Mon, 25 Feb 2019 18:20:21 -0300
Message-ID: <20190225212035.24781-24-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

And display the error message from removing the old data file:

  $ perf record ls
  Can't remove old data: Permission denied (perf.data.old)
  Perf session creation failed.

  $ perf record ls
  Can't remove old data: Unknown file found (perf.data.old)
  Perf session creation failed.

Not sure how to make fail the rename (after we successfully remove the
destination file/dir) to show the message, anyway let's have it there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index bbf9a299615e..d008c3973012 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -41,12 +41,27 @@ static int check_backup(struct perf_data *data)
 		return 0;
 
 	if (!stat(data->path, &st) && st.st_size) {
-		/* TODO check errors properly */
 		char oldname[PATH_MAX];
+		int ret;
+
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		rm_rf_perf_data(oldname);
-		rename(data->path, oldname);
+
+		ret = rm_rf_perf_data(oldname);
+		if (ret) {
+			pr_err("Can't remove old data: %s (%s)\n",
+			       ret == -2 ?
+			       "Unknown file found" : strerror(errno),
+			       oldname);
+			return -1;
+		}
+
+		if (rename(data->path, oldname)) {
+			pr_err("Can't move data: %s (%s to %s)\n",
+			       strerror(errno),
+			       data->path, oldname);
+			return -1;
+		}
 	}
 
 	return 0;
-- 
2.20.1
