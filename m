Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9760C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A13761059
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 09:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhEGJ7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 05:59:30 -0400
Received: from foss.arm.com ([217.140.110.172]:53158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233487AbhEGJ73 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 05:59:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F1C113E;
        Fri,  7 May 2021 02:58:29 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.84.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F2C23F718;
        Fri,  7 May 2021 02:58:25 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Date:   Fri,  7 May 2021 12:58:13 +0300
Message-Id: <20210507095814.17933-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is an intermittent issue on Trogdor devices that
results in all Coresight timestamps having a value of zero.
Because zero is currently treated as "not found" rather
than "found but zero", this breaks the decoding flow
when it would otherwise work.

This patch adds an out parameter and return code so
the difference between zero and non-existent timestamps
can be determined.

There is also a change to fix an underflow.

Although this is a workaround, the change is technically
a valid way of writing the cs_etm__etmq_get_timestamp()
function. It could have been written similarly to this
without trying to work around this issue, so it's no less
correct. But, because it's a workaround to a problem
elsewhere, I will submit this as an RFC for feedback.

This patch applies on top of the "[PATCH v2 0/2] perf
cs-etm: Set time on synthesised samples to preserve ordering"
patchset.

Co-developed-by: Denis Nikitin <denik@chromium.org>
Signed-off-by: Denis Nikitin <denik@chromium.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  5 ++++-
 tools/perf/util/cs-etm.c                      | 22 +++++++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b01d363b9301..947e44413c6e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	 * which instructions started by subtracting the number of instructions
 	 * executed to the timestamp.
 	 */
-	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
+	if (packet_queue->instr_count >= elem->timestamp)
+		packet_queue->cs_timestamp = 0;
+	else
+		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
 	packet_queue->next_cs_timestamp = elem->timestamp;
 	packet_queue->instr_count = 0;
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e5c1a1b22a2a..1969921c406a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -210,13 +210,14 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 	etmq->pending_timestamp_chan_id = trace_chan_id;
 }
 
-static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
+static int cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
+				      u64 *timestamp,
 				      u8 *trace_chan_id)
 {
 	struct cs_etm_packet_queue *packet_queue;
 
 	if (!etmq->pending_timestamp_chan_id)
-		return 0;
+		return -ENODATA;
 
 	if (trace_chan_id)
 		*trace_chan_id = etmq->pending_timestamp_chan_id;
@@ -224,13 +225,15 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
 						     etmq->pending_timestamp_chan_id);
 	if (!packet_queue)
-		return 0;
+		return -ENODATA;
 
 	/* Acknowledge pending status */
 	etmq->pending_timestamp_chan_id = 0;
 
 	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
-	return packet_queue->cs_timestamp;
+	if (timestamp)
+		*timestamp = packet_queue->cs_timestamp;
+	return 0;
 }
 
 static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
@@ -864,11 +867,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
 		 * the timestamp calculation for us.
 		 */
-		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
-
-		/* We found a timestamp, no need to continue. */
-		if (cs_timestamp)
+		if (!cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
+			/* We found a timestamp, no need to continue. */
 			break;
+		}
 
 		/*
 		 * We didn't find a timestamp so empty all the traceid packet
@@ -2286,9 +2288,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 		if (ret)
 			goto out;
 
-		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
-
-		if (!cs_timestamp) {
+		if (cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
 			/*
 			 * Function cs_etm__decode_data_block() returns when
 			 * there is no more traces to decode in the current
-- 
2.28.0

