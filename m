Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019414;
	b=wiHNzyNSqOSQFGH4kkt5U/1Nv4ZA9DoGzpqXrq2f/rZ2t9M25odDvX3wh6V5vv7pzmnY
	 b+nZRDGBT1o5SOZj7SIV15EgLOsrIJml92L6C3n4lJFvTYkbMHZb3nciurvje570N5gld
	 KrvuxcaHPHMplZJ9XNKjrLgYH4CML+FWh8tsXT8jpQ/5roDE1RMQA5GYa2iSGku44YFOL
	 pNKIye3hGOISSPCr96zHkDdv9qhcXwRbTJa9ItL1yoZ4OxkgTsKxLguLS8IH+7LkSBQPo
	 y5J75iZcM2Y3hx0mckWz2CdbW6OXdu6uSyGS4ROl4A+x2ILd3MqF0TyCbxKhjg7tf/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZboqFiaiSOAznM2ndDaajsevi4MTXt6SNvnhzrehEVM=;
	b=5bZTyOjxYp44+DwUywk2+gPHIYmV8NhjUhvPDboseYe73KmNY1+bJRpth+RxaqxAFpny
	 Tva3LeVTR9GnbgpBcKrU85dL//KUrBz9JiCmIhgH7hYton2aDB3HAYkLzbDF3bpFO/tSS
	 hsPPpvHeyxi6ZZrmvkMiTEu+BvpfIixlGnrz42zypwkaP3XYLti2LeP+JiFWS0g0Fpc55
	 Pu9nzLp0jSpakldFbj2hr+Isy6udjqjgMOdO6z8fAfxjm71r0QeL6k4ZlkgBa9UADSB/D
	 NUN2I2Xa/3U5QUI/acNhaax9Tivo6Aoub55p5ah8cFknee0yTylX/bsvj8BR8N1eKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l0inJtkL;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254E60A3838
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B254E60A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l0inJtkL
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1071488f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019409; x=1795624209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZboqFiaiSOAznM2ndDaajsevi4MTXt6SNvnhzrehEVM=;
        b=l0inJtkL5ylUuOMcsw0okRR8tIPy/L1sfy90+tfGs4ug9OjVkfLpzFJpBeuiumKLGj
         tfXp6i0pExXdI+KBFXqZbirBKhoJBt/Bds2kDNYaqlZX7tinWdCj8Vnxe/fXhPKk+y6r
         cxKzysGjDQ0LTaAZ6IVYmzYZRYIambjDvKkWcWuqm0mQhRJOxnaopwAl3INjHD3eN6iX
         xPmvMAVjq3fOpjtVUEgZ5mfyV5IdIslUHI0KaVgFTlZZmUUzB4F9lHrPCBe4Ts2InvXy
         iYV2SBnV+0yyLr1rPzjl6Vbzwq89QcGdbozhUdKJHjENyFvj6pZRiLvvNAG9TJpQX3bx
         RWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019409; x=1795624209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZboqFiaiSOAznM2ndDaajsevi4MTXt6SNvnhzrehEVM=;
        b=OFwRaZ5LfPVKJAjhpm8/yP74tfspDUhjrB4QnZlWZV7nbi3TqSNSgOXQEJkCK/ble9
         pwBCYueEvEt2QoddTVRkAgyei6PG470/mjDjfwTLlXJtJDz/KXzouN+snFrcDqVHkGss
         sKazJS/U8vjEzyQmVLDfrYvaEG+DmE1FjACStX3ofsxF1YsyWKrjs5lOTvB+Tb0YTp3I
         hfikl+kCopbFyYgkMls1KO5ogcVlAgSo8Fo9rGHy6IMm4TFUqWjlJm0DjvtUuHmHXn8h
         7MnQnFpP6iPqfVbUpzc4YfsSqSz0TnqZL36DWUvRjCXUgKJ+QFnlhpbpx+4HaBccQ0jU
         pfjg==
X-Gm-Message-State: APuU4Z+gMAP43B+MGjcXVk7x7V0RhkVNwGGM5Pjw+AklhUU8a/d9oBoO
	tfwx4ehJAH5Bw0ap7b/ymDmtfz0mqEYNmQB4PEtZOvNs49XLyUlWYp0lolyE+xlAsaQ=
X-Gm-Gg: AZFdTZeKUu8aS9L47nzgGiBMr6H4fXqEieojhH3tZ9J0O6Iq1Us39b5ItKQn+wMuBG/
	3yV6PsBLzUlGMwFXJnbhFq0aAKlOFkAdPxBNGMYQmm/BjgidWOPpdks2n2ovDNiCB+oHr/9dK41
	5FHA6fWEbIsH7JyWDpIE703nz7452aMoxMNfcQHO4eOBowx1Kij9wVnkjpRdJwBqRMIiUHfTFOZ
	FgDhsjbekW+sWqFrPw8kvW53uxP3dvcxKoR2yDKcaQyYBvI8M2AS6zx5GWCMG6j5kzjqkYl8e8z
	kmFvwUr+7LE0pBGk2YXKBSL74rp3/qxoqRCiFVYgpLQACEzrhKUyOEJrDA7qr7TXygtac/39JFv
	MOYzrqtv9Dzug8lUStLB7G9AUchIFUfzbamwMjWGYF3RbXkTf2pGe4Pkv228+kzm24f5dE5rRgg
	KYsv5iPm1hdkWbsUiNJQ+ffccwDdbwJArHtxg4YIwaCrNI0Eok/aecCfmfxEqVM+yNQnyxaodYX
	NbEBL9WNwlEMnOat+P67IL61fzllS/Fc/5p4bB3vmyu8xfziwXXrml57pzSf4zvqp9XoOcgp+zC
	dI2DyMb/pGugJjGy6+pjHKaQJXCOG6NEcMAA8gdYF+5mzFvMm1SrpQ==
X-Received: by 2002:a05:6000:4312:b0:48d:f831:2681 with SMTP id ffacd0b85a97d-4a63a2d5b8amr7126622f8f.38.1795019408782;
        Wed, 18 Nov 2026 08:30:08 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:08 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:41 +0000
Subject: [PATCH 19/34] perf cs-etm: Decode one packet at a time and don't
 estimate timestamps
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
Message-Id: <20261118-james-coresight-jit-v1-19-dad4d90747f6@linaro.org>
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

Stop decoding after each packet instead of buffering packets until a
timestamp is reached. Give each range the last known timestamp instead
of estimating time using instruction counts. This makes the interleaving
of ranges between sinks less frequent, but that can be increased by
increasing the timestamp frequency. Timestamp estimation only added
complexity and was probably more misleading than useful.

Until the first trace timestamp is found, sort using zero. Only use the
AUX record time when trace timestamps are disabled.

packet_buffer[] now only ever has one packet in it, but keep it for a
later more mechanical removal in a later commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 124 +-----------------------
 tools/perf/util/cs-etm.c                        |  10 +-
 tools/perf/util/cs-etm.h                        |   4 +-
 3 files changed, 9 insertions(+), 129 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 895e85a1f54b..d7b596aeaa41 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -33,15 +33,6 @@
 #define CS_PKT_MON	0
 #endif
 
-/*
- * Assume a maximum of 0.1ns elapsed per instruction. This would be the
- * case with a theoretical 10GHz core executing 1 instruction per cycle.
- * Used to estimate the sample time for synthesized instructions because
- * Coresight only emits a timestamp for a range of instructions rather
- * than per instruction.
- */
-const u32 INSTR_PER_NS = 10;
-
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg, void *data);
@@ -124,20 +115,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 	return 1;
 }
 
-/*
- * Calculate the number of nanoseconds elapsed.
- *
- * instr_count is updated in place with the remainder of the instructions
- * which didn't make up a whole nanosecond.
- */
-static u32 cs_etm_decoder__dec_instr_count_to_ns(u32 *instr_count)
-{
-	const u32 instr_copy = *instr_count;
-
-	*instr_count %= INSTR_PER_NS;
-	return instr_copy / INSTR_PER_NS;
-}
-
 static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
 					    ocsd_etmv3_cfg *config)
 {
@@ -259,18 +236,6 @@ cs_etm_decoder__init_def_logger_printing(struct cs_etm_decoder_params *d_params,
 	return 0;
 }
 
-static void
-cs_etm_decoder__do_soft_timestamp(struct cs_etm_packet_queue *packet_queue)
-{
-	u64 estimated_ts;
-
-	estimated_ts = packet_queue->cs_timestamp +
-			cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
-
-	/* Estimated TS can never be higher than the next real one in the trace */
-	packet_queue->cs_timestamp = min(packet_queue->next_cs_timestamp, estimated_ts);
-}
-
 static ocsd_datapath_resp_t
 cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 				  const ocsd_generic_trace_elem *elem,
@@ -279,7 +244,6 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet_queue *packet_queue;
 	u64 converted_timestamp;
-	u64 estimated_first_ts;
 
 	/* Ignore trace timestamps when unavailable or disabled by --itrace=Z. */
 	if (!cs_etm__has_timestamps(etmq))
@@ -297,54 +261,14 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	converted_timestamp = elem->timestamp ?
 				cs_etm__convert_sample_time(etmq, elem->timestamp) : 0;
 
-	/*
-	 * We've seen a timestamp packet before - simply record the new value.
-	 * Function do_soft_timestamp() will report the value to the front end,
-	 * hence asking the decoder to keep decoding rather than stopping.
-	 */
-	if (packet_queue->next_cs_timestamp) {
-		/*
-		 * What was next is now where new ranges start from, overwriting
-		 * any previous estimate in cs_timestamp
-		 */
-		packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
-		packet_queue->next_cs_timestamp = converted_timestamp;
-		return OCSD_RESP_CONT;
-	}
-
 	if (!converted_timestamp) {
-		/*
-		 * Zero timestamps can be seen due to misconfiguration or hardware bugs.
-		 * Warn once, and don't try to subtract instr_count as it would result in an
-		 * underflow.
-		 */
-		packet_queue->cs_timestamp = 0;
 		pr_warning_once("Bad Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
 				". Decode in order of trace collection by prepending 'Z' to your current --itrace arguments.\n",
 				indx);
-
-	} else if (packet_queue->instr_count / INSTR_PER_NS > converted_timestamp) {
-		/*
-		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
-		 * result in an underflow. Warn and clamp at 0 if it would.
-		 */
-		packet_queue->cs_timestamp = 0;
-		pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
-	} else {
-		/*
-		 * This is the first timestamp we've seen since the beginning of traces
-		 * or a discontinuity.  Since timestamps packets are generated *after*
-		 * range packets have been generated, we need to estimate the time at
-		 * which instructions started by subtracting the number of instructions
-		 * executed to the timestamp. Don't estimate earlier than the last used
-		 * timestamp though.
-		 */
-		estimated_first_ts = converted_timestamp -
-					(packet_queue->instr_count / INSTR_PER_NS);
-		packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, estimated_first_ts);
+		return OCSD_RESP_CONT;
 	}
-	packet_queue->next_cs_timestamp = converted_timestamp;
-	packet_queue->instr_count = 0;
+
+	packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, converted_timestamp);
 
 	/* Tell the front end which traceid_queue needs attention */
 	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
@@ -353,13 +277,6 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	return OCSD_RESP_WAIT;
 }
 
