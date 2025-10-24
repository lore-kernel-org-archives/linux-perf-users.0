Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD134BA54
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328775; cv=none; b=C/rIx0m652p1tw4XUQXlqqNEiRGufxw0/iMjECj6AZyO0uOC3GS8eKofkU+Rz5dQv7Jxm9ZmbBjxVjaF8nTomi0Hez3+Dbs2U/YrXIVDNeOdQ/26C/yS2vxQ9anATBTdGSrYPshgEXmBubqcURAIWLKbZScBFrZ2eGmw5dGUTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328775; c=relaxed/simple;
	bh=BqNKmhYdLVVOMxSxOJ05Qh+AKv/HTqCJorm5Grxp6zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=goD2I2I9ywVMADUbVttXaHHQ/uiyA7+iWS9Ter4N0rjYIXS4o24DruhYWxf6+ueWtyPly98gQGa8nRUJFD5WYJlrtKVG1BDxzrcrt//wyqZmedeAAwKFbHP6MvHB3FhPujspWWCPX67T6gR9Rq5w7Q0CNNowT1z7e+P3H3PztYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4euEVdb/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4euEVdb/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso4973049a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328773; x=1761933573; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCPacSqb5S79ptlAfnfLDbabLvPXVS08f3+jSVTqtcg=;
        b=4euEVdb/LrdS6ac9gwLpNgna+PPsM+HpYe0et4sw8KpGXCnIgzgCNvzV5uY5kKHt+G
         w7P0PKjo+tAeo5ksRBekFIrielR4MXteHeDHVdcZe1mdjBfbhEDPDP9vESw8RmQUtdyc
         HXlk9TLs+CiNiqKoGQdAnHrDz5Y2fES8bQp2ydViqUi2lKdVaj143l+ME911BnXKwjv5
         YYeJ0YWYXYoMUqKj5orq/8pFTU9ijXvEXySGz4CbAJOC18BDHkYmLHoLLzN6SbpLsuW0
         fL59EH8BjQw3FU2pHAxw0QOyaB73jEifbClYPHj+UodfcWfL3KzokyLjtj8aQjSXzbXE
         hN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328773; x=1761933573;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCPacSqb5S79ptlAfnfLDbabLvPXVS08f3+jSVTqtcg=;
        b=hhc0L2z+6urzjj9AU3wWIh/wkiNMsjuMhpsy9zH2onAA315X1NQSxFMgEhJVMiBb6u
         eWeEDpXCTU3H+Ham3RlBD43t/GyPvie2TtJ19NBe+LQlMB7KuGbVLpx4J3mkn6eCOprS
         OaSrI4VtzhNCDYw2J3pqoGgt9/unJbb/QTeIv6i6GqhVNy/BdLhnvbEmA/l8wCxL1HNn
         FXRCC7zhWLbQRiWEG4d1mE3FVtxucSGZoYbQGYM6z+UohJBhOxvP4bxVhoh7OB7ASDqm
         +rXcjDsGlY3KQoY5sK0rRXefyesYYcqijv5d6zUw/isJ54mCmbLumVDIwAQFtiOkayyE
         WWng==
X-Forwarded-Encrypted: i=1; AJvYcCW7dGQ0toGI4oteHxAW716LBX5FYD2vOnLZvueLs88kA7p2+imu+f+NdjiiyRMIeiT73QQYv3xeHBbRDPSDEQAk@vger.kernel.org
X-Gm-Message-State: AOJu0YydGtKh/kWLdsOai+aJnCFaLdwogEbw/ab4mz85gJadf1hm5jh3
	5isYUU4B7D6SqAXVYh06Zaz40cfo6EMrkGDm1ja63y1LOfPggA2H6wVLLHxuyxRGaPbderXSLWf
	PfWgz5zYOew==
X-Google-Smtp-Source: AGHT+IFK0u6JY2sQK+J+PSCyGOXlBWsHHnuv48u/sSFbbHB8oDEd4cACgo0M8Xw0uOhqqHeHuKQoxiCdKIXH
X-Received: from pjyj8.prod.google.com ([2002:a17:90a:e608:b0:33b:51fe:1a8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc4:b0:330:6f13:53fc
 with SMTP id 98e67ed59e1d1-33bcf8f870bmr35826864a91.27.1761328773449; Fri, 24
 Oct 2025 10:59:33 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:50 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-16-irogers@google.com>
Subject: [PATCH v1 15/22] perf stat: Remove "unit" workarounds for metric-only
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog

