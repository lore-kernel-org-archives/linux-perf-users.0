From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/28] perf ftrace: Improve error message about capability to use ftrace
Date: Wed, 14 Aug 2019 15:40:40 -0300
Message-ID: <20190814184051.3125-18-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If we link against libcap, then we can state that CAP_SYS_ADMIN is
needed, if not, fallback to telling the user it needs to be root, as was
before linking against libcap.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-hhnbjdo8r67054of9zm2kxtl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 01a5bb58eb04..1367bb5046a7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -284,7 +284,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	};
 
 	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
-		pr_err("ftrace only works for root!\n");
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
 		return -1;
 	}
 
-- 
2.21.0
