Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621749;
	b=b1YbZjoRlVQVCeSZBWEfr5LNXjudTpjGF4dZiSc758w8fe+7VOnyaVQKQ59aA+ySTj38
	 SEwWIzLNTUorhpbxXLMM9G00xfbU7pK4969N3nTPs3uNptxvKF/I0+AM25fwZpQLJs38z
	 6zYNmI2MKgYuGqfDkX4eKSKzyJTRJ1muMWuFAWnTkeqj/mHPL0xTRDTuqkhpf5kOyyUAJ
	 jhWFBf8A0RXG+XxHpExEoqUg1YPa1IT0Fyn0yRbv4tU50ODewpCMMu+HTBllBy5VoVAcD
	 n2/+SAdvAtWUzatEZJP7bhhpROfH9dwWsBabtV9jKRX7KtDwGVd01EsVdmrJNDHxsjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gDOKgyiHoV1+L9IrHJGqzLdyPO03dwc9hJe20Z/mTLk=;
	b=Y2VvOmK579XVZM1/CbTOMVs0sb7UkhVJ3bHIYQArQLSxfJ0hE4qxeLLvdwMkGBtgqvme
	 9Mwq/2aYPn2H9fWLwnH+mE9URBjhqPyhZUk1H4vRJOqeDLtwJQcanP7ZV7d7Fk1pZV7jv
	 tQyZZErTo2Vl6EHAzRbBCl3bbarnXEO2Ls6LtasSvb6j0pNI9ggobktuiz5dsMRiIHUjs
	 TNUYwEupHDuRZjHpIfgpNc9fSX4kFDM+6DgCOW4cini1H8HEr6OCsehMpI6YYgMsOS4Pv
	 4tZxLVmmvTDu6Vff6Lp88V1uDMq97XHglPnpdd+Xj/Y93ncD01k1mPyVtRolE74DR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YJN7Iw4Q;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44460A2631
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A44460A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YJN7Iw4Q
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so31217695e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621747; x=1794226547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDOKgyiHoV1+L9IrHJGqzLdyPO03dwc9hJe20Z/mTLk=;
        b=YJN7Iw4Q0LLmBxRNrJVqSg3KtrkyLiLCTIzVd1vsu6yUmY8LBpkywyUB3JKl5LmCAr
         CjPDJbb7qKFi4BdrX4Ii/f8PHkHDSyv+s7SgccxhHdkUuzNeZxhtpi7Ob+vVmLSZOCov
         43PmRuWevzyAJfnA5UKArt8+i+MHrfKkQgDDZKIJUOvOcdsJYuPNJ/GN5DyxSsbRvRgk
         QMduL+tj+KFmGNG1lGL36wQB6rcrHoDpy0HGsaBjIjr5LnmSaEplo0X0eCQFyRuJ27ao
         U+zUh8uni6tRFJVyeAL1YEs+D9pjTPds/NO5TByW/8QdVeymK3Por7rJFEa+5KCulo6M
         93TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621747; x=1794226547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gDOKgyiHoV1+L9IrHJGqzLdyPO03dwc9hJe20Z/mTLk=;
        b=hbxrqTfKHsRDxOM/KFNpGIQONqxb7PN8VcBQpUoJ3H3BcDZKLtBwBnyyGHIhaEP1dd
         ru/cd9V/qF+fY5VtT7lb53WM7pKSPAN6ekz0Wqm5JFWW4IvsGYfJ08nW42LsS3LokzJo
         y3uOVfhxmhV3HQvZR3CkJaKofqnPmk5TXndSWgi+ZSyA5hL2pzqyt1ay3Js7pKlkeXcK
         s6FUjM7DayfG6vpVbwOF83h7IEnzZ3NKO54BxJ2EVfQp/NkLAZNTm/1JgSonoHi4rk3U
         suRQ6WjOGH9QRfSwvYfVSV6NvqMTNao454RDPQIwEqpXzowqf1law7qN3wN+z0PDz1sT
         Wzzw==
X-Forwarded-Encrypted: i=1; AKwUvBylIEXvzmBocbyS8jSXYuNW0ZuUR3v8WHz53RyBXO+cEhGusNuAVSVlfKwcHouGSY7hVP63Uxrl+BQubS3qxIlg@vger.kernel.org
X-Gm-Message-State: AFq9FYLLxpRw0dlzrwyvSc2HxCqM7pzfli1igBCJSFpmXzn3h6lsNgWZ
	ooTD9cDUasaH+P01o4NbeU6r0A13ZlxFDq/wOEx6R/KJJxnIE/YVm/PbLC/Q+MEVQmk=
