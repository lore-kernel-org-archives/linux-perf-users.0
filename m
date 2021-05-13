Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B49C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16E361433
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 May 2021 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhEMOhO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 May 2021 10:37:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234553AbhEMOgx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 May 2021 10:36:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8361764;
        Thu, 13 May 2021 07:35:42 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 766E03F73B;
        Thu, 13 May 2021 07:35:39 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] perf cs-etm: Prevent and warn on underflows during timestamp calculation.
Date:   Thu, 13 May 2021 17:35:20 +0300
Message-Id: <20210513143520.22694-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513143520.22694-1-james.clark@arm.com>
References: <20210513143520.22694-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When a zero timestamp is encountered, warn once. This is to make
hardware or configuration issues visible. Also suggest that the issue
can be worked around with the --itrace=Z option.

When an underflow with a non-zero timestamp occurrs, warn every time.
This is an unexpected scenario, and with increasing timestamps, it's
unlikely that it would occur more than once, therefore it should be
ok to warn every time.

Only try to calculate the timestamp by subtracting the instruction
count if neither of the above cases are true. This makes attempting
to decode files with zero timestamps in non-timeless mode
more consistent. Currently it can half work if the timestamp wraps
around and becomes non-zero, although the behavior is undefined and
unpredictable.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 45 ++++++++++++++-----
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b01d363b9301..3e1a05bc82cc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <asm/bug.h>
 #include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/list.h>
@@ -17,6 +18,7 @@
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
+#include "debug.h"
 #include "intlist.h"
 
 /* use raw logging */
@@ -294,7 +296,8 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 static ocsd_datapath_resp_t
 cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 				  const ocsd_generic_trace_elem *elem,
-				  const uint8_t trace_chan_id)
+				  const uint8_t trace_chan_id,
+				  const ocsd_trc_index_t indx)
 {
 	struct cs_etm_packet_queue *packet_queue;
 
@@ -313,14 +316,33 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		return OCSD_RESP_CONT;
 	}
 
-	/*
-	 * This is the first timestamp we've seen since the beginning of traces
-	 * or a discontinuity.  Since timestamps packets are generated *after*
-	 * range packets have been generated, we need to estimate the time at
-	 * which instructions started by subtracting the number of instructions
-	 * executed to the timestamp.
-	 */
-	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
+
+	if (!elem->timestamp) {
+		/*
+		 * Zero timestamps can be seen due to misconfiguration or hardware bugs.
+		 * Warn once, and don't try to subtract instr_count as it would result in an
+		 * underflow.
+		 */
+		packet_queue->cs_timestamp = 0;
+		WARN_ONCE(true, "Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
+				". Decoding may be improved with --itrace=Z...\n", indx);
+	} else if (packet_queue->instr_count > elem->timestamp) {
+		/*
+		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
+		 * result in an underflow. Warn and clamp at 0 if it would.
+		 */
+		packet_queue->cs_timestamp = 0;
+		pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
+	} else {
+		/*
+		 * This is the first timestamp we've seen since the beginning of traces
+		 * or a discontinuity.  Since timestamps packets are generated *after*
+		 * range packets have been generated, we need to estimate the time at
+		 * which instructions started by subtracting the number of instructions
+		 * executed to the timestamp.
+		 */
+		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
+	}
 	packet_queue->next_cs_timestamp = elem->timestamp;
 	packet_queue->instr_count = 0;
 
@@ -542,7 +564,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
-				const ocsd_trc_index_t indx __maybe_unused,
+				const ocsd_trc_index_t indx,
 				const u8 trace_chan_id __maybe_unused,
 				const ocsd_generic_trace_elem *elem)
 {
@@ -579,7 +601,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		break;
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
-							 trace_chan_id);
+							 trace_chan_id,
+							 indx);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
 		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
-- 
2.28.0

