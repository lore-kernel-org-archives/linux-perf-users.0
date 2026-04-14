Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68F3D6471
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164778; cv=none; b=Rwf8iqxpspNuW637LVC9AU0YdL4hyOP1kmze4JpYklqHpflhVbMyu/AYmSaIW85KHUfhjNKpphAMsPiM0n2GCEPVYmvgOhapmFrWE2yPgRz8LvNSV1vAjeCzP1qoLjNoSwbXCiQwLhoRT/ppSq+YYlEE+W5fRJJ1jdanpp4SEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164778; c=relaxed/simple;
	bh=B4MOcb4BErEsKUcIM7RRmNpCR6Vyqi8cYdqj84QRn4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXaN+B2BihYkFE5kcr6MEl3UDokAoau4BkGWBdgudtXD5rSLWL7byPa88TAiG/IvmyWi0biNdppd/MmamompiP6GqEd0aMBEd8U6st7kEWJ/Giz0Pt66XdDv0GrzXvbY34/h3FGRcJY7tNKo3rvh9v3JZFs4ZBRz27W8ULcv1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOY2kjiy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOY2kjiy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so53117715e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164775; x=1776769575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkEHFh887Es+jtZSLZuibHtBrvBj/V7mtq/pJJpeMMk=;
        b=KOY2kjiywJmcfZkhMW9HgUIB0CbFtc4ZTkCCRBgsJd42I66UYKLElLJVLqb/GfOZAH
         R0tDiUKU3G30ybzfrguxs6yq1OjLeEiZa8kww+/dtGpafcg8gig6weolD9QhSq77WoN1
         2V/wmQF8Do2tDJa2P8/TOnDut0wRJ7q6oeNy+Uw++8kBj6IzTf9QE+gRHnKI7E0b7YTs
         nG8fm2C9Stuo1cbhLTsGG+X6WIHyZpy7R+QyN21+ZtxMY8xrASV7TD885qVVrpv4aXIw
         ZNdIe+U8tNq11GQZNVdGsdiht2yiYVOB/B5XJiy5fUkUyvhuIwYWFXCrko2kqUYcZu8M
         8bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164775; x=1776769575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkEHFh887Es+jtZSLZuibHtBrvBj/V7mtq/pJJpeMMk=;
        b=W7xUDky1lBLpcseaXmR3zM2t9wQj7DyhhbImxYgPHBQD7amapLFIajXrQ/QaIR2Yfr
         O85bSTw2mX2Flofu9qSyjCjJJgZrhW9Y3LXYAUj2rsxfgO0I6uGgaCGEd16qtCZyDHdS
         NvQfMtDx0HJwoMfrt0B6Rf7gof8qU3ahYjtucHwuMJApaIB1qVx5msXw9Oly90NFzU8r
         WvOh3w3xku92so9B6+Ah+ah5nRLOFGMgOfEctCJ9qgDZY6SXwXpojVpV+Xsp/+cES5Kd
         P5hvylTijPxJ4/RbK9yvYhwt5sAECQbjRCju2OIx3DGe9WdFRDQ9pUMgrxejP4JZQSt3
         FSMg==
X-Forwarded-Encrypted: i=1; AFNElJ8hlWNeH3nvhmMfbeAZLf7NDUK8aoiuQJs+EGn4l4aVNToTI23zodX/ZxDkzC2oi2Z+4+S6akegGp+CeSjukey4@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAb3NzVW5l2BTm8EvKks54JEqYoxOe15Wr4XCG6cCuSqTEDp9
	91JoC6rPGt+txWAqfQx1Y7vh0vNx9uU8SUCuohuDLKVDxeCU1CH+hYoiQAuBWGxqr7Y=
X-Gm-Gg: AeBDieue6ip6/Z74kqLYv/+jkZ1uWHSHUK1XRiF8fG1Gse6+5NRjGAmfDreBX+LRHYI
	qQJfyngE99gKgaFW4ex5HWZ6FNXh5135pHNId2dWCFEevMT+C3ZgnDOtpOC3GwITYorbmuimlKR
	Ky/lwGu3H2nxbxSd17IYe/SBQNauc1qyELW9GaIrdxzPe5rnMYlpbX2/evxFHXkd+y/83zzsD3+
	sWtSRhNcMdDZW6PA0UondUTqaLSauYRKued8DgeQ+W0J8ITOLj7fcXk8AgNq/S8PW7vff2Wtsaz
	rnxPqbSwIhdNECO0F6+XEbf2V3DE43GdSPeM6IL6L+NCFbeQv00HDDYqa+0hjJ0too8yXG1R8eL
	V4RnHcxmj+vhXf3zknovcYbGY+GNRevvqStA3totpOiunCeyu8Qi9FNPLmvkcVVUNLxmEyVYEib
	Gr5shAuvUh+uNkM2I9gnlkQvPxetjjnGFB94iti9Gdxw==
X-Received: by 2002:a05:600c:c0da:b0:488:ab5b:d711 with SMTP id 5b1f17b1804b1-488d6864b6cmr191505975e9.23.1776164775580;
        Tue, 14 Apr 2026 04:06:15 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 12:04:47 +0100
Subject: [PATCH v3 1/6] perf arm_spe: Make a function to get the MIDR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v3-1-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

We'll need the MIDR to dump IMPDEF events in the next commits so extract
a function for it.

No functional changes intended.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index e5835042acdf7685f95e19665cd45f97ed868275..39046033e1433cff82ef0668074867aba4a462a4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -972,14 +972,9 @@ static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
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
@@ -987,15 +982,28 @@ static void arm_spe__synth_ds(struct arm_spe_queue *speq,
 
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

