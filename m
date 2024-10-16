Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D22144AA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101246; cv=none; b=EKEeH3begS1Eb7rBBhw/S3SEiGpEHna7W/yk/aMEc66HoxqwiWgGvEyq2XuVOheQdb0VF6kkwEPbqHQv7tXCLuGMVQYKnPme6NOz0VMMTNTVWrtMit5kU27YpnUlOvrzTPRA1yT9cu2qZJoW2zokPsUm1x4SW+bY+FIZWo1R7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101246; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D5hbmZBWOqFV9hSLxwJ5UZgNkzpbOyT7lQlWsQIyFFGp63LEzmfFqfyx9xsZkSuGPvj3vSldcpv0K2GWfbspW83QaRmwejnKYeCSvpAbzvsCArHNwFLYCjAvVqtc5/xa/le/75LP9z7ldewIPUIR9iuIg6+sovFM4kdu/HDL+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSFuQ3zv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSFuQ3zv"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29142c79d6so56509276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101243; x=1729706043; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=nSFuQ3zv66b3+ICwOEnquoFChnbGinRg9mzWc9uWveUrqxeAG08VyQFH+EOjj8KESa
         ZBvJQg4TvwynzA882n69dDe3cR3v7shN4Jf+baKR2t9F9mvLXKNj2BRejIyJeTF4NuwX
         qOarH0H2rBEoohjfNdjswKypw0N5Y1hWcVlQINlKNxZ1qEjZ/Zd8Vsv9CR55vCzs1Pdg
         7ei7TP+9jwyOvF++8Eo+zju2MVsHvQogNxaJbIIRfWwpivSkB15pI/z+CSdJfcJDbGiX
         J1E0KM2vdvPUsGjW9yqYDivz3YraLeFfBmy3RZRdgdOeO4WKyOyTS8+tdBRLxWZ1FR8L
         eUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101243; x=1729706043;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=ABMxajOZ69R9XBpPSPx+r0qBdcXqwEnzAs+scmpKyJU4iZEB0m3VYYWsMuw6A7dZP6
         VSRs6wfz986otbIn0eVSz3M096k0euKIbU3ytunmKRvJbIJk3vZVlEliTe7HfAsAAUB5
         z4X5lqaDPKlcsFap4pMWMncAPdQJBgyhKAOhkBLlgC3BuYAKRo4VMj24VAQA+GHT+wjY
         qflu0ne3DU5YlEYKUaMmY7j2fT6HXvnTOzFYArufbiYYTacIx7WPv2vwMI1pk0HDrpwc
         zHWff9UMp34/CRoRTPSyo1iaSVSGRh5qI5PkhtwRqqQhYOXkLamUkfmcxTYjx5c8pz3v
         gPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWFyHgWVGd5fVzwTHfw8UT8fON4gcP8uY3x9iVY8CXdAvZGkbwPtfT64it5GaY+ft/ezApTKd7+O5jMqSuSoa2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U0gEfOmTcsRGFgRM+MW9PtfVwBS1jH6tj09qKJqIV3mGdLlc
	l2K0pYC7S3FZ/J3Y+acudlaE+kC3iymft2nKXy+Lil8qIAjY8beCnPOjFRNejwv8gBsgJ+rj06u
	uWPYsHg==
X-Google-Smtp-Source: AGHT+IHCPG9L9oWbfk5tOWCZkv2tp2sF7rrGkdVUIb+ubd1ZsfFeQQS6KOfWmd9ApJSK1xc5jRsIrFnSeVvf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc10:0:b0:e2a:e7e2:60cf with SMTP id
 3f1490d57ef6-e2ae7e2629bmr1152276.10.1729101243038; Wed, 16 Oct 2024 10:54:03
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:46 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 4/8] perf stat: Drop metric-unit if unit is NULL
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

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a137b377efa4..c6d33010ed22 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -471,8 +471,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.105.g07ac214952-goog

