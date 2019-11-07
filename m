From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/63] perf data: Rename directory "header" file to "data"
Date: Thu,  7 Nov 2019 15:59:11 -0300
Message-ID: <20191107190011.23924-4-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to support a single file directory format, rename "header"
to "data" because "header" is a mis-leading name when there is only 1 file.
Note, in the multi-file case, the "header" file also contains data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 2 +-
 tools/perf/util/util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 8993253c5564..df173f0bf654 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -306,7 +306,7 @@ static int open_dir(struct perf_data *data)
 	 * So far we open only the header, so we can read the data version and
 	 * layout.
 	 */
-	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+	if (asprintf(&data->file.path, "%s/data", data->path) < 0)
 		return -1;
 
 	if (perf_data__is_write(data) &&
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index ae56c766eda1..3096654377c2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -185,7 +185,7 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
-		"header",
+		"data",
 		"data.*",
 		NULL,
 	};
-- 
2.21.0
