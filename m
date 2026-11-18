Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019408;
	b=uzPT97lbhdZPMXK0BceHfi7oiWVMfJWXygn5udJaooq3Lv4JINYVqUEhRzhJOVKr97Il
	 sEQGX6rbA0Nydoal4089sojUaXcrxx6RZPNDFmnYRgEqah7aZKoDrlPlv0wtopR90V2jU
	 QhFvW0/DWr9GXBVaskVh8cdVj7dTOkj5Ben4B0mb0RbRybGPrCQlyKGXnHDVzWXrBafbz
	 7KccBTCwMZEQGXlIkiXM6L9oPXTTt0JBeOktPGJDl1BkW+UKD5YjPAD4oGC6N0IRmrYF8
	 kRNTWvhHLW/ZZVgBdY35wMwletK6YWETM2O15L5rjIEL+l4+ndmxehCHV7c9wCKGjvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=sxVhElAnpgNRNsgHcnjSLsgUsNEXWfsZYegUDnlKrMw=;
	b=G4Cxel8vx5kCesVO/xJ77M1iY0m07A5pEnM9lT1eU/uHo9wAB0qWEJZjlFdsdrrYjPeH
	 rC50WDElBe+Gp0RbsVybWHuzSBHFDF110LSumEyvjhhjOWfWwAVv/sP2joi+dXxktUElM
	 uTbIYLy4K8ikGbFkD1bLNLZ3J+c1rGWpCMwST8lqWVOC6PXRe4U0BHCDiDZwdhl+ozJap
	 hdkYFdbMzliO7Yk8/zh3sKY6DmGNB5uLBpFkytDe3+jQQRVD8whAH65aFFxn2G0Wxq6o3
	 qVqWm0ZHnx6AwKIV5dFZOWLlQaX89v7QUQHPevWKLwNQIaAlNpm8juDEXVS5ShitKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E34WSuG9;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4460A5BE2
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C4460A5BE2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E34WSuG9
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so661084f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019405; x=1795624205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxVhElAnpgNRNsgHcnjSLsgUsNEXWfsZYegUDnlKrMw=;
        b=E34WSuG9U8KH96kE8aaoTzieK8VvmnzjmfI4+oBJ7zMcD0C9b263uWaNeJjJavDeXu
         MiVwyWuqfr/VbPJm+thYD22MfIIiONJa/TMqjluIjqZ1vIBZRiuQa2hPY9GQP4TjsZo4
         h4xcLwppjM6XPnxRC5/GGWB1aa/pzuYNCkg7edSRKlTCoL4H3mL8DcZj4znshqujkFtu
         +hnkAboPsReXxdI7e2GbhaXzz7zmB0YiSU9iKkNbiu8X9CXVdSRHoGKy7+Fdq8oF4WWa
         MrOHdZVZmktOtW06w7HWGF1LAId+gLCYF+7SXPeZKpsrCSwShl80pP5jieXuRIureDuu
         8hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019405; x=1795624205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxVhElAnpgNRNsgHcnjSLsgUsNEXWfsZYegUDnlKrMw=;
        b=lwf9NpoBeokq7pQZq5CNyUWo5u/UDjzWERMtTt5wUlsEIKdIa+d9unqH+R9rAAHnpG
         ZGDDlrDavPvflqNQjw2twR6CTLiwpGwtJjvS0QlRex8sZvzL5oWcU7NxOZBMnUdHizMU
         7/DBNTYNatUVh488jfBXaPAI5cFK5fSo3B9lAZF3/y5SCOYZhO1V24vlLOIg56qNXocN
         yJDsBc7sLvBBqZGbr8g0iDblhx3FE5jap4IA187veuKIRVly4GYcmFEIeavMMUj+xNCL
         c6oNhplaUtplRmzFUzyIrDpl7Y+QCH4tjTM57Izxundag97JR5iODh8opHPgnvxOxR6e
         O/HA==
X-Gm-Message-State: APuU4Z9UQKEEu+bK9iG8gaTBsa+qOEeR69ldBDQFdQEnJ3ci4u7JNOGA
	DnQk/KjRMEG+HWm1ud60V5Id2p5ctzyE96mNFn8HdjpzXHqTHXqlEvphuCHxw21jOzA=
