Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DAF1586C9
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085293; cv=none; b=CYg7OAUm0k/xJLwuR9D0AILulywRwFl+DOrvp2doEbE5HFOnZyzS+N02krVTAHdy7tDoekVoeSPsSXdZcIVHQw0tWwDGwH50Dmf1OOK+4cgpmhonne4bLINXDxQKWEZq+XuaBNvYKzRIyzjQPTOaihl0IQt+y0Mrxksy8YcAqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085293; c=relaxed/simple;
	bh=582DRnB5Pp2nT0TmmUs1PKu6Q4ckzT+k5c03nxLaKLU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F/75sD+5SgJduzQmCQaY1W5fltTO41lmBJV8iOra3cvhwprQtst9Ds8QB1T6JFcKrhLKR3JfqhylXEH0cBFWe+MCr/MXiK22JUgPaV6VdmCYWcmfmdsdK0U0f0E4EPJE0qi20R6uwGqc8YY2IwQE5hfy1/PjkzwWrY1SEjy8y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsUjdMx7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsUjdMx7"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso3994743276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085290; x=1728690090; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKmYAtBHo12nlkSZDOvO0LdX2ud+8CKD/pmfUApXbfo=;
        b=KsUjdMx7fWtf4NOksTLfaumdkjdkiS2dIxKe6zQmKfMbSyc0EnLR4Q/h7ZBB5oQijs
         zeVVnluVzDRv8Pa8Yby6jy9tNs1+5+35UisgJQ9dbAnpeVteoQdqjL14RnvQqa5vx1lt
         TFW8FbZwXIFLWRJHbJIZ2dGIiZ5f8W5JHMcYlRmBO9v3bcRcVJqmIea32GceEanCLSas
         PPSPQszjuRjJ1qwv0F3lzmPYFgC9SzeBcxceGbnN9l/QrfRfyt0ym2NJpexElfd4Yv1T
         7ceZsOBv36ryjdd8esy8iDdTxOwox3cvhOiwNs19k8Ax6RHzSDuepMxmMk4Abr/DWzTd
         jsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085290; x=1728690090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKmYAtBHo12nlkSZDOvO0LdX2ud+8CKD/pmfUApXbfo=;
        b=F4wzwOzdff0JhOJaRb6z64VDNfVOKTuU9uz19ikdVk1gygWr0R08DFPKxTZ7l+yF4S
         LDAL/UyRHbjtk1fOS46SACVuAja1yL3Q5rD23rCIvH3chSz5oLJTpUzo9DesllLbnqwR
         gYjA5c302Ux5ig+5aylQTOP45fraBFxPKbt57P9HGGYSpVM3TVPkmPGroB0Ff/XUOIBc
         TYrPq1r3zfiX/ZuhJv1Qdq8fU7AtUsZMu/KKPqCqTnPtTC1LwKYCkbM+hpcF2l3vW6+i
         B0Xjd+5OSshdorfFEqe7NdNUin32e1z2MvfgKiYH9dEL0TkaSBjGzAQ0Q2kRx0mp9zEN
         iupg==
X-Forwarded-Encrypted: i=1; AJvYcCX9SqDBeoVXPXOwZvEPiqKpJ59KV1/08ighcnqZUQO7qpJVP7qxJSUlwflfi2e8EdX83RBTHuS8RXnznyZa5Ul8@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRdUKwBA5+7f8AJ55J5Nc6YELHHWE6Ci2ybnQtt7cgFTlNcdt
	/a1KLfY5G3b85wXCtOvJ1xqt54JTLMskPW8Rb6o0/x+QR+mvYgmTHXs9iXrrEYGI7f6OXMkeeL2
	/AdchSw==
X-Google-Smtp-Source: AGHT+IFIP1vxomIUR1izckKXkT0KBqdFIx8rKTHDFttFm5UhBt8Cz3r+IBAR/Uuku6pVTLADgrA8Md0dEdz5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:ce88:0:b0:e25:d596:4847 with SMTP id
 3f1490d57ef6-e28939190b5mr10441276.6.1728085290158; Fri, 04 Oct 2024 16:41:30
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:15 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 3/8] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Return earlier for an empty unit case. If snprintf of the fmt doesn't
produce digits between vals and ends, as happens with NaN, make the
value "none" as happens in print_metric_end.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5402998881c4..e392ee5efb45 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[64], *vals, *ends;
+	char buf[64], *ends;
 	char tbuf[1024];
+	const char *vals;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
+	if (!unit[0])
+		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
-	ends = vals = skip_spaces(buf);
+	vals = ends = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	if (!unit[0] || !vals[0])
-		return;
+	if (!vals[0])
+		vals = "none";
 	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
 	os->first = false;
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog

