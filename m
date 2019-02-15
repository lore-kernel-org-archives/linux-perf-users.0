From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/43] perf cs-etm: Remove unused structure field "state"
Date: Thu, 14 Feb 2019 21:45:19 -0300
Message-ID: <20190215004539.23571-24-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki K Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Field "state" in structure cs_etm_queue is no longer used and needs
to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0b11d653cfbe..ebd68eb43da9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,7 +65,6 @@ struct cs_etm_queue {
 	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
-	const struct cs_etm_state *state;
 	union perf_event *event_buf;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-- 
2.19.1
