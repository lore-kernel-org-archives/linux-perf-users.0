From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/63] perf tests: Fix a typo
Date: Thu,  7 Nov 2019 15:59:21 -0300
Message-ID: <20191107190011.23924-14-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Correct typo in comment: s/suck/stuck.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reported-by: Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191023083324.12093-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 166f411568a5..415903b48578 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -295,7 +295,7 @@ bool test__bp_signal_is_supported(void)
 	 * breakpointed instruction.
 	 *
 	 * Since arm64 has the same issue with arm for the single-step
-	 * handling, this case also gets suck on the breakpointed
+	 * handling, this case also gets stuck on the breakpointed
 	 * instruction.
 	 *
 	 * Just disable the test for these architectures until these
-- 
2.21.0
