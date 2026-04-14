Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CF3E638E
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170897; cv=none; b=TQWH0znZkisCwxMZmGg2JA//4tO+VXJo4eLEkXhJ6+DSYp50fVktdB2u6Sr2jOHQYTVUeMDlSNI+F/IcRkNHO+WPArQ4MpdA0+khjlLkbMvEN4k+tcSfn9UJRKfancEkePxpnkcy8s+Q0cINqWtKJpW50dMgAKmEhBUp7kn2gGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170897; c=relaxed/simple;
	bh=B4MOcb4BErEsKUcIM7RRmNpCR6Vyqi8cYdqj84QRn4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUym/3zl/1m8yAsNNadCaNtxhw4yl3Gy+NcEtncCPaguTUKKGAwDijQnPnNB8Yurp3KCiy1hyt1XdLAUGmGbu5KW6oyYmV9mZn1YP7xjZsN62oErKPrA+Z0ySSxH076Gr0Vg5JE/u/38DBIow3l6mCSfQquSzXDKByYhuyWg8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZeWOTro; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZeWOTro"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0046078so55148075e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170894; x=1776775694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkEHFh887Es+jtZSLZuibHtBrvBj/V7mtq/pJJpeMMk=;
        b=jZeWOTroFtLLV9F8C9Vw2d+u85VQxcUKNza/mJdvKe4sZyWkZMvoaUOM6EvuiB0lY1
         9lXu0ZNQPUR2VEuFVbdGZfTB7FEkqA7xSzxdCUBT5Mao9gZgUCnO4bCN5Esuk5op79qB
         p6eTcU+RpqKTYdzmz06VJOffbK7O62IkPrRp1hkYwS6jIXSSGnd58ZykPyB11DKoxzdx
         LeOig1VH/AtYjqufYM9k/nR2TNdlu+99lTv5oh8+iMR5AIyk1fuKmEfKYqmHQD4FhQbq
         7JAH9K3dYhkupXsaBfw/icTcyo9hiDNU6mxv2iWUzGY/jtl4r3xetOjI7orkDDR9uQwc
         SQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170894; x=1776775694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkEHFh887Es+jtZSLZuibHtBrvBj/V7mtq/pJJpeMMk=;
        b=HDcYdRSXZ5b83pYNzVNLIgxJRkby0GvSyKT1MY0PbnynyA3OINCumOW/K6G2L1oZvQ
         19QLHtZ2BkAt60qqpt4SZDUl5ZjHT8Dc/o6yncYXSYtlSOE/2+0IasDLNNaNYNA5H8aO
         MI+uQ0kOw1c/jSg/M3PzzFElBvboIdRBoeQ3DtM3r675Cd5palslz+nE6BWPJa/8VTbW
         eDEJpNhPu5M7pdqnNTY1pJzv+C/pRYZN0xzz96O4Sfb1OnhqE56Y81TYZ8IkT3hEZ5+T
         1AhksHRdFCY+WdPQPolTb6mZcM5UIncfqTBNlmcsrwhZO+MCcEMEL/N074V+MFf6izkZ
         NDZA==
X-Forwarded-Encrypted: i=1; AFNElJ8skWTz0QylIhO+/Ay+hU5cdoZI0JwGcezG+ozsd8/HREWKaudcbnfstzRXg5ARGBGL12hpvaOvJTy1i5TkToup@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZJbKYCmO01Ff3JTpE1zwtGwD/NfepY72tNO2lP6zlx8fkMMH
	MVNMnIfBLweVaWH3OsFw4wxL9CkqOx5AlTQrM2pZS7+jWIKN7CCPFHo6PxUgrtoX0VY=
X-Gm-Gg: AeBDies0eZA+OnUMzTzcAYZ2sL7NG6+3iheGbOtVRA4Ynka2ii6RSsfpFA3ina3QQ90
	zepKC4LfrrVNkAirM9p3hBgMHSsjjxb8U4MpnqKdDGY+Vg5ghppX6SXHb5dohOUfPmb1c4vTCNy
	2CBYFGrQKdzNsQRAJS1Wl3PvoyIS2aDS/WQ/ZYCVYtpQOnsNsBzatsmiUCeToWjPa9TmeZb5uZr
	nBzKnhQ4/jcbGm1SZSp07E3udbet9KZ3YloZZY7xnJ5JCorCQW4AnAjgIddUXz6YGu0fNlHNcxl
	pGiEmVJLColltaHXtily6bg0wCEoC25oki9usCRwcdgQRQ6k6A6IFXUT8uVfL0VsTBs4QtTAxxV
	XlyMcABOoK5gseA36Rl00sJNR90Hz92jRsEejuK0AvrcXcFY0i6ZyaAm6KNpuMXxWDS6MWAz82e
	jtAcaXsXUNalhl9crhb9KPNJhU4gfYaZ4XeOl9VTq3NQ==
X-Received: by 2002:a05:600c:c10d:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-488d683982dmr166085705e9.15.1776170893726;
        Tue, 14 Apr 2026 05:48:13 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:47:59 +0100
Subject: [PATCH v4 1/6] perf arm_spe: Make a function to get the MIDR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-1-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
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