X-Gm-Gg: AZFdTZczs9Ntg+G8s2Hh14JcCren+j/rqjf6kCVCGVzRgC+nTiEt6sS91HJ1EjOmY31
	71wWxjdyWhos7ETAv4v52ggG/S04XRDvxTOGquPrh/fL8GEbVHZqR6EML5/KOHiLpkbKNrf5kSk
	esT/hMF4ZQrgb3fJwDvnM5zr/WkB9HNMeeK/Em0Dv6AjBfsGXnPH2OhSwbXgYZX0AiUJ3nkqC61
	jzzrJflNFdStdQwE4RVuG5TZy2EicHD4wt6O8JW6p4Sfhhx0Qs24PLgYak4uFLEdocY5gy8v6LJ
	kXcxrJ/u0olFKGgXIoVQUSewHXfH9ZQKiBlZztWu53e7ISGtk69WivUK3vD4R9DNJnPDj1oqvVe
	8/IbHFmW23f2fNCucp5vuNVtdwk7DY+f/sTwL9CiFrDIrrxgkJSt7OB5cXk+cq4rKJXQaFmXz2V
	0nR7dWJ+CE03gCjeKLzvelf0HQBIsYxkWB1GohF+0sR45MX+CRhGG2IuGXlNu0oC6uyp+qodeYH
	pQJGLI5g61/CYnLE7DwSc+pg/I8FJg7hD3+pSH1c7n83FLMIyKHrqwrqlT88ylOYrhcvQlK2NI1
	s2OIRZ4bJ+qKA14tKrRR5PZRRwBONONW
X-Received: by 2002:a05:6000:27d2:b0:491:8462:20b6 with SMTP id ffacd0b85a97d-4a63ac6bc12mr4817915f8f.38.1795019404507;
        Wed, 18 Nov 2026 08:30:04 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:03 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:37 +0000
Subject: [PATCH 15/34] perf cs-etm: Use time from Perf samples
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
Message-Id: <20261118-james-coresight-jit-v1-15-dad4d90747f6@linaro.org>
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

The time from the AUX record that's associated with a chunk of data can
be used as a time for the generated samples when there is no virtual
trace timestamp. This replaces 'latest_kernel_timestamp'.

Invert 'timeless_decoding' to 'has_timestamps' so that it's easier to
use and initialize it and 'has_virtual_ts' taking --itrace=Z into
account. That way the same codepaths can treat the trace as if it didn't
have timestamps, even if they exist in the trace.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/auxtrace.h                      |   2 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  15 +--
 tools/perf/util/cs-etm.c                        | 162 +++++++++++++-----------
 tools/perf/util/cs-etm.h                        |   2 +-
 4 files changed, 98 insertions(+), 83 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 980acb2dc687..c0f971b09b24 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -248,6 +248,7 @@ struct auxtrace {
  * @buffer_nr: used to number each buffer
  * @use_size: implementation actually only uses this number of bytes
  * @use_data: implementation actually only uses data starting at this address
+ * @time: PERF_SAMPLE_TIME associated with the trace
  */
 struct auxtrace_buffer {
 	struct list_head	list;
@@ -266,6 +267,7 @@ struct auxtrace_buffer {
 	u64			buffer_nr;
 	size_t			use_size;
 	void			*use_data;
+	u64			time;
 };
 
 /**
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index f133e11ccc7b..d260d89453ef 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -292,6 +292,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	u64 converted_timestamp;
 	u64 estimated_first_ts;
 
+	/* Ignore trace timestamps when unavailable or disabled by --itrace=Z. */
+	if (!cs_etm__has_timestamps(etmq))
+		return OCSD_RESP_CONT;
+
 	/* First get the packet queue for this traceID */
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
 	if (!packet_queue)
@@ -326,10 +330,9 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		 * underflow.
 		 */
 		packet_queue->cs_timestamp = 0;
-		if (!cs_etm__etmq_is_timeless(etmq))
-			pr_warning_once("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
-					". Decoding may be improved by prepending 'Z' to your current --itrace arguments.\n",
-					indx);
+		pr_warning_once("Bad Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
+				". Decode in order of trace collection by prepending 'Z' to your current --itrace arguments.\n",
+				indx);
 
 	} else if (packet_queue->instr_count / INSTR_PER_NS > converted_timestamp) {
 		/*
@@ -472,10 +475,6 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 
 	packet->last_instr_size = elem->last_instr_sz;
 
-	/* per-thread scenario, no need to generate a timestamp */
-	if (cs_etm__etmq_is_timeless(etmq))
-		goto out;
-
 	/*
 	 * The packet queue is full and we haven't seen a timestamp (had we
 	 * seen one the packet queue wouldn't be full).  Let the front end
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4252d25c991d..ca3878a3b74e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -49,14 +49,8 @@ struct cs_etm_auxtrace {
 	struct perf_session *session;
 	struct perf_tsc_conversion tc;
 
-	/*
-	 * Timeless has no timestamps in the trace so overlapping mmap lookups
-	 * are less accurate but produces smaller trace data. We use context IDs
-	 * in the trace instead of matching timestamps with fork records so
-	 * they're not really needed in the general case. Overlapping mmaps
-	 * happen in cases like between a fork and an exec.
-	 */
-	bool timeless_decoding;
+	/* Trace timestamps are available and not disabled by --itrace=Z. */
+	bool has_timestamps;
 
 	/*
 	 * Per-thread ignores the trace channel ID and instead assumes that
@@ -66,12 +60,11 @@ struct cs_etm_auxtrace {
 	 */
 	bool per_thread_decoding;
 	bool snapshot_mode;
-	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
+	bool has_virtual_ts; /* Trace timestamps can be used as kernel time. */
 	bool use_thread_stack;
 	bool use_callchain;
 
 	int num_cpu;
-	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
 	u32 branches_filter;
 	u64 branches_sample_type;
@@ -588,7 +581,19 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 	etmq->pending_timestamp_chan_id = trace_chan_id;
 }
 
-static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
+/*
+ * Timestamp used to order sample generation between queues.
+ *
+ * This can either be a virtual or non-virtual CoreSight timestamp value, or the
+ * kernel time from the AUX record if there are no timestamps. The only
+ * requirement is that it's the same timebase between queues so comparisons
+ * work, the absolute value isn't important.
+ *
+ * This is not the same as the timestamp assigned to synthesized samples
+ * (cs_etm__resolve_sample_time()) and may be zero before a timestamp is
+ * received, at which point sample generation is still un-ordered.
+ */
+static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 				      u8 *trace_chan_id)
 {
 	struct cs_etm_packet_queue *packet_queue;
@@ -607,6 +612,13 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
 	/* Acknowledge pending status */
 	etmq->pending_timestamp_chan_id = 0;
 
+	/*
+	 * If there are no timestamps, use the TS from the AUX records to sort
+	 * in order of trace collection.
+	 */
+	if (!etmq->etm->has_timestamps)
+		return etmq->buffer->time;
+
 	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
 	return packet_queue->cs_timestamp;
 }
