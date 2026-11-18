Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019421;
	b=ukcFISjnapTxqjU+Ysmr7tYH+6e69Zg3yNr0ekf8maJkTIrSm5MZna9h+sYwb1v1jk3U
	 YZpk2PztKGaTWYbilf2/u9A4bKRAiO2tjpaW890biqw+zrtCKJwzvJ5qT1oZP0cj2DwoV
	 T+l0IijkpPZ8+u+/tuGEhNqjMic1SWSSzqxyBCOyzE0VMXt/5ln8kxPAbjBGj8vzb5B2C
	 P+GLYkEV2qlQJYUcl0t7SpFslRrg/b7ArKcrQQZH2WX34mNOuLQdu9toMXAxIEFG12WAt
	 uwNiOBOKe4Zy19U+VzH7n26VIv0twbi+d2m/Sapgu3nDETki4q0Tl4THvgljbTQW5vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=AStLUcHUmI1uFLWNZAiB9nK6L8yHvacrhqAtKjdrA+4=;
	b=nyFcIm/ELsc0zMQasJJPSjhgc5zmn7aTdxfahhUPFMic7ZxuvVkO4t8Vi43N3WDOsuu6
	 oiRAMCobZSdm6Cl4lUC44Qe5M5c+7ov12U1C9oiKz8sbbCFJO8wZ7s5IbiYWYtQlSKnvg
	 1yEde1pS4wpSQmj0KD7a8CL8c8JxslDuhZf9E872EsDOkMXsMRuFm9CABGAgCTZOxVW4k
	 yxnYEz7fWoJ6X8betZ6G2BUHKNd3ge+FZ3xz6FFfex+y+ZJLlaY3U8kTjM1RPDYEzOQ3/
	 TkR3usL8jS1FPwDCoWYeNfEA0C+13BLPgXryInTfk86YVWU46KGWAMbiSuo6rw2ihMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jKHdtO0I;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C160A2633
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 234C160A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jKHdtO0I
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so1021129f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019411; x=1795624211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AStLUcHUmI1uFLWNZAiB9nK6L8yHvacrhqAtKjdrA+4=;
        b=jKHdtO0IGB2icRHuB8OUYsgsu8THmiAG8sfTJii5AdmblTOkLMCuqnpDOoENvJ+Xlu
         rGRtfcXsKk2ejcxtu40zRY0o0c4z8T9SfUVnTFVTMSlr3WPeknQkBcWcU9XcNPrd++c3
         KwGCVc9v14J9WRJdn5eE+XRwesvJtDnIqecX+N8u3oJ/YgxYx/NJHqDM7WPiG0mCohJT
         9ehmrr6R/9OJsNUtvc6/g1Hk0rGYlLIbfviKdccl4OUkA6IiTdSDRQTM2oAOz8rHccy/
         REaiX3KJERZ9uemM+/83S/qToY3xqCaZQQ3N/dNtN6/x2xV3uj9LoCHAdXmtjs1vTQ5E
         YWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019411; x=1795624211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AStLUcHUmI1uFLWNZAiB9nK6L8yHvacrhqAtKjdrA+4=;
        b=rFcFPmUGjU3vFOoNdU0ZP+gMGH6y5wmfQLgH1zbKdT+p+3vowJ7kSeX9W8WEahYgSd
         iEtpCkhobyYw2UpOOLc43askhzhSXSA9+fMDYxOazmIviEspJeW0vcuBTDway1oJA3DZ
         O7zH8pL7l/DjlCAlsZPQFerYCZ8OoftQMCJQyAfr+/8nLoAS3S+2TO1yDfaaeczSXGY7
         gMqz4AK0G4KkcmKhZ+Ckl6QqiwSmMweef2ia70kr6wYvA0unwHDo3R5VmbkssJGUKCJt
         Kx3x79m7KV8FU4vokm6oGTHIyxNW2KEB46chKBQbvgK/iCyml7dJ1wemKAoZTn20aPjC
         /8xg==
X-Gm-Message-State: APuU4Z8c22db2bBX4fCHTqKo3YERsKErQQMVu7PXkqSJEIbHbltBnIlx
	6ieiAmibIQI5JY1v9cAT3zQgvB6Rf+GpKOhiczAmdqHbx7n6b1tg0o8D7au3XC8sfuE=
