Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CD4657D6
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053574; cv=none; b=Two0YXVQz/lmohInxxwR08iVOiUhs0/b/Jam5gOmGkmCQDwLV6Gtm8wJPOoTDNGIVGJR+kgoxHW4EebBqUPsVfb2xKiOscLfLVSdWWfSiONVMQcRCpRYWelO7nwdYU7PkFjndB24bOUpRtDQBf7GB4s4vuvOBeFLc+izOBDoJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053574; c=relaxed/simple;
	bh=+FMZz6XfK7GZAd6AXUWNQbC86FlwgnBY/fa7MUm++S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMqI9fY3psH92Z5ot+Sy+pOeTXJkww/f9kcpNwB/fNF8wcvcdIOdoHk3xR9mbfcVbbSSctfk0Ck0SH1iEZKm9IW+V3VzdcEhhOlodjrAicAC0sQsDqkyqXYBcIn0RVr6IB7PtxEb0Sg5MXbMosFf5A+COC/uhR5Vc+lfLhbbsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8Dt/s7N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8Dt/s7N"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so74903785e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775053570; x=1775658370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oqas3u7UM5z91PWtBVrB+LRpDVECVVS14S5CCLaW82w=;
        b=O8Dt/s7NGDBRkpWq694HWuqklHzI1sZDtUKdUpb7R9ZRJctLIOQ6sG+e+KSH3Tcr5N
         6Ylri3IqVf3iVypZCHHGC0FtfDkh5vkVsKCTy9bYwuaD61Y8jbrpW1kGRWpfVZozyert
         K2BXzSXf/sk6pSXQcDOGuE8ElvSnVMI6viCH26xE1ueBulCwoMDLH6+idTa/9SjRCOla
         +/U7qSecg0TOyMs2o+hMcX0M89JesgsDKfOMvV09h1njXchAd8d4H+Yb/eQFQNrSYtbm
         SbG4dI0P86eUMfchIKE4IjRm7bdh9NWPCgosW86haT6Fltg+kctq4biQBNzdN7a+IZD3
         iKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053570; x=1775658370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oqas3u7UM5z91PWtBVrB+LRpDVECVVS14S5CCLaW82w=;
        b=XqpRs++vL/DeAjD4IQnhakcy/Eenr/FzBFOMlFiEHODDV/dvW3PiN+CDmW91GHZX+M
         lgp5PMPJNMmJP8EcF4rBl4SbGBFlkx9th8PIMCmp/xWQXKP8tZnd3vWSW3OnyoM78BPZ
         wOa6DcWS9gbUpW7HRx07AtfDjkf0qW8YIC1ejgny1DeT3v1S1E9ddh35qjs1gzh+muzp
         uIyM/jkfvb/VQnzg2Iv2eGd7fuDFG33cmv4q7Wg5mYaj8TEEbbkUOUckPs1TuLiWsI9O
         7UDqSTY5JNFYmyx3TF/vI+JgZswJXfWUkwSHtaBYL2DHWkZQbb5oBFRUYXGAn9JDCpDo
         NxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq4Wgr0yNfZdJwR6FP2l4fH50uMD8gm1uoBVJnaOPlb/djfF11FU+xFejgPwokCTVVtotvSli7nz68ptXkLJJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlN/iVMHfBXQpWpslvPFa6qoAx5iNdRhAuI+5+pIlqdgtT1iw
	IXXl6mks+JuQAdFBmlTfV/0E4cLFjsNUIxXB6K8bkVZ6D8ULCOYx+LHulqBmO6ki2SU=
X-Gm-Gg: ATEYQzxwbpcV/jCsXPCfrieglgJgl2U8VsF/FPj+U5QVzg4RqxGoQUg3fksKs2YM62y
	/CFfIq79Zi4CdBIFheoJMUyNm+WWzHkkqK2UwufPI7ck87iH8KQorNJiLKCFIJ1EOO3aVnyKHqi
	TU0y+NM41CVjXQZzYM7yKHENz+5qDK6SG5d5fIoqHrT3oQFAqaTQc6trVxWMHPIFHlKpnSNGL/j
	IqNejH1C65sJCUhNHunqnsIZ3all9z0n5HxQlUzjqynLWlznwZtl4W9lggGe+F4y7zaIsdPD7d1
	pHygBjFEbnP4CrGdj4i6pfeQh3pzgHMF2uzYcSUW5R2p8LpzfAEznT/vxMEmriAi2Hba0+PKQHh
	+wy4tUE6kUfFuHWewP6OMgMEPmITM5eYs8Li16ztjr282WNHTpTly6m4TVYvjIm1Ce6bWbZHFcV
	WFgvE96jAJS6cF6qZpo9LBmBej/5uC8w9X
X-Received: by 2002:a05:600c:c04a:b0:486:f9aa:2b57 with SMTP id 5b1f17b1804b1-48883597e39mr46789365e9.16.1775053570170;
        Wed, 01 Apr 2026 07:26:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm2305595e9.5.2026.04.01.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 01 Apr 2026 15:25:49 +0100
Subject: [PATCH 1/4] perf arm_spe: Make a function to get the MIDR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-james-spe-impdef-decode-v1-1-ad0d372c220c@linaro.org>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

We'll need the MIDR to dump IMPDEF events in the next commits so extract
a function for it.

No functional changes intended.

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

