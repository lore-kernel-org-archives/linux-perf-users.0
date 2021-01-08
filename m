Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A0C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Jan 2021 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F7322AAF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Jan 2021 14:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbhAHO2y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:28:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAHO2x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Jan 2021 09:28:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844F4ED1;
        Fri,  8 Jan 2021 06:28:07 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.1.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 996B73F70D;
        Fri,  8 Jan 2021 06:28:03 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: Update OpenCSD to v1.0.0
Date:   Fri,  8 Jan 2021 16:27:52 +0200
Message-Id: <20210108142752.27872-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Replace the OCSD_INSTR switch statement with an if to
fix compilation error about unhandled values and avoid
this issue again in the future.

Add new OCSD_GEN_TRC_ELEM_SYNC_MARKER and
OCSD_GEN_TRC_ELEM_MEMTRANS enum values to fix unhandled
value compilation error. Currently they are ignored.

Increase the minimum version number to v1.0.0 now
that new enum values are used that are only present
in this version.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/feature/test-libopencsd.c           |  4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 15 ++++-----------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 1547bc2c0950..52c790b0317b 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
+#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.14.0 is required"
+#error "OpenCSD >= 1.0.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd007cc9c283..3f4bc4050477 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -419,19 +419,10 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	packet->last_instr_subtype = elem->last_i_subtype;
 	packet->last_instr_cond = elem->last_instr_cond;
 
-	switch (elem->last_i_type) {
-	case OCSD_INSTR_BR:
-	case OCSD_INSTR_BR_INDIRECT:
+	if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
 		packet->last_instr_taken_branch = elem->last_instr_exec;
-		break;
-	case OCSD_INSTR_ISB:
-	case OCSD_INSTR_DSB_DMB:
-	case OCSD_INSTR_WFI_WFE:
-	case OCSD_INSTR_OTHER:
-	default:
+	else
 		packet->last_instr_taken_branch = false;
-		break;
-	}
 
 	packet->last_instr_size = elem->last_instr_sz;
 
@@ -572,6 +563,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_EVENT:
 	case OCSD_GEN_TRC_ELEM_SWTRACE:
 	case OCSD_GEN_TRC_ELEM_CUSTOM:
+	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
+	case OCSD_GEN_TRC_ELEM_MEMTRANS:
 	default:
 		break;
 	}
-- 
2.28.0

