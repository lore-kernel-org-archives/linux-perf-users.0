Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BD3BB9F5
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462255; cv=none; b=ZkTGT0XkZHC0VEY6HP5FvH99KfEiYKj68mZo7mSuXNXLd8dNj8u/trtTIK9IvYjbEBkjoMTBpPuDCF2a/kAwuylQJr14xnP7r9CfeR3T0R1unuKLJ3qjMu53Ru7RWJojT5KbKu9RJyaHkYBeoz/AjsE6Gp+DI7TUp7KFHcy9gag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462255; c=relaxed/simple;
	bh=Uk3MecH/GWSUCO4iYoK2aoC9xkOIm2VEOmSDFrmBCc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvbPznyMw4I+z+0Gfqkg5g1eE8i0uQqmvkDPkRCzNaH2Bd3tCdX0dQhGMnGktKFNmuqUjCezgx+HUP4Jmj/4ULkvnwWjx9ISeU5Z2u16IT0ao8iRpLr9+My+gDT8oAcOI2s3lQOOzC/Ihpn9pEw+I24H84/beuLOnGqMgjoaQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHyCsOd9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHyCsOd9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so17000625e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462252; x=1787067052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ne4dLz1fWz978dK33mNbt0k4ckMaGsbkZeA7j/BD+8s=;
        b=rHyCsOd9A0eLIxwpU9fZcQ2DcoBEkxqdyOfX7AGFTnPl5GxUnmldYU/5P9UVuF7VTT
         GNcpesAvQSL36LwaRpp4u9Y5I/nWBlTRGKn009U66zR51G374LliPJbE5eDhqf1tX8Ca
         87Dc6q8V725XsoMgrncYgD7kIFDX78+2SNXRxhGn3LHYNA/Vz+IiSjANnsNKsQcfdpHx
         YbuPAhVe261SpWOBkkk/qkRebEcU7eDkFprUXZHnCBtp8s8d8jKqyBzGB7rrjdEbBERN
         Ec9qW8AQ5DTSwLhodQiE2VQo9Wtrad+YuiosFSkFicTo+UxfM+uqI6Ii6FRUK+BQq39p
         gLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462252; x=1787067052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ne4dLz1fWz978dK33mNbt0k4ckMaGsbkZeA7j/BD+8s=;
        b=AhPkx2Qo4V3roeq6mItd7rdb1i2xz9EQ2aV2x1xJxFGiMN3zca7p3QdJVvTZ2/+2zy
         9McpDlA+1hPHRbpPUGERarbAmvK29IuLV/lmCBd/VGaUu61VQ8vH4zN9Yz2QUiZcBQU8
         GfwZRHNdAV17KpiIR+D8//cAKH0dNwKOLM/8IYsxThx1dP02gD3xF5b1HBk/MFhQ7M9W
         euqIKA806qgIbD7detMOwADJ61IgmAySIoRn+EeOt+wXV4KkHzH8X2e7wPoAdNMEYiNT
         axW3E6FnPbsmIYSo4PxJtIs+WadkwDQArPGw89V6Uv5BnSuiMYKSCAl7nSCUooUE3o5i
         zaBg==
X-Forwarded-Encrypted: i=1; AHgh+RoSFgB4rA7dld4Wu4PXC5ebqeNZ1e6xY0zKxR2+dHGKy/dLwRaNNeqM+uaiS7BJPUy1+LNJsy5viydutxpW7I6K@vger.kernel.org
X-Gm-Message-State: AOJu0YztVlONF1T3MzmQtbLmajOrh6l6zXt4QyBVJIL5ahL21/tPkiVT
	opvNAyZNDQr2eABopMHv2ls2T+L6VtNedz36riJYqS7SSg/L2W93mmAL5GJNSeqmVDU=
X-Gm-Gg: AR+sD13ko5fwWxWL03ZvR6V29jLEF0NQvaDcRciYNnzg+mlyurB6/qn6VhAyv4Bd+wi
	smuZtK8avRQTZRukpcFcvaNr+Kku9pPt9JFkSuoLuQGL5jz+5mdH3OTWGfH17jwBgmW3V0n5yTR
	fbaJIz7xJpNOh72cdBMARtPm+Ex5gwU1sj/fO8UuJyNjL/477XVmeDR9XLLWQq6cx1p2teUlZ2O
	ICkNOSvohVKmJBJQFmSdS0LByA3i8EtZj32r8BHfxdKScg719QUEc1Jibs9KQcnv8avIwoq2vJJ
	TBXR9rpGVF2aDgDsUlFLioq8lDHD89N2ewoXLv68Zr2+Gn1FUmQYS61hZLy0/5l3rarwTnL4rYX
	81zh57KWzZa1du+yqBQz5xomM2dsrlUI6DfyF7NvWJ0/inIMmXBN1JXX+98c3ubTnhHtodcpxsp
	tprO5MxiDGR+PfYQg9u8cBeUSuIUUeltFnf2YGKqTw56Ng4XgQ2vaHbQ56FbQ+wf5oMwZZ5yuE8
	zo=
X-Received: by 2002:a05:600c:190d:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49978e1a90emr57210825e9.6.1786462251684;
        Tue, 11 Aug 2026 08:30:51 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:07 +0100
Subject: [PATCH 04/14] perf cs-etm: Use per-CPU queues for per-thread mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-4-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

This fixes two problems, firstly per-thread mode didn't support multiple
threads well or at all because we always use queue 0 and assumed it was
for a single thread. However, Perf attaches to all child threads of one
process or allows multiple threads to be specified on the commandline.
This meant that trace before a context packet could use the wrong MMAP
for decoding, and threads running concurrently wouldn't be interleaved
properly.

The second problem is that we'd put all HW_IDs into queue 0, so if a
thread runs on multiple CPUs then it would receive multiple HW_IDs and
trigger the assert that unformatted trace should only have 1 decoder
per-CPU:

  $ perf record --per-thread -e cs_etm//u -- taskset --cpu-list 0 \
     taskset --cpu-list 1 true
  $ perf script

  perf: util/cs-etm.c:3381: cs_etm__create_queue_decoders: Assertion `decoders == 1' failed.

Fixes: 9182f04a85b2 ("perf cs-etm: Pass unformatted flag to decoder")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d423f1cb408f..28f5ce63ba80 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -295,9 +295,6 @@ static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
 
 static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
 {
-	if (etm->per_thread_decoding)
-		return etm->queues.queue_array[0].priv;
-
 	if (cpu < 0 || cpu >= (int)etm->queues.nr_queues)
 		return NULL;
 
@@ -2160,6 +2157,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
  */
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
 
 	/* The current block is not finished */
@@ -2188,6 +2186,27 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
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
+			tidq->frontend_thread = machine__findnew_thread(&etm->session->machines.host,
+									-1, etmq->buffer->tid);
+			tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host,
+								      -1, etmq->buffer->tid);
+		}
+	}
+
 	return 1;
 }
 
@@ -3245,7 +3264,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
-		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
+		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, sample->cpu);
 
 		if (!etmq)
 			return -EINVAL;

-- 
2.43.0

