Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019410;
	b=F1WPPUSNXQsNaEB5qIl5mCtZhTjKkbdB/rLMZwvTrh/GTs+Vmh9tV8Anahy6XBQQ5elk
	 XgxCc6fP8i4D5ADNfPxQcBklvCYaM10OlLvD5jZ4zusYgTFpvlZWsueabOKaAoo9/DKQQ
	 AbbjItwno5u3vEl8okcj6djWBqTK3L3glxv3LHxzDyCOvxovbXkzvlXL2aSQB/t3KaRcq
	 STN1MFD1vaPcypI60CAJuZNvnjMZUTxfmtbKGpiOxWDrVz0J6RbxLsoiM3OhKnxsLRJrP
	 k1F1PoFJd67aweVDunwCOX01whliG0qG9i1UfB8pJkqsdhXu2SFNUPHGlGNYFT8TQBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=h8ddsP+SFgCsu/2Whmv76Fu1fsXFcieF5z95Ul9s/Pg=;
	b=4d3m8QJYslnar+9L4Aq6wEu/oA685HJH8lRLAlMFr/jcDerWWGYMwse00dkDeUW7f2ql
	 JjEHJ3H89zT7p4d6vaADRLb9RthyR82B9e4MqXngYs3cdlgNlYJ9zzQiIN1bUpW5G+Pbq
	 PmWpTcEOsQ8oAUvIuCeb6il8dn8NTQQqJFcaKOywNWAMlhq1Sj8/h6Ed2FVA3x4Xhoh+C
	 VHZfa6FowJZzcPAat++GoAqbQDWWWU6iAP+rqsjHDEtkYxkVNBu8Lwe4T+JLamWiglrIX
	 wxVuSkfrV32xnk1CAIlJWf61EEwhN6F6d/+9uTPF7CcqDKm6GyS3SP9CUxVUXhfWnLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQtmkK+A;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E460A5BFD
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 304E460A5BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQtmkK+A
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso759136f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019405; x=1795624205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8ddsP+SFgCsu/2Whmv76Fu1fsXFcieF5z95Ul9s/Pg=;
        b=sQtmkK+A9brRVWVybev30bwPk4K03Orq9EEeZ/X10C0Ga0/vkZ5WW7vWQYVcZ1tOHV
         /Z5qvl4sbqL1q+LTrKVweSelSOPrPuKl6wRnaWZ0WxamuweS0nXINi4Y8zRzhlHP6sSj
         wwP6gFlQufdsk6BjgBiiv+4Kpcpxu3OzLwTjG5C15RRpl43IX1ioG/XCV4fQuK3I+QyX
         Vv7Y1yBx+6hJplrPhqKnOkjpdm+UNCW05ynjQ1/hlYAsbrOUbPc2Kkh3TjIIL/o86xtF
         TkK8N4ugAXR78MMbmr1HvZacpCoZiDgVrqrP/WjJtGnqOZC0rSCSshPDPN2WtAS9JP05
         TbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019405; x=1795624205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8ddsP+SFgCsu/2Whmv76Fu1fsXFcieF5z95Ul9s/Pg=;
        b=hKGxw04Y4zhJoMoSUuZbpH4N/DhvDWVfRYUKIIytoIG4zd7LIq1+X2ppGmLKtuwGDd
         6OZeXnLTkCMQeKT12GoKS9E4Yx1iT705Razls2zOLlrXX2k2CMqsAFGO6j94VwcbqAkc
         fRkQVOtuRTrm1a347HN8GT6HQWlwVTfvL/W0oR/HkZ0cRjp6KxbqgqgdilwhPFTSI+BW
         361tAU/vWBsOFoggaf0EcznF6XHMaBqKc9Rllnd0UH2vRemizywve5VMjcPzyERtD0wp
         sVykXXuGTIo3Ru2n7gxKNqnby+8TNsIPXLjxOqQuqT5TeFblKh0UXusHb8w94uZ/ikEQ
         mHvA==