X-Gm-Gg: AZFdTZeB+be93eZ7O8rPhhJBcZOOUx81fiYT1b8iYhBNHsszDSvULxjiO6nI9O7AWl+
	aGZZ08WXlaMj6Z6xFf5QxkY7rCbYY1DifdZ1v9Bgi0BXPEtaccCDOFzUYMRWRAH5KAEXZ7YvOhc
	EKQ0iXzHJRbAJD//E9llijmbGtsFQrc9dx3yzsqnG34OyfODpEa6QrdBprrR9ycz7K8VQ/KX0ms
	V1P7nhZ/WIJqpmCB+9Z6GE6r3RCAh9DIgyfDLn5YTN4YkLp9/ETVUFlk3ETk1offwtUsRYz1Chh
	L+E2nrxdAF2j9RKBaSOeXy/j3yeNGki7IKdk9bHWvoMCRciKI5PZSUPRgDQLjWPi/sywOU8MaK2
	v3qnXalSmYzmQcOrd7h9PoUmQ2acR6m3nqm40WKP4Lp9ZYKdVoeZNnGKG3rHxY/2icQ7UNR2/fl
	6Flt4QFUi8Jokx5YbBm2qryuXdaRBYnltwcaFMBZE0v6GxLeZTMzoY4LQeGXW3vvUzqmlhiJdns
	yhS3OKownZGud9+oHQ3gpb+6tRyfJYuDkKD+0CZd0MpyZTu3oGUfkPe9cqLH+woBBRVzrfFWsDz
	VIB637tle0OxoFmNn+5AzueZ2t5ly7aZyw==
X-Received: by 2002:adf:e00f:0:10b0:48d:f730:bda8 with SMTP id ffacd0b85a97d-4a63d2cf89cmr5015394f8f.50.1795019410865;
        Wed, 18 Nov 2026 08:30:10 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:10 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:43 +0000
Subject: [PATCH 21/34] perf cs-etm: Fold packet state into the trace ID
 queue
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
Message-Id: <20261118-james-coresight-jit-v1-21-dad4d90747f6@linaro.org>
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

The packet queue no longer owns a packet buffer. The remaining timestamp
and packet_count state belongs to the surrounding trace ID queue.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 34 +++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 +-
 tools/perf/util/cs-etm.c                        | 86 ++++++-------------------
 tools/perf/util/cs-etm.h                        | 39 ++++++++---
 4 files changed, 67 insertions(+), 96 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e2eb606f2feb..4c47bcf3e2e2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -87,7 +87,7 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	return 0;
 }
 
-int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
+int cs_etm_decoder__get_packet(struct cs_etm_traceid_queue *packet_queue,
 			       struct cs_etm_packet *packet)
 {
 	if (!packet_queue || !packet)
@@ -228,15 +228,15 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 				  const uint8_t trace_chan_id,
 				  const ocsd_trc_index_t indx)
 {
-	struct cs_etm_packet_queue *packet_queue;
+	struct cs_etm_traceid_queue *packet_queue;
 	u64 converted_timestamp;
 
 	/* Ignore trace timestamps when unavailable or disabled by --itrace=Z. */
 	if (!cs_etm__has_timestamps(etmq))
 		return OCSD_RESP_CONT;
 
-	/* First get the packet queue for this traceID */
-	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
+	/* First get the decode context for this traceID */
+	packet_queue = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
@@ -256,7 +256,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 
 	packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, converted_timestamp);
 
-	/* Tell the front end which traceid_queue needs attention */
+	/* Tell the front end which decode context needs attention */
 	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
 
 	/* Halt processing until we are being told to proceed */
@@ -293,7 +293,7 @@ cs_etm_decoder__get_isa(const ocsd_generic_trace_elem *elem)
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
-			      struct cs_etm_packet_queue *packet_queue,
+			      struct cs_etm_traceid_queue *packet_queue,
 			      const ocsd_generic_trace_elem *elem,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
@@ -307,7 +307,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	packet = cs_etm__etmq_get_packet(etmq, trace_chan_id);
+	packet = packet_queue->packet;
 	if (!packet)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
