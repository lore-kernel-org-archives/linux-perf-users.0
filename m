From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/28] perf tools: Add CAP_SYSLOG define for older systems
Date: Wed, 14 Aug 2019 15:40:38 -0300
Message-ID: <20190814184051.3125-16-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some of the systems I test don't have that define, provide it
conditionally since we'll use it in the kptr_restrict checks in the next
patch.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-dcize2v6jjab7tds5ngz97dk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index 10af94e473da..051dc590ceee 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -24,4 +24,9 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
 
 #endif /* HAVE_LIBCAP_SUPPORT */
 
+/* For older systems */
+#ifndef CAP_SYSLOG
+#define CAP_SYSLOG	34
+#endif
+
 #endif /* __PERF_CAP_H */
-- 
2.21.0
