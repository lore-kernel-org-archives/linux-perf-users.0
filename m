Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC4C636C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95C061222
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhGUOW5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:22:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239519AbhGUOWA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 10:22:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061641396;
        Wed, 21 Jul 2021 08:02:30 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62D253F73D;
        Wed, 21 Jul 2021 08:02:27 -0700 (PDT)
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
Subject: [PATCH v2 6/6] perf cs-etm: Pass unformatted flag to decoder
Date:   Wed, 21 Jul 2021 16:02:02 +0100
Message-Id: <20210721150202.32065-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
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
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
 tools/perf/util/cs-etm.c                      | 53 ++++++++++++++-----
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ed1f0326f859..9c9039ae6989 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -687,7 +687,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 }
 
 struct cs_etm_decoder *
-cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
+cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 		    struct cs_etm_trace_params t_params[])
 {
 	struct cs_etm_decoder *decoder;
@@ -732,7 +732,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	/* init raw frame logging if required */
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
-	for (i = 0; i < num_cpu; i++) {
+	for (i = 0; i < decoders; i++) {
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
 							 &t_params[i],
 							 decoder);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 760050ea936d..f4b2bff533f3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
-				     struct cs_etm_auxtrace *etm)
+				     struct cs_etm_auxtrace *etm,
+				     int decoders)
 {
 	int i;
 	u32 etmidr;
 	u64 architecture;
 
-	for (i = 0; i < etm->num_cpu; i++) {
+	for (i = 0; i < decoders; i++) {
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
@@ -720,11 +722,17 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return len;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
+static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
+						bool formatted)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
+	/*
+	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
+	 * needed.
+	 */
+	int decoders = formatted ? etm->num_cpu : 1;
 
 	etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
@@ -735,21 +743,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 		goto out_free;
 
 	/* Use metadata to fill in trace parameters for trace decoder */
-	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+	t_params = zalloc(sizeof(*t_params) * decoders);
 
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etm))
+	if (cs_etm__init_trace_params(t_params, etm, decoders))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					dump_trace ? CS_ETM_OPERATION_PRINT :
-						     CS_ETM_OPERATION_DECODE))
+						     CS_ETM_OPERATION_DECODE,
+					formatted))
 		goto out_free;
 
-	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
+	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
+					    t_params);
 
 	if (!etmq->decoder)
 		goto out_free;
@@ -777,14 +787,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 
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
@@ -2430,8 +2441,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
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
 
@@ -2678,6 +2695,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	union perf_event auxtrace_fragment;
 	__u64 aux_offset, aux_size;
 	__u32 idx;
+	bool formatted;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
@@ -2745,7 +2763,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 			return err;
 
 		idx = auxtrace_event->idx;
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
+		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
+		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
+					   idx, formatted);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
@@ -3034,6 +3054,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 
 	etm->data_queued = etm->queues.populated;
+	/*
+	 * Print warning in pipe mode, see cs_etm__process_auxtrace_event() and
+	 * cs_etm__queue_aux_fragment() for details relating to limitations.
+	 */
+	if (!etm->data_queued)
+		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
+			   "Continuing with best effort decoding in piped mode.\n\n");
 
 	return 0;
 
-- 
2.28.0