X-Gm-Gg: AYBFou3X0OrYVVGQYN8OdePbM2NNb9u4OS8GmnWXoaweNFTVBUOnV7Le4YnnAQvAodD
	wDWqHimrVROnBLrN7rw0Lh9pJLsSuaIylJjnkvh5SiaupJXidiPgFOlbKTX5ECeeeugaiZ8tThE
	fqeAbGL5eRCHeacuiqDVkhYE3aMSNmO+n7fxQyYB+OtxdtocblHbQd9CGduTbqE3w89AgMqZvMo
	XY/dRoLX8XWXENTcN3I76fOb89hCmxcBO5Xxtmanmy5rZwyL3QIidyQ8V856UoM92aILJLzldqU
	UNs9tA1hhyaVcQcEd5xe/S6/u4QzIWgPUKC9u6JWgtZqvSB+C0Yyw2roA7SNh5RaWGvHzXEmya/
	1E9AeoKGLtxqygT1GJpaCNyg7CWZxyxRS3iOyf0m1Q9jPi/YK7rW4Hl+hrhR4sgCodoXrnYSRGS
	XTyzJUvR37SjDg0aTmStYxDb472ETqAranB1W694PWC3Riqvk7atI8yt+NecBAJRyydQq1u8sxh
	mcqGhCNiwnr1zkCthlZJCcJ9XAZLGl3HbE8rtcTw7lMLfiNuBPL66jtDNOaog/CHnjaqsn3OHHN
	nwtAVy1fOE6JJ1llK2gH+3QjqFW1bJbo
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ac1923581cmr215808995e9.32.1793621747540;
        Mon, 02 Nov 2026 04:15:47 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:18 +0000
Subject: [PATCH v3 04/18] perf cs-etm: Use per-CPU queues for per-thread
 mode
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

This makes it easier to support multiple threads without creating a
decode tree for every CPU for every thread. It also fixes the CPU field
of synthesised samples being incorrect when the CPU can't be retrieved
using the trace ID in unformatted mode.

It also simplifies by removing a special case in the decode path for
per-thread mode. Per-thread mode is now decoded in exactly the same way
as per-CPU (apart from pre-initialising the context).

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 509ec014b276..f19aa4f787fa 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -296,9 +296,6 @@ static int cs_etm__map_trace_id(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
 {
-	if (etm->per_thread_decoding)
-		return etm->queues.queue_array[0].priv;
-
 	if (cpu < 0 || cpu >= (int)etm->queues.nr_queues)
 		return NULL;
 
@@ -436,11 +433,7 @@ static int cs_etm__map_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
 			return -EINVAL;
 		}
 
-		if (etm->per_thread_decoding)
-			cpu_data = etm->metadata[0];
-		else
-			cpu_data = get_cpu_data(etm, queue->cpu);
-
+		cpu_data = get_cpu_data(etm, queue->cpu);
 		if (!cpu_data) {
 			pr_err("CS_ETM: Unformatted queue missing CPU metadata\n");
 			return -EINVAL;
@@ -1301,7 +1294,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
-	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
+	queue->cpu = queue_nr;
 	etmq->offset = 0;
 	etmq->sink_id = SINK_UNSET;
 
@@ -2187,6 +2180,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
  */
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
 
 	/* The current block is not finished */
@@ -2215,6 +2209,29 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	 */
 	cs_etm__flush_all_stack(etmq);
 
+	/*
+	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
+	 * different threads. When the TID from the AUX record on a CPU changes,
+	 * re-initialize the thread using the AUX record/buffer fragment TID so
+	 * we can start decoding even if the context ID packet was cropped or
+	 * they're disabled.
+	 */
+	if (etm->per_thread_decoding) {
+		struct cs_etm_traceid_queue *tidq = cs_etm__etmq_get_traceid_queue(etmq,
+							CS_ETM_PER_THREAD_TRACEID);
+
+		if (thread__tid(tidq->decode_thread) != etmq->buffer->tid) {
+			thread__zput(tidq->frontend_thread);
+			thread__zput(tidq->decode_thread);
+			tidq->frontend_thread = machine__findnew_thread(
+				&etm->session->machines.host, -1,
+				etmq->buffer->tid);
+			tidq->decode_thread = machine__findnew_thread(
+				&etm->session->machines.host, -1,
+				etmq->buffer->tid);
+		}
+	}
+
 	return 1;
 }
 
@@ -3288,7 +3305,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
-		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
+		/* Old per-thread files have no CPU (before v6.4) */
+		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
+		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);
 
 		if (!etmq)
 			return -EINVAL;
@@ -3301,6 +3320,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		auxtrace_fragment.auxtrace.size = aux_size;
 		auxtrace_fragment.auxtrace.offset = aux_offset;
 		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
+		auxtrace_fragment.auxtrace.cpu = etmq->queue_nr;
 		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64

-- 
2.43.0

