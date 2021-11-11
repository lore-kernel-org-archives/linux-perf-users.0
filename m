Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCCAC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F9D61872
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhKKNjw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:39:52 -0500
Received: from foss.arm.com ([217.140.110.172]:39944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhKKNjq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 08:39:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC24BED1;
        Thu, 11 Nov 2021 05:36:56 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD6DD3F70D;
        Thu, 11 Nov 2021 05:36:54 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] perf arm-spe: Support hardware-based PID tracing
Date:   Thu, 11 Nov 2021 13:36:25 +0000
Message-Id: <20211111133625.193568-5-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111133625.193568-1-german.gomez@arm.com>
References: <20211111133625.193568-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If Arm SPE traces contain CONTEXT packets with TID info, use these
values for tracking tid of samples. Otherwise fall back to using context
switch events and display a message warning the user of possible timing
inaccuracies [1].

[1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 99 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 230bc7ab2..6bb545ba0 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -71,6 +71,7 @@ struct arm_spe {
 	u64				kernel_start;
 
 	unsigned long			num_events;
+	u8				use_ctx_pkt_for_pid;
 };
 
 struct arm_spe_queue {
@@ -226,6 +227,44 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
 		PERF_RECORD_MISC_USER;
 }
 
+static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
+				    struct auxtrace_queue *queue)
+{
+	struct arm_spe_queue *speq = queue->priv;
+	pid_t tid;
+
+	tid = machine__get_current_tid(spe->machine, speq->cpu);
+	if (tid != -1) {
+		speq->tid = tid;
+		thread__zput(speq->thread);
+	} else
+		speq->tid = queue->tid;
+
+	if ((!speq->thread) && (speq->tid != -1)) {
+		speq->thread = machine__find_thread(spe->machine, -1,
+						    speq->tid);
+	}
+
+	if (speq->thread) {
+		speq->pid = speq->thread->pid_;
+		if (queue->cpu == -1)
+			speq->cpu = speq->thread->cpu;
+	}
+}
+
+static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
+{
+	struct arm_spe *spe = speq->spe;
+	int err = machine__set_current_tid(spe->machine, speq->cpu, -1, tid);
+
+	if (err)
+		return err;
+
+	arm_spe_set_pid_tid_cpu(spe, &spe->queues.queue_array[speq->queue_nr]);
+
+	return 0;
+}
+
 static void arm_spe_prep_sample(struct arm_spe *spe,
 				struct arm_spe_queue *speq,
 				union perf_event *event,
@@ -460,6 +499,19 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		 * can correlate samples between Arm SPE trace data and other
 		 * perf events with correct time ordering.
 		 */
+
+		/*
+		 * Update pid/tid info.
+		 */
+		record = &speq->decoder->record;
+		if (!spe->timeless_decoding && record->context_id != (u64)-1) {
+			ret = arm_spe_set_tid(speq, record->context_id);
+			if (ret)
+				return ret;
+
+			spe->use_ctx_pkt_for_pid = true;
+		}
+
 		ret = arm_spe_sample(speq);
 		if (ret)
 			return ret;
@@ -586,31 +638,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
 	return timeless_decoding;
 }
 
-static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
-				    struct auxtrace_queue *queue)
-{
-	struct arm_spe_queue *speq = queue->priv;
-	pid_t tid;
-
-	tid = machine__get_current_tid(spe->machine, speq->cpu);
-	if (tid != -1) {
-		speq->tid = tid;
-		thread__zput(speq->thread);
-	} else
-		speq->tid = queue->tid;
-
-	if ((!speq->thread) && (speq->tid != -1)) {
-		speq->thread = machine__find_thread(spe->machine, -1,
-						    speq->tid);
-	}
-
-	if (speq->thread) {
-		speq->pid = speq->thread->pid_;
-		if (queue->cpu == -1)
-			speq->cpu = speq->thread->cpu;
-	}
-}
-
 static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
 {
 	unsigned int queue_nr;
@@ -641,7 +668,12 @@ static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
 			ts = timestamp;
 		}
 
-		arm_spe_set_pid_tid_cpu(spe, queue);
+		/*
+		 * A previous context-switch event has set pid/tid in the machine's context, so
+		 * here we need to update the pid/tid in the thread and SPE queue.
+		 */
+		if (!spe->use_ctx_pkt_for_pid)
+			arm_spe_set_pid_tid_cpu(spe, queue);
 
 		ret = arm_spe_run_decoder(speq, &ts);
 		if (ret < 0) {
@@ -740,8 +772,9 @@ static int arm_spe_process_event(struct perf_session *session,
 		if (err)
 			return err;
 
-		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
-		    event->header.type == PERF_RECORD_SWITCH)
+		if (!spe->use_ctx_pkt_for_pid &&
+		    (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+		    event->header.type == PERF_RECORD_SWITCH))
 			err = arm_spe_context_switch(spe, event, sample);
 	}
 
@@ -808,7 +841,15 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
 		return arm_spe_process_timeless_queues(spe, -1,
 				MAX_TIMESTAMP - 1);
 
-	return arm_spe_process_queues(spe, MAX_TIMESTAMP);
+	ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
+	if (ret)
+		return ret;
+
+	if (!spe->use_ctx_pkt_for_pid)
+		ui__warning("Arm SPE CONTEXT packets not found in the traces.\n"
+			    "Matching of TIDs to SPE events could be inaccurate.\n");
+
+	return 0;
 }
 
 static void arm_spe_free_queue(void *priv)
-- 
2.25.1

