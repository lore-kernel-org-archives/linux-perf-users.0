Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67019C43219
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3782F2310B
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbhASRym (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:54:42 -0500
Received: from foss.arm.com ([217.140.110.172]:34358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbhASOsQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 09:48:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 254C5142F;
        Tue, 19 Jan 2021 06:47:31 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.56.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 556B23F66E;
        Tue, 19 Jan 2021 06:47:27 -0800 (PST)
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
Subject: [PATCH 5/8] perf arm-spe: Synthesize memory event
Date:   Tue, 19 Jan 2021 16:46:55 +0200
Message-Id: <20210119144658.793-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The memory event can deliver two benefits:

- The first benefit is the memory event can give out global view for
  memory accessing, rather than organizing events with scatter mode
  (e.g. uses separate event for L1 cache, last level cache, etc) which
  which can only display a event for single memory type, memory events
  include all memory accessing so it can display the data accessing
  cross memory levels in the same view;

- The second benefit is the sample generation might introduce a big
  overhead and need to wait for long time for Perf reporting, we can
  specify itrace option '--itrace=M' to filter out other events and only
  output memory events, this can significantly reduce the overhead
  caused by generating samples.

This patch is to enable memory event for Arm SPE.

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
 tools/perf/util/arm-spe.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 578725344603..5550906486d8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -53,6 +53,7 @@ struct arm_spe {
 	u8				sample_tlb;
 	u8				sample_branch;
 	u8				sample_remote_access;
+	u8				sample_memory;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -62,6 +63,7 @@ struct arm_spe {
 	u64				tlb_access_id;
 	u64				branch_miss_id;
 	u64				remote_access_id;
+	u64				memory_id;
 
 	u64				kernel_start;
 
@@ -293,6 +295,18 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
+#define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
+			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
+			 ARM_SPE_REMOTE_ACCESS)
+
+static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
+{
+	if (type & SPE_MEM_TYPE)
+		return true;
+
+	return false;
+}
+
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -354,6 +368,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
+	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
+		err = arm_spe__synth_mem_sample(speq, spe->memory_id);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -917,6 +937,16 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 	}
 
+	if (spe->synth_opts.mem) {
+		spe->sample_memory = true;
+
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->memory_id = id;
+		arm_spe_set_event_name(evlist, id, "memory");
+	}
+
 	return 0;
 }
 
-- 
2.28.0

