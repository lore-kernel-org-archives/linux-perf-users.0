Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7BBC433E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8F22E00
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392070AbhASRzU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:55:20 -0500
Received: from foss.arm.com ([217.140.110.172]:34516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391230AbhASOuL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 09:50:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE798147A;
        Tue, 19 Jan 2021 06:47:42 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.56.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37BAD3F66E;
        Tue, 19 Jan 2021 06:47:38 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 8/8] perf arm-spe: Set thread TID
Date:   Tue, 19 Jan 2021 16:46:58 +0200
Message-Id: <20210119144658.793-8-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Set thread TID for SPE samples. Now that the context ID is saved
in each record it can be used to set the TID for a sample.

The context ID is only present in SPE data if the kernel is
compiled with CONFIG_PID_IN_CONTEXTIDR and perf record is
run as root. Otherwise the PID of the first process is assigned
to each SPE sample.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Wei Li <liwei391@huawei.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 27a0b9dfe22d..9828fad7e516 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -223,6 +223,46 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
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
+	int err;
+	struct arm_spe *spe = speq->spe;
+	struct auxtrace_queue *queue;
+
+	err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
+	if (err)
+		return err;
+
+	queue = &speq->spe->queues.queue_array[speq->queue_nr];
+	arm_spe_set_pid_tid_cpu(speq->spe, queue);
+	return 0;
+}
+
 static void arm_spe_prep_sample(struct arm_spe *spe,
 				struct arm_spe_queue *speq,
 				union perf_event *event,
@@ -431,6 +471,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 {
 	struct arm_spe *spe = speq->spe;
+	const struct arm_spe_record *record;
 	int ret;
 
 	if (!spe->kernel_start)
@@ -450,6 +491,11 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		if (ret < 0)
 			continue;
 
+		record = &speq->decoder->record;
+		ret = arm_spe_set_tid(speq, record->context_id);
+		if (ret)
+			return ret;
+
 		ret = arm_spe_sample(speq);
 		if (ret)
 			return ret;
@@ -500,6 +546,10 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
 
 		record = &speq->decoder->record;
 
+		ret = arm_spe_set_tid(speq, record->context_id);
+		if (ret)
+			return ret;
+
 		speq->timestamp = record->timestamp;
 		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
 		if (ret)
@@ -552,31 +602,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
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
-- 
2.28.0

