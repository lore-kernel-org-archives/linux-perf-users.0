Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D02F7EE1
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305852; cv=none; b=fBSOTx/0UWOqp/FB68kXfUfRuh1Snxw7DhJ+uF2I3+2PQqoQ04zqc4sLV0WuRQFezd+0hc+9TrHY8jtkfJoB8QZgNQJt7bse++spt1SG7SOaL1xkYk6PT1DDIx/cUo+tmpnIweVay8WivUok2xvKkZTsX1CgKo9g+JorMMO/dLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305852; c=relaxed/simple;
	bh=DfHVRgZKJo7FcaZJs/rrBeFqWYYg2Q9WHniNMVQc3K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T828ZjUdQ3+kD0RMcpiXTsviPhV3IgvibUeCZLTTJNiGpZWdJs3Pmuya4OXQACk9prInILhgoV4Qz0fO3TnVIs9Z+SEezsdmeeN3mRdSpZxNoXQjzXkEszZrO55OSutByx5P9pajIEQI3Mpi09gKfymDx8FgRIIHMlEFe7Jl2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBNhXCTS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBNhXCTS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-499b6c02b02so3663465e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305842; x=1787910642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rihT5LklrtpR0kzEsT66cm8MSESBfy35sRA2IEprsPg=;
        b=SBNhXCTSR25JZ7UzS/C9SkF4f3qxDddUBKKXeIsvWa4o0GV1U/lnNTznotjlYIsUPQ
         x3hxcCh4YfOKoyRP8BcJhUdwGJDrgRsOABpFnlEb2hFFwwBeyKgCitTWvslnfbHD9Nqs
         gsC9DNTe0UnfS2pOBcPSqBqNcpdcMd34AfydMAcovOCsXGN5HnDknAyFffCB2FpQw7AD
         kWQZ78eqJJObo+EZ0hqHd3P+OP/xccjNJu0Tk/3dzD0vPG/tVVTAgIuDJoU5XocFq5aj
         KWEyzMK7nvhat33mlontfFbWpFhV2Xm5Y8dRKMbeGlV0Ltjc7Zkx9hJMphEvc7quSlSx
         8G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305842; x=1787910642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rihT5LklrtpR0kzEsT66cm8MSESBfy35sRA2IEprsPg=;
        b=TmmXsiYICT1yWGyZvS1NFvkT3d61GoaEL2JN025fojYX5FYFQ5cWG7E3w38yXKMYPD
         U5HSs1fMQmAgFllolZE0UWPqsf9fOjyXI2uQk1xlD1D3p6LL7wbRV50WiQu8imc8mqrZ
         tRcXlYMh/E/MKCsNPa0cEUj4pGxTGJE2GaEPy8KD4HzZIFNRDMYM+hQZqcqRIUOrNc9H
         VwIyu7+1bDT2Ta3vSgo+8SMiSLuhOfZiJlt5XitIFcp7AVDA6K5T/+cxYCg3ewd21dmp
         WPU0TdUtdidOry6EIqYslSMrytH0m04GESFwW/hjwXUfzfDIz8j9Oq7RHDKyJl+IEnJ8
         4h+g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/P8jNfJJA5npnOYjlh7RXM0J3BEnJTI5ckP4qweF5YYQWO63L/a6ZWF8ZKnIwxg4vB6YVEYyN03uEv0OxiHuH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7s3nVFBVBBhL2Ld0HQX9JvMKoR5SHS+3TOlPAE1HJZA42rC/
	vruekFC7haGfdxJqD+aAkpuNtiT7K2m5jbXCYmlhQKP3c68Q006G2dLiLgCM6ei5FXQ=
X-Gm-Gg: AR+sD10RC9Pmuj34XMsvJ4bdf+Ru0aqKnHfWMUC6Z3fvpQJyew78NFPcD3VIV2BT7N3
	I+PoAmihe5dr4yw77w32vfbk4Tih6EKJkYNCd0GxOVA2aOP8G6pmabVYoiaiiiR3n+ojLwWKsaF
	FF45Mbxn11w5LOAt4sg+hLUdP2OxD6DBfHhC/c7k5MA/ravR9ogP3RPHE3eMTEnolxK3TDSxcAz
	sTXsw2nWUDi7YkmG0TSJ7MrHP35sRidsgMINtMssNIVULGTI10tyZH+vUyCKikvLaDY9Nln9Gx6
	Q6d+3gTfSx0RPiIhrNZ7oTBlpIi9A1I7j5uYSvwhgPGP2lpr0rb02CHRf5ihHQJtj6swxJX66j0
	SDJnye6PpPA3M93UV6B62EkP/s1KTHWxBsyrrRa6q6FHLNcZomM7qv6pzexNpgTRnaP8V1aA0dr
	vtyviY2a+zXtTbeEhlpdJ21J2FJnt36kj3Hg3fHEB+kL3EGCTBngYAbHIxuPadpZf5
X-Received: by 2002:a05:600c:1384:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-499b84618f0mr55399775e9.14.1787305841820;
        Fri, 21 Aug 2026 02:50:41 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:29 +0100
Subject: [PATCH 1/6] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
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
index 6e04602ec204..8dfafd389066 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -306,27 +306,27 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
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

