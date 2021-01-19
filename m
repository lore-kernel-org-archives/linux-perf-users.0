Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE72C282E1
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5153823103
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392014AbhASRy6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:54:58 -0500
Received: from foss.arm.com ([217.140.110.172]:34518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391243AbhASOuL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 09:50:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11A11474;
        Tue, 19 Jan 2021 06:47:38 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.56.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201AE3F66E;
        Tue, 19 Jan 2021 06:47:34 -0800 (PST)
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
Subject: [PATCH 7/8] perf arm-spe: Save context ID in record
Date:   Tue, 19 Jan 2021 16:46:57 +0200
Message-Id: <20210119144658.793-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to save context ID in record, this will be used to set TID
for samples.

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
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 32fe41835fa6..1b58859d2314 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 	u64 payload, ip;
 
 	memset(&decoder->record, 0x0, sizeof(decoder->record));
+	decoder->record.context_id = -1;
 
 	while (1) {
 		err = arm_spe_get_next_packet(decoder);
@@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_COUNTER:
 			break;
 		case ARM_SPE_CONTEXT:
+			decoder->record.context_id = payload;
 			break;
 		case ARM_SPE_OP_TYPE:
 			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 59bdb7309674..46a8556a9e95 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -38,6 +38,7 @@ struct arm_spe_record {
 	u64 timestamp;
 	u64 virt_addr;
 	u64 phys_addr;
+	u64 context_id;
 };
 
 struct arm_spe_insn;
-- 
2.28.0

