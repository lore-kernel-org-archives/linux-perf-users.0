Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E97C10DC1
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384D622E01
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbhASRys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:54:48 -0500
Received: from foss.arm.com ([217.140.110.172]:34378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389207AbhASOs0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 09:48:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22EA143B;
        Tue, 19 Jan 2021 06:47:34 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.56.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85C403F66E;
        Tue, 19 Jan 2021 06:47:31 -0800 (PST)
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
Subject: [PATCH 6/8] perf arm-spe: Set sample's data source field
Date:   Tue, 19 Jan 2021 16:46:56 +0200
Message-Id: <20210119144658.793-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The sample structure contains the field 'data_src' which is used to
tell the data operation attributions, e.g. operation type is loading or
storing, cache level, it's snooping or remote accessing, etc.  At the
end, the 'data_src' will be parsed by perf mem/c2c tools to display
human readable strings.

This patch is to fill the 'data_src' field in the synthesized samples
base on different types.  Currently perf tool can display statistics for
L1/L2/L3 caches but it doesn't support the 'last level cache'.  To fit
to current implementation, 'data_src' field uses L3 cache for last level
cache.

Before this commit, perf mem report looks like this:
    # Samples: 75K of event 'l1d-miss'
    # Total weight : 75951
    # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
    #
    # Overhead       Samples  Local Weight  Memory access             Symbol                  Shared Object     Data Symbol             Data Object       Snoop         TLB access
    # ........  ............  ............  ........................  ......................  ................  ......................  ................  ............  ...................
    #
        81.56%         61945  0             N/A                       [.] 0x00000000000009d8  serial_c          [.] 0000000000000000    [unknown]         N/A           N/A
        18.44%         14003  0             N/A                       [.] 0x0000000000000828  serial_c          [.] 0000000000000000    [unknown]         N/A           N/A

Now on a system with Arm SPE, addresses and access types are displayed:

    # Samples: 75K of event 'l1d-miss'
    # Total weight : 75951
    # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
    #
    # Overhead       Samples  Local Weight  Memory access             Symbol                  Shared Object     Data Symbol             Data Object  Snoop         TLB access
    # ........  ............  ............  ........................  ......................  ................  ......................  ...........  ............  ......................
    #
         0.43%           324  0             L1 miss                   [.] 0x00000000000009d8  serial_c          [.] 0x0000ffff80794e00  anon         N/A           Walker hit
         0.42%           322  0             L1 miss                   [.] 0x00000000000009d8  serial_c          [.] 0x0000ffff80794580  anon         N/A           Walker hit

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
 tools/perf/util/arm-spe.c | 69 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 5550906486d8..27a0b9dfe22d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -261,7 +261,7 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 }
 
 static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
-				     u64 spe_events_id)
+				     u64 spe_events_id, u64 data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -274,6 +274,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->virt_addr;
 	sample.phys_addr = record->phys_addr;
+	sample.data_src = data_src;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -307,21 +308,66 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
 	return false;
 }
 
+static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
+{
+	union perf_mem_data_src	data_src = { 0 };
+
+	if (record->op == ARM_SPE_LD)
+		data_src.mem_op = PERF_MEM_OP_LOAD;
+	else
+		data_src.mem_op = PERF_MEM_OP_STORE;
+
+	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
+		data_src.mem_lvl = PERF_MEM_LVL_L3;
+
+		if (record->type & ARM_SPE_LLC_MISS)
+			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+		else
+			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
+		data_src.mem_lvl = PERF_MEM_LVL_L1;
+
+		if (record->type & ARM_SPE_L1D_MISS)
+			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+		else
+			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+	}
+
+	if (record->type & ARM_SPE_REMOTE_ACCESS)
+		data_src.mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+
+	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
+		data_src.mem_dtlb = PERF_MEM_TLB_WK;
+
+		if (record->type & ARM_SPE_TLB_MISS)
+			data_src.mem_dtlb |= PERF_MEM_TLB_MISS;
+		else
+			data_src.mem_dtlb |= PERF_MEM_TLB_HIT;
+	}
+
+	return data_src.val;
+}
+
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
 	struct arm_spe *spe = speq->spe;
+	u64 data_src;
 	int err;
 
+	data_src = arm_spe__synth_data_source(record);
+
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_L1D_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -329,13 +375,15 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_llc) {
 		if (record->type & ARM_SPE_LLC_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_LLC_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -343,13 +391,15 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_tlb) {
 		if (record->type & ARM_SPE_TLB_MISS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id,
+							data_src);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_TLB_ACCESS) {
-			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id,
+							data_src);
 			if (err)
 				return err;
 		}
@@ -363,13 +413,14 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_remote_access &&
 	    (record->type & ARM_SPE_REMOTE_ACCESS)) {
-		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id);
+		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id,
+						data_src);
 		if (err)
 			return err;
 	}
 
 	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
-		err = arm_spe__synth_mem_sample(speq, spe->memory_id);
+		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
 	}
-- 
2.28.0

