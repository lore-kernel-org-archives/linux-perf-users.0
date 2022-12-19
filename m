Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8030C46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSQON (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiLSQOB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 11:14:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90DE1F008;
        Mon, 19 Dec 2022 08:14:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43D851688;
        Mon, 19 Dec 2022 08:14:41 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A7873F703;
        Mon, 19 Dec 2022 08:13:57 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     robh@kernel.org, German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] perf arm-spe: Add SVE flags to the SPE samples
Date:   Mon, 19 Dec 2022 16:12:57 +0000
Message-Id: <20221219161259.3097213-4-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219161259.3097213-1-james.clark@arm.com>
References: <20221219161259.3097213-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

Add flags from the Scalable Vector Extension (SVE) to the SPE samples
which are available from Armv8.3 (FEAT_SPEv1p1).

These will be displayed in a new SIMD sort field in a later commit.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/arm-spe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index bfae4731a47a..7b36ba6b4079 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -273,6 +273,25 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
 	return 0;
 }
 
+static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *record)
+{
+	struct simd_flags simd_flags = {};
+
+	if ((record->op & ARM_SPE_OP_LDST) && (record->op & ARM_SPE_OP_SVE_LDST))
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
+
+	if ((record->op & ARM_SPE_OP_OTHER) && (record->op & ARM_SPE_OP_SVE_OTHER))
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
+
+	if (record->type & ARM_SPE_SVE_PARTIAL_PRED)
+		simd_flags.pred |= SIMD_OP_FLAGS_PRED_PARTIAL;
+
+	if (record->type & ARM_SPE_SVE_EMPTY_PRED)
+		simd_flags.pred |= SIMD_OP_FLAGS_PRED_EMPTY;
+
+	return simd_flags;
+}
+
 static void arm_spe_prep_sample(struct arm_spe *spe,
 				struct arm_spe_queue *speq,
 				union perf_event *event,
@@ -289,6 +308,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->tid = speq->tid;
 	sample->period = 1;
 	sample->cpu = speq->cpu;
+	sample->simd_flags = arm_spe__synth_simd_flags(record);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-- 
2.25.1

