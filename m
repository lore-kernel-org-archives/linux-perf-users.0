From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/85] perf cs-etm: Add handling of switch-CPU-wide events
Date: Tue, 11 Jun 2019 15:58:27 -0300
Message-ID: <20190611185911.11645-42-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Add handling of SWITCH-CPU-WIDE events in order to add the tid/pid of
the incoming process to the perf tools machine infrastructure.  This
information is later retrieved when a contextID packet is found in the
trace stream.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0742c50fce46..5322dcaaf654 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1680,6 +1680,42 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
+					   union perf_event *event)
+{
+	struct thread *th;
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+
+	/*
+	 * Context switch in per-thread mode are irrelevant since perf
+	 * will start/stop tracing as the process is scheduled.
+	 */
+	if (etm->timeless_decoding)
+		return 0;
+
+	/*
+	 * SWITCH_IN events carry the next process to be switched out while
+	 * SWITCH_OUT events carry the process to be switched in.  As such
+	 * we don't care about IN events.
+	 */
+	if (!out)
+		return 0;
+
+	/*
+	 * Add the tid/pid to the log so that we can get a match when
+	 * we get a contextID from the decoder.
+	 */
+	th = machine__findnew_thread(etm->machine,
+				     event->context_switch.next_prev_pid,
+				     event->context_switch.next_prev_tid);
+	if (!th)
+		return -ENOMEM;
+
+	thread__put(th);
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -1719,6 +1755,8 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_ITRACE_START)
 		return cs_etm__process_itrace_start(etm, event);
+	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return cs_etm__process_switch_cpu_wide(etm, event);
 
 	return 0;
 }
-- 
2.20.1