@@ -961,7 +973,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	if (etm->timeless_decoding) {
+	if (!etm->has_timestamps) {
 		/*
 		 * Pass tid = -1 to process all queues. But likely they will have
 		 * already been processed on PERF_RECORD_EXIT anyway.
@@ -1355,7 +1367,7 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
 		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
 		 * the timestamp calculation for us.
 		 */
-		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+		cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
 
 		/* We found a timestamp, no need to continue. */
 		if (cs_timestamp)
@@ -1572,9 +1584,9 @@ int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 	return 0;
 }
 
-bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
+bool cs_etm__has_timestamps(struct cs_etm_queue *etmq)
 {
-	return !!etmq->etm->timeless_decoding;
+	return etmq->etm->has_timestamps;
 }
 
 static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
@@ -1625,10 +1637,14 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
-	if (!etm->timeless_decoding && etm->has_virtual_ts)
+	if (etm->has_virtual_ts)
 		return packet_queue->cs_timestamp;
-	else
-		return etm->latest_kernel_timestamp;
+
+	/*
+	 * Timestamps were disabled or no virtual TS. All samples are assigned
+	 * the kernel time from when the trace block was emitted.
+	 */
+	return etmq->buffer->time;
 }
 
 static bool cs_etm__packet_has_branch(struct cs_etm_packet *packet)
@@ -1897,10 +1913,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
 	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
 			    PERF_SAMPLE_PERIOD;
-	if (etm->timeless_decoding)
-		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
-	else
-		attr.sample_type |= PERF_SAMPLE_TIME;
+	attr.sample_type |= PERF_SAMPLE_TIME;
 
 	attr.exclude_user = evsel->core.attr.exclude_user;
 	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
@@ -2935,7 +2948,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		if (ret)
 			goto out;
 
-		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+		cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
 
 		if (!cs_timestamp) {
 			/*
@@ -3062,7 +3075,7 @@ static int cs_etm__process_event(struct perf_session *session,
 		 * for flush so that events from different threads are interleaved
 		 * properly.
 		 */
-		if (etm->per_thread_decoding && etm->timeless_decoding)
+		if (etm->per_thread_decoding && !etm->has_timestamps)
 			return cs_etm__process_timeless_queues(etm,
 							       event->fork.tid);
 		break;
@@ -3076,15 +3089,6 @@ static int cs_etm__process_event(struct perf_session *session,
 	case PERF_RECORD_SWITCH:
 		return cs_etm__process_switch(etm, sample);
 
-	case PERF_RECORD_AUX:
-		/*
-		 * Record the latest kernel timestamp available in the header
-		 * for samples so that synthesised samples occur from this point
-		 * onwards.
-		 */
-		if (sample->time && (sample->time != (u64)-1))
-			etm->latest_kernel_timestamp = sample->time;
-		break;
 
 	default:
 		break;
@@ -3122,23 +3126,6 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static void cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
-{
-	/* Take first ETM as all options will be the same for all ETMs */
-	u64 *metadata = etm->metadata[0];
-
-	/* Override timeless mode with user input from --itrace=Z */
-	if (etm->synth_opts.timeless_decoding) {
-		etm->timeless_decoding = true;
-		return;
-	}
-
-	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
-		etm->timeless_decoding = !(metadata[CS_ETM_ETMCR] & ETMCR_TIMESTAMP_EN);
-	else
-		etm->timeless_decoding = !(metadata[CS_ETMV4_TRCCONFIGR] & TRCCONFIGR_TS);
-}
-
 /*
  * Read a single cpu parameter block from the auxtrace_info priv block.
  *
@@ -3287,6 +3274,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		/* Old per-thread files have no CPU (before v6.4) */
 		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
 		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);
+		struct auxtrace_buffer *buffer;
 
 		if (!etmq)
 			return -EINVAL;
@@ -3306,10 +3294,12 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
 			  " tid: %d cpu: %d\n", frag_size, frag_start, sample->tid, sample->cpu);
 		err = auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
