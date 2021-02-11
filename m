Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6BC433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D660D64DC3
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBKNld (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:41:33 -0500
Received: from foss.arm.com ([217.140.110.172]:52076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231827AbhBKNkO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Feb 2021 08:40:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA05D1396;
        Thu, 11 Feb 2021 05:39:26 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.43.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94DB93F73B;
        Thu, 11 Feb 2021 05:39:22 -0800 (PST)
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
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 3/6] perf arm-spe: Store operation type in packet
Date:   Thu, 11 Feb 2021 15:38:53 +0200
Message-Id: <20210211133856.2137-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210211133856.2137-1-james.clark@arm.com>
References: <20210211133856.2137-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to store operation type in packet structure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
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
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 ++++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 7aac3048b090..32fe41835fa6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -182,6 +182,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_CONTEXT:
 			break;
 		case ARM_SPE_OP_TYPE:
+			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
+				if (payload & 0x1)
+					decoder->record.op = ARM_SPE_ST;
+				else
+					decoder->record.op = ARM_SPE_LD;
+			}
 			break;
 		case ARM_SPE_EVENTS:
 			if (payload & BIT(EV_L1D_REFILL))
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 7b845001afe7..59bdb7309674 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -24,9 +24,15 @@ enum arm_spe_sample_type {
 	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
 };
 
+enum arm_spe_op_type {
+	ARM_SPE_LD		= 1 << 0,
+	ARM_SPE_ST		= 1 << 1,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
+	u32 op;
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
-- 
2.28.0