X-Gm-Message-State: APuU4Z81L5p3gHnsObzJ2suA5/XCHhnYT1R6mWX2Y1HPRc0t3683yc1h
	VmmZuZIjR8OnLVxmwExB6+bhWoCLMxgK8dHlbuYB2aWgVpKIZcDsjXg58oqY+1abS4A=
X-Gm-Gg: AZFdTZdrMP/OP2y+cTQj1FvAVJ+zHzFzEsuA2lRf7cxPp3C3TiYF/DTwkt5ikqoNtpf
	r44kBKX4jxyIzkbTuSHLVkIQp9CkY2NBU9AqPUMY3hC3nqwcvunhqXhxItnJrvFiOj3I3rSRb/e
	67hXgTdvgpVO0QzxS8dfR7VtaBShUQjqUxqfj5us2NnUB/959WCTnAl+wBINgwLU1E3WD30ETWb
	PjoywZxwLXuXxPjzbjQFPpMBGE5VVyBQF3sUfKk7VihwBLYFt/ga9szz+Gd12UbvGY5BDs0rQ8A
	yvCho1rzpCKeHY38lGhPyzS3SD5diyzp1ou6OhQTNZBjvRzKfF6WUE3+ZpkXcb5uOV1pZ9wmtGS
	QTgdjg7fkXCiEdw5T1g6oxXpSvVl959Fx7hXTQR55xP5I+Ww33AtxR4FYYa66ZNhiNopVRKhPRr
	mQZpwy9/k49Xktb4vUEtBuT7E/tCPO9KBppCXWXJz0JWJ+hadM6ipOLHEZ5uG20kNmuuLr05DTP
	bVXU3uj4U18nEhKBR0Bn87ZPi0lzUgL86NOMxTBH2+8Uq9jeMAEGUcM+MxSt1w5N1F7WouCK+EU
	LOlOgHRpe+DE8G+0p64mgtU2NOZCn9HwewfAwl1Wyo6rE5wkovLdgg==
X-Received: by 2002:a05:6000:4812:b0:492:a72:9303 with SMTP id ffacd0b85a97d-4a63b9d9635mr6271664f8f.22.1795019405544;
        Wed, 18 Nov 2026 08:30:05 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:05 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:38 +0000
Subject: [PATCH 16/34] perf cs-etm: Don't buffer non-timestamped packets
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
Message-Id: <20261118-james-coresight-jit-v1-16-dad4d90747f6@linaro.org>
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

We're going to use the same decode path for timestamped and not
timestamped, but we don't want to buffer non-timestamped trace
unnecessarily. Buffering is only for searching for a timestamp and doing
it when there are no timestamps only results in not generating samples
in trace order.

Let the backend know if timestamps are expected or not so it can decide
to buffer or not.

Rename pending_timestamp_chan_id because now it just means that a packet
is pending, either due to a timestamp being found or the first packet
decoded.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 50 +++++++++++--------------
 tools/perf/util/cs-etm.c                        | 23 ++++--------
 tools/perf/util/cs-etm.h                        |  4 +-
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d260d89453ef..895e85a1f54b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -259,27 +259,16 @@ cs_etm_decoder__init_def_logger_printing(struct cs_etm_decoder_params *d_params,
 	return 0;
 }
 
-static ocsd_datapath_resp_t
-cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
-				  struct cs_etm_packet_queue *packet_queue,
-				  const uint8_t trace_chan_id)
+static void
+cs_etm_decoder__do_soft_timestamp(struct cs_etm_packet_queue *packet_queue)
 {
 	u64 estimated_ts;
 
-	/* No timestamp packet has been received, nothing to do */
-	if (!packet_queue->next_cs_timestamp)
-		return OCSD_RESP_CONT;
-
 	estimated_ts = packet_queue->cs_timestamp +
 			cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
 
 	/* Estimated TS can never be higher than the next real one in the trace */
 	packet_queue->cs_timestamp = min(packet_queue->next_cs_timestamp, estimated_ts);
-
-	/* Tell the front end which traceid_queue needs attention */
-	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
-
-	return OCSD_RESP_WAIT;
 }
 
 static ocsd_datapath_resp_t