-						 file_offset, NULL);
+						 file_offset, &buffer);
 		if (err)
 			return err;
 
+		buffer->time = sample->time;
+
 		format = (aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW) ?
 				UNFORMATTED : FORMATTED;
 		if (etmq->format != UNSET && format != etmq->format) {
@@ -3568,6 +3558,51 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
+static void cs_etm__timestamp_opts_init(struct cs_etm_auxtrace *etm)
+{
+	/*
+	 * Take first ETM for has_timestamps because record options are the same
+	 * for all ETMs.
+	 */
+	u64 *metadata = etm->metadata[0];
+
+	/* Leave both timestamp flags clear with --trace=Z */
+	if (etm->synth_opts.timeless_decoding)
+		return;
+
+	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
+		etm->has_timestamps = metadata[CS_ETM_ETMCR] & ETMCR_TIMESTAMP_EN;
+	else
+		etm->has_timestamps = metadata[CS_ETMV4_TRCCONFIGR] & TRCCONFIGR_TS;
+
+	if (!etm->has_timestamps)
+		return;
+
+	if (etm->synth_opts.use_timestamp) {
+		/*
+		 * Prior to Armv8.4, Arm CPUs don't support FEAT_TRF feature,
+		 * therefore the decoder cannot know if the timestamp trace is
+		 * same with the kernel time.
+		 *
+		 * If a user has knowledge for the working platform they can
+		 * specify itrace option 'T' to force the decoder to use the
+		 * traced timestamp as the kernel time.
+		 */
+		etm->has_virtual_ts = true;
+	} else {
+		/* Use virtual timestamps if all ETMs report ts_source = 1 */
+		etm->has_virtual_ts = cs_etm__has_virtual_ts(etm->metadata, etm->num_cpu);
+		if (!etm->has_virtual_ts) {
+			ui__warning(
+				"Virtual timestamps are not enabled, or not supported by the traced system.\n"
+				"The time field of the samples will not be set accurately.\n"
+				"For Arm CPUs prior to Armv8.4 or without support FEAT_TRF,\n"
+				"you can specify the itrace option 'T' for timestamp decoding\n"
+				"if the Coresight timestamp on the platform is same with the kernel time.\n\n");
+		}
+	}
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
@@ -3733,29 +3768,8 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
 
-	if (etm->synth_opts.use_timestamp)
-		/*
-		 * Prior to Armv8.4, Arm CPUs don't support FEAT_TRF feature,
-		 * therefore the decoder cannot know if the timestamp trace is
-		 * same with the kernel time.
-		 *
-		 * If a user has knowledge for the working platform and can
-		 * specify itrace option 'T' to tell decoder to forcely use the
-		 * traced timestamp as the kernel time.
-		 */
-		etm->has_virtual_ts = true;
-	else
-		/* Use virtual timestamps if all ETMs report ts_source = 1 */
-		etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
-
-	if (!etm->has_virtual_ts)
-		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
-			    "The time field of the samples will not be set accurately.\n"
-			    "For Arm CPUs prior to Armv8.4 or without support FEAT_TRF,\n"
-			    "you can specify the itrace option 'T' for timestamp decoding\n"
-			    "if the Coresight timestamp on the platform is same with the kernel time.\n\n");
-
-	cs_etm__setup_timeless_decoding(etm);
+	/* Set etm->has_timestamps and etm->has_virtual_ts */
+	cs_etm__timestamp_opts_init(etm);
 
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index bf0e0f5a9711..9e842f1be9fc 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -269,7 +269,7 @@ enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 				       u8 trace_chan_id, ocsd_ex_level el,
 				       pid_t tid);
-bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
+bool cs_etm__has_timestamps(struct cs_etm_queue *etmq);
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id);
 struct cs_etm_packet_queue

-- 
2.43.0

