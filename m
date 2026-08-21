Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B13B71BD
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305850; cv=none; b=GtGajX/c1hdxd4p2uStzSVV7kuWSxf1xMpKbr7zi5dsvhAx+BjtgA/8PfFdfCBqW81LaIeEgoY3M3aY4Dr1lRv8g+tnN51ddli9VCsYprblKlCgUCKmiC3mYk6DK2m3MtFK/XCf5m2/tBZbVPIj6NiSWAGzt0I02UFNvZiCu7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305850; c=relaxed/simple;
	bh=sb43BObHmZtyjwQ9/BEH9eWIoM2A8l6ZE+2UO2Ce/ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhTUO8u8G2nW15LBR2h4FKi78Wfwi+599qXjJ/u3JsX1nC41RwH2PSNdWg8IhJqrGyombTX4wBRTi0lt8DaPeRSdvUgPcIbFwytinnToHKTkx/jISiKdkKZNV3S2LGnu4D+c+DbBgnEVcTUjwJRsI6v0DozLeTC8rLec/tsTSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJzAfbkE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJzAfbkE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso8840375e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305843; x=1787910643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYjd0xAS1cNSY6XVrkyFUu4UCXh5rU8Z/1PEhyvhecM=;
        b=oJzAfbkEwSf/KcRGron2V905MsO69g9WfquV7hTmOlUq3MgqtjyrOdtigWbVJ75kL9
         jWXhd7adrcylQBI5X0eJWRl1Eis0q1jnShfkNA0RtyPwfJNnohKbVVb8He06zGK/jgj1
         eTMD2wfVJ/sTRodN3FxwWfT1IOt1MbO5fhwBJmeTKDUF6gJ8QF/x7JDU2vwbWJQz3weI
         M6pu1oo/Dzy7SnDCzWIW+FLDPzwujCCxm95W+SPeKwE6hz3DvQOZvdL+30ofo1Pla3aL
         uWg6fXbo8MojmP/dj4bQsqn0y0g6O9h2kvFuxNyIeX4WphjBlOemst76dtiEuwSWcXdf
         Cypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305843; x=1787910643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYjd0xAS1cNSY6XVrkyFUu4UCXh5rU8Z/1PEhyvhecM=;
        b=mR7YYdh78dqleGnlEKvoZL6t0R6cFSjWVOtjgeMpWmrA/pDiGZh9rJpoUg/KPnuljk
         TMXDy7TTcMSSH+aYZW/4QsrpHISZl3gl4ATkY9oMKAi4OnVDF3sflet7XjQhr1m8KUTW
         yhbl4n+cmwGbYBT4e0ZM50dobijzInhLSZyyCzECtKhSFkJYBsjh9GoOhaHHdvnywNQh
         6MF6CCudFNvTi7QWLaS61auTOHvdl9c7CBpaX4AIa2qTqmZ5ppiTcilH3Fm1UxGp8O3R
         TPKwzuH6LMw+zzw2ycgexh8YfdBjfeM+3C4bDTnTO198CcaEGfWWu6J6eOVTSRKGtIAh
         L5GQ==
X-Forwarded-Encrypted: i=1; AHgh+RpF4yw37tv4GXVB3MsMJoaExWWhIGJ1Kw2fHBIdssNjCmPod61qAv0OG6Is5dd+ZALNJNCJ/URUgZEcymrzI4av@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmvyV9GqXuUUYX5CjdIIMhr/OgnBQ7vuupotKTzFhxbaWUuwF
	9qb8tQNQyziqUDFipY5+6pRGNg7seDFLjjggvdc1241dvSMp/12L3tZ5v+yfnVSTcfE=
X-Gm-Gg: AR+sD10I5YBXRycFA1fjcjfxXawxYvjkx5rAIxmqTNT1Et4PVleGgUoscG7B/063qCC
	GDToopCLoOVv9iqU55uPp5fXz3CvdFxQOSVqUzXv2OS1fpgjYl1wN1zb/HR90s538IB7VfEg39Q
	yewC1nPiUagvZeayVMXbRRQLVCgfX2eHbjwYgTIoLLzOQxE1nhbtwzADsT+GAhQ3mU5xENPhubI
	hlNsU00nB1CvYtyH9sGj41PFkx+HY1W2Iz/BIqvgUahnUIJB7HX3WgYYYvaz0sx7hmlE5Es/Akq
	73cWs6pv35XhzOAAXbHTJze1CfhnLctErkMr2l+VHYhGEH5i4OwJtNVSf3tJR4wQ0P5yaZyl9Ip
	ksqM4GpmdOLE9j6ci5ijpXV0nC3EB/sCG2kegQbx/+bc8XUdU4OVOc8N+I8yX7F0kLqal12MfIm
	UEbYZTc+0sSTGnHTbsCA9So3hrjUppDnT5d3w4n2pWlXesiAf2LD5Iv7WSyWvdhiyKTvI87YI7c
	I8=
X-Received: by 2002:a05:600c:c4b7:b0:499:900c:9c68 with SMTP id 5b1f17b1804b1-499b8310653mr65038535e9.6.1787305842976;
        Fri, 21 Aug 2026 02:50:42 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:30 +0100
Subject: [PATCH 2/6] perf cs-etm: Free partially created queues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>
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

cs_etm__create_decoders() can fail half way through and the
err_free_queues label won't free them. Call the full queue free function
here instead. If no decoders were created it's a nop.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8dfafd389066..44e20067da1f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1014,13 +1014,10 @@ static void cs_etm__free_queue(void *priv)
 	free(etmq);
 }
 
-static void cs_etm__free_events(struct perf_session *session)
+static void cs_etm__free_queues(struct cs_etm_auxtrace *etm)
 {
 	unsigned int i;
-	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
-						   struct cs_etm_auxtrace,
-						   auxtrace);
-	struct auxtrace_queues *queues = &aux->queues;
+	struct auxtrace_queues *queues = &etm->queues;
 
 	for (i = 0; i < queues->nr_queues; i++) {
 		cs_etm__free_queue(queues->queue_array[i].priv);
@@ -1030,13 +1027,23 @@ static void cs_etm__free_events(struct perf_session *session)
 	auxtrace_queues__free(queues);
 }
 
+static void cs_etm__free_events(struct perf_session *session)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	cs_etm__free_queues(aux);
+}
+
 static void cs_etm__free(struct perf_session *session)
 {
 	int i;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
-	cs_etm__free_events(session);
+
+	cs_etm__free_queues(aux);
 	session->auxtrace = NULL;
 
 	for (i = 0; i < aux->num_cpu; i++)
@@ -3520,6 +3527,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
+	etmq->decoder = NULL;
 out_free:
 	zfree(&t_params);
 	return -EINVAL;
@@ -3801,7 +3809,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	return 0;
 
 err_free_queues:
-	auxtrace_queues__free(&etm->queues);
+	cs_etm__free_queues(etm);
 	session->auxtrace = NULL;
 err_free_etm:
 	zfree(&etm);

-- 
2.43.0

