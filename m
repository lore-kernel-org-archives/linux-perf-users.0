Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019421;
	b=OhUNKxJ67kz9G7AY7A/s+QKIltKnlhyNFQaAAbgSxEIfkS64zspDzFUd6xd01T8Z60Cb
	 GvfmgxPZxKXWDnVfjOtpHXmJlKuN3kp+L0bBzjvdNuJP2dvvtWApLzMEz7vxjMYTOKKXH
	 dKt7ech6vx6xe01o/zTfr3lNLLGMj2GWuAcxMIrBlefdIXiJ2sVb1uBu0FQFfJJDzMZ3R
	 sfVMjv+KnuO/koUCtLroaaFW9JDJ/Hqx7pkB5NrzAZUsaY61/tP9xfuhdPT88Z7zthMAG
	 sgmDHSPhOnAGNskeYYAL2woGEc4vD+mpVrVKah7XjgnjeNV2osrQ3TJdvMrDt2KYEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+/cFyPSe4R8rd2Uk0pIoJKmvB3bqoeY2Kqija0FTB3Q=;
	b=fG7F0sDvts1Ln2ANZdPNy6Z7iSNibC0lc1Vy9hISQpWaE9VXlcVsDZone8IzCX0klRmZ
	 wlziK9sNZZoYoFd+vd6biZGf2i4fA/i/Lw/Ze6Won7hhKstOA/zBjtYpuvogXDp7nja0+
	 0dTFTyX9zSe3UK/BjcX6RNjHLR1vlMVqnb2uieQnvqRBtCSGGGw9L1x1ecKdgVM4DlxCk
	 35Sk8vH2Bg7zbqLvICpwSUMb04iOvMp5OMDglB2aiEwwPY5TU5Fe4vAqeGY1nK44T+NZk
	 FAzEybhWbRlVKlv6wSOuIRDfTL+yOwgx1hKMEkrIdja0U0ybGm1TrKOGgUuQjWJprCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y91Hmdw+;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98360A263B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B98360A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y91Hmdw+
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492f0a1b685so840771f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019416; x=1795624216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/cFyPSe4R8rd2Uk0pIoJKmvB3bqoeY2Kqija0FTB3Q=;
        b=y91Hmdw+1R/UK01FGfVcXhYgzJKXpWwr5QFc4Ubi7pD0hCYbZqJQiVzuQPUsfuPF1J
         ERYlCX+F799g8wP0JnQVqlMetLkRAMElfZh/EM/1HIR0cxycCI2tjn5dEbtN80KzyqRT
         UhhBXWMprPtRvnMOJf1u8cBFJPS0QK6yAOFp+FeREdvt7y3Ci2E3j8ZePrr/4anCmoT7
         LwDTj22fI9AA+eFDuT26Y1prp7/QPeZEAJbUlPkqhsuV5toJMcSF0IKWAawxs8xwM+72
         z1j3jRhm67chMDvoLt7rJRAyLBxbzi8Pr44GIFKsqpS93qtJWj09Qg49q/K5/+psLUFi
         0ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019416; x=1795624216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/cFyPSe4R8rd2Uk0pIoJKmvB3bqoeY2Kqija0FTB3Q=;
        b=LmFZdGxnhz10JxCVz2v/fWLvAO4Av1HSo9oNMym3bm2malnpurpgsjpsKaErsbMX32
         qp5WvOadgWdPySw7ccEWlNkiGHT+s3Q4KL2KCQyW3vo1njgS3UvlEJx/fp6VP838Z96m
         dy6+86Z7xwl+ipjbCI6Psb8xHKgunwzw41nHsA6jQIsTB8fcB9Sd0J2qhWpJudc5q2si
         aE4hyRX3JTN4vbsHf6Cy8WCxR67HOJJy/r/NgvGGcXY2YlSxOPHYwQPjID810kVc3Id8
         YtDRrCoY63/TX5oBuvhl5QBPJtTox5LNPD/Jvlxulq15CRtU3MAIrjzAzMwYEJP9J7aU
         rU6Q==
X-Gm-Message-State: APuU4Z9jlUnnj4c8/5aEY/zqcqVAO1QbpDJPDViNidLjpxMV+clHLQxs
	1mo7hEUTfCLX71Dye2Z6/2XjGabMTLA5Py+AV+C8YAW49BfvY9bNSDhMQzsHuREuD6Q=
