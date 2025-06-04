Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504918DF8D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059162; cv=none; b=bSkcdWsa6cBJNd5dcanR4b1ws0ZV0St5oMcubqgtlxdOA8CraMFdL0d2DAbKCwRabPyp5amhEa88WWVF4aidp3QOUmbwEtG/wTjDs6ewpzzluSSYjpXChqoPGAOFL5KROyAVtH0+K8LhCsR+hrxvM7rkHjihuFNIeXd3kMVsfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059162; c=relaxed/simple;
	bh=mj6O7f7WcH/zJTyNj5dVGJmYfITex5422KtPR0vbY2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DeuTEskrjtPkgutOXUFIS1dN68GhkzEcGq/+z7tosb9mO76jlhKJskECJs59D4zMNkxeCU9wFHX/MM03RDOpbmog5W760+Qc/Hsmog/EvHK4mInEVxlW055xxGGxAqqmLKGlipCuof1UXASzFOBEjSyNfWmDRahwAaBHXEaQe4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/UYpurF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/UYpurF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso123076a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059160; x=1749663960; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cr8AU18vrh9A9pbk1lgn8Z0KqD4pWB6L1KR+gFE/XN0=;
        b=L/UYpurFMFckJRvZrZPVO29Iwr3/Q6Rdfl4st/QRvnlqz/MfCvqG4TPr4Ql//Dce7v
         6iCU3CpsI9sV7HZFrsaKzAaMtW/tgjD3ijJoTpB22fV8A07DGwlcTflXXHjsqKmQZ/Kb
         W6zBoF+EZm9qoVlzDPoDdrcnvgehYjwMgwD4Z6Y46GtBSF6slYpF+4kP8dW+em8JBJeY
         TNFlaxjI9PPDV+mdQdr9cCgXXxmWQ93jG279+S9ZtIg9K8pioH7c3mcpUBrEuj2rVhQe
         M/rRBux8gF1U+AyWTli3t2E5QDMy/T0xcZTESO33WkNGv23pn+Nr+XIlczEyvYsESDvt
         6r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059160; x=1749663960;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr8AU18vrh9A9pbk1lgn8Z0KqD4pWB6L1KR+gFE/XN0=;
        b=g80j2J6AaNSR+OUIQIxjXE40Xi1jl+mGHzlQu9ILKZqUpLu4609jXqpmFa+KkohUl8
         IlBfGO4X9bqUZrOELdN/jF9cYY+7nynF250sDkdswDJfoYLehRCkyTU9GOgKSYcTcVRD
         oq2eJ+ecxQrRgSLGLqtuGfPu6kgrehF8PgPommsJoVtrDkFjyHLZxzuh5dmh+XK1JiO1
         94nN+L2WJHNZflku8XKTAZ/vJ2dfOClFLaFTtUuSNhQ+aaPAghFx9GANgwTkMbQ1T7R3
         IaiEnbYXeoBJ4CRD9rkbt5LFMnDC3L00dY0nqyQiflCYxycZrHymEh9yYrbqWaYrPIRa
         1bHg==
X-Forwarded-Encrypted: i=1; AJvYcCWDqeMvYSSkpqDxx0ZKxFwH2Jn3PUtqQlnjGlw524NmfHXD2a+r5cTsOJ6WJejBFqNrwJLbYDMxwF+hbT9tQ4Kx@vger.kernel.org
X-Gm-Message-State: AOJu0YzFatV5sybG1IG/TGBOswsBTe/+oWQv/bSW2VHvgGZ6ii7WZt/O
	CWsewO7VIQp3Lf01HvB7tOrFLErIk5wcRVRwQzyeHR/nJRxWSp8xn7OEQK0AkkiZodu4u5D4AMQ
	J5zyLuSohPg==
X-Google-Smtp-Source: AGHT+IEOHpDk1MKKyIDD4q4LfRorilSCWNnk3I7uuyrrodCqLKuvammmxhdoTFNTJO57M9BNCXCFuWEOQX2b
X-Received: from pjvv11.prod.google.com ([2002:a17:90b:588b:b0:311:1a09:11ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5544:b0:311:c970:c9ce
 with SMTP id 98e67ed59e1d1-3130cdd981dmr6224022a91.28.1749059160074; Wed, 04
 Jun 2025 10:46:00 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:35 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-2-irogers@google.com>
Subject: [PATCH v4 01/10] perf parse-events filter: Use evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually scanning PMUs, use evsel__find_pmu that can use
the PMU set during event parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2380de56a207..d96adf23dc94 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2564,9 +2564,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
-	bool found = false;
 	int nr_addr_filters = 0;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2584,16 +2583,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return 0;
 	}
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL)
-		if (pmu->type == evsel->core.attr.type) {
-			found = true;
-			break;
-		}
-
-	if (found)
+	pmu = evsel__find_pmu(evsel);
+	if (pmu) {
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
-
+	}
 	if (!nr_addr_filters)
 		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