@@ -335,7 +335,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
-			     struct cs_etm_packet_queue *packet_queue,
+			     struct cs_etm_traceid_queue *packet_queue,
 			     const ocsd_generic_trace_elem *elem,
 			     const uint8_t trace_chan_id)
 {
@@ -347,7 +347,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
-	packet = cs_etm__etmq_get_packet(etmq, trace_chan_id);
+	packet = packet_queue->packet;
 
 	packet->start_addr = elem->st_addr;
 	packet->end_addr = elem->en_addr;
@@ -370,7 +370,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
-				     struct cs_etm_packet_queue *queue,
+				     struct cs_etm_traceid_queue *queue,
 				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
@@ -380,7 +380,7 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
-				 struct cs_etm_packet_queue *queue,
+				 struct cs_etm_traceid_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {
@@ -393,7 +393,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
-	packet = cs_etm__etmq_get_packet(etmq, trace_chan_id);
+	packet = queue->packet;
 	packet->exception_number = elem->exception_number;
 	if (elem->context.el_valid)
 		packet->el = elem->context.exception_level;
@@ -431,7 +431,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
-				     struct cs_etm_packet_queue *queue,
+				     struct cs_etm_traceid_queue *queue,
 				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
@@ -441,7 +441,7 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
-			struct cs_etm_packet_queue *packet_queue,
+			struct cs_etm_traceid_queue *packet_queue,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
@@ -477,7 +477,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
-	packet = cs_etm__etmq_get_packet(etmq, trace_chan_id);
+	packet = packet_queue->packet;
 	packet->tid = tid;
 	if (elem->context.el_valid)
 		packet->el = elem->context.exception_level;
@@ -495,10 +495,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	ocsd_gen_trc_elem_t type;
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
 	struct cs_etm_queue *etmq = decoder->data;
-	struct cs_etm_packet_queue *packet_queue;
+	struct cs_etm_traceid_queue *packet_queue;
 
 	/* First get the packet queue for this traceID */
-	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
+	packet_queue = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 2a8214f17958..4420daaf159d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -16,7 +16,7 @@
 
 struct cs_etm_decoder;
 struct cs_etm_packet;
-struct cs_etm_packet_queue;
+struct cs_etm_traceid_queue;
 
 struct cs_etm_queue;
 
@@ -102,7 +102,7 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 				      u64 start, u64 end,
 				      cs_etm_mem_cb_type cb_func);
 
-int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
+int cs_etm_decoder__get_packet(struct cs_etm_traceid_queue *packet_queue,
 			       struct cs_etm_packet *packet);
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0175b2facaac..3f5865ed2724 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -70,28 +70,6 @@ struct cs_etm_auxtrace {
 	enum cs_etm_pid_fmt pid_fmt;
 };
 
-struct cs_etm_traceid_queue {
-	u8 trace_chan_id;
-	u64 period_instructions;
-	u64 kernel_start;
-	union perf_event *event_buf;
-	unsigned int br_stack_sz;
-	struct branch_stack *last_branch;
-	struct ip_callchain *callchain;
-	struct cs_etm_packet *prev_packet;
-	struct cs_etm_packet *packet;
-	struct cs_etm_packet_queue packet_queue;
-
-	struct thread *decode_thread;
-	ocsd_ex_level decode_el;
-
-	/*
-	 * Samples use the EL saved in their source packet. A branch sample
-	 * cannot change thread, so the thread is kept in the frontend context.
-	 */
-	struct thread *frontend_thread;
-};
-
 enum cs_etm_format {
 	UNSET,
 	FORMATTED,
@@ -589,7 +567,7 @@ void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
 static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 				      u8 *trace_chan_id)
 {
-	struct cs_etm_packet_queue *packet_queue;
+	struct cs_etm_traceid_queue *tidq;
 
 	if (!etmq->ready_chan_id)
 		return 0;
@@ -597,8 +575,8 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 	if (trace_chan_id)
 		*trace_chan_id = etmq->ready_chan_id;
 
-	packet_queue = cs_etm__etmq_get_packet_queue(etmq, etmq->ready_chan_id);
-	if (!packet_queue)
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, etmq->ready_chan_id);
+	if (!tidq)
 		return 0;
 
 	/* Acknowledge pending status */
@@ -612,7 +590,7 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 		return etmq->buffer->time;
 
 	/* Use the last trace timestamp, or zero if none has been found yet. */
-	return packet_queue->cs_timestamp;
+	return tidq->cs_timestamp;
 }
 
 static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
@@ -679,7 +657,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return rc;
 }
 
-static struct cs_etm_traceid_queue
+struct cs_etm_traceid_queue
 *cs_etm__etmq_get_traceid_queue(struct cs_etm_queue *etmq, u8 trace_chan_id)
 {
 	int idx;
@@ -688,8 +666,8 @@ static struct cs_etm_traceid_queue
 	struct cs_etm_traceid_queue *tidq, **traceid_queues;
 
 	/*
-	 * Check if the traceid_queue exist for this traceID by looking
-	 * in the queue list.
+	 * Check if a decode context exists for this traceID by looking
+	 * in the context list.
 	 */
 	inode = intlist__find(traceid_queues_list, trace_chan_id);
 	if (inode) {
@@ -697,16 +675,16 @@ static struct cs_etm_traceid_queue
 		return etmq->traceid_queues[idx];
 	}
 
-	/* We couldn't find a traceid_queue for this traceID, allocate one */
+	/* We couldn't find a decode context for this traceID, allocate one */
 	tidq = malloc(sizeof(*tidq));
 	if (!tidq)
 		return NULL;
 
 	memset(tidq, 0, sizeof(*tidq));
 
-	/* Get a valid index for the new traceid_queue */
+	/* Get a valid index for the new decode context */
 	idx = intlist__nr_entries(traceid_queues_list);
-	/* Memory for the inode is free'ed in cs_etm_free_traceid_queues () */
+	/* Memory for the inode is freed in cs_etm__free_traceid_queues() */
 	inode = intlist__findnew(traceid_queues_list, trace_chan_id);
 	if (!inode)
 		goto out_free;
@@ -746,27 +724,6 @@ static struct cs_etm_traceid_queue
 	return NULL;
 }
 
