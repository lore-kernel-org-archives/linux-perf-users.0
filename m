Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC963167DB7
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981488; cv=none; b=YBEquusundpM6T9y67gJAAaDjkP3ig25p7KUdHq8JhqObOK5Fd4NDD7VjWdHldz7Z23BWziEDm9sqSz+mbklXFEm5quZ/jq16JZmdAIN0F2/puysWCz/QKTXvuhiRPR9M4rJz6U+K0XFOjYql9rWnOAHtJEVm/togT9IwK/30C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981488; c=relaxed/simple;
	bh=q1Kxi5uJOOpz5sbB76n+6+jBjcdqXi06psYDtou9fos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpWxRyz7vf88FDT6qi7pfGT4VJle808DbtaxmG+KVN6f8hX7PeJIIIUiFr8Ib6BNWR5Isai2xAmObdGyltWQ5DOjJMX81afv+tDSsFHcbPkkGOpc8ttGz+2vAD1MhZ9G0Q0VBH7kSs+KwNVlUNWZGxCmOcth9W54i+0cOGtvUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+3ErAcR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+3ErAcR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so33253035e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981485; x=1726586285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbXzulT1hvclpO2gUzyU2PPxHH5lSuW+E82Abjkw8Ls=;
        b=T+3ErAcRB58eHpW+R4OcC853JipIUWmTl+xfQgvf7WP1JQo5WHM9H3WGSaG4uXp1vQ
         hJWXkvEW6KzHkltpROPsuXr2eN8UPpk5XkyIXxWCR1tx0lbNgg24rSyoZJ/OBhTHPioT
         GIh25zuVU5qC5G7N2weWrw+1qHgT0a4Q5nI5rAtcJ17VPvXhFL4PuJbXvOJCMopyJrOK
         AjEFLL+PRUTE8qF6JpQVXDB2utl0s33yquNYMQIAwDqoPl4iutuOk+6JfxHIAiGAT7RB
         gRdGqlU1cacR+5nnsNZVzfAH+P+CpqcUzbTPheEhf8RAhkuq1xVLIdJ1x56FGJXItxX4
         WhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981485; x=1726586285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbXzulT1hvclpO2gUzyU2PPxHH5lSuW+E82Abjkw8Ls=;
        b=u6RwLluv6iHupMnpvWPPPzQ+Lx+LbfNM0EhRbe4W7OUgtfknvmMO4cKhSCFkchpwA0
         OmXPRQUyVd61581j2DHEPi2E6ocaSiZSh8muN5R9BxOhxl0pe+XnExW2GAtnVpzdEEIu
         65zhSMy1pGItY780z/VLBVNFPDSeIYygg8WywFTNxjzlzzigN0UeNIP02cADNDSAISyf
         ha1u7Iuojt3Z8PfAoFjYKAmk/8YMfHCznqb/rvA/2I1IQpJnUUZbekBlvaQlhn9aE3/9
         WmiNn8OFfnDcsR1UenMOabJJ1H+dxCVsXR4NGBSGvCE+kriiIeWNWQDhhthIY7E00YXx
         FEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUEfym1nOsGS4LHU8oHxcbsriq1g4uZh+oOvu2u6uKcn7EiMf1/xC3xkDmrbtgJPohRTS4WvtZyn9yigoKtCkDw@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfK8gs1H5h3zx0klpxQeD2AILtw1AkD+wumWLLiCa5jX64Ns2
	Ry4Z5T4+SebrosYgf3x28H6OL/hbdjkxPJUE8uklXoiZK7JoZ5tjdRwFHzzxmt0=
X-Google-Smtp-Source: AGHT+IGLuI3uuWRzeekOoiV/Leqs/HePhibFQkWY9zQigVvbRn3rucJiuFLpiP3IkkkJklG+SpMqAg==
X-Received: by 2002:a05:600c:a4c:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-42c9f9d842cmr118945155e9.32.1725981484964;
        Tue, 10 Sep 2024 08:18:04 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:04 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Tue, 10 Sep 2024 16:16:22 +0100
Message-Id: <20240910151640.907359-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
References: <20240910151640.907359-1-james.clark@linaro.org>
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

