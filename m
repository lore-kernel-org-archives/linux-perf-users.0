Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3911C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD82F6135F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhGMPnw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:43:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237181AbhGMPnw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 11:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2CBD6E;
        Tue, 13 Jul 2021 08:41:02 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F7043F774;
        Tue, 13 Jul 2021 08:40:58 -0700 (PDT)
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
Subject: [PATCH 6/6] perf cs-etm: Pass unformatted flag to decoder
Date:   Tue, 13 Jul 2021 16:40:08 +0100
Message-Id: <20210713154008.29656-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210713154008.29656-1-james.clark@arm.com>
References: <20210713154008.29656-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The TRBE (Trace Buffer Extension) feature allows a separate trace buffer
for each trace source, therefore the trace wouldn't need to be
formatted. The driver was introduced in commit 3fbf7f011f24
("coresight: sink: Add TRBE driver").

The formatted/unformatted mode is encoded in one of the flags of the
AUX record. The first AUX record encountered for each event is used to
determine the mode, and this will persist for the remaining trace that
is either decoded or dumped.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 760050ea936d..62769a84a53f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
-				     struct cs_etm_auxtrace *etm)
+				     struct cs_etm_auxtrace *etm,
+				     int decoders_per_cpu)
 {
 	int i;
 	u32 etmidr;
 	u64 architecture;
 
-	for (i = 0; i < etm->num_cpu; i++) {
+	for (i = 0; i < decoders_per_cpu; i++) {
 		architecture = etm->metadata[i][CS_ETM_MAGIC];
 
 		switch (architecture) {
@@ -488,7 +489,8 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
-				       enum cs_etm_decoder_operation mode)
+				       enum cs_etm_decoder_operation mode,
+				       bool formatted)
 {
 	int ret = -EINVAL;
 
@@ -498,7 +500,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 	d_params->packet_printer = cs_etm__packet_dump;
 	d_params->operation = mode;
 	d_params->data = etmq;
-	d_params->formatted = true;
+	d_params->formatted = formatted;
 	d_params->fsyncs = false;
 	d_params->hsyncs = false;
 	d_params->frame_aligned = true;
@@ -720,11 +722,13 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return len;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
+static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
+						bool formatted)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
+	int decoders_per_cpu = formatted ? etm->num_cpu : 1;
 
 	etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
@@ -735,21 +739,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 		goto out_free;
 
 	/* Use metadata to fill in trace parameters for trace decoder */
-	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+	t_params = zalloc(sizeof(*t_params) * decoders_per_cpu);
 
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etm))
+	if (cs_etm__init_trace_params(t_params, etm, decoders_per_cpu))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					dump_trace ? CS_ETM_OPERATION_PRINT :
-						     CS_ETM_OPERATION_DECODE))
+						     CS_ETM_OPERATION_DECODE,
+					formatted))
 		goto out_free;
 
-	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
+	etmq->decoder = cs_etm_decoder__new(decoders_per_cpu, &d_params,
+					    t_params);
 
 	if (!etmq->decoder)
 		goto out_free;
@@ -777,14 +783,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr)
+			       unsigned int queue_nr,
+			       bool formatted)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
 		return 0;
 
-	etmq = cs_etm__alloc_queue(etm);
+	etmq = cs_etm__alloc_queue(etm, formatted);
 
 	if (!etmq)
 		return -ENOMEM;
@@ -2430,8 +2437,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		if (err)
 			return err;
 
+		/*
+		 * Knowing if the trace is formatted or not requires a lookup of
+		 * the aux record so only works in non-piped mode where data is
+		 * queued in cs_etm__queue_aux_records(). Always assume
+		 * formatted in piped mode (true).
+		 */
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx);
+					  idx, true);
 		if (err)
 			return err;
 
@@ -2678,6 +2691,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	union perf_event auxtrace_fragment;
 	__u64 aux_offset, aux_size;
 	__u32 idx;
+	bool formatted;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
@@ -2745,7 +2759,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 			return err;
 
 		idx = auxtrace_event->idx;
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
+		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
+		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
+					   idx, formatted);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
-- 
2.28.0

