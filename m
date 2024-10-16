Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D41D415C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115522; cv=none; b=L6kFXbmTkgjNUTX84E5stQJZOKk/Ily6TQcTSKHwnanp20kiuz0/luYCzrqAAVntQ/bDjq1kMDYd8SI/xHWM4W9qe6GCXKtJUwN2Hj1Y/7uj/uOaDw7zW2z2cdq5ksxUbTUZ0DT7qMnDQkEIglUiPUhwh1g9vSaErVDuVUv6SOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115522; c=relaxed/simple;
	bh=d4p2SSC+jRmzGX9QPS6kNxF3hzHXI6/kfpx81KrMoUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F3SGNYMzXIXJteQc5aBm39IIfEGRvKHCPsIl0gWVSFvddo4N638aYKwLKZNjMgw/6ix+CWiUS0TjH1pAsgsH5a/X3BA1ln8L89R+rg2eEIcC+8qAz4oXxbADaaUnCnf3hXiidk9bIH8+ngZLY0uKjh1bBh1l7+C7NQ64NOQq7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOmWYb97; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOmWYb97"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e321d26b38so7426467b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115520; x=1729720320; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=nOmWYb97tgLhVRST7jIFxiX6+3C11QzzV9uORvsOUqmziOGWLnzrWTz9n+cAi0HxSM
         a70pLA5I7JyZmPbfvupyfJ3LIKtXYhjRw+ihZCudA8DjGja/fy6OvgcHIu96AZSTkjhD
         StnhIaBzSkhmwld1t0ltbj9ChjUkoN6zx8+dCTQBv8Vq+ioJzTWiIN3WolWMCDbLPTc0
         yW5hgjP1KuxZujHyVO688tEt3WD0tPbgk5dkFzUScVEs8IBQEsrqtBeaAqizjK/L+LuP
         bZFLq/RupkEyCOWE0DD4uZMwosJfok6iKNB2k4Xv2HjRAaEUMbh/NswMjw3mjjwRvbsN
         kGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115520; x=1729720320;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=eMhH9EsGrTvKyuR05AU6bo9qnZ5qTspMwgmshj/dTxjqIy/eiuxxNj6I/Pf5tiJ8Ut
         rpEidoo4NYqhsItXR5UKMzY97nwZdp/y3SQ82napX/Tga8U+cFsScpjmTjhrNS7gti39
         9nT4M9TELURf4aCCCCTmVJudS+QVp3C4tW9mEX0sNe8Dbt8tYtiP6JjUhsSaAjJ++TPM
         lnthzvAMnnFxyciNdbgjBMmUVm9UFlph1P3LDw8fVf+uYLYmNjrRhsLPggAfxAHShfaH
         DSWa9v2+wtpH8Gylvwpj931q8vKivf7Myy4ARgK8tyu6kR7G1kllpXLgbbVcQhB/G8Bj
         7xUg==
X-Forwarded-Encrypted: i=1; AJvYcCW05yZUaLIQI77yeZpYHDKdxfJyRO1VxVwz1HxFNU6bdHGgkLY22EAUn3BXGtiv/Ur7MsAPwQfv05QgJ6P39txJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jHhCM+zgSCsuUEuyQd6XQEbx8A2W5xj7t7qZ+Frmzl4Fw/YU
	EDI8GuISoqzeOOYOu1BJW+QzR3SW+bwXiUfRLMycYfBmCSWW+0vwkJFGSjEfItLhigdP/tGhavd
	4dR9OMg==
X-Google-Smtp-Source: AGHT+IHYLGCrAS7wsnpPLNLCwRIdj/82Nvg4w9FR5SgswF7g/KhN9wQduXAv8HJvlw2EV2tnrt3IkAKSmr9M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b12:b0:62c:f6fd:5401 with SMTP
 id 00721157ae682-6e3d41ca698mr818757b3.6.1729115519815; Wed, 16 Oct 2024
 14:51:59 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:34 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 3/7] perf stat: Display "none" for NaN with metric only json
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
index ef0ca8cd802d..a137b377efa4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -610,19 +610,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
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
2.47.0.105.g07ac214952-goog

