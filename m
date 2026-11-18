Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019428;
	b=UgrFm40qKHOaHv3ZSAeiXffz5kCkn0Xk2iNG4B25rqImF8rKD+OymG6pRoo724H4DIOu
	 zilZOpSjoy5pMiUJLOAav+joueqXdJxwj08Crr/GUQmxd2xhyRacJt9lxknhWfAs0hiC3
	 pOK2wA4uUWNMF6wTBieM/TVQZhHIEnwisS7qqkIORelK6gX/kVlLz0D4aI5Vtm2BYvb4R
	 4WSSBDjI4jkKo6BzYLNmF5ml4lDslogJ1DKS9IGTbtuBeidNz6/k+NtBgNGYixXpOacYD
	 8rDa5CC3guZ3HJnHZIIRwH5e/UzPXBpj79RJB+gvIsJKlUDWEI15Fx148BY8Qu7SY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=E/2hFSm7meulPmCwLu++JRGIkk9hAFb9HU0/al2mUsQ=;
	b=N4GY6rWLAYtSPk89iPRNWcv8cNawVYA+2etMme7nbzlc9ifqXu/8z7P717SrhzkO4pe/
	 ne1KQkgfbwZEtF/sO04aS2ZYDWsgvRRl9/Kab1jzYDnkEcZS3oCq1vg60DhiCVR6OnhuX
	 SsCTcX2fBrJhgrSOZOsDWRK6H8rsdxwFH+ohqi4ptgyB5qHejWxuU7Wmpxk8kRjeNxNBt
	 q/zpnj/Uv7j84hCceHpPT18CvZbhmHEhVHBoAtipvUv1B8C4HnveUVp/ESLcCY2JP1rLf
	 17/9bd7xtFUKlMwOMg2j2JYwokwGBL32oxqXYj9bH98F/rH8l28P24e7ZZVOyxBP0tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zI1NCbim;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D66606A330
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8D66606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zI1NCbim
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so842935f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019420; x=1795624220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/2hFSm7meulPmCwLu++JRGIkk9hAFb9HU0/al2mUsQ=;
        b=zI1NCbimL0cC2DD5CQctccLpUJbBhgWwtm73z1xyituue/cnIvOT+LTHJv77w1pJwO
         x76dyrtD48Mn5BAXKGtDQaSMVxKx6N8b70ANG6Ulgp1g2te4xkGCd6aOuOEuZhaEt3nu
         sFvuu1QBH6WnNYID9MgAW4ZnSNDGxTaWDzdAZTpTobYTFzWoaTiskSniOkxFPXyP501T
         0bciRLyiVakjSr0XNJi7zNdRfFk4vGpKWgv0fJEcyoG4zRX+s/PpOQJ3YcUo8OJBElWc
         qkKi2eVv/6unS71F9a3IGJPnQp0nNdpERaO9E4xFLFT4uqH9rSrMsC9k9VdJHC0bC5mO
         MkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019420; x=1795624220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/2hFSm7meulPmCwLu++JRGIkk9hAFb9HU0/al2mUsQ=;
        b=fPARAcvFXMP5So8/GJXR3mmlbe+K+BkN8/8QJFh6z4VBEEPUSZwikdMAKZXZdbcZgo
         9FoT0Sxz2TfJHjFV/6rCsdOLb/WIwBYPhNils5y85lHcZ4VCzOznUb0vt5YBtpxfwn/i
         qS3Nob/T0QpSuUVhKhffuEUOI4Umbn+7rt1glhmfPICGxy/8RsSn915Iw8hpvDdVf2sk
         189SIhaKmyy4sF9n51gjPPuB1cjYnGi7zeTJkQvz9TAxfbRCmUWjq32YR6uwddN0+ciM
         OOB9PoFJfUQ3hhtj5191kOsFn9oWyjFQwrs/SNmgYjAoOkuzJaT/WhSC9TEWZsSQW4TG
         4Oqw==
X-Gm-Message-State: APuU4Z8KQyVCyTlePiXfnOKP6+xQtr+RaWWJ9O44rRCtNl2dNy2slS9e
	o4Cm1sMhYN+pt6PDvrzba/FGyhPnSpcm+1rzg9s6jN3azbLsjEOt4u7ItAH8Ez7zLk0=
X-Gm-Gg: AZFdTZeDvTrR/SWNEFU4DsUYlVqAPxheVkAOQPhaZ/4mRUPC7Bf1GpEmY8u8ymKHiZH
	P1y5qPgmWP03roFVoiSr3eogb3zSEeScUP50W8NIHwwkVSayKBbhniXEdIubGohy2isQzL5qDEu
	7h4oCuRIkd+h5upQUdGkLLxFGbvVBqC6qJnJxBtQEViGmOrfth1XcNsOoKePmYUVN/E3LS9Uz7t
	IEEToG17H7v6eHin5x3MB70KB6ySZUVm21VbzCKZYyVjoA/ZcwxPeNtvT75NEPIO4/DOfnKsX0+
	QOrXT8dVA8btkuBWgI2QvyAEtshNDWFy6B+f6j87l6SNEPUhNqJ+//XNbNIVLiB6/THM9W2SBdo
	2umIx7VQxkZfcXo+THcHsezZ/DY5Kuw45fD5DQSk4yVRXubKnToXYq0BTUk3eItxzLtJtMl15AL
	Hi5b+RRpyxn/QCJJwdfl2MlDUQG0FcWOKa1aFH55RgIYrPiRFbwCD7Dq5BMqXuAfH2tUYzhhB/j
	XUtaDChiZt5StIOQIugLlCZM/7dmU2H6rsxm+zJwmZoMirMfLB6X00rWtxAb5vxMArT4llDu4yk
	iFhLM+2prtyjvHRf6Jcmt9RkhqpBvYs+
X-Received: by 2002:a05:6000:290c:b0:4a7:a8f:5297 with SMTP id ffacd0b85a97d-4a70a8f5685mr6082263f8f.19.1795019419993;
        Wed, 18 Nov 2026 08:30:19 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:19 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:51 +0000
Subject: [PATCH 29/34] perf cs-etm: Find timestamps by searching ahead
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
Message-Id: <20261118-james-coresight-jit-v1-29-dad4d90747f6@linaro.org>
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

Use the packet-only timestamp decoder to search ahead for the next
timestamp on discontinuities, so the time is known before the full
decoder needs instruction mappings.

Use the next timestamp from any trace ID rather than searching only
within one stream which would be significantly more complicated.
Searching and re-ordering is most useful with TRBE and virtual
timestamps where there is only one trace ID stream anyway. Timestamps are
also unlikely to be significantly out of order between streams.

Reorder the packets in the backend so timestamps precede context packets
and discontinuities. The frontend can then flush samples using the old
timestamp before processing the next packet, and not attempt to look up
the thread from the context packet before the Perf event for it was
reached.

Drop the trace ID from the heap and only store the queue number. We
never used the heap to re-order between individual trace ID streams
anyway, and now that the decoder returns last decoded context directly,
storing the ID in the heap does nothing.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 163 +++++++++++++++++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   9 +-
 tools/perf/util/cs-etm.c                        | 200 +++++++++---------------
 tools/perf/util/cs-etm.h                        |   2 +-
 4 files changed, 227 insertions(+), 147 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 56de6c76de68..b7ed7847f209 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -13,12 +13,12 @@
 #include <linux/overflow.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <string.h>
 #include <opencsd/c_api/opencsd_c_api.h>
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
 #include "debug.h"
-#include "intlist.h"
 
 /* use raw logging */
 #ifdef CS_DEBUG_RAW
@@ -42,6 +42,12 @@
  */
 #define CS_ETM_TIMESTAMP_SEARCH_MAX 1024
 
