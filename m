Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4B3587CA
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470960; cv=none; b=KTJUXJqIbRKs4q19xYPAazIAnQYlhTuDq+6zey7LS8cOLHwqUOJniQsw2Ck1ZR+ecvU80QFkecz7A/qs68nbY7e2BhwDMVvfaYKCQYkPChREU9tk1LM9Xw5YwiD/w1wWpX5szhPA9JruAPA32paeJ4Fqwy7dHyPFFNpZ3BpPGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470960; c=relaxed/simple;
	bh=3kfszh9GvrFi8Y4HcNCDpFFabOoNANjoDq9+KWDc9ZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fRxUoyLu4FapRfngX7IRpCGKA8wA2QKuxmnKPCJ7G9zaaAAhUk/4Hy70VejoZO7cg42jbYQSoSRaIVn59ouOt8/mv8af433videhcDG/FGeFbsFUmFXOYEatK3NhQ9Zb+e2SOzHcjOrgfqJeXg1qbTWd8pa479fhan94Uk9s7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGDz71ku; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGDz71ku"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so2203715ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470958; x=1763075758; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=WGDz71ku5MjqA/ubNhzpLSQQneU2FkyuzlIzECa9P7HSKKkGl0deojofTB193Lqy16
         RGXNK0rq2NhBfjkpPJPVkZv18FUeHjfNGn64Nt5KM37dCRl3deBRzOvlPsJc3A6ESSe3
         gvlx50YL2TnwnBV21uUpURzLmmDlEytKsl87PkuSEyAYk3bqz26ETXjPexDiD/fZMT7T
         RXFZM4/kAXg0CQVmDNLYmzRwYuUixNw/LS5858YFn3UMx+zOuuR7owfpsI/xZpnP+cKo
         8mW+vB2SWkbeEFg9HeMJAnLzq1kvdRFyqonuAnxrkior1NONlaUmgtH8o5ysGL2I/2AB
         gRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470958; x=1763075758;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=jzn0eipTJVOzA3G21d9UjqY8+wIsNq6vZb3O+yYuh/wk+6v1AR/gVK009ilyQ/Pkxk
         NR0FF1rwbs1+xb3Q4ObbgqBRKEuHUn9gaqF72CvK9ss/pSFgWIUqbX/W1EKiU3kaFRdj
         1M3h+zPTrNNGGo0RFqOED/NKVwWjERh9Y7g4bEr21OqPKe4BBgIRj+MuXLQ8vZR+7B4/
         dK3heKCvQ0JD4ZNastMDTCO68RUl4tt1HiLdaI3JeFJvtVYb/jSaRExoS2c4MHYz/Aqq
         rBSKxDHVASOA+uAMAqgBrof0hGtY9fNy1UT0j02C/1B4mPh+YeMsDJWgLF2f9qSQHanZ
         9ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUt4wtaandyxE3W3rfRzgKjpqowwyGlBk296BEl81wRf7LnVmdP8Xa2ij9pq0Bd4dHbNkfXkw/3l6C9IfMOWg2H@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9SIe0CsKe09R3xnPamdmHNuU4KabrjKSZ4L/7W6yNqkZpzbV
	pCpdNZ8GzoxjMkxxHKPgae2Zck6eo+IyyaQF4AGNCEMMueFiGnoo3MUz3kK6YUKMYC0wJe1Uijz
	qv7roQWdaAA==
X-Google-Smtp-Source: AGHT+IGusCIzgTLNZfY2mSSQ1Usvy6ejq0IMq2fUL4lvimGrlWfdC7717TTTc5KiNRvFZvcE483VuMJlifRr
X-Received: from plof10.prod.google.com ([2002:a17:902:860a:b0:290:9ee0:e8cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:294:fcae:826
 with SMTP id d9443c01a7336-297c0478227mr15537655ad.59.1762470957691; Thu, 06
 Nov 2025 15:15:57 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:00 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-11-irogers@google.com>
Subject: [PATCH v2 10/18] perf stat: Remove "unit" workarounds for metric-only
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove code that tested the "unit" as in KB/sec for certain hard coded
metric values and did workarounds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 47 ++++++----------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index eabeab5e6614..b3596f9f5cdd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -592,42 +592,18 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 	fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
 }
 
-/* Filter out some columns that don't work well in metrics only mode */
-
-static bool valid_only_metric(const char *unit)
-{
-	if (!unit)
-		return false;
-	if (strstr(unit, "/sec") ||
-	    strstr(unit, "CPUs utilized"))
-		return false;
-	return true;
-}
-
-static const char *fixunit(char *buf, struct evsel *evsel,
-			   const char *unit)
-{
-	if (!strncmp(unit, "of all", 6)) {
-		snprintf(buf, 1024, "%s %s", evsel__name(evsel),
-			 unit);
-		return buf;
-	}
-	return unit;
-}
-
 static void print_metric_only(struct perf_stat_config *config,
 			      void *ctx, enum metric_threshold_classify thresh,
 			      const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[1024], str[1024];
+	char str[1024];
 	unsigned mlen = config->metric_only_len;
 	const char *color = metric_threshold_classify__color(thresh);
 
-	if (!valid_only_metric(unit))
-		return;
-	unit = fixunit(buf, os->evsel, unit);
+	if (!unit)
+		unit = "";
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
 
@@ -643,16 +619,15 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 				  void *ctx,
 				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
-				  const char *unit, double val)
+				  const char *unit __maybe_unused, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[64], *vals, *ends;
-	char tbuf[1024];
 
-	if (!valid_only_metric(unit))
+	if (!unit)
 		return;
-	unit = fixunit(tbuf, os->evsel, unit);
+
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
@@ -670,13 +645,9 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	char buf[64], *ends;
-	char tbuf[1024];
 	const char *vals;
 
-	if (!valid_only_metric(unit))
-		return;
-	unit = fixunit(tbuf, os->evsel, unit);
-	if (!unit[0])
+	if (!unit || !unit[0])
 		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	vals = ends = skip_spaces(buf);
@@ -695,7 +666,6 @@ static void print_metric_header(struct perf_stat_config *config,
 				const char *unit, double val __maybe_unused)
 {
 	struct outstate *os = ctx;
-	char tbuf[1024];
 
 	/* In case of iostat, print metric header for first root port only */
 	if (config->iostat_run &&
@@ -705,9 +675,8 @@ static void print_metric_header(struct perf_stat_config *config,
 	if (os->evsel->cgrp != os->cgrp)
 		return;
 
-	if (!valid_only_metric(unit))
+	if (!unit)
 		return;
-	unit = fixunit(tbuf, os->evsel, unit);
 
 	if (config->json_output)
 		return;
-- 
2.51.2.1041.gc1ab5b90ca-goog

