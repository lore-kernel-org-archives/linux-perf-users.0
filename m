From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/41] perf machine: Return NULL instead of null-terminating /proc/version array
Date: Wed, 29 May 2019 10:35:55 -0300
Message-ID: <20190529133605.21118-32-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Donald Yandt <donald.yandt@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Donald Yandt <donald.yandt@gmail.com>

Return NULL instead of null-terminating version char array when fgets
fails due to end-of-file or error.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: 30ba5b0e66c8 ("perf machine: Null-terminate version char array upon fgets(/proc/version) error")
Link: http://lkml.kernel.org/r/20190528134128.30841-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f5569f005cf3..17eec39e775e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1241,9 +1241,9 @@ static char *get_kernel_version(const char *root_dir)
 		return NULL;
 
 	tmp = fgets(version, sizeof(version), file);
-	if (!tmp)
-		*version = '\0';
 	fclose(file);
+	if (!tmp)
+		return NULL;
 
 	name = strstr(version, prefix);
 	if (!name)
-- 
2.20.1