-static void
-cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
-{
-	packet_queue->next_cs_timestamp = 0;
-	packet_queue->instr_count = 0;
-}
-
 static enum cs_etm_isa
 cs_etm_decoder__get_isa(const ocsd_generic_trace_elem *elem)
 {
@@ -426,11 +343,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet_queue->packet_buffer[et].el = ocsd_EL_unknown;
 	packet_queue->packet_buffer[et].tid = -1;
 
-	/* Keep decoding until a timestamp is hit or queue fills up */
-	if (cs_etm__has_timestamps(etmq) &&
-	    packet_queue->packet_count < CS_ETM_PACKET_MAX_BUFFER - 1)
-		return OCSD_RESP_CONT;
-
 	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
 	return OCSD_RESP_WAIT;
 }
@@ -467,19 +379,6 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 
 	packet->last_instr_size = elem->last_instr_sz;
 
-	packet_queue->instr_count += elem->num_instr_range;
-
-	if (packet_queue->next_cs_timestamp) {
-		/*
-		 * Once a real timestamp has been received, every range can be
-		 * handed to the frontend without queueing using an estimated
-		 * soft timestamp.
-		 */
-		cs_etm_decoder__do_soft_timestamp(packet_queue);
-		cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
-		return OCSD_RESP_WAIT;
-	}
-
 	return ret;
 }
 
@@ -489,11 +388,6 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
 				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
-	/*
-	 * Something happened and who knows when we'll get new traces so
-	 * reset time statistics.
-	 */
-	cs_etm_decoder__reset_timestamp(queue);
 	return cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
@@ -602,12 +496,6 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	if (elem->context.el_valid)
 		packet->el = elem->context.exception_level;
 
-	/*
-	 * A timestamp is generated after a PE_CONTEXT element so make sure
-	 * to rely on that coming one.
-	 */
-	cs_etm_decoder__reset_timestamp(packet_queue);
-
 	return ret;
 }
 
@@ -815,11 +703,7 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 			break;
 		}
 
-		/*
-		 * Return to the input code if the packet buffer is full.
-		 * Flushing will get done once the packet buffer has been
-		 * processed.
-		 */
+		/* Return to the input code if processing was paused. */
 		if (OCSD_DATA_RESP_IS_WAIT(cur))
 			break;
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index accd4ffc19aa..f33e410e85bf 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -570,6 +570,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
 					  u8 trace_chan_id)
 {
+	/* Tell the frontend which queue the last processed packet is in. */
 	etmq->ready_chan_id = trace_chan_id;
 }
 
@@ -596,8 +597,7 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 	if (trace_chan_id)
 		*trace_chan_id = etmq->ready_chan_id;
 
-	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
-						     etmq->ready_chan_id);
+	packet_queue = cs_etm__etmq_get_packet_queue(etmq, etmq->ready_chan_id);
 	if (!packet_queue)
 		return 0;
 
@@ -611,7 +611,7 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 	if (!etmq->etm->has_timestamps)
 		return etmq->buffer->time;
 
-	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
+	/* Use the last trace timestamp, or zero if none has been found yet. */
 	return packet_queue->cs_timestamp;
 }
 
@@ -2614,9 +2614,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	/*
 	 * Packets are decoded and added to the decoder's packet queue
 	 * until the decoder packet processing callback has requested that
-	 * processing stops or there is nothing left in the buffer.  Normal
-	 * operations that stop processing are a timestamp packet or a full
-	 * decoder buffer queue.
+	 * processing stops or there is nothing left in the buffer.
 	 */
 	ret = cs_etm_decoder__process_data_block(etmq->decoder,
 						 etmq->offset,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index ffe3a33885a7..e404753820dc 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -199,9 +199,7 @@ struct cs_etm_packet_queue {
 	u32 packet_count;
 	u32 head;
 	u32 tail;
-	u32 instr_count;
-	u64 cs_timestamp; /* Timestamp from trace data, converted to ns if possible */
-	u64 next_cs_timestamp;
+	u64 cs_timestamp; /* Timestamp, in ns when has_virtual_ts == true */
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 

-- 
2.43.0

