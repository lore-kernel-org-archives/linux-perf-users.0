Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3B3043DC
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316570; cv=none; b=Kn+ks2ykuQ8WDH0BIcRj3v9xCtxGrtjtBGr+9p6jAdZMy8B6FAk2Zzg8NFntLpL5SknHyd2Ni6i45Ygdgs3kUUhhoys8Tm29N/+l51hXSQm4Wi6yYy02piu39SURZAuOR8XHHrdg+JE3RfCoMFZkwD8Nb/hJcxeJ63C9GdsX1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316570; c=relaxed/simple;
	bh=lD1+OFpB1OrjKxsvRZVK0L7J7pnTjwUFT0jTzwfjn10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pRhBp2KFcUciKkq6P01WS7vb+J5mjKe3hoiC/HJkDXRsQoBXPbVWSKK0NeoBIXUJywdoP06MI1JOqOUxGULozkTX66F8pzXFNz8kMcIYkufv/d3xeTBLNDSMcVdtbYyIW7S93t2BwmxKPsJ4GGqPwp2C9ZsRKgFBGaPLlUd183k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8WddXYa; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8WddXYa"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124aa710af7so264850c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770316569; x=1770921369; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4O5bL7BZkrXx19I0WB1IPTeDdFzwyD7CNTQgiiqDJY=;
        b=M8WddXYaNpoYpFqRND6RbZPiO3zyYFBfxRvzdjeoRvBSMjpmP5uH1bN1xQObXKNXpa
         b+ELvzyt694dX6t9stGWmF4i1hOEBtnYam+HO+5mBpNQRVjt5m/HfiXoGhBWbKsC450q
         6ERnIVe7wEp8VpeILcdDCGy3g9zFkIx6SaJUzhKXRqy/7gzmSdnzX2Ug1/ZSF3leFKT7
         gHvG18CDVryeaW+EhOKp3Zirrd/RHd9SPTJHVZHkeG2UhISBgqjv6y2Sd6j6XWgsqU+z
         vDvHmwNGwndQ+GjgtLUvxS5+5LADhfFu0hIrQJlCK/Dp0+Pw6NpPOwzZHrzBIxrjtfwC
         1QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770316569; x=1770921369;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4O5bL7BZkrXx19I0WB1IPTeDdFzwyD7CNTQgiiqDJY=;
        b=F2WtKoOKiKj8rbV83tJMUxfcKHiyBmbzZb5NDag4HLDEnRdsoBzdaGZj3lBac0vxQY
         yrS4ZWh1KRoajMPk18FryAXYCCpjB2jgVF6fJYCHYMlYvLF4SqcT+A+kgSJQEToqyay2
         TLj9pRZp6elrvmxWZLvPU9MFaBGgq3jq1QO54PI2SVDK+v6H//PUGQYxiHlRbSRa3pd+
         DD1nEsRteZBZvjIS5Qe0QMAOytQ5SwirKTXUh5V9AEXaz9st1GxrFza/j9mhXCsjZvir
         LyBXdfaJoim1BLBQWJt/JtQC8I/lK2SQLJ3gjaO9wAGYWAjj7zVH0Bj90MOuZbGWHrgq
         ZHsw==
X-Forwarded-Encrypted: i=1; AJvYcCUmyLDwj9H6uPzVgqGSKGYtOBk7wNWZw09onvZ+OpbS6nFQkJRrMhd1qyNj3hPomJ3ZOgtw03IRSQHyfit4UV6U@vger.kernel.org
X-Gm-Message-State: AOJu0YxELL1qIkXtWbTxIpDKZCDJ8Hat5qHe9oRZpEnuYeDaArBMCI71
	JDazaxuBwTFhfoRu+QmKciAvVeH8YzUpww7zspkH3uOrUTmoAEp0HzlI3B04juJcAT8Pgru3fzw
	zU28yMbtJwQ==
X-Received: from dlai11.prod.google.com ([2002:a05:701b:270b:b0:120:56a0:1dd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6625:b0:119:e56b:9580
 with SMTP id a92af1059eb24-12703f72774mr102840c88.5.1770316568863; Thu, 05
 Feb 2026 10:36:08 -0800 (PST)
Date: Thu,  5 Feb 2026 10:36:03 -0800
In-Reply-To: <20260205183603.459363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205183603.459363-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205183603.459363-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf metricgroup: Don't early exit if no CPUID table exists
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The failure to find a table of metrics with a CPUID shouldn't early
exit as the metric code will now also consider the default table.
When searching for a metric or metric group,
pmu_metrics_table__for_each_metric considers all tables and so the
caller doesn't need to switch the table to do this.

Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on default ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 40a1e14de418..46bf4dfeebc8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1562,8 +1562,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
-	if (!table)
-		return -EINVAL;
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
@@ -1601,22 +1599,16 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
 
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
 {
-	const struct pmu_metrics_table *tables[2] = {
-		pmu_metrics_table__find(),
-		pmu_metrics_table__default(),
-	};
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 	struct metricgroup__has_metric_data data = {
 		.pmu = pmu,
 		.metric_or_groups = metric_or_groups,
 	};
 
-	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
-		if (pmu_metrics_table__for_each_metric(tables[i],
-							metricgroup__has_metric_or_groups_callback,
-							&data))
-			return true;
-	}
-	return false;
+	return pmu_metrics_table__for_each_metric(table,
+						  metricgroup__has_metric_or_groups_callback,
+						  &data)
+		? true : false;
 }
 
 static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
-- 
2.53.0.rc2.204.g2597b5adb4-goog

