Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C71E008E
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187650; cv=none; b=G22p3p+yTEIDuVORvGD0esIgMZ1kYq/Oa4ADzBD2RZdhvSZWBhujrKoc10iT0LoTh3exErqfaZEMEt/RDI2Nm5mrFCuWPLRsjLS+Ofi0+IfDJcuHYCCVJZrfpygz1S0PyPLeQ5TzEoj6dC/aseE6txOOUmT3lGk0dYnK+LeG5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187650; c=relaxed/simple;
	bh=d4p2SSC+jRmzGX9QPS6kNxF3hzHXI6/kfpx81KrMoUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KC0R3iOVttbeIiqATHz21qt/cGf3rXN3TCloPqZw3l/+v6ZtSXwiM0Ds3E4eEO16+GqwK0/c7gi2Aq3JrKbu3JO31ng6F49CBrbFqcqGpMMsloNZb3ho3KQMhnB/d/Iar5emzs9P+I9fJlTpUyNpiQ9S7ikdjiR8g+pWr6gH+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtXbRUDC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtXbRUDC"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso22211657b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187648; x=1729792448; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=UtXbRUDC+PD/2L1h69b6UO3C7Arl5kBYSbI6DP5EQb2f4Hf7Hn9aAVUOJp0mcxU2n7
         FELYmGdDFyxea8EyxdXslbt/ZLS6qBIOIyUoiqGjpUrat8Yr8gJWQsjMjkN7uvptiA3M
         ze/uXusPm+Xr7FC8Nx91ek/R6X8v3fH5lNzJtPjLQ3t4kSnLQJW5T13e9DVyVKSPMHIW
         4mUJqYXHcHfc9gmuq5wozX7AxFZyOcm2bgkB4/1kHuZWRTEc2/kqE+T6nh7XC92mGdPD
         m0AU+JSOuNbUZ1Q4Et4bbLO4DZFXbnZhWgSdUZ289ME9dI5DNGNe+k5L2DXOMQjU4dWE
         6Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187648; x=1729792448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=dRpnlNm77dl6PK7IrwrNuVUpoUQziFCQIC/TRnOYQhyE9f7VazoM7O1mr89BrWllR6
         HVv2B5Fs4xPWEeZfgKaKGWejXJTt0Y8bxjF97XzjTijGgDBVUSemJnh8PVL1JOXUcDq2
         OFLioq56oo++bhNsJqOlZJ8YQCF7OTc/sJjAE/jzW1wyBdoOxeQAI3uUw0NvH3sLreQn
         VgpRnVvVISQny95pLi5HaYYlsft0XBP9uGvhxUk4U3x4cR2pyj0CmmyQQK9g29akiSMR
         RK5qoCxDsfbFqAmHuoxpc3IX1oYsNc0EP42oqbzFOMEt8aJt+s8Msrb6SPufeC57pQ5t
         SpxA==
X-Forwarded-Encrypted: i=1; AJvYcCXCqKAzuY1fvD6g6aWyjPHVF3yHetaNL9NIKbRgYyD8g/tMRK0np1eg4R8y7+WnQtyPJoqMHyNMsHkSxS6L4h7P@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwJfbX2kaTieaDe2kz++fScozkZ6FA5M+9WUKWX0XWhfei4uk
	29/AuchY0JkSsHx65WAwncFFJC4SIrWtKg3JzCk44CZfao/gEVzEPL4nd29TPJL1daNBRBtbWuX
	eXradIw==
X-Google-Smtp-Source: AGHT+IFWI153JAZftkTDRK4H3G+AWk03BVP1rqIrqsWHYCRDtPZDe81i5SeYYAG+nYoX4BSvPym+jcuhv3xr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:4d04:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6e3d4213b28mr1776457b3.8.1729187648222; Thu, 17 Oct 2024
 10:54:08 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:52 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 3/7] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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

