Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90862ED16A
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052281; cv=none; b=cUnZMem8prGi9bk1/54htrgU2bsmDvF/V510TEfkygSAR3Etpvo49kdnb+CJtSZuSJxYYhEtELK3HQP5aVnaDIWxoCStWegYbaNz2nXx2/mV2x2Akj7O3fJSWjxl8gwzaNvCglG/aBxmIvGixq94HFwZqGiHdTLKZHSrablJkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052281; c=relaxed/simple;
	bh=aNMN2DWhRyU+2RMpyUjUFGngTzlUnjuyhGY6JPjW1Eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IstC5vOOoHB1S8b71rrv3WXHMhtQ7AdOfLZxG9AwwCKhv4FV22d5AOIBhk/SPXh9ZMmYE25hdR3r4CPAjnkLvrrdE0uQ1NeEO4dvYJNT+MI3yQLfnbKlwT536Bndb3wrMqM4sWIYR8ma/pTlHlPCsIFsj9tngrop4CVGkr5YpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WpF7uTs; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WpF7uTs"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e90e7f170eso2768942fac.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052279; x=1751657079; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y648qPWPFyBd60sW81F/WAt0bQS91tJJCKmWVX/1yDk=;
        b=2WpF7uTsZWSOWHDNmMCdPl3WuQT/JGiF0vETmMnX0TnfxEpajkmrINYeK3q87yu+3q
         LrebpuUOLdiUrei9UtDv3A9ajnyu8voNNzFbxo6Cm+JoM44whOxbiokJYjkoEO4GRdHz
         em/H2UOhNcuDF8I7xQKCSmbZYhct8A+XV9RY+5uEck27p24LrKBTY0EYPlzV4EfLmCyb
         Afyl8v6g0E5yMIXwdsVMpa82Z5F914lNj2RWDO9CEdWy4+aJBIJPVqTCXpV7xk0OoCdq
         hzH4lxLJNYrbBupdcsaPSiEU+vqKuFuvR6TKi8qhtrla9yXcOR44tGQuQz7A/eDHJ+Lr
         JTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052279; x=1751657079;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y648qPWPFyBd60sW81F/WAt0bQS91tJJCKmWVX/1yDk=;
        b=IcbKAPcPzQ45LBXIMOvHPfdrr0NoXFxWAnxthZYzDnmOUbfq3kf0Y0XElpUnj7bEW1
         +UmNvMozSVpTpgF0eGTqT+yaQIJydYyFr7wCvVkUmucwWmUDWuuChAhhNm8wNNIiDY6+
         t9De61Chx6+x6dWz9Tq0ynvwgH1w/8TikKDhkSS/jpNA5WgX7pBCQS8T3vbHXkhycFXp
         o9F9tKn+qQsKrwBC3ykXUsNMcKy/j7t0hyCTHQ2sGEidZfjbvIIVJqNWuSSpdCvacNFu
         Aw2FT2jfi/xZhdn+i3TNqIwEBg9qVy6dVRl2d2co+REfi1MPDARRW6sQLP6gBKRyfEtO
         qJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlVUBbXEKmDhGK8Ufqd5HleWahfRR3A32vJpULCXL+2ixurpGsndhmuN3wwHI7IC1zmm7mjJ/PF+pUT3ZeWkdm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LTXoG2NQ3Tq8YpkFBovGGYI/C6f/meFZumTRwLxWxCvBpyeu
	iOjHXUbs7KWyYLa6HqbMU9KyMO/mV0ns4eyFrwri3ulLzqQK3NCvMfJJQWtUUZgKF+52r005dFu
	ozU3VQ4kAfw==
X-Google-Smtp-Source: AGHT+IEl0ZSGGe1ulHNJcLJqY9IP+npGVG5iV/pYKzVba8MHXlliSCOPcJXopnVaaMUpJL7mwG+wscVnaTwb
X-Received: from oabvp16.prod.google.com ([2002:a05:6871:a010:b0:2d5:7c74:78d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:f60f:b0:2e9:95cc:b855
 with SMTP id 586e51a60fabf-2efed7553a2mr3126222fac.34.1751052279003; Fri, 27
 Jun 2025 12:24:39 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:14 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-10-irogers@google.com>
Subject: [PATCH v1 09/12] perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow a PMU to be found by a perf_event_attr, useful when creating
evsels.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 29 +++++++++++++++++------------
 tools/perf/util/pmus.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3bbd26fec78a..8bf698badaa7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -715,24 +715,18 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu = evsel->pmu;
-	bool legacy_core_type;
-
-	if (pmu)
-		return pmu;
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	u32 type = attr->type;
+	bool legacy_core_type = type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE;
 
-	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-	legacy_core_type =
-		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
 	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
-		u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
 		pmu = perf_pmus__find_by_type(type);
 	}
-	if (!pmu && (legacy_core_type || evsel->core.attr.type == PERF_TYPE_RAW)) {
+	if (!pmu && (legacy_core_type || type == PERF_TYPE_RAW)) {
 		/*
 		 * For legacy events, if there was no extended type info then
 		 * assume the PMU is the first core PMU.
@@ -743,6 +737,17 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 		 */
 		pmu = perf_pmus__find_core_pmu();
 	}
+	return pmu;
+}
+
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel->pmu;
+
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_attr(&evsel->core.attr);
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..09590b1057ef 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -16,6 +17,7 @@ void perf_pmus__destroy(void);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
-- 
2.50.0.727.gbf7dc18ff4-goog

