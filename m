Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7631AA83
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203811; cv=none; b=XqegB9GGyNv3hbUQUgdp0aL/eQudi6pxTlOPEr21yzPLU0C80IHlt05sPWJN8fXSnO8hp8wkm8RB8RPKFIXJ0pM8xD3GwBmYQRt0sO97yGnq6vioEzhrRH5uq8x7QvghzedpSsFyDPDDj6rKiSffSQOgmG8A5Z5TvqgSKQtutQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203811; c=relaxed/simple;
	bh=+w1iFxCmBs3uSvHvYtkhGpYpTANK4myW7Uve2CygcO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOEJsAW32sfLWlUwOzDPlSoNoj/tK896eQz5MG65lmBBSO5JKHT79/R7woYmsTdgSJUV7fMbRaMSwMV5BG2WzK+Y8KnR7sbRloqlJ/xRQ9tNzKYhLkpWLaq4NfvBv70knhiDv6ITOF1yQQ67/WeI5e7Kj+Bx5pnGBKV23Ok2t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7HovBVB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7HovBVB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a637712so33700235e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203808; x=1765808608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jd2yrStTOWGOmxByUtMp4BdKIyOeVJpeKEcTyld+gI=;
        b=o7HovBVBZF+Kh3WKuwv+R4/AbbCMof8d08VRto6kYcAAjV6qP4ym/Vsp+FddGX54GP
         axclrH2usPbzYpVx8n03tWTEbjXUs4io3bcvE69m0ogZJaECbLpv/BYICNvzMyxSRhAY
         Em1vYTT7z++1NsZMV7uDKZnKRxLYXTTE45pBNhvC1mt46Bijqq1uOwbMRINf/dCleXr6
         0MLx+CK3MFHDZplHomBohlk6nWw/ZQnsps5ufxV0m/MQu/pWusjKaMwzOBVDTSW0rbOl
         rsm6eR3OWHABB2JXkWM/lMqg2OaG5cXQlNtBUhDiJalhswOzAJL2MSDIf7FzBLcs12XL
         cmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203808; x=1765808608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jd2yrStTOWGOmxByUtMp4BdKIyOeVJpeKEcTyld+gI=;
        b=s+HpklRNfsgo+8biypQvIm+j39XDoHavTFt75t7wgm2ysa5X7Lm9JXdy0hEqRLH9a9
         maUS9AODpxjJymNvj4V8ePWmVP2zKbzcOuArLjgBMDfReK+/IJBdTpXr4YPjBRMy7wrz
         /ExefEoeqwe5e5oDsm4/1EQ6zjZ5GCNYqWRUAWMPUm+PnRo4PN2V7V8hMv78lFoW9izb
         EvZ9bdrmzdbyxG0sx1nJ7AQV3vlevKK0o/JoY23wqSDtipv7JmTunHfDzlkctCshlYhf
         OsfNVW/nASmf7ydpMH6IjNQZrUk6JKMUW5Q0y1mnNQtl4NLxarVNVKU3bM1VaNiadrd0
         OErg==
X-Gm-Message-State: AOJu0YwRe9i0CpAkTg1UooprKlecwzX2hiOxh7VcOW7FigxrzJVcUJTS
	VLIf87Yg9oEnsdl0itaVJyKPsPwwCUQ/pYn8GJh5schRJjPwUE5gEv2wvVM4cc01u7c=
X-Gm-Gg: ASbGnctuKLgDF8LDoGGsub3AprCxLHo9BW/rHfV4oLVhPhpYhHGzBgJS+e0D9JQivwp
	cYo30vB/4Kd5p+D3TxSEStMdLhWaZ0WqrxREU0HshGIPuTGptjLqF5fcFoeywTdjJhwc9dqfkVs
	VxYg8d9S1iDHWocpweNA+jSZHBhrTbqbrojsyYcOrnBKyE/NA8ApeQZDhI3c5TSAKQmCCxPp/xW
	W8Vbdysmo9M35KxcEoMkouI2EBio51dCZxfbLDxbYpOSAhM0vMzhJm0jhk2ccEFp9CiTtEV6Z9o
	LugmB1VtArI83C+oRsof2scLVZghiBuv0wCeA5wOd0mpchWIlcZyIKV1CnJmHzrxvUX5xgN3QBN
	r0Y593aXGjF2rxUzTSWsEZFpvPVmg3cWTxQH13e8mYKRk4TUCdtLdEie4Zk4PXbwCNqpGrF2OP2
	Dmm5FpuBHmQiXeDnnonRYi
X-Google-Smtp-Source: AGHT+IFGmwb2kb7IVcMJGI+bmMQWoQ9Xck7BMYDULw0ILtMY20pG9v/l2Oz2SqT1V002Z0ra/fhTlw==
X-Received: by 2002:a05:600c:4ecb:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-47939e4ff58mr81937945e9.34.1765203807943;
        Mon, 08 Dec 2025 06:23:27 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:27 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:11 +0000
Subject: [PATCH v2 08/12] perf cs-etm: Make a helper to find the Coresight
 evsel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-8-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This pattern occurs a few times and we'll add another one later, so add
a helper function for it.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 50 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f4..22c6272e8c36 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -302,6 +302,19 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 	return 0;
 }
 
+static struct evsel *cs_etm_get_evsel(struct evlist *evlist,
+				      struct perf_pmu *cs_etm_pmu)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == cs_etm_pmu->type)
+			return evsel;
+	}
+
+	return NULL;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct evlist *evlist,
 				    struct record_opts *opts)
@@ -476,29 +489,21 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
-	u64 config = 0;
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct evlist *evlist = ptr->evlist;
-	struct evsel *evsel;
+	struct evsel *evsel = cs_etm_get_evsel(evlist, cs_etm_pmu);
 
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == cs_etm_pmu->type) {
-			/*
-			 * Variable perf_event_attr::config is assigned to
-			 * ETMv3/PTM.  The bit fields have been made to match
-			 * the ETMv3.5 ETRMCR register specification.  See the
-			 * PMU_FORMAT_ATTR() declarations in
-			 * drivers/hwtracing/coresight/coresight-perf.c for
-			 * details.
-			 */
-			config = evsel->core.attr.config;
-			break;
-		}
-	}
-
-	return config;
+	/*
+	 * Variable perf_event_attr::config is assigned to
+	 * ETMv3/PTM.  The bit fields have been made to match
+	 * the ETMv3.5 ETRMCR register specification.  See the
+	 * PMU_FORMAT_ATTR() declarations in
+	 * drivers/hwtracing/coresight/coresight-perf.c for
+	 * details.
+	 */
+	return evsel ? evsel->core.attr.config : 0;
 }
 
 #ifndef BIT
@@ -832,12 +837,11 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
-	struct evsel *evsel;
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, ptr->cs_etm_pmu);
+
+	if (evsel)
+		return evsel__disable(evsel);
 
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
-			return evsel__disable(evsel);
-	}
 	return -EINVAL;
 }
 

-- 
2.34.1

