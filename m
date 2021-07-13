Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E76EC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8731161175
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhGMPnd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:43:33 -0400
Received: from foss.arm.com ([217.140.110.172]:45576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237020AbhGMPnd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 11:43:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40D7E6D;
        Tue, 13 Jul 2021 08:40:43 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E63593F774;
        Tue, 13 Jul 2021 08:40:38 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf cs-etm: Split setup and timestamp search functions
Date:   Tue, 13 Jul 2021 16:40:04 +0100
Message-Id: <20210713154008.29656-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210713154008.29656-1-james.clark@arm.com>
References: <20210713154008.29656-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This refactoring has some benefits:
 * Decoding is done to find the timestamp. If we want to print errors
   when maps aren't available, then doing it from cs_etm__setup_queue()
   may cause warnings to be printed.
 * The cs_etm__setup_queue() flow is shared between timed and timeless
   modes, so it needs to be guarded by an if statement which can now
   be removed.
 * Allows moving the setup queues function earlier.
 * If data was piped in, then not all queues would be filled so it
   wouldn't have worked properly anyway. Now it waits for flush so
   data in all queues will be available.

The motivation for this is to decouple setup functions with ones that
involve decoding. That way we can move the setup function earlier when
the formatted/unformatted trace information is available.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4c69ef391f60..426e99c07ca9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -809,29 +809,32 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
 {
-	int ret = 0;
-	unsigned int cs_queue_nr;
-	u8 trace_chan_id;
-	u64 cs_timestamp;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
-		goto out;
+		return 0;
 
 	etmq = cs_etm__alloc_queue(etm);
 
-	if (!etmq) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!etmq)
+		return -ENOMEM;
 
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
 	etmq->offset = 0;
 
-	if (etm->timeless_decoding)
-		goto out;
+	return 0;
+}
+
+static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
+					    struct cs_etm_queue *etmq,
+					    unsigned int queue_nr)
+{
+	int ret = 0;
+	unsigned int cs_queue_nr;
+	u8 trace_chan_id;
+	u64 cs_timestamp;
 
 	/*
 	 * We are under a CPU-wide trace scenario.  As such we need to know
@@ -2218,13 +2221,27 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr;
+	unsigned int cs_queue_nr, queue_nr, i;
 	u8 trace_chan_id;
 	u64 cs_timestamp;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
 	struct cs_etm_traceid_queue *tidq;
 
+	/*
+	 * Pre-populate the heap with one entry from each queue so that we can
+	 * start processing in time order across all queues.
+	 */
+	for (i = 0; i < etm->queues.nr_queues; i++) {
+		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq)
+			continue;
+
+		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
+		if (ret)
+			return ret;
+	}
+
 	while (1) {
 		if (!etm->heap.heap_cnt)
 			goto out;
-- 
2.28.0

