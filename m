Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56F340A62
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570757; cv=none; b=JTZtoOeTuezwqsHiqLF+5/TcS5sRCjxJt8yJNLY5fYZfobjTnCoBM+8WM++0sq4+GgeYhz2oc3abSS+fXH/vdydr+1NSBa/1diu6adzmqOiEEjaQLxzWKy9XgaeyvHWJ10jGk4Wseo3HFyaZTaA4lCRK5m6w+hI0pB22rZzfsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570757; c=relaxed/simple;
	bh=Ke+mofOeDLb5pmcMy/dBCh0xbRjGzNIFYZJwmJXyb9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JljMWUw6ttImq+k1qZNA8o2dPGyBREaH5H4y/flMP6b0DZI+w0nxeVLMsUuf1nULGmj31R6pEot1kcsvPaIN6mDru2nNFlCl0aMNtuFMwYWq6WtmD09j/3PeT+M86TDVCwCgbjPazio5gu8vGJcclxszgmP5ez1eGNvFagUtQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrRInc31; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrRInc31"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso46790015e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570754; x=1776175554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KE4LNWE9ei5fXKZj9AAb4uKojrTcY8EpFDsm6Wly7w=;
        b=ZrRInc31nlQvt576b4KVZ+9hfSP9GPtYJ/WmMU/4+lQjQK67hmN9oBg8RJYwjS0KAa
         IUCRUcWpCBWI8QHvb9k+/G04UGZeoe8CJnSz42SOFSuWp35qcnS+5VSjYGv6y3nNJRPL
         dThr+c3JS4A6S9Kp/kFydjfUReCI3pxnTUDeycqxac2HceDFTO0ka4TQaF+QjKBhJLn7
         Rlf24ILhbW2kV4jO0CKqL30qEqyd3bo05/2chLeFVP0iTAM9wZp9H3xNwON0wQE6uGxv
         p4o5yHRUUYByaAFtDG3U6+cyj0OzsEARkRqb0gk60rBFgitFFMZ+nP63dxK+OUwxKz/3
         y0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570754; x=1776175554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KE4LNWE9ei5fXKZj9AAb4uKojrTcY8EpFDsm6Wly7w=;
        b=LynHPczanulHsDIqrr88P60n2FnnLEEsrAikYU4/ng5PC9Nx4ibVSfkYh+kjt5e4o8
         FF8r1K37y+E867D5BOSyFslp0ub13ctcf6bbp5mG22lmwp7ZGnlwj4D56gdVRN8Ne+2R
         oYeRl+rSbLEl74sutFA93iDGHHWiNmGxGofo4tniAFahzjQZ0tI8MS0EEH5UcNKf+yj4
         1/0TMV5rQFFzsuJsuIIC+MJ/4YfUPCFfFiLlgPem+yTvJfCX8Js0XpNva1c6L2BhqLxl
         t49BF1D9DsiL7YI4+tlmwpfCM4mdyE0e27ef5Rg8QXPWmvzsbUPeS+Yx4Nud1PGPvUI8
         TvBw==
X-Forwarded-Encrypted: i=1; AJvYcCXpRlbf82sjZL2oaP7ryBj6lRiATKfw2Vir7rft6oGe2dbZczTAEijxub3oTwwzndtTzk/LwqKiKDk6Th3XpwoO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fldaPIpFat11egDCM5KPBu+FDJ/vIA8MJIEZB4m/y2cEkMCj
	B/ZnFwHcpOcw2RUefFwX6M5cHmhrm5do/8nwwS6720vLDPW67kQ1nXNYFy76uxv8DpM=
X-Gm-Gg: AeBDieuYynOGJOoO3+m/Oh1rvqszJrg5FD8S+JL78WKw+OzgqQdHqnO4TX+rmBSKgGB
	1t3TyyZAwJm6lUSdnijDvWvE0kA6uI5CSSLjHCPqhLk0NBCUh3oa7xwqNQUQSyWioEDTiaW+nJj
	d9SZzqIoxNgsJ+NY6ZOgSBRtyxRyGl5Vgwb4FLZkhkLyo6JFssDmbyvcCVr4nlvLc/9AZIZD5xj
	TeyBGCwxw3WyFeMmboDsiQcyZ5agByLldE7DGP9E4LTZoqXPBuIiwQ7HOImvTPE/tUUYoK4DYWU
	XvRy5Tp13ErAPbOS2MQbwQRFZVslzC8rh66w46tFOiPwuHpIY4CAN9Wfb86yZydWZseg1ziDHUn
	3tRv0R9z0XNSBysGWqvd88WuxIn+kzyXP3rdYjFZvvH5ImsMKF/6OfO636DhHG689IZOraOEfI3
	lEwyR+OGcLLz73KDLWXFLikNO2TqMRLukr
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr232506695e9.27.1775570753935;
        Tue, 07 Apr 2026 07:05:53 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:15 +0100
Subject: [PATCH v2 1/6] perf arm_spe: Make a function to get the MIDR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-1-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

We'll need the MIDR to dump IMPDEF events in the next commits so extract
a function for it.

No functional changes intended.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70dd9bee47c7..7447b000f9cd 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -958,14 +958,9 @@ static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
 	}
 }
 
-static void arm_spe__synth_ds(struct arm_spe_queue *speq,
-			      const struct arm_spe_record *record,
-			      union perf_mem_data_src *data_src)
+static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr)
 {
-	struct arm_spe *spe = speq->spe;
-	u64 *metadata = NULL;
-	u64 midr;
-	unsigned int i;
+	u64 *metadata;
 
 	/* Metadata version 1 assumes all CPUs are the same (old behavior) */
 	if (spe->metadata_ver == 1) {
@@ -973,15 +968,28 @@ static void arm_spe__synth_ds(struct arm_spe_queue *speq,
 
 		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
 		cpuid = perf_env__cpuid(perf_session__env(spe->session));
-		midr = strtol(cpuid, NULL, 16);
-	} else {
-		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
-		if (!metadata)
-			return;
-
-		midr = metadata[ARM_SPE_CPU_MIDR];
+		*midr = strtol(cpuid, NULL, 16);
+		return 0;
 	}
 
+	metadata = arm_spe__get_metadata_by_cpu(spe, cpu);
+	if (!metadata)
+		return -EINVAL;
+
+	*midr = metadata[ARM_SPE_CPU_MIDR];
+	return 0;
+}
+
+static void arm_spe__synth_ds(struct arm_spe_queue *speq,
+			      const struct arm_spe_record *record,
+			      union perf_mem_data_src *data_src)
+{
+	u64 midr;
+	unsigned int i;
+
+	if (arm_spe__get_midr(speq->spe, speq->cpu, &midr))
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
 		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
 			return data_source_handles[i].ds_synth(record, data_src);

-- 
2.34.1

