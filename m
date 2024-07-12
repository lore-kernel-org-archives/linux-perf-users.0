Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8415B548
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779738; cv=none; b=p3RUCqoYhkib8rP5NzDqhiUXKmm24r9twmDwIJsdvrFFM7MS+EmoI/gFEECzJ5IjIDDHiis3aMKZsSLfeiHrBYu/yc9XER3Uz+yHKxMwr+PzAar5pmQTxRyqXMUZAh1z0QmsoEBLXCUGG23r9F0O6Pq7Jhi5ux++KfT/AK2cOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779738; c=relaxed/simple;
	bh=o4TLkDUQM2jPHQGaB2ChCXge2O12uDzAcClw0+3s8Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JroFwXAmX4rdjCoTtlJ+tI2gOGhOWr/PS+EX3935libi2Dv0pTYKJ0ilBiLmX1SOC80r1SsI/8iYQceQBcW+0T1T6vFJrAZ6KlH0a9pCKluLjFkzocZE9RVRsrGw3SBB7kMKWFrWDH9gIM4eQdgpLrinYfvgOut+OxlGCzjkp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wqol0+mG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wqol0+mG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36798779d75so1627024f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779735; x=1721384535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNTcw4AodgvALwpMsLXckWgH/elRtcEkEFuXm1R3qd8=;
        b=Wqol0+mGNDcOju+/1wX41bKSmyWdGj5t7BN85Eq7QzkianIHXcavk5gF3Upj/NOtGi
         55VikmQdiRCOepk0DBcOkcCgTBmzuvMB89IQFeRRQaDBU0tkoCHdgXTahKzEoNZR34g7
         /p3BJXUW4Zxp7qjXr8JVS3JPEgciwNRASKSxm/eBs+FidWPE9qDfrhaeRepku8MOTh5S
         WVPcfdnI2UtlJ6uyhFPYzg4vB5P3nqtL6eYtHhviVPp93GSFaK19mWBkQxcMwdWh1L0p
         6urLlKUvLHv7TvviqdDrBJ8p8jgR6yTm/gghsj0oi+m9lVztr8d8E08y3ptBA5Ruk1IC
         ftTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779735; x=1721384535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNTcw4AodgvALwpMsLXckWgH/elRtcEkEFuXm1R3qd8=;
        b=DZK8UyaOT4TQH9Po87V9uxbasbfmsWvOfGnanOb0zL0nQ+CUXpLHw26FX4fjCOp0VY
         H8mhv0nVfkF43+N1faFtQS5t0ifC5HwbvJS/OyqOHR1qw7rZnjqvp1jg/NK4KsEUaiUc
         K/EIj7tk+g18B9pRNmZ9Wmyx1bSNInmFEAV0m+znyqxAu4GrRN1UMQk7PCR3LQ1cr6z8
         Kv/04gdO5jcdWyN9ClCkoKw2/ltjPikWwFKQapt8jiJoE1sh6aJKocdSsvrKqQhf92xP
         zzawCUbzZtFzUMJM2anmbP2JckcOuEv+SxOTiB6PMPCczpjZc0go5Qu62UCLovRb+CGu
         0vjg==
X-Forwarded-Encrypted: i=1; AJvYcCWK4cWklRSY7j6eiSjqV3U9qXkl+e5LZ0HuocWyi1ZNnmNe6ORhA8Vlm81XlXwmLQ2y82BRaUQeNa0MkZnBdOTA5IOrzblkVsRPCrkFTBBl7w==
X-Gm-Message-State: AOJu0YxwrRdBjS4wmoiyHxdV3Hm/UMp4IYxaeVsVc+whbHMqzX+HUID/
	IflGke0b1qVAOH7dSLNjo97apciUpzjm5k+ESxDwmKkyJXW+gTta5RR4EzD1xw0=
X-Google-Smtp-Source: AGHT+IE5jKQ77NknrR1XwjZL3fqsubIZUggpAAhD4zFlsuEcwxOSOWIRp0kfpWgaR1ofOTl5hlff2g==
X-Received: by 2002:a5d:4e46:0:b0:367:8ff5:5870 with SMTP id ffacd0b85a97d-367cead15f4mr7970265f8f.47.1720779734955;
        Fri, 12 Jul 2024 03:22:14 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 01/17] perf: cs-etm: Create decoders after both AUX and HW_ID search passes
Date: Fri, 12 Jul 2024 11:20:10 +0100
Message-Id: <20240712102029.3697965-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Both of these passes gather information about how to create the
decoders. AUX records determine formatted/unformatted, and the HW_IDs
determine the traceID/metadata mappings. Therefore it makes sense to
cache the information and wait until both passes are over until creating
the decoders, rather than creating them at the first HW_ID found. This
will allow a simplification of the creation process where
cs_etm_queue->traceid_list will exclusively used to create the decoders,
rather than the current two methods depending on whether the trace is
formatted or not.

Previously the sample CPU from the AUX record was used to initialize
the decoder CPU, but actually sample CPU == AUX queue index in per-CPU
mode, so saving the sample CPU isn't required. Similarly
formatted/unformatted was used upfront to create the decoders, but now
it's cached until later.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 167 ++++++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 32818bd7cd17..f09004c4ba44 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -103,6 +103,7 @@ struct cs_etm_queue {
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
 	u8 pending_timestamp_chan_id;