X-Gm-Gg: AZFdTZdruWucTnLfNTuCZzGbWRWjNVNpkaEBfVfDoVidVkOhgSUhc0nPblEPnf2IjEl
	GnkCcrfmAGlKkHJmM9dXWfNutWDXiAS/gQcViB+RMo6wiUvKtSRAzxbezcxyaNGuxzBjt1JJ12l
	JAFO/JfYbwHrpqDNkW2PxoKIyUxDoMF+KPhyFfZxy6WFazynrIXVN9OSW4QS/yFxtLpG8E+2W4T
	bPfrSVxULXVhJPbgBObpM/k7cgcLGft7pBoRykBxEL4Q0hqqYiQhRs43TlmeN984weLGqy7TfT1
	sneTLKs1fHGptvYMxYO4LZ11Yqr2fDxxT9naoFRdIdocrcranP7br3SoJj4s+7JFsNJ64lMieDu
	KZqpkjwcSUKAMInN5ShkxaZsB0GEXyMX1mRFfGLawChyMLBmPX+LXgC5sBWcqsyGODYT2Ht4eic
	3WMYfILvhqQzCjxmBVAvpefKvOcV5ScU0PrByLKtNVABZMCKzR69WsokOAJv498xKxY4QdeYSHs
	HNRQ5UlpoS5zkILWzh/rzHDpTavoD5RisrCjU++9rvKtrWs2pi7hJ/lc0fQy820qdlfaMlFFHqm
	R7cOMgmMJ/DwCKriz6NY8fbcmVQBvJmK7g==
X-Received: by 2002:a5d:5f91:0:b0:498:c419:3728 with SMTP id ffacd0b85a97d-4a63a0eadc5mr6258635f8f.22.1795019415331;
        Wed, 18 Nov 2026 08:30:15 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:14 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:47 +0000
Subject: [PATCH 25/34] perf cs-etm: Consume each OpenCSD packet immediately
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-25-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Decode and consume one packet during each heap iteration. Return the
context directly from the backend so that the packet can be processed.
If the packet was a timestamp, then there is no action other than
inserting that queue back into the heap at the new time.

Drain the decoder on the last trace byte of each buffer because it gets
reset across each buffer and that would drop the last bit of unprocessed
trace.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  39 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   5 +-
 tools/perf/util/cs-etm.c                        | 225 +++++++++---------------
 tools/perf/util/cs-etm.h                        |   4 +-
 4 files changed, 105 insertions(+), 168 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 06c57326ac80..dc17a2fd6c00 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -41,6 +41,7 @@ struct cs_etm_decoder {
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
 	const char *decoder_name;
+	struct cs_etm_traceid_ctxt *traceid_ctxt;
 };
 
 static u32
@@ -87,20 +88,6 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	return 0;
 }
 
-int cs_etm_decoder__get_packet(struct cs_etm_traceid_ctxt *tidc,
-			       struct cs_etm_packet *packet)
-{
-	if (!tidc || !packet)
-		return -EINVAL;
-
-	/* Nothing to do, might as well just return */
-	if (tidc->packet_count == 0)
-		return 0;
-
-	tidc->packet_count--;
-	return 1;
-}
-
 static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
 					    ocsd_etmv3_cfg *config)
 {
@@ -255,9 +242,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	}
 
 	tidc->cs_timestamp = max(tidc->cs_timestamp, converted_timestamp);
-
-	/* Tell the front end which decode context needs attention */
-	cs_etm__etmq_set_traceid_ctxt_ready(etmq, trace_chan_id);
+	tidc->packet->sample_type = CS_ETM_TIMESTAMP;
 
 	/* Halt processing until we are being told to proceed */
 	return OCSD_RESP_WAIT;
@@ -301,9 +286,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	struct cs_etm_packet *packet;
 	int cpu;
 
-	if (tidc->packet_count)
-		return OCSD_RESP_FATAL_SYS_ERR;
-
 	if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
@@ -311,7 +293,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	if (!packet)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	tidc->packet_count++;
 	packet->sample_type = sample_type;
 	packet->isa = cs_etm_decoder__get_isa(elem);
 	packet->cpu = cpu;
@@ -329,7 +310,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet->el = ocsd_EL_unknown;
 	packet->tid = -1;
 
-	cs_etm__etmq_set_traceid_ctxt_ready(etmq, trace_chan_id);
 	return OCSD_RESP_WAIT;
 }
 
@@ -522,6 +502,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__set_tid(etmq, tidc,
 					       elem, trace_chan_id);
 
+	if (OCSD_DATA_RESP_IS_WAIT(resp))
+		decoder->traceid_ctxt = tidc;
+
 	return resp;
 }
 
