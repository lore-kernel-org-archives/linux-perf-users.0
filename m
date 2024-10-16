Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4921D2700
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115524; cv=none; b=DkJM2LWJ/1yP3sVxChEDcB73E1pz7D4V8Ric6b2hiLmBMnkOhu/UDfXhwJUCNDbMy8otxz6CVZk9QwLD9eCW0LHJFybpJjNaMm87P0IDK4wdXpRhtgf5FswG7zov9jiZxlKpJCrNVlog9Qfw0oVZfK2EuBbnhIyFWQlGjn8spZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115524; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XTMD/ex63gOyFHnK1mejK2PJaaP/gw+oYfNPf2jSk8dBFFNxaRf0RoUS+CNiZRnbXW9pR4zXqifQB0/CrH4O1BLnedd8t5ykcGDYWuuwTKh6eK5muunnqkwcI8aQTrC2M1Ek4GykgoJGeypfcxITxzM0XvfCO5jCstx7/HQG/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxBxVH8i; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxBxVH8i"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso405721276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115522; x=1729720322; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=yxBxVH8i3u+xGNDryIDhYNLmlk2A3zJZUg/ImHsTvkb2e76g1NRuc5r2BWS1/CRPdh
         yMm4REhPLHFweKGNw7JoWvznT1mIRUpOdA8Y4TtI0Ej1Klc3+ZC9bGyYUd3VyYs3/5Gb
         F/QryG5TlU840j3aDBzF5g9OHMJZXTGKRfMsQPI/bHvgdxxcbAr2lLkSGzVfe20ErJM9
         Cm/SIyvWBcnPgQMGCaW1dw0p+K7zLeLXsqWXtkzJDppNBVJ5q40WFTO7zqRGCzJ8dKIX
         TISWi0R84jOMhNqkaAbSUaM0l2pM5qfqQtnIlIoaJyU2t5uUxwMgJj1JQNIx9JqnNmCK
         nKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115522; x=1729720322;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=wG91YGfjewcZQKAgPv86VV1ra5N76IlGI66OLy7noshYBE8/s80bH/ILcafkAO588S
         /4iaNnMMtHCmNt/7q5OxRPABBpq12hSLazNzwW/sQRpqP9Qv3RxM2LoTlEntg0h7DL1G
         /5RLyP7ofaQiLCefi6RiaQ6Kjrk7gY9IOqa+4WEY1Gq/YSG38vqH+2xWgfYUIfXqMos7
         nzVVwimMN8GbTL6Pjv2XqT5jRr3M0+ph/P3qaZxoCziTFeZLL8yXn/7CRT60YnnZmI/c
         hmlPZnatDtzMqg00RQJUxMOPiDuuqNLJ5KtfMzHCJkMfD9g3VWe68v3OIUSepAWBEaMR
         n6fg==
X-Forwarded-Encrypted: i=1; AJvYcCWBdF1lfeWs8YTMeGephX/1/wNM0qorO5pYSoM48BEKgHYHyuL1WFDk8s/5JmpIAVHMf0g66cBZz7DX7zHGPS/1@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDlMRFZvobokLsveskf3elj69LIbAvS+ZjnX54SAZgB+SYRLG
	tLCtUJ/1dIdZLKoMxRAuPj6+ek6b0cXCEXDNrX3ItiyUQHxGH9sXnwwnYGyCgdOlDzN+5cg3pDr
	4Ky4Kvg==
X-Google-Smtp-Source: AGHT+IFCBcL2WI1OJ/qL8tTsZfu56WPN4fK7Lp+XqvP5F6nW8xQvXYG5rGEA97JIV3Z+cvI8Pf9Ow7NrHkAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:b204:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2978594b05mr2587276.9.1729115521830; Wed, 16 Oct 2024 14:52:01
 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:35 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 4/7] perf stat: Drop metric-unit if unit is NULL
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