+	bool formatted;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -738,8 +739,7 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
-				       enum cs_etm_decoder_operation mode,
-				       bool formatted)
+				       enum cs_etm_decoder_operation mode)
 {
 	int ret = -EINVAL;
 
@@ -749,7 +749,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 	d_params->packet_printer = cs_etm__packet_dump;
 	d_params->operation = mode;
 	d_params->data = etmq;
-	d_params->formatted = formatted;
+	d_params->formatted = etmq->formatted;
 	d_params->fsyncs = false;
 	d_params->hsyncs = false;
 	d_params->frame_aligned = true;
@@ -1041,81 +1041,34 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return ret;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						bool formatted, int sample_cpu)
+static struct cs_etm_queue *cs_etm__alloc_queue(void)
 {
-	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params = NULL;
-	struct cs_etm_queue *etmq;
-	/*
-	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
-	 * needed.
-	 */
-	int decoders = formatted ? etm->num_cpu : 1;
-
-	etmq = zalloc(sizeof(*etmq));
+	struct cs_etm_queue *etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
 		return NULL;
 
 	etmq->traceid_queues_list = intlist__new(NULL);
 	if (!etmq->traceid_queues_list)
-		goto out_free;
-
-	/* Use metadata to fill in trace parameters for trace decoder */
-	t_params = zalloc(sizeof(*t_params) * decoders);
+		free(etmq);
 
-	if (!t_params)
-		goto out_free;
-
-	if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
-		goto out_free;
-
-	/* Set decoder parameters to decode trace packets */
-	if (cs_etm__init_decoder_params(&d_params, etmq,
-					dump_trace ? CS_ETM_OPERATION_PRINT :
-						     CS_ETM_OPERATION_DECODE,
-					formatted))
-		goto out_free;
-
-	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
-					    t_params);
-
-	if (!etmq->decoder)
-		goto out_free;
-
-	/*
-	 * Register a function to handle all memory accesses required by
-	 * the trace decoder library.
-	 */
-	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
-					      0x0L, ((u64) -1L),
-					      cs_etm__mem_access))
-		goto out_free_decoder;
-
-	zfree(&t_params);
 	return etmq;
-
-out_free_decoder:
-	cs_etm_decoder__free(etmq->decoder);
-out_free:
-	intlist__delete(etmq->traceid_queues_list);
-	free(etmq);
-
-	return NULL;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr,
-			       bool formatted,
-			       int sample_cpu)
+			       unsigned int queue_nr, bool formatted)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
+	if (etmq && formatted != etmq->formatted) {
+		pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
+		return -EINVAL;
+	}
+
 	if (list_empty(&queue->head) || etmq)
 		return 0;
 
-	etmq = cs_etm__alloc_queue(etm, formatted, sample_cpu);
+	etmq = cs_etm__alloc_queue();
 
 	if (!etmq)
 		return -ENOMEM;
@@ -1123,7 +1076,9 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
+	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
+	etmq->formatted = formatted;
 
 	return 0;
 }
@@ -2843,7 +2798,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		 * formatted in piped mode (true).
 		 */
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, true, -1);
+					  idx, true);
 		if (err)
 			return err;
 
@@ -3048,8 +3003,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 		idx = auxtrace_event->idx;
 		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					   idx, formatted, sample->cpu);
+
+		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, formatted);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
@@ -3233,6 +3188,84 @@ static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
 	return 0;
 }
 
+/*
+ * Use the data gathered by the peeks for HW_ID (trace ID mappings) and AUX
+ * (formatted or not) packets to create the decoders.
+ */
+static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
+{
+	struct cs_etm_decoder_params d_params;
+
+	/*
+	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
+	 * needed.
+	 */
+	int decoders = etmq->formatted ? etmq->etm->num_cpu : 1;
+
+	/* Use metadata to fill in trace parameters for trace decoder */
+	struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
+
+	if (!t_params)
+		goto out_free;
+
+	if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->formatted,
+				      etmq->queue_nr, decoders))
+		goto out_free;
+
+	/* Set decoder parameters to decode trace packets */
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					dump_trace ? CS_ETM_OPERATION_PRINT :
+						     CS_ETM_OPERATION_DECODE))
+		goto out_free;
+
+	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
+					    t_params);
+
+	if (!etmq->decoder)
+		goto out_free;
+
+	/*
+	 * Register a function to handle all memory accesses required by
+	 * the trace decoder library.
+	 */
+	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
+					      0x0L, ((u64) -1L),
+					      cs_etm__mem_access))
+		goto out_free_decoder;
+
+	zfree(&t_params);
+	return 0;
+
+out_free_decoder:
+	cs_etm_decoder__free(etmq->decoder);
+out_free:
+	zfree(&t_params);
+	return -EINVAL;
+}
+
+static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
+{
+	struct auxtrace_queues *queues = &etm->queues;
+
+	for (unsigned int i = 0; i < queues->nr_queues; i++) {
+		bool empty = list_empty(&queues->queue_array[i].head);
+		struct cs_etm_queue *etmq = queues->queue_array[i].priv;
+		int ret;
+
+		/*
+		 * Don't create decoders for empty queues, mainly because
+		 * etmq->formatted is unknown for empty queues.
+		 */
+		if (empty)
+			continue;
+
+		ret = cs_etm__create_queue_decoders(etmq);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
@@ -3396,6 +3429,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
+	err = cs_etm__queue_aux_records(session);
+	if (err)
+		goto err_free_queues;
+
 	/*
 	 * Map Trace ID values to CPU metadata.
 	 *
@@ -3418,7 +3455,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 * flags if present.
 	 */
 
-	/* first scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
+	/* Scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
 	aux_hw_id_found = 0;
 	err = perf_session__peek_events(session, session->header.data_offset,
 					session->header.data_size,
@@ -3436,7 +3473,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	err = cs_etm__queue_aux_records(session);
+	err = cs_etm__create_decoders(etm);
 	if (err)
 		goto err_free_queues;
 
-- 
2.34.1

