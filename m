Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D81C636CA
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1EF60FF1
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhGUOWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:22:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239515AbhGUOVs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AED211D4;
        Wed, 21 Jul 2021 08:02:20 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B3EA3F73D;
        Wed, 21 Jul 2021 08:02:17 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] perf cs-etm: Only setup queues when they are modified
Date:   Wed, 21 Jul 2021 16:01:59 +0100
Message-Id: <20210721150202.32065-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Continually creating queues in cs_etm__process_event() is unnecessary.
They only need to be created when a buffer for a new CPU or thread is
encountered. This can be in two places, when building the queues in
advance in cs_etm__process_auxtrace_info(), or in
cs_etm__process_auxtrace_event() when data_queued is false and the
index wasn't available (pipe mode).

This change will allow the 'formatted' decoder setting to applied when
iterating over aux records in a later commit.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 54 +++++++++++-----------------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 426e99c07ca9..2d07e52ffd3c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -96,7 +96,6 @@ struct cs_etm_queue {
 /* RB tree for quick conversion between traceID and metadata pointers */
 static struct intlist *traceid_list;
 
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
@@ -564,7 +563,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 static int cs_etm__flush_events(struct perf_session *session,
 				struct perf_tool *tool)
 {
-	int ret;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
@@ -574,11 +572,6 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	ret = cs_etm__update_queues(etm);
-
-	if (ret < 0)
-		return ret;
-
 	if (etm->timeless_decoding)
 		return cs_etm__process_timeless_queues(etm, -1);
 
@@ -898,30 +891,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
 	return ret;
 }
 
-static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
-{
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < etm->queues.nr_queues; i++) {
-		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
-{
-	if (etm->queues.new_data) {
-		etm->queues.new_data = false;
-		return cs_etm__setup_queues(etm);
-	}
-
-	return 0;
-}
-
 static inline
 void cs_etm__copy_last_branch_rb(struct cs_etm_queue *etmq,
 				 struct cs_etm_traceid_queue *tidq)
@@ -2395,7 +2364,6 @@ static int cs_etm__process_event(struct perf_session *session,
 				 struct perf_sample *sample,
 				 struct perf_tool *tool)
 {
-	int err = 0;
 	u64 sample_kernel_timestamp;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
@@ -2414,12 +2382,6 @@ static int cs_etm__process_event(struct perf_session *session,
 	else
 		sample_kernel_timestamp = 0;
 
-	if (sample_kernel_timestamp || etm->timeless_decoding) {
-		err = cs_etm__update_queues(etm);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * Don't wait for cs_etm__flush_events() in per-thread/timeless mode to start the decode. We
 	 * need the tid of the PERF_RECORD_EXIT event to assign to the synthesised samples because
@@ -2476,6 +2438,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		int fd = perf_data__fd(session->data);
 		bool is_pipe = perf_data__is_pipe(session->data);
 		int err;
+		int idx = event->auxtrace.idx;
 
 		if (is_pipe)
 			data_offset = 0;
@@ -2490,6 +2453,11 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		if (err)
 			return err;
 
+		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
+					  idx);
+		if (err)
+			return err;
+
 		if (dump_trace)
 			if (auxtrace_buffer__get_data(buffer, fd)) {
 				cs_etm__dump_event(etm, buffer);
@@ -2732,6 +2700,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	struct perf_record_auxtrace *auxtrace_event;
 	union perf_event auxtrace_fragment;
 	__u64 aux_offset, aux_size;
+	__u32 idx;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
@@ -2793,8 +2762,13 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
 			  " tid: %d cpu: %d\n", aux_size, aux_offset, sample->tid, sample->cpu);
-		return auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
-						  file_offset, NULL);
+		err = auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
+						 file_offset, NULL);
+		if (err)
+			return err;
+
+		idx = auxtrace_event->idx;
+		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
-- 
2.28.0