@@ -655,7 +638,8 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 				       u64 indx, const u8 *buf,
-				       size_t len, size_t *consumed)
+				       size_t len, size_t *consumed,
+				       struct cs_etm_traceid_ctxt **tidc)
 {
 	int ret = 0;
 	ocsd_datapath_resp_t cur = OCSD_RESP_CONT;
@@ -663,7 +647,10 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 	size_t processed = 0;
 	u32 count;
 
-	while (processed < len) {
+	decoder->traceid_ctxt = NULL;
+
+	/* Drain buffered output even if the last input byte was consumed. */
+	while (processed < len || OCSD_DATA_RESP_IS_WAIT(prev_return)) {
 		if (OCSD_DATA_RESP_IS_WAIT(prev_return)) {
 			cur = ocsd_dt_process_data(decoder->dcd_tree,
 						   OCSD_OP_FLUSH,
@@ -693,6 +680,10 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 
 	decoder->prev_return = cur;
 	*consumed = processed;
+	if (tidc)
+		*tidc = decoder->traceid_ctxt;
+	if (OCSD_DATA_RESP_IS_FATAL(cur))
+		return -EINVAL;
 
 	return ret;
 }
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index f29f286f1d8b..afe9a466986a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -89,7 +89,8 @@ enum cs_etm_decoder_operation {
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 				       u64 indx, const u8 *buf,
-				       size_t len, size_t *consumed);
+				       size_t len, size_t *consumed,
+				       struct cs_etm_traceid_ctxt **tidc);
 
 struct cs_etm_decoder *
 cs_etm_decoder__new(int num_cpu,
@@ -102,8 +103,6 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 				      u64 start, u64 end,
 				      cs_etm_mem_cb_type cb_func);
 
-int cs_etm_decoder__get_packet(struct cs_etm_traceid_ctxt *tidc,
-			       struct cs_etm_packet *packet);
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
 const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 97ed12d03555..97c1dde1579b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -81,7 +81,6 @@ struct cs_etm_queue {
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
-	u8 ready_chan_id;
 	enum cs_etm_format format;
 	u64 offset;
 	const unsigned char *buf;
@@ -104,7 +103,8 @@ struct cs_etm_queue {
 static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp);
 static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
-static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq,
+				     struct cs_etm_traceid_ctxt **tidc);
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
 static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
 static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
@@ -545,13 +545,6 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 	return err;
 }
 
-void cs_etm__etmq_set_traceid_ctxt_ready(struct cs_etm_queue *etmq,
-					  u8 trace_chan_id)
-{
-	/* Tell the frontend which queue the last processed packet is in. */
-	etmq->ready_chan_id = trace_chan_id;
-}
-
 /*
  * Timestamp used to order sample generation between queues.
  *
@@ -565,23 +558,8 @@ void cs_etm__etmq_set_traceid_ctxt_ready(struct cs_etm_queue *etmq,
  * received, at which point sample generation is still un-ordered.
  */
 static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
-				      u8 *trace_chan_id)
+					struct cs_etm_traceid_ctxt *tidc)
 {
-	struct cs_etm_traceid_ctxt *tidc;
-
-	if (!etmq->ready_chan_id)
-		return 0;
-
-	if (trace_chan_id)
-		*trace_chan_id = etmq->ready_chan_id;
-
-	tidc = cs_etm__etmq_get_traceid_ctxt(etmq, etmq->ready_chan_id);
-	if (!tidc)
-		return 0;
-
-	/* Acknowledge pending status */
-	etmq->ready_chan_id = 0;
-
 	/*
 	 * If there are no timestamps, use the TS from the AUX records to sort
 	 * in order of trace collection.
@@ -860,7 +838,7 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
 		ret = cs_etm_decoder__process_data_block(
 				etmq->decoder, buffer->offset,
 				&((u8 *)buffer->data)[buffer_used],
-				buffer->size - buffer_used, &consumed);
+				buffer->size - buffer_used, &consumed, NULL);
 		if (ret)
 			break;
 
@@ -1234,30 +1212,26 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
-static int cs_etm__add_to_heap(struct cs_etm_queue *etmq)
+static int cs_etm__add_to_heap(struct cs_etm_queue *etmq,
+			       struct cs_etm_traceid_ctxt *tidc)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
-	int ret;
 	unsigned int cs_queue_nr;
-	u8 trace_chan_id;
-	u64 cs_timestamp;
+	int ret;
 
-	ret = cs_etm__decode_data_block(etmq);
-	if (ret || !etmq->ready_chan_id)
-		return ret;
+	if (!tidc) {
+		struct int_node *inode = intlist__first(etmq->traceid_list);
 
-	cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
+		if (!inode)
+			return -EINVAL;
+		tidc = cs_etm__etmq_get_traceid_ctxt(etmq, inode->i);
+	}
+	if (!tidc)
+		return -ENOMEM;
 
-	/*
-	 * We have a timestamp.  Add it to the min heap to reflect when
-	 * instructions conveyed by the range packets of this traceID queue
-	 * started to execute.
-	 *
-	 * Note that any packets decoded above are still in the traceID's packet
-	 * queue and will be processed later.
-	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
-	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
+	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, tidc->trace_chan_id);
+	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr,
+				 cs_etm__etmq_get_sort_timestamp(etmq, tidc));
 	if (!ret)
 		etmq->on_heap = true;
 	return ret;
@@ -1277,7 +1251,7 @@ static int cs_etm__push_queue(struct cs_etm_queue *etmq, u64 time)
 		if (!etmq->etm->has_virtual_ts && etmq->buffer->time > time)
 			return 0;
 
-		ret = cs_etm__add_to_heap(etmq);
+		ret = cs_etm__add_to_heap(etmq, NULL);
 		if (ret)
 			return ret;
 	}
@@ -2506,6 +2480,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		}
 		break;
 	case CS_ETM_CONTEXT:
+	case CS_ETM_TIMESTAMP:
 	case CS_ETM_EMPTY:
 	default:
 		break;
@@ -2514,22 +2489,19 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 	return 0;
 }
 
-static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq,
+				     struct cs_etm_traceid_ctxt **tidc)
 {
 	int ret = 0;
 	size_t processed = 0;
 
-	/*
-	 * Packets are decoded and added to the decoder's packet queue
-	 * until the decoder packet processing callback has requested that
-	 * processing stops or there is nothing left in the buffer.
-	 */
+	/* Stop at a packet, a timestamp update, or the end of the buffer. */
 	ret = cs_etm_decoder__process_data_block(etmq->decoder,
 						 etmq->offset,
 						 &etmq->buf[etmq->buf_used],
 						 etmq->buf_len,
-						 &processed);
-	if (ret)
+						 &processed, tidc);
+	if (ret < 0)
 		goto out;
 
 	etmq->offset += processed;
