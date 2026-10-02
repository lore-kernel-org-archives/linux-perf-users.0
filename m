Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1048B395
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939731; cv=none; b=tg8tabwy36XuAuymXHzfmeZc4rKe1ya8q492L5CfJQg7CYZvFNtzA6WZFNmsSH2yJfKXhDjA99njY4YrI3qLK1VkT6jvKeS+6E+ezYY3f1GxVtPzb7gXeiZaf2J4Z2ElMjYroh2C5K/Le5N7YTE/kn65A/lvNoLOeqqmaHGNvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939731; c=relaxed/simple;
	bh=xka5UItDIrEJnIvKmqLwmmfEobjfMvpvaTiygYgaFd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlpv5mbHCrzRgQCdVLDPauhaGDQsh/8IP6PpHEP3W9nFFYcdhF2R2VJol16b1C7wgxo7V41B2T2J9MucweWfBDFrkQ5qhmjisfKThEe7BqsdTytJ1zbH18chmCuiXSO29JezcvrV+fGKXl+hgl/V+KpSBefMn67ibasY+5l6SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuHx0ahT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuHx0ahT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so57245385e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939727; x=1791544527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEiJjq6Jc7fnijCf7RLJfnGkUIPBSRhorQ+d3FhIqF8=;
        b=YuHx0ahTFpFQsFZ4PTs4JWJiwCj9GoI1p71c9OegGitFmnRvd0XDMIFcDPtYJL7HnH
         hath1dE7DMdNnU/aiR640iMRoK5CDUAqh2as1BZk1zhYeqlDexugflMzQOR0lGdOVBIn
         rav+QdQvV3HAsypkgSKzV82OIwnQ8aSbhpS/JpGlh06PSuN79W837JBOgKzmRUZh9cXA
         6aS4bocEpGWmMNv93/DWmHVup6LYsDczIVDWQT/WYa4BNKWnKmeBcfXgVmm9zIriR+2v
         M2fdU+k+ocNgUBLri54mGuFcjUJlPFRfowwByWQ07I/DyygEoOAbX0RbYTjvj7bOhPKV
         +N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939728; x=1791544528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEiJjq6Jc7fnijCf7RLJfnGkUIPBSRhorQ+d3FhIqF8=;
        b=X6ETY1zvq2p+NIEWnPDDDle5f0DR515jhbT0iKwCTMVBRpxN2gLAXKYotf287iTb9Y
         fWg9ukxCDkllVn/2dli1HSbZ+BJcYb+7rm/KSGLrHvbbC1OXZV+9PZBT+FHgc/9PuSsW
         LMj0AcCjjT6aVw7smnQxpV8ehmKYBslG03d87k7f6dbfhAOPhuuIc79awZZEjZweOqlD
         WioEDj9eImbda+qXpMZBh7xp3aDc8TRVtwzUSH/UIsxgO+IK3hHQ21ncmj0R4ZdVW6/G
         lwSHMEj//qhc7QuIX4NTfTC2+I5RpWQh0MBFfC76KuMmqBW+Ve6x0clwvEC5pj4FJc4d
         S0aA==
X-Forwarded-Encrypted: i=1; AKwUvBwpIbUMLB5o8XWFYXVM/dNt8b9cRFfcboMQWlbS2JxNGjxHAvZJwFV+MadG7WdD0nOomHnHFaerWUXQFGV6DqJ3@vger.kernel.org
X-Gm-Message-State: AFuF++lrta/Zv8PRIRRBGUz73LlYJ5ugEcCB5HcqhX+9PDQ8ay1KVyj9
	wdSXWsxFd7nab+RNZetHFc2dyb0rWexTrvMK/ZRaoQcHD8W/uSFQsZ2vG65F/sPG+kM=
X-Gm-Gg: AYBFou3BGrxkyEAGbJ57shlBTbhh2uUUdwdjYvYDogMDKFFUmaL0hed2mn8Y0BuPU4A
	RpqB9L2kVZ/nbNBd3oaxiKMcUvjbgTEddpmAE1ldd4iGec9GY0Ryk6CrLorArQt8P+GcRBay/GC
	70UqNXzxsbnR4tsvuos+1XMWBKiFha3k+FRRNmh+M9CHqbtNjFur2NzQE4oUIU8uasX2dec3GSE
	zCcmqQ76uO/wuHOk5xWbjqMZIFg82xkrdKVsRvWXWrTNIZT3R9hXw9aKAoaf/31ohBI370oqDtI
	Sw02swIb/uN8xebyh1XqV5tggDeFehiu/evB+bGFoELz5UmUlsQR4eQLHhRFRcKrq9ltRnkD4N0
	h1bTsqNIM4sfnW1+bKzpHgogw9AdusYfkIFMDiD02kzUoLlnBjOMpKzPpfJwmDubfNVu0DtkzTf
	2knbIgfJ17uThKi1nPeBtmYIBiGR8Dov5vHzPExtsQoaircJ6YBtUBy4IixLmTwVbNHI6mqp9Kr
	4SYskC4tZhK
X-Received: by 2002:a05:600c:4f04:b0:4a0:a34:6e7d with SMTP id 5b1f17b1804b1-4a027564c91mr48663925e9.18.1790939727443;
        Fri, 02 Oct 2026 04:15:27 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38306dd4sm4752986f8f.43.2026.10.02.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:15:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Oct 2026 12:15:11 +0100
Subject: [PATCH v3 1/4] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-james-cs-hw_id-output-failure-v3-1-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
fallback, formatted queues will write their HW_IDs to unformatted
queues. This will result in an assert because of multiple decoders on an
unformatted queue.

Fix it by not inserting trace ID nodes on other unformatted queues. This
isn't an issue for v0.1 HW_IDs because they aren't global so will only
add to their own queue.

Fixes: 19c3e4db38c5 ("perf: cs-etm: Create decoders based on the trace ID mappings")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d1ab34f7b6b..fda6b6c02e26 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -309,27 +309,27 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
 {
 	struct cs_etm_queue *etmq;
 
-	/*
-	 * If the queue is unformatted then only save one mapping in the
-	 * queue associated with that CPU so only one decoder is made.
-	 */
 	etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
 	if (!etmq)
 		return -EINVAL;
 
+	/*
+	 * If the queue is unformatted then only save one mapping in the
+	 * queue associated with that CPU so only one decoder is made.
+	 */
 	if (etmq->format == UNFORMATTED)
 		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
 						    cpu_metadata);
 
 	/*
 	 * Otherwise, version 0 trace IDs are global so save them into every
-	 * queue.
+	 * formatted queue.
 	 */
 	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
 		int ret;
 
 		etmq = etm->queues.queue_array[i].priv;
-		if (!etmq)
+		if (!etmq || etmq->format == UNFORMATTED)
 			continue;
 
 		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,

-- 
2.43.0

