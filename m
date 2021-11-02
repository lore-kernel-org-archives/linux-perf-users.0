Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D1D60230
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhKBSKs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:10:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234946AbhKBSKo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Nov 2021 14:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D882711B3;
        Tue,  2 Nov 2021 11:08:08 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E9223F7B4;
        Tue,  2 Nov 2021 11:08:06 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] perf arm-spe: Support hardware-based PID tracing
Date:   Tue,  2 Nov 2021 18:07:39 +0000
Message-Id: <20211102180739.18049-4-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211102180739.18049-1-german.gomez@arm.com>
References: <20211102180739.18049-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If Arm SPE traces contain CONTEXT packets with PID info, use these
values for tracking pid of samples. Otherwise fall back to using context
switch events and display a message warning the user of possible timing
inaccuracies [1].

[1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 123 ++++++++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 230bc7ab2..00a409469 100644
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
+	int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
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
@@ -460,6 +499,13 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		 * can correlate samples between Arm SPE trace data and other
 		 * perf events with correct time ordering.
 		 */
+
+		if (spe->use_ctx_pkt_for_pid) {
+			ret = arm_spe_set_tid(speq, speq->decoder->record.context_id);
+			if (ret)
+				return ret;
+		}
+
 		ret = arm_spe_sample(speq);
 		if (ret)
 			return ret;
@@ -586,31 +632,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
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
@@ -641,7 +662,13 @@ static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
 			ts = timestamp;
 		}
 
-		arm_spe_set_pid_tid_cpu(spe, queue);
+		/*
+		 * Here we only consider PID tracking based on switch events.
+		 * For tracking based on CONTEXT packets, the pid is assigned in the function
+		 * arm_spe_run_decoder() in order to support timeless decoding.
+		 */
+		if (!spe->use_ctx_pkt_for_pid)
+			arm_spe_set_pid_tid_cpu(spe, queue);
 
 		ret = arm_spe_run_decoder(speq, &ts);
 		if (ret < 0) {
@@ -740,8 +767,9 @@ static int arm_spe_process_event(struct perf_session *session,
 		if (err)
 			return err;
 
-		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
-		    event->header.type == PERF_RECORD_SWITCH)
+		if (!spe->use_ctx_pkt_for_pid &&
+		    (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+		     event->header.type == PERF_RECORD_SWITCH))
 			err = arm_spe_context_switch(spe, event, sample);
 	}
 
@@ -805,10 +833,16 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
 		return ret;
 
 	if (spe->timeless_decoding)
-		return arm_spe_process_timeless_queues(spe, -1,
+		ret = arm_spe_process_timeless_queues(spe, -1,
 				MAX_TIMESTAMP - 1);
+	else
+		ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
 
-	return arm_spe_process_queues(spe, MAX_TIMESTAMP);
+	if (!spe->use_ctx_pkt_for_pid)
+		ui__warning("Arm SPE CONTEXT packets not found in the traces.\n\n"
+			    "Matching of TIDs to SPE events could be inaccurate.\n\n");
+
+	return ret;
 }
 
 static void arm_spe_free_queue(void *priv)
@@ -1056,6 +1090,22 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	return 0;
 }
 
+static bool arm_spe_is_ctx_pkt_enabled(struct arm_spe *spe)
+{
+	struct auxtrace_queues *queues = &spe->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		struct auxtrace_queue *queue = &spe->queues.queue_array[i];
+		struct arm_spe_queue *speq = queue->priv;
+
+		if (speq)
+			return speq->decoder->record.context_id != (u64) -1;
+	}
+
+	return false;
+}
+
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -1131,9 +1181,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	if (spe->queues.populated)
+	if (spe->queues.populated) {
 		spe->data_queued = true;
 
+		/*
+		 * Ensure the first record of every queue can be read in the function
+		 * arm_spe_is_ctx_pkt_enabled()
+		 */
+		err = arm_spe__update_queues(spe);
+		if (err)
+			goto err_free_queues;
+
+		spe->use_ctx_pkt_for_pid = arm_spe_is_ctx_pkt_enabled(spe);
+	}
+
 	return 0;
 
 err_free_queues:
-- 
2.25.1