@@ -2541,81 +2513,64 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 }
 
 static int cs_etm__process_traceid_ctxt(struct cs_etm_queue *etmq,
-					 struct cs_etm_traceid_ctxt *tidc)
+				 struct cs_etm_traceid_ctxt *tidc)
 {
 	int ret;
 
-	/* Process each packet in this chunk */
-	while (1) {
-		ret = cs_etm_decoder__get_packet(tidc, tidc->packet);
-		if (ret <= 0)
-			/*
-			 * Stop processing this chunk on
-			 * end of data or error
-			 */
-			break;
+	/*
+	 * Since packet addresses are swapped in packet
+	 * handling within below switch() statements,
+	 * thus setting sample flags must be called
+	 * prior to switch() statement to use address
+	 * information before packets swapping.
+	 */
+	ret = cs_etm__set_sample_flags(etmq, tidc);
+	if (ret < 0)
+		return ret;
 
+	switch (tidc->packet->sample_type) {
+	case CS_ETM_RANGE:
 		/*
-		 * Since packet addresses are swapped in packet
-		 * handling within below switch() statements,
-		 * thus setting sample flags must be called
-		 * prior to switch() statement to use address
-		 * information before packets swapping.
+		 * If the packet contains an instruction
+		 * range, generate instruction sequence
+		 * events.
 		 */
-		ret = cs_etm__set_sample_flags(etmq, tidc);
-		if (ret < 0)
-			break;
-
-		switch (tidc->packet->sample_type) {
-		case CS_ETM_RANGE:
-			/*
-			 * If the packet contains an instruction
-			 * range, generate instruction sequence
-			 * events.
-			 */
-			ret = cs_etm__sample(etmq, tidc);
-			if (ret)
-				goto out;
-			break;
-		case CS_ETM_CONTEXT:
-			/*
-			 * Update context but don't swap packet. Keep the
-			 * previous one for branch source address info, if
-			 * tracing the kernel the context packet will be emitted
-			 * between two ranges.
-			 */
-			ret = cs_etm__context(etmq, tidc);
-			if (ret)
-				goto out;
-			break;
-		case CS_ETM_EXCEPTION:
-			ret = cs_etm__exception(etmq, tidc);
-			if (ret)
-				goto out;
-			break;
-		case CS_ETM_EXCEPTION_RET:
-			/* The return annotates the preceding instruction range. */
-			break;
-		case CS_ETM_DISCONTINUITY:
-			/*
-			 * Discontinuity in trace, flush
-			 * previous branch stack
-			 */
-			cs_etm__flush(etmq, tidc);
-			break;
-		case CS_ETM_EMPTY:
-			/*
-			 * Should not receive empty packet,
-			 * report error.
-			 */
-			pr_err("CS ETM Trace: empty packet\n");
-			return -EINVAL;
-		default:
-			break;
-		}
+		ret = cs_etm__sample(etmq, tidc);
+		break;
+	case CS_ETM_CONTEXT:
+		/*
+		 * Update context but don't swap packet. Keep the
+		 * previous one for branch source address info, if
+		 * tracing the kernel the context packet will be emitted
+		 * between two ranges.
+		 */
+		ret = cs_etm__context(etmq, tidc);
+		break;
+	case CS_ETM_EXCEPTION:
+		ret = cs_etm__exception(etmq, tidc);
+		break;
+	case CS_ETM_EXCEPTION_RET:
+		/* The return annotates the preceding instruction range. */
+		break;
+	case CS_ETM_DISCONTINUITY:
+		/*
+		 * Discontinuity in trace, flush
+		 * previous branch stack
+		 */
+		cs_etm__flush(etmq, tidc);
+		break;
+	case CS_ETM_EMPTY:
+		/*
+		 * Should not receive empty packet,
+		 * report error.
+		 */
+		pr_err("CS ETM Trace: empty packet\n");
+		return -EINVAL;
+	case CS_ETM_TIMESTAMP:
+	default:
+		break;
 	}
 
-out:
 	return ret;
 }
 
@@ -2626,7 +2581,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 	u8 trace_chan_id;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
-	struct cs_etm_traceid_ctxt *tidc;
+	struct cs_etm_traceid_ctxt *tidc, *decoded;
 	u64 queue_time;
 
 	while (1) {
@@ -2664,19 +2619,16 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 			goto out;
 		}
 
-		/*
-		 * Packets associated with this timestamp, if any, are already in
-		 * the etmq's traceID queue, so process them.
-		 */
-		ret = cs_etm__process_traceid_ctxt(etmq, tidc);
+		ret = cs_etm__decode_data_block(etmq, &decoded);
 		if (ret < 0)
 			goto out;
-
-		/*
-		 * Packets for this timestamp have been processed, time to
-		 * move on to the next timestamp, fetching a new auxtrace_buffer
-		 * if need be.
-		 */
+		if (decoded) {
+			tidc = decoded;
+			ret = cs_etm__process_traceid_ctxt(etmq, tidc);
+			if (ret)
+				goto out;
+			goto add_to_heap;
+		}
 get_data_block:
 		ret = cs_etm__get_data_block(etmq);
 		if (ret < 0)
@@ -2689,12 +2641,9 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		if (!ret)
 			continue;
 
-		/*
-		 * Add the next timestamp or decoded packets to the min heap.
-		 * Packets will be processed and synthesized during the next call
-		 * to cs_etm__process_traceid_ctxt() for this queue/traceID.
-		 */
-		ret = cs_etm__add_to_heap(etmq);
+add_to_heap:
+		/* Schedule the next decode step after consuming the current packet. */
+		ret = cs_etm__add_to_heap(etmq, tidc);
 		if (ret)
 			goto out;
 		if (!etmq->on_heap)
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index c41a7b5dd62f..5d9cc31b08d0 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -159,6 +159,7 @@ enum cs_etm_sample_type {
 	CS_ETM_EXCEPTION,
 	CS_ETM_EXCEPTION_RET,
 	CS_ETM_CONTEXT,
+	CS_ETM_TIMESTAMP,
 };
 
 enum cs_etm_isa {
@@ -257,7 +258,6 @@ struct cs_etm_traceid_ctxt {
 	struct ip_callchain *callchain;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
-	u32 packet_count;
 	u64 cs_timestamp; /* Timestamp, in ns when has_virtual_ts == true */
 
 	ocsd_ex_level decode_el;
@@ -268,8 +268,6 @@ struct cs_etm_traceid_ctxt {
 int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 bool cs_etm__has_timestamps(struct cs_etm_queue *etmq);
-void cs_etm__etmq_set_traceid_ctxt_ready(struct cs_etm_queue *etmq,
-					  u8 trace_chan_id);
 struct cs_etm_traceid_ctxt
 *cs_etm__etmq_get_traceid_ctxt(struct cs_etm_queue *etmq, u8 trace_chan_id);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,

-- 
2.43.0

