Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F2C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84BD64DA8
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhBKNl3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:41:29 -0500
Received: from foss.arm.com ([217.140.110.172]:52058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhBKNkK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Feb 2021 08:40:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC6B11B3;
        Thu, 11 Feb 2021 05:39:22 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.43.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31EDF3F73B;
        Thu, 11 Feb 2021 05:39:18 -0800 (PST)
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
Subject: [PATCH v2 2/6] perf arm-spe: Store memory address in packet
Date:   Thu, 11 Feb 2021 15:38:52 +0200
Message-Id: <20210211133856.2137-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210211133856.2137-1-james.clark@arm.com>
References: <20210211133856.2137-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to store virtual and physical memory addresses in packet,
which will be used for memory samples.

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
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 90d575cee1b9..7aac3048b090 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -172,6 +172,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				decoder->record.from_ip = ip;
 			else if (idx == SPE_ADDR_PKT_HDR_INDEX_BRANCH)
 				decoder->record.to_ip = ip;
+			else if (idx == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT)
+				decoder->record.virt_addr = ip;
+			else if (idx == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS)
+				decoder->record.phys_addr = ip;
 			break;
 		case ARM_SPE_COUNTER:
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 24727b8ca7ff..7b845001afe7 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -30,6 +30,8 @@ struct arm_spe_record {
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
+	u64 virt_addr;
+	u64 phys_addr;
 };
 
 struct arm_spe_insn;
-- 
2.28.0