@@ -358,7 +347,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	packet_queue->instr_count = 0;
 
 	/* Tell the front end which traceid_queue needs attention */
-	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
+	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
 
 	/* Halt processing until we are being told to proceed */
 	return OCSD_RESP_WAIT;
@@ -437,10 +426,13 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet_queue->packet_buffer[et].el = ocsd_EL_unknown;
 	packet_queue->packet_buffer[et].tid = -1;
 
-	if (packet_queue->packet_count == CS_ETM_PACKET_MAX_BUFFER - 1)
-		return OCSD_RESP_WAIT;
+	/* Keep decoding until a timestamp is hit or queue fills up */
+	if (cs_etm__has_timestamps(etmq) &&
+	    packet_queue->packet_count < CS_ETM_PACKET_MAX_BUFFER - 1)
+		return OCSD_RESP_CONT;
 
-	return OCSD_RESP_CONT;
+	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
+	return OCSD_RESP_WAIT;
 }
 
 static ocsd_datapath_resp_t
@@ -475,19 +467,19 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 
 	packet->last_instr_size = elem->last_instr_sz;
 
-	/*
-	 * The packet queue is full and we haven't seen a timestamp (had we
-	 * seen one the packet queue wouldn't be full).  Let the front end
-	 * deal with it.
-	 */
-	if (ret == OCSD_RESP_WAIT)
-		goto out;
-
 	packet_queue->instr_count += elem->num_instr_range;
-	/* Tell the front end we have a new timestamp to process */
-	ret = cs_etm_decoder__do_soft_timestamp(etmq, packet_queue,
-						trace_chan_id);
-out:
+
+	if (packet_queue->next_cs_timestamp) {
+		/*
+		 * Once a real timestamp has been received, every range can be
+		 * handed to the frontend without queueing using an estimated
+		 * soft timestamp.
+		 */
+		cs_etm_decoder__do_soft_timestamp(packet_queue);
+		cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
+		return OCSD_RESP_WAIT;
+	}
+
 	return ret;
 }
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ca3878a3b74e..b746d1215e0a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -110,7 +110,7 @@ struct cs_etm_queue {
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
-	u8 pending_timestamp_chan_id;
+	u8 ready_chan_id;
 	enum cs_etm_format format;
 	u64 offset;
 	const unsigned char *buf;
@@ -568,17 +568,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 	return err;
 }
 
-void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
-					      u8 trace_chan_id)
+void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
+					  u8 trace_chan_id)
 {
-	/*
-	 * When a timestamp packet is encountered the backend code
-	 * is stopped so that the front end has time to process packets
-	 * that were accumulated in the traceID queue.  Since there can
-	 * be more than one channel per cs_etm_queue, we need to specify
-	 * what traceID queue needs servicing.
-	 */
-	etmq->pending_timestamp_chan_id = trace_chan_id;
+	etmq->ready_chan_id = trace_chan_id;
 }
 
 /*
@@ -598,19 +591,19 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet_queue *packet_queue;
 
-	if (!etmq->pending_timestamp_chan_id)
+	if (!etmq->ready_chan_id)
 		return 0;
 
 	if (trace_chan_id)
-		*trace_chan_id = etmq->pending_timestamp_chan_id;
+		*trace_chan_id = etmq->ready_chan_id;
 
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
-						     etmq->pending_timestamp_chan_id);
+						     etmq->ready_chan_id);
 	if (!packet_queue)
 		return 0;
 
 	/* Acknowledge pending status */
-	etmq->pending_timestamp_chan_id = 0;
+	etmq->ready_chan_id = 0;
 
 	/*
 	 * If there are no timestamps, use the TS from the AUX records to sort
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 9e842f1be9fc..71b1ef321625 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -270,8 +270,8 @@ int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 				       u8 trace_chan_id, ocsd_ex_level el,
 				       pid_t tid);
 bool cs_etm__has_timestamps(struct cs_etm_queue *etmq);
-void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
-					      u8 trace_chan_id);
+void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
+					  u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,

-- 
2.43.0

