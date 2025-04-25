Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D8225760
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617225; cv=none; b=pYfyRwma/KLQoF+IUcLdqXG3T+c2Uy3g2wI5qlJoGrjiwYqFlOuqy8B72KWOm+kBI5j8uQXTEGrsm537+uvjFsxTws0DDa7F26bQfuRCvDM9m5KtrWKal5PG8MoE+bdj9SAr+/pMtq4pcIIHVwRmzrtpqdklKmjE+pfi8ocjZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617225; c=relaxed/simple;
	bh=ZL08rcqyCgtd3fCAOlGvbvozdsTpLdsBGxJ125AYgWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EDbAr0fjQYz4H9ndrRlM47brR+qRVNB73nJpCOBQs5Dp81X9kY3+e0mNF2C0dslLvQyaPmZ/12UjovZs3H7bfZRh18Z76P6NyEGKJD4I0mGjuDYRoSXejTeq4iSh3Wxfl2mB+76z7soje+cgiIJlfqAkJiW+UwNnfgQcPQsgoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7puIXBH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7puIXBH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ed471999so24642055ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617224; x=1746222024; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAX+9khAQi7fMOsJvYWjYKrWaI2re/p3GAurUNFPS60=;
        b=r7puIXBH+rdF1IYC1waoyXxyIoRnLXWCAuRyXDU6Oy0Q45mrqperPH+xIRvGfjgNkS
         7T+ET3VZXR4tI4yZ8zDcLzUraxkBk7xoMseyKSeL0RJdMYZaHK7e1ne3rJQSldPCBdsp
         KFF/4WJeARfCCzKU6F24IUMij8t7Ueje09r7tsjpJSxL0Lt+FqL8T5eESgqDIDOHxqEL
         mC1+WQ/XmvbrHVzLVcBm0idT6bFHue+2lAwfs/beumOk842zfY3O2XQPHUVxQQuJwH2g
         ObBwSQvzN3SNX58If/GuTuA+HKhqUSWdRJYpQngoacH71AA91iIqDh1X+ovY2pZC8zbE
         EDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617224; x=1746222024;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAX+9khAQi7fMOsJvYWjYKrWaI2re/p3GAurUNFPS60=;
        b=itKE1YJoRsRwB7EAxcJRT72I7nuykXwLJKcfoGNInzdu1KNAaVrHv6IiHRKH80LU04
         WzIXOjRI3h6cToXbiUnVsM0ztG5tRaf8UjIh51Cx4bSlsuhJjTmx1Ux1T0NLo7r98IW9
         bL7s0CAyWj/UA5Gkp6v6TDGIOvc4AO5gCMKw5R65Hc6xtGu/Lm1gV94kFpbf7eGqUEoo
         R+8gDe94qL50CVVPiKt8lEqGBQAUyxtBPU21mcG+NmNcMgCSZCd+abvjCHQ6kKSpRblK
         h4AA4XNolgVgobb+FoU/tleBLdAMRLu/D8BtfxNIGBc5A6G7KMZ+gtymgBIEpykAWmtm
         rkXA==
X-Forwarded-Encrypted: i=1; AJvYcCXZvGQryu+1aE9yLveXaFwcpgetGPLI9mSCw4x7cWJN2P7SHgI3HHwde2Ls1YVAZYyRVfndbE7lhEFZ2rvRuLbC@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuuXCpmY6dhN/+GiG+MIYzyzrvjdLf0rcthE1thmr2Zgr/xdB
	JUUgc7CBOfk5oKJzyeOAm0rqrIXQ1YsZxdxNV8bx9EDFUz8NOtUcgxKdpBAI7wZDk5C+H/EGx8p
	MZjRP0g==
X-Google-Smtp-Source: AGHT+IEOXvhmXgBH203IRvWhR6UGZfK84QlccQK0fbPrnmGOEV62oiaNtGPJB8OlZltmpiATXhLkEWG2ULWJ
X-Received: from pjm5.prod.google.com ([2002:a17:90b:2fc5:b0:2f4:4222:ebba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8f:b0:2fe:85f0:e115
 with SMTP id 98e67ed59e1d1-309f8df728bmr4719663a91.26.1745617223972; Fri, 25
 Apr 2025 14:40:23 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:39:59 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-2-irogers@google.com>
Subject: [PATCH v3 01/10] perf parse-events filter: Use evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
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
index 89708d1769c8..2a60ea06d3bc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2463,9 +2463,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
-	bool found = false;
 	int nr_addr_filters = 0;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2483,16 +2482,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
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
2.49.0.850.g28803427d3-goog

