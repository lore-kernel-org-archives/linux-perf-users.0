Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E1149E16
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362207; cv=none; b=nBqY+ijMZUjL3QOHCebwZ+hY9HpaHK9i/6Q1UubW0DBxBz7L6Yzc0NkwTxHRS9CHvUskbcZovRhdqpgByyA/8BJAs4TqzXY7Wy4etxhblWKpDFBwL62LaqRQNriiyBvr4YTHGURa3UgLJ0eVo5UX8Z65n+Vk5tZJ4dUrkFoHLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362207; c=relaxed/simple;
	bh=PTT83CDGzF8j6RDNmUZnZvh4vgTyoBRmwdV2VAH/O8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGoZtZnpzcQJQHJlT/HNtH0CNTAdm8JLKRyGWoyiPM0zCnliDXNOygoXRR1O7RGPDJPthFolYUT5Mu3mPBerGyyjXdKBZ+SynQtiP8wObn7QbMXxCOzN1N3GaSlSBuKj+pxQjFz2LIymf8GfEwwEQk+liIUjdAXmNeTJ2SBY5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=no/stc4j; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="no/stc4j"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d56155f51so129786966b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362204; x=1727967004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWSJTlcUZqJc1Q72aDywG6mEPNHoFW3+x51bKeYfGjU=;
        b=no/stc4jrzFfEWnJo6neUiNZRYxO1t+4SJZXpQxsRLQE+h2de1z5oE7Q7YmSOZQuc2
         zHxrKnuzQjLFrL0jgd0FQEcqsbjkPwYss0BO1H4hwQ14Nyd855bUZ8iIPVTxhwaPcTGM
         JqTGzHRmExfbRWGSq6Z+RwfTaHoDN5oIMQREiDVUlxnVwmH0PUB2zNWlBV9zxZHOy3u0
         0nW3M5CugqO0HpQVH0azWRZ1R0qvxOlpDKr45uXp4gb7atDnQKHvpv8kIF66jCpWEI+M
         lFweolblun8FI3sJ4wnH3U4+ENZY9LZuVMbB+VZTufCUeEfZWtMVXEu5+SePvC5AKmL2
         4QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362204; x=1727967004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWSJTlcUZqJc1Q72aDywG6mEPNHoFW3+x51bKeYfGjU=;
        b=h8kbT6RGqOljfwxOHIsXVJ4cu/QiVtr2NfarFR3XABGKvEhHGA1QzztLaN/vcQO4FI
         pMFpJjGTBe/1sSrMcUIMNtt7a9I7BFvxqXlQ+015rVVaPL7RD5tOA9P89P3+BJpP0WEW
         ojv2tX10WYfwZRTng5gxfbYxn2bUYLkMtzoDKB347YI3MpRTMnDwHhdDjH979ksuICrV
         y+XzHe++gz08RwygVuEwuF2R8axO/jWMUjGBSH7+NrM4IcLZSEfGf2xF1zV8L5xsQ7nJ
         SVZxtAX70798lCwPMksJMu4ebgaS+wXQ5VEnCZGXS92V7xivZ73jszUsnYSQ7hwkiRLI
         2KqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTlHXaFBtCCgYtj6x8NlMXjJLBp7AzUnO7JPAwDzwI4zE3H2fK9Ud+oCdip/CqZz7BBHDTMYvq7h7VRaB1Hnr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/1nL+lbubzqoHA17SXmDSuODLSnR+pzieo+8eJkmwM0lH2gY
	6yIFonv/4N1q10YuRUueJHupZPQ7iLB1dp1l2DCi2F5VYErTPgMP7jwPUlDPfsI=
X-Google-Smtp-Source: AGHT+IFVb7sSRn39qxyC7VnF93ZMoZ0TZHVjg1NjGZKl+w/BNqbLDXtVjbZLiCJ0Q6lmV8piIlggjA==
X-Received: by 2002:a17:906:dc8f:b0:a86:83f8:f5a2 with SMTP id a640c23a62f3a-a93a038c991mr608744466b.19.1727362204313;
        Thu, 26 Sep 2024 07:50:04 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:50:03 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Thu, 26 Sep 2024 15:48:35 +0100
Message-Id: <20240926144851.245903-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144851.245903-1-james.clark@linaro.org>
References: <20240926144851.245903-1-james.clark@linaro.org>
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evsel.c | 31 ++++++++++++++++++++++++++-----
 tools/perf/util/pmu.c            |  2 +-
 tools/perf/util/pmu.h            |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..ec2ac3bbb76f 100644
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
+	if (pmu && perf_pmu__is_fake(pmu))
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e32d601b48f1..8993b5853687 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1168,7 +1168,7 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	return pmu;
 }
 
-static bool perf_pmu__is_fake(const struct perf_pmu *pmu)
+bool perf_pmu__is_fake(const struct perf_pmu *pmu)
 {
 	return pmu->type == PERF_PMU_TYPE_FAKE;
 }
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f4271395c374..d352d53b8d55 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -281,5 +281,6 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
+bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
 #endif /* __PMU_H */
-- 
2.34.1