-struct cs_etm_packet *cs_etm__etmq_get_packet(struct cs_etm_queue *etmq,
-					      u8 trace_chan_id)
-{
-	struct cs_etm_traceid_queue *tidq;
-
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
-	return tidq ? tidq->packet : NULL;
-}
-
-struct cs_etm_packet_queue
-*cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id)
-{
-	struct cs_etm_traceid_queue *tidq;
-
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
-	if (tidq)
-		return &tidq->packet_queue;
-
-	return NULL;
-}
-
 static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 				struct cs_etm_traceid_queue *tidq)
 {
@@ -949,7 +906,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		priv = (uintptr_t)inode->priv;
 		idx = priv;
 
-		/* Free this traceid_queue from the array */
+		/* Free this decode context from the array */
 		tidq = etmq->traceid_queues[idx];
 		thread__zput(tidq->frontend_thread);
 		thread__zput(tidq->decode_thread);
@@ -1590,10 +1547,9 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 					       struct cs_etm_traceid_queue *tidq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
-	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
 	if (etm->has_virtual_ts)
-		return packet_queue->cs_timestamp;
+		return tidq->cs_timestamp;
 
 	/*
 	 * Timestamps were disabled or no virtual TS. All samples are assigned
@@ -2619,14 +2575,10 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 					 struct cs_etm_traceid_queue *tidq)
 {
 	int ret;
-	struct cs_etm_packet_queue *packet_queue;
-
-	packet_queue = &tidq->packet_queue;
 
 	/* Process each packet in this chunk */
 	while (1) {
-		ret = cs_etm_decoder__get_packet(packet_queue,
-						 tidq->packet);
+		ret = cs_etm_decoder__get_packet(tidq, tidq->packet);
 		if (ret <= 0)
 			/*
 			 * Stop processing this chunk on
@@ -2706,6 +2658,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
 	struct cs_etm_traceid_queue *tidq;
+	u64 queue_time;
 
 	while (1) {
 		if (!etm->heap.heap_cnt)
@@ -2719,13 +2672,10 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		etmq = queue->priv;
 
 		/* Don't go further than the trace timestamp or collection time */
-		if (etm->has_virtual_ts) {
-			if (etm->heap.heap_array[0].ordinal >= timestamp)
-				break;
-		} else {
-			if (etmq->buffer->time >= timestamp)
-				break;
-		}
+		queue_time = etm->has_virtual_ts ? etm->heap.heap_array[0].ordinal :
+						   etmq->buffer->time;
+		if (queue_time >= timestamp)
+			break;
 
 		/*
 		 * Remove the top entry from the heap since we are about
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index c757a1fb465d..1cbc8bc0aa06 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -193,11 +193,6 @@ struct cs_etm_packet {
 	pid_t tid;
 };
 
-struct cs_etm_packet_queue {
-	u32 packet_count;
-	u64 cs_timestamp; /* Timestamp, in ns when has_virtual_ts == true */
-};
-
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
 
@@ -247,6 +242,34 @@ enum cs_etm_pid_fmt {
 
 #ifdef HAVE_CSTRACE_SUPPORT
 #include <opencsd/ocsd_if_types.h>
+
+/*
+ * Decode context for a single trace ID stream. In a decode tree there is one
+ * of these for each stream.
+ */
+struct cs_etm_traceid_queue {
+	u8 trace_chan_id;
+	u64 period_instructions;
+	u64 kernel_start;
+	union perf_event *event_buf;
+	unsigned int br_stack_sz;
+	struct branch_stack *last_branch;
+	struct ip_callchain *callchain;
+	struct cs_etm_packet *prev_packet;
+	struct cs_etm_packet *packet;
+	u32 packet_count;
+	u64 cs_timestamp; /* Timestamp, in ns when has_virtual_ts == true */
+
+	struct thread *decode_thread;
+	ocsd_ex_level decode_el;
+
+	/*
+	 * Samples use the EL saved in their source packet. A branch sample
+	 * cannot change thread, so the thread is kept in the frontend context.
+	 */
+	struct thread *frontend_thread;
+};
+
 int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
@@ -255,10 +278,8 @@ int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 bool cs_etm__has_timestamps(struct cs_etm_queue *etmq);
 void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
 					  u8 trace_chan_id);
-struct cs_etm_packet *cs_etm__etmq_get_packet(struct cs_etm_queue *etmq,
-					      u8 trace_chan_id);
-struct cs_etm_packet_queue
-*cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
+struct cs_etm_traceid_queue
+*cs_etm__etmq_get_traceid_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
 				       struct perf_session *session __maybe_unused);
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp);

-- 
2.43.0