+struct cs_etm_buffer {
+	u64 index;
+	const u8 *data;
+	size_t len;
+};
+
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg, void *data);
@@ -55,7 +61,12 @@ struct cs_etm_packet_decoder {
 	struct cs_etm_decoder base;
 	cs_etm_mem_cb_type mem_access;
 	struct cs_etm_traceid_ctxt *traceid_ctxt;
+	u64 packet_index;
+	/* Next output packet, returned before resuming OpenCSD. */
+	struct cs_etm_traceid_ctxt *pending;
+	struct cs_etm_packet pending_packet;
 	struct cs_etm_timestamp_decoder *timestamp_decoder;
+	u64 timestamp; /* Last delivered queue timestamp. */
 };
 
 struct cs_etm_timestamp_source {
@@ -126,6 +137,10 @@ int cs_etm_decoder__reset(struct cs_etm_packet_decoder *decoder, u64 index)
 {
 	int ret;
 
+	decoder->traceid_ctxt = NULL;
+	decoder->packet_index = 0;
+	decoder->pending = NULL;
+	memset(&decoder->pending_packet, 0, sizeof(decoder->pending_packet));
 	ret = cs_etm_decoder__reset_core(&decoder->base);
 	if (ret)
 		return ret;
@@ -294,11 +309,12 @@ static int cs_etm_decoder__init_core(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
+cs_etm_decoder__do_hard_timestamp(struct cs_etm_packet_decoder *decoder,
 				  const ocsd_generic_trace_elem *elem,
 				  const uint8_t trace_chan_id,
 				  const ocsd_trc_index_t indx)
 {
+	struct cs_etm_queue *etmq = decoder->base.data;
 	struct cs_etm_traceid_ctxt *tidc;
 	u64 converted_timestamp;
 
@@ -325,7 +341,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		return OCSD_RESP_CONT;
 	}
 
-	tidc->cs_timestamp = max(tidc->cs_timestamp, converted_timestamp);
+	decoder->timestamp = max(decoder->timestamp, converted_timestamp);
 	tidc->packet->sample_type = CS_ETM_TIMESTAMP;
 
 	/* Halt processing until we are being told to proceed */
@@ -579,15 +595,17 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__buffer_exception_ret(etmq, tidc,
 							    elem, trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_TIMESTAMP)
-		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
+		resp = cs_etm_decoder__do_hard_timestamp(decoder, elem,
 							 trace_chan_id,
 							 indx);
 	else if (type == OCSD_GEN_TRC_ELEM_PE_CONTEXT)
 		resp = cs_etm_decoder__set_tid(etmq, tidc,
 					       elem, trace_chan_id);
 
-	if (OCSD_DATA_RESP_IS_WAIT(resp))
+	if (OCSD_DATA_RESP_IS_WAIT(resp)) {
 		decoder->traceid_ctxt = tidc;
+		decoder->packet_index = indx;
+	}
 
 	return resp;
 }
@@ -827,30 +845,27 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 	return NULL;
 }
 
-int cs_etm_decoder__process_data_block(struct cs_etm_packet_decoder *decoder,
-				       u64 indx, const u8 *buf,
-				       size_t len, size_t *consumed,
-				       struct cs_etm_traceid_ctxt **tidc)
+static int cs_etm_decoder__process_data(struct cs_etm_decoder *decoder,
+					u64 indx, const u8 *buf,
+					size_t len, size_t *consumed)
 {
 	int ret = 0;
 	ocsd_datapath_resp_t cur = OCSD_RESP_CONT;
-	ocsd_datapath_resp_t prev_return = decoder->base.prev_return;
+	ocsd_datapath_resp_t prev_return = decoder->prev_return;
 	size_t processed = 0;
 	u32 count;
 
-	decoder->traceid_ctxt = NULL;
-
 	/* Drain buffered output even if the last input byte was consumed. */
 	while (processed < len || OCSD_DATA_RESP_IS_WAIT(prev_return)) {
 		if (OCSD_DATA_RESP_IS_WAIT(prev_return)) {
-			cur = ocsd_dt_process_data(decoder->base.dcd_tree,
+			cur = ocsd_dt_process_data(decoder->dcd_tree,
 						   OCSD_OP_FLUSH,
 						   0,
 						   0,
 						   NULL,
 						   NULL);
 		} else if (OCSD_DATA_RESP_IS_CONT(prev_return)) {
-			cur = ocsd_dt_process_data(decoder->base.dcd_tree,
+			cur = ocsd_dt_process_data(decoder->dcd_tree,
 						   OCSD_OP_DATA,
 						   indx + processed,
 						   len - processed,
@@ -869,16 +884,130 @@ int cs_etm_decoder__process_data_block(struct cs_etm_packet_decoder *decoder,
 		prev_return = cur;
 	}
 
-	decoder->base.prev_return = cur;
+	decoder->prev_return = cur;
 	*consumed = processed;
-	if (tidc)
-		*tidc = decoder->traceid_ctxt;
 	if (OCSD_DATA_RESP_IS_FATAL(cur))
 		return -EINVAL;
 
 	return ret;
 }
 
+static int cs_etm_decoder__process_timestamp(struct cs_etm_timestamp_decoder *timestamp_decoder,
+					     const struct cs_etm_buffer *buffer,
+					     u64 index)
+{
+	u64 decode_index = timestamp_decoder->timestamp_decode_index;
+	size_t offset, processed;
+	int ret;
+
+	if (decode_index < buffer->index ||
+	    decode_index - buffer->index > buffer->len)
+		return -EINVAL;
+
+	offset = decode_index - buffer->index;
+	timestamp_decoder->timestamp_search_index = index;
+	timestamp_decoder->timestamp_packet_count = 0;
+	timestamp_decoder->timestamp = 0;
+	ret = cs_etm_decoder__process_data(&timestamp_decoder->base, decode_index,
+					   &buffer->data[offset], buffer->len - offset,
+					   &processed);
+	timestamp_decoder->timestamp_decode_index += processed;
+	return ret;
+}
+
+static int cs_etm_decoder__search_timestamp(struct cs_etm_packet_decoder *decoder,
+					    const struct cs_etm_buffer *buffer,
+					    u64 index, u64 *timestamp)
+{
+	struct cs_etm_timestamp_decoder *timestamp_decoder = decoder->timestamp_decoder;
+	int ret;
+
+	*timestamp = 0;
+	if (index < buffer->index || index - buffer->index >= buffer->len)
+		return 0;
+
+	/* Reuse a timestamp still ahead of this packet instead of skipping it. */
+	if (!timestamp_decoder->timestamp ||
+	    timestamp_decoder->timestamp_search_index <= index) {
+		ret = cs_etm_decoder__process_timestamp(timestamp_decoder, buffer, index);
+		if (ret)
+			return ret;
+	}
+
+	if (timestamp_decoder->timestamp)
+		*timestamp = cs_etm__convert_sample_time(decoder->base.data,
+							 timestamp_decoder->timestamp);
+	return 0;
+}
+
+/*
+ * Re-order timestamps and context and discontinuity packets so that the
+ * frontend can process them at the correct time.
+ */
+static int cs_etm_decoder__reorder_packet(struct cs_etm_packet_decoder *decoder,
+					  const struct cs_etm_buffer *buffer,
+					  struct cs_etm_traceid_ctxt *tidc)
+{
+	u64 timestamp;
+	int ret;
+
+	if (tidc->packet->sample_type != CS_ETM_CONTEXT &&
+	    tidc->packet->sample_type != CS_ETM_DISCONTINUITY)
+		return 0;
+
+	/*
+	 * ETM always emits a timestamp after a context or trace discontinuity
+	 * so search for it and give it to the frontend first.
+	 */
+	ret = cs_etm_decoder__search_timestamp(decoder, buffer, decoder->packet_index, &timestamp);
+	if (ret)
+		return ret;
+
+	decoder->pending = tidc;
+	decoder->pending_packet = *tidc->packet;
+	decoder->pending_packet.timestamp = max(decoder->timestamp, timestamp);
+	if (tidc->packet->sample_type == CS_ETM_CONTEXT) {
+		/* Publish the timestamp before allowing the context to be applied. */
+		decoder->timestamp = decoder->pending_packet.timestamp;
+		tidc->packet->sample_type = CS_ETM_TIMESTAMP;
+	} else {
+		/* Let the discontinuity flush preceding samples at the old time. */
+		decoder->pending_packet.sample_type = CS_ETM_TIMESTAMP;
+	}
+	return 0;
+}
+
+int cs_etm_decoder__process_data_block(struct cs_etm_packet_decoder *decoder,
+				       u64 indx, const u8 *buf,
+				       size_t len, size_t offset, size_t *consumed,
+				       struct cs_etm_traceid_ctxt **tidc)
+{
+	const struct cs_etm_buffer buffer = { .index = indx, .data = buf, .len = len };
+	int ret;
+
+	*consumed = 0;
+	if (decoder->pending) {
+		*tidc = decoder->pending;
+		*(*tidc)->packet = decoder->pending_packet;
+		decoder->timestamp = decoder->pending_packet.timestamp;
+		decoder->pending = NULL;
+		ret = 0;
+		goto out;
+	}
+
+	decoder->traceid_ctxt = NULL;
+	ret = cs_etm_decoder__process_data(&decoder->base, indx + offset, buf + offset,
+					   len - offset, consumed);
+	if (tidc)
+		*tidc = decoder->traceid_ctxt;
+	if (!ret && decoder->timestamp_decoder && tidc && *tidc)
+		ret = cs_etm_decoder__reorder_packet(decoder, &buffer, *tidc);
+out:
+	if (!ret && tidc && *tidc)
+		(*tidc)->packet->timestamp = decoder->timestamp;
+	return ret;
+}
+
 void cs_etm_decoder__zfree(struct cs_etm_packet_decoder **decoder)
 {
 	if (!(*decoder))
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 125696520625..67592b93778e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -87,9 +87,14 @@ enum cs_etm_decoder_operation {
 	CS_ETM_OPERATION_MAX,
 };
 
+/*
+ * Feed the complete AUX buffer, starting full decoding at offset. The timestamp
+ * decoder maintains its own position in the same buffer. Output may be
+ * returned without consuming input, including at the buffer end.
+ */
 int cs_etm_decoder__process_data_block(struct cs_etm_packet_decoder *decoder,
 				       u64 indx, const u8 *buf,
-				       size_t len, size_t *consumed,
+				       size_t len, size_t offset, size_t *consumed,
 				       struct cs_etm_traceid_ctxt **tidc);
 
 struct cs_etm_packet_decoder *
@@ -103,7 +108,7 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_packet_decoder *decoder,
 				      u64 start, u64 end,
 				      cs_etm_mem_cb_type cb_func);
 
-
+/* Reset all decoders to the start index of a new AUX buffer. */
 int cs_etm_decoder__reset(struct cs_etm_packet_decoder *decoder, u64 index);
 const char *cs_etm_decoder__get_name(struct cs_etm_packet_decoder *decoder);
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d275d3701165..5a704dfeebd3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -79,6 +79,8 @@ enum cs_etm_format {
 struct cs_etm_queue {
 	struct cs_etm_auxtrace *etm;
 	struct cs_etm_packet_decoder *decoder;
+	/* current packet/context */
+	struct cs_etm_traceid_ctxt *tidc;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
 	enum cs_etm_format format;
@@ -103,8 +105,8 @@ struct cs_etm_queue {
 static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp);
 static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
-static int cs_etm__decode_data_block(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_ctxt **tidc);
+static int cs_etm__decode_packet(struct cs_etm_queue *etmq,
+				 struct cs_etm_traceid_ctxt **tidc);
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
 static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
 static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
@@ -112,16 +114,6 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
 
-/*
- * A struct auxtrace_heap_item only has a queue_nr and a timestamp to
- * work with.  One option is to modify to auxtrace_heap_XYZ() API or simply
- * encode the etm queue number as the upper 16 bit and the channel as
- * the lower 16 bit.
- */
-#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)	\
-		      (queue_nr << 16 | trace_chan_id)
-#define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
-#define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
 #define SINK_UNSET ((u32) -1)
 #define MAX_TIMESTAMP (~0ULL)
 
@@ -545,32 +537,6 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 	return err;
 }
 
-/*
- * Timestamp used to order sample generation between queues.
- *
- * This can either be a virtual or non-virtual CoreSight timestamp value, or the
- * kernel time from the AUX record if there are no timestamps. The only
- * requirement is that it's the same timebase between queues so comparisons
- * work, the absolute value isn't important.
- *
- * This is not the same as the timestamp assigned to synthesized samples
- * (cs_etm__resolve_sample_time()) and may be zero before a timestamp is
- * received, at which point sample generation is still un-ordered.
- */
-static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
-					struct cs_etm_traceid_ctxt *tidc)
-{
-	/*
-	 * If there are no timestamps, use the TS from the AUX records to sort
-	 * in order of trace collection.
-	 */
-	if (!etmq->etm->has_timestamps)
-		return etmq->buffer->time;
-
-	/* Use the last trace timestamp, or zero if none has been found yet. */
-	return tidc->cs_timestamp;
-}
-
 static int cs_etm__init_traceid_ctxt(struct cs_etm_queue *etmq,
 				      struct cs_etm_traceid_ctxt *tidc,
 				      u8 trace_chan_id)
@@ -836,9 +802,8 @@ static void cs_etm__dump_event(struct cs_etm_queue *etmq,
 		size_t consumed;
 
 		ret = cs_etm_decoder__process_data_block(
-				etmq->decoder, buffer->offset,
-				&((u8 *)buffer->data)[buffer_used],
-				buffer->size - buffer_used, &consumed, NULL);
+				etmq->decoder, buffer->offset, buffer->data,
+				buffer->size, buffer_used, &consumed, NULL);
 		if (ret)
 			break;
 
@@ -1215,68 +1180,74 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
-static int cs_etm__add_to_heap(struct cs_etm_queue *etmq,
-			       struct cs_etm_traceid_ctxt *tidc)
+static int cs_etm__add_to_heap(struct cs_etm_queue *etmq, u64 timestamp)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
-	unsigned int cs_queue_nr;
 	int ret;
 
-	if (!tidc) {
-		struct int_node *inode = intlist__first(etmq->traceid_list);
-
-		if (!inode)
-			return -EINVAL;
-		tidc = cs_etm__etmq_get_traceid_ctxt(etmq, inode->i);
-	}
-	if (!tidc)
-		return -ENOMEM;
+	/*
+	 * Use collection time only when trace timestamps are unavailable or
+	 * disabled. Otherwise keep the last trace timestamp, or zero until
+	 * one is found.
+	 */
+	if (!etm->has_timestamps)
+		timestamp = etmq->buffer->time;
 
-	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, tidc->trace_chan_id);
-	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr,
-				 cs_etm__etmq_get_sort_timestamp(etmq, tidc));
+	ret = auxtrace_heap__add(&etm->heap, etmq->queue_nr, timestamp);
 	if (!ret)
 		etmq->on_heap = true;
 	return ret;
 }
 
-static int cs_etm__push_queue(struct cs_etm_queue *etmq, u64 time)
+static int cs_etm__insert_heap_queue(struct cs_etm_queue *etmq, u64 time)
 {
 	int ret;
 
 	if (!etmq || etmq->on_heap)
 		return 0;
 
-	while (!etmq->on_heap) {
+	if (!etmq->buf) {
 		ret = cs_etm__get_data_block(etmq);
 		if (ret <= 0)
 			return ret;
+	}
+
+	while (1) {
 		if (!etmq->etm->has_virtual_ts && etmq->buffer->time > time)
 			return 0;
 
-		ret = cs_etm__add_to_heap(etmq, NULL);
-		if (ret)
+		ret = cs_etm__decode_packet(etmq, &etmq->tidc);
+		if (ret < 0)
 			return ret;
+		if (etmq->tidc)
+			return cs_etm__add_to_heap(etmq, etmq->tidc->packet->timestamp);
+
+		/* Drain buffered decoder output before fetching another AUX buffer. */
+		ret = cs_etm__get_data_block(etmq);
+		if (ret <= 0)
+			break;
 	}
 
-	return 0;
+	if (!ret)
+		etmq->buf = NULL;
+	return ret;
 }
 
-static int cs_etm__push_heap(struct cs_etm_auxtrace *etm,
-			     struct perf_sample *sample)
+static int cs_etm__insert_heap(struct cs_etm_auxtrace *etm,
+			       struct perf_sample *sample)
 {
-	return cs_etm__push_queue(cs_etm__get_queue(etm, sample->cpu),
-				  sample->time);
+	return cs_etm__insert_heap_queue(cs_etm__get_queue(etm, sample->cpu),
+					 sample->time);
 }
 
-static int cs_etm__push_heap_all(struct cs_etm_auxtrace *etm)
+static int cs_etm__insert_heap_all(struct cs_etm_auxtrace *etm)
 {
 	unsigned int i;
 	int ret;
 
 	for (i = 0; i < etm->queues.nr_queues; i++) {
-		ret = cs_etm__push_queue(etm->queues.queue_array[i].priv,
-					 MAX_TIMESTAMP);
+		ret = cs_etm__insert_heap_queue(etm->queues.queue_array[i].priv,
+						MAX_TIMESTAMP);
 		if (ret)
 			return ret;
 	}
@@ -1493,12 +1464,12 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
 }
 
 static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
-					       struct cs_etm_traceid_ctxt *tidc)
+					       struct cs_etm_packet *packet)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 
 	if (etm->has_virtual_ts)
-		return tidc->cs_timestamp;
+		return packet->timestamp;
 
 	/*
 	 * Timestamps were disabled or no virtual TS. All samples are assigned
@@ -1598,7 +1569,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidc);
+	sample.time = cs_etm__resolve_sample_time(etmq, packet);
 
 	sample.ip = addr;
 	sample.pid = thread__pid(tidc->thread);
@@ -1694,7 +1665,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidc);
+	sample.time = cs_etm__resolve_sample_time(etmq, tidc->packet);
 
 	sample.ip = ip;
 	sample.pid = thread__pid(tidc->thread);
@@ -2086,7 +2057,7 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 
 	/*
 	 * We cannot assume consecutive blocks in the data file
-	 * are contiguous, reset the decoder to force re-sync.
+	 * are contiguous, reset the decoders to force re-sync.
 	 */
 	ret = cs_etm_decoder__reset(etmq->decoder, etmq->offset);
 	if (ret)
@@ -2492,17 +2463,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 	return 0;
 }
 
-static int cs_etm__decode_data_block(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_ctxt **tidc)
+/*
+ * Decode the next packet and put its context in tidc.
+ */
+static int cs_etm__decode_packet(struct cs_etm_queue *etmq,
+				 struct cs_etm_traceid_ctxt **tidc)
 {
 	int ret = 0;
 	size_t processed = 0;
+	size_t len = etmq->buf_used + etmq->buf_len;
+	u64 buffer_index = etmq->offset - etmq->buf_used;
 
-	/* Stop at a packet, a timestamp update, or the end of the buffer. */
 	ret = cs_etm_decoder__process_data_block(etmq->decoder,
-						 etmq->offset,
-						 &etmq->buf[etmq->buf_used],
-						 etmq->buf_len,
+						 buffer_index, etmq->buf, len,
+						 etmq->buf_used,
 						 &processed, tidc);
 	if (ret < 0)
 		goto out;
@@ -2520,6 +2494,10 @@ static int cs_etm__process_traceid_ctxt(struct cs_etm_queue *etmq,
 {
 	int ret;
 
+	/* A timestamp update only reschedules decoding; it consumes no trace. */
+	if (tidc->packet->sample_type == CS_ETM_TIMESTAMP)
+		return 0;
+
 	/*
 	 * Since packet addresses are swapped in packet
 	 * handling within below switch() statements,
@@ -2560,7 +2538,7 @@ static int cs_etm__process_traceid_ctxt(struct cs_etm_queue *etmq,
 		 * Discontinuity in trace, flush
 		 * previous branch stack
 		 */
-		cs_etm__flush(etmq, tidc);
+		ret = cs_etm__flush(etmq, tidc);
 		break;
 	case CS_ETM_EMPTY:
 		/*
@@ -2580,11 +2558,11 @@ static int cs_etm__process_traceid_ctxt(struct cs_etm_queue *etmq,
 static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr;
-	u8 trace_chan_id;
+	unsigned int queue_nr;
+	u64 cs_timestamp;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
-	struct cs_etm_traceid_ctxt *tidc, *decoded;
+	struct cs_etm_traceid_ctxt *tidc;
 	u64 queue_time;
 
 	while (1) {
@@ -2592,14 +2570,13 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 			break;
 
 		/* Take the entry at the top of the min heap */
-		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
-		queue_nr = TO_QUEUE_NR(cs_queue_nr);
-		trace_chan_id = TO_TRACE_CHAN_ID(cs_queue_nr);
+		queue_nr = etm->heap.heap_array[0].queue_nr;
+		cs_timestamp = etm->heap.heap_array[0].ordinal;
 		queue = &etm->queues.queue_array[queue_nr];
 		etmq = queue->priv;
 
 		/* Don't go further than the trace timestamp or collection time */
-		queue_time = etm->has_virtual_ts ? etm->heap.heap_array[0].ordinal :
+		queue_time = etm->has_virtual_ts ? cs_timestamp :
 						   etmq->buffer->time;
 		if (queue_time >= timestamp)
 			break;
@@ -2611,46 +2588,15 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		auxtrace_heap__pop(&etm->heap);
 		etmq->on_heap = false;
 
-		tidc  = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
-		if (!tidc) {
-			/*
-			 * No traceID queue has been allocated for this traceID,
-			 * which means something somewhere went very wrong.  No
-			 * other choice than simply exit.
-			 */
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = cs_etm__decode_data_block(etmq, &decoded);
-		if (ret < 0)
-			goto out;
-		if (decoded) {
-			tidc = decoded;
-			ret = cs_etm__process_traceid_ctxt(etmq, tidc);
-			if (ret)
-				goto out;
-			goto add_to_heap;
-		}
-get_data_block:
-		ret = cs_etm__get_data_block(etmq);
-		if (ret < 0)
+		tidc = etmq->tidc;
+		etmq->tidc = NULL;
+		ret = cs_etm__process_traceid_ctxt(etmq, tidc);
+		if (ret)
 			goto out;
 
-		/*
-		 * No more auxtrace_buffers to process in this etmq, simply
-		 * move on to another entry in the auxtrace_heap.
-		 */
-		if (!ret)
-			continue;
-
-add_to_heap:
-		/* Schedule the next decode step after consuming the current packet. */
-		ret = cs_etm__add_to_heap(etmq, tidc);
+		ret = cs_etm__insert_heap_queue(etmq, timestamp);
 		if (ret)
 			goto out;
-		if (!etmq->on_heap)
-			goto get_data_block;
 	}
 out:
 	return ret;
@@ -2767,7 +2713,7 @@ static int cs_etm__process_event(struct perf_session *session,
 		 * Perf events.
 		 */
 		if (has_sample_time && etm->has_virtual_ts) {
-			ret = cs_etm__push_heap(etm, sample);
+			ret = cs_etm__insert_heap(etm, sample);
 			if (ret)
 				return ret;
 		}
@@ -2791,7 +2737,7 @@ static int cs_etm__process_event(struct perf_session *session,
 		 * point because it's emitted at the same time.
 		 */
 		if (has_sample_time && etm->has_virtual_ts) {
-			ret = cs_etm__push_heap(etm, sample);
+			ret = cs_etm__insert_heap(etm, sample);
 			if (ret)
 				return ret;
 		}
@@ -2806,9 +2752,9 @@ static int cs_etm__process_event(struct perf_session *session,
 		 * would be too late.
 		 */
 		if (etm->has_timestamps && !etm->has_virtual_ts)
-			ret = cs_etm__push_heap_all(etm);
+			ret = cs_etm__insert_heap_all(etm);
 		else if (has_sample_time)
-			ret = cs_etm__push_heap(etm, sample);
+			ret = cs_etm__insert_heap(etm, sample);
 
 		if (ret)
 			return ret;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 5d9cc31b08d0..ff947bb847df 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -172,6 +172,7 @@ enum cs_etm_isa {
 struct cs_etm_queue;
 
 struct cs_etm_packet {
+	u64 timestamp; /* Timestamp, in ns when has_virtual_ts == true */
 	enum cs_etm_sample_type sample_type;
 	enum cs_etm_isa isa;
 	/* For exceptions: source PC, or CS_ETM_INVAL_ADDR. */
@@ -258,7 +259,6 @@ struct cs_etm_traceid_ctxt {
 	struct ip_callchain *callchain;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
-	u64 cs_timestamp; /* Timestamp, in ns when has_virtual_ts == true */
 
 	ocsd_ex_level decode_el;
 

-- 
2.43.0

