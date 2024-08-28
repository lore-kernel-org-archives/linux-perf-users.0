Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB218953C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854146; cv=none; b=HkgOJARTX4hlvu7EsJ1DIORzXz9ru3W0IUY9AEHEZzMQvzRJUsCanCcDp/8Q88i8A+Uo6SZEuMz1/Z79FLshSOnAs+B6UHvIgvVlm70fTY9AoFcxuN4jzclTNXUfoWxCxWjE3p4zdTOvqVjcxiZk/eqXiNz2BBfVbh2wmLVq0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854146; c=relaxed/simple;
	bh=R1rW+JeCliU9jErQ2ls0dfEKB+GTh0fwrinuUyPU/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l072b4w69EMzZqBWzeTjB66KdHiMp7VJ9ZshkPPlO8/L1lTLMXc7VXEClxelQu7v2mXceyXVURK3TDl+9Ycvo9XJwLZ/xg3+Xj5n/B8/8Mj9jULcyWYin8EKT2vTdeVI03g0zJ6tkmA7AFlHVVrqn5j1eR5PvlbSAJWmWW3n7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYC5SJBB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYC5SJBB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so611998066b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854143; x=1725458943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=oYC5SJBBaf4Z9uBvwEfa54ygOM2LoPocNUY/cgE/L30ZXhitSasLBSUmKf5QLwymQO
         ccKHtn2fe/4vdUFnJKHZY7Sur8K88WFprrLEZqkPAGwlyZgGt1zqCJvstscQu9W2og7y
         /Uq+2XEH9mIpUSxfrW7ujA7jncq2z1WhMLdS/y8VKsH2HnJfnSSVFBzN157k041sd0UB
         6yTTIOeEQjih0TOb+Cuqrwxhrj/AXE2SD+o3XRRoIdmik2jtZ5En4+6r72xXgW8zf9St
         I7iIoDluZneKXf7hIqZ4ATWfe46cf35ylrFaSNQ1Z3d4IN2bI6Fa9CEZ8X3EMujS4ucL
         8DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854143; x=1725458943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=WY2jcxn/KIsEiRakgwMbbE8ZM4eWx3EpdX74HqZj6xa/hdLnLxd+Inb0AmFzxUFm5K
         1Wu9VaEXew3l6ca6urVj2yjR0zCq9RGsDF5b2UDwF26V6ypEJajeCLI0q7zRxY1F4meM
         cSgAPwakRNAzSeMmSVkKmcFMgeV/Rf3q5hUvwjisyU+mYyr7DHfd/TV/WrPQa+H8ovV7
         9p3q3PCkItKx2EkPWe9BBC3o6vg1cvVIAEdxHlPoWG5SY96cziFvlXKDhJfTgIcLkGUA
         73qdSU0u9eTVAJ76HS6PsbbGS9ky6TQkkE9NJnLYWRXDTCtoWW4y9m/8pNQdkELbk5hI
         M2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqVHqxwGMXHCScFxRIUQWTQRwa2SLwieAYed/Ms/4P2G9i5nViFR8TB1SvlRbIMjB7nlI2dh/wam3Tbd2JCvIc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pE5U5W+Wvw5tYIH6y/B1Jr/qzl8/Sb+eqbI89PWHOW3mkkhb
	v2w4aU5B52W9xYLfTKgS407gkPfcIJ4pSI6tDRnEtc7pxzevmaf5yP903ggNqF0=
X-Google-Smtp-Source: AGHT+IGamSH+hxEvqf/wJhui3D/jzrZ5i+zWZOp+8vazvps8M4Uh6pYxZyTr3OpCAb2zab1HQy4wJw==
X-Received: by 2002:a17:907:96a5:b0:a77:cf09:9c70 with SMTP id a640c23a62f3a-a86a54b9cafmr1229096666b.43.1724854142718;
        Wed, 28 Aug 2024 07:09:02 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:01 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Wed, 28 Aug 2024 15:07:18 +0100
Message-Id: <20240828140736.156703-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>
References: <20240828140736.156703-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

Use PMU interface to better detect core PMU for legacy events. Look
for slots event on core PMU if it is appropriate for the event.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evsel.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..1eaae8819c5e 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -21,7 +21,8 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
 /* Check whether the evsel's PMU supports the perf metrics */
 bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
-	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
+	struct perf_pmu *pmu;
+	u32 type = evsel->core.attr.type;
 
 	/*
 	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
@@ -31,11 +32,31 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 	 * Checking both the PERF_TYPE_RAW type and the slots event
 	 * should be good enough to detect the perf metrics feature.
 	 */
-	if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
-	    perf_pmus__have_event(pmu_name, "slots"))
-		return true;
+again:
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+	case PERF_TYPE_HW_CACHE:
+		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		if (type)
+			goto again;
+		break;
+	case PERF_TYPE_RAW:
+		break;
+	default:
+		return false;
+	}
+
+	pmu = evsel->pmu;
+	if (pmu == &perf_pmu__fake)
+		pmu = NULL;
 
-	return false;
+	if (!pmu) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (pmu->type == PERF_TYPE_RAW)
+				break;
+		}
+	}
+	return pmu && perf_pmu__have_event(pmu, "slots");
 }
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
-- 
2.34.1

