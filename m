Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24A1CB150
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333217; cv=none; b=YOR/xGNicZ2F0ruVYCm9HC6W1c+aY7ceiQPfUE2GKM+IYgNjTUAGUF5sQhO6k0p152ELW3ztzxOSgZAFwoE5WTMxSRaXHqo4n4bFuKBOvIThK1VYqNIq6ea8OmiYWYE4/EQhjFRwbBbc06eKitYG7Q6b48vfWJ9giDRVfnOHFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333217; c=relaxed/simple;
	bh=R1rW+JeCliU9jErQ2ls0dfEKB+GTh0fwrinuUyPU/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgvkgzJDB7ed4ODnGmXiu1TGzE0zlRbSDiu9XAu7A0s6rgd7JZ+iB8YYz/MZUtixQQw2NLSsdO4kSPwvzXqOT8BUVObeLaJPlySFvzHZquPF5FMT3g6wQ8Dh3hbqgW2vDxR8VJKSM2J7Y8IaYI33P0Z83+s5F949dSFdFMsSdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXys8XYv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXys8XYv"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so95824166b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333214; x=1724938014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=fXys8XYv4hQZOPhsxzu1D5eWtiz21j0GVw5aD5yRGlKL3TJrisfjN/hK4IuW7TDJaK
         Gpej2osy7or6PMEHcGvbqUOJBlBh/VmcEmuvMUrMafVUr7OI/e9DSjMWZqZ9J0MQ5IKD
         m2Ht20+Es3m7beNAP3xbeUGcWYqov9/N2nA7rot3dlNa6QgAlSNXhffSjDLxnXfqnb6P
         DxAd37XsVcVUScsKqncxLSgZgWmWUsk/Tv2raFOZvxTZgwf2njlJ8N03ZAS0kBHGccbe
         wR73yva4HEx/MGv4kAZ2LvEKeWgRGnx3zcj4O4MSpAFjN/spmugffe0SLS/TolzE0XBj
         heYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333214; x=1724938014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=We7ncYVgoXqRzToPJb8CyQno65t9wgy8zkGFG0W5VPq9O/UzS8H50EqAegk1I4Kkwg
         q81mO9hNeLFiSX76gy9PBd/A9KAXkfA6v54AGGGyDy0HEWuU2gT/UYsjV5M8sc0rCdZ8
         Rc2vsJCuQWETGGOEox6htNVLUHCnzXrn/Jhq30a4wLWpIiDeExaodLM4pPdCs/ov1ljL
         WWrR6J8CIHynko1eXp0bPc7Tcl9qCadi9Ppm7x56N778VNEe7KlM/1JCDK6XMnXp3kfb
         I0ZGVTnrfztBCEQLi4joEo2hmkq/E3m0OcCSex2Ug4jgq+ODRYt6IK43gtdfsPGSFQdC
         bTFA==
X-Forwarded-Encrypted: i=1; AJvYcCW2u6Zw4AqS82yWPR/m/RDR1yeFj1I6u6hO/WA6LqVwRL2x4PKe6M41vq5x5VvIOESHmhEBDXHlzcpIff5GLcKk@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaK5o/giZk6xlbSWhnsD2P7FobDoLYQ3b/1+SVBSSy9r1P/rS
	kTnmrPBveTFcRwVqSbwxwDu7w7v/VWMmmaDbUuwQrPwG6H9PQQeSgK222D7frUw=
X-Google-Smtp-Source: AGHT+IHjm7Q+JoZgcM2Zph/tZNRKj+q2DW0doo5EcFiHyW+jdSlZaqVjNw0PmuMr+kvtWO0dxJNqxw==
X-Received: by 2002:a17:907:d3c7:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a866f9d2811mr428685466b.58.1724333213916;
        Thu, 22 Aug 2024 06:26:53 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:26:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Thu, 22 Aug 2024 14:24:48 +0100
Message-Id: <20240822132506.1468090-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>
References: <20240822132506.1468090-1-james.clark@linaro.org>
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

