Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347F34C145
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833887; cv=none; b=ICK7eBuMt/EhWzuUbAEFXDQ6Jea8YeA4tU1dcLS0QrIJFXHxzrkJ1ufZsYVtvfR5SIaewdCTlB3uBkXmMPJS+mnzaHYlJxtmsEAoa16r2A272fN9xFVUmN1Y237UwTUSHDJGJcQWY6ihjjucNwullZ/75iqCLLqHQDVv6yzXteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833887; c=relaxed/simple;
	bh=3kfszh9GvrFi8Y4HcNCDpFFabOoNANjoDq9+KWDc9ZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jkZ+o0NDiuaX7jACSFQrwvw4rlbiRKkLBaYz01Uv3LMOkL8iKHMf8FpzwmmsLTTGUCTg5mfO+DOiq/0FiDTtPC0qkR5DiR1EfavdjySuVDI4PZkOqZjY4hVOgWMTovaV/RJZf5nXmuQySnrfDR4gbP5t90T9dxgrU6a833fUdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3Cy+iYw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3Cy+iYw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29806c42760so51139205ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833885; x=1763438685; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=l3Cy+iYw7wDFdkgGm4ZOVXDbymTf+r+hi+ZjpREjXkIc21KUTihrrP/mzXUX4hZmiv
         q9dVaexZmg6WTzF7BLwn9chVMddfflsd5aYuZYkHlZ+Ssm9eOoPue5RgZINkerKqddXa
         Hvjk8xlgbRrovEx2M3HWkgtBoI5KSyvtrdEOAoW8SHKAVDuwz+xjTL1h9uWfsiveApGS
         IKWm1sMKnxzisEZUq94TgBlwK6IvsS0TS8YfoZvO80cRLpZNlVoIoLXdCdIy28tMz08M
         fPIIEo5qSm1SO6cIEstoxq7+t7Ue7uF4HcTnumkzceeMhvjPryi7ZPl1srXLqRWBnWHH
         qwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833885; x=1763438685;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=qSvKjm/tD7iTsFZ9AzrxpOo/lwzoe8dnQ20jc1VbbRc9rDrhKjDhRlbREb34jYmYdm
         BA0YFL5YbDOnIqnGF+KiMi27Rh1XBr6WN0BAGTnOWGBgXEUYcIa4rjLfx88VQoVTiEFx
         hRkwG1Ys4LVLAi2svBMCp5I3Bz3oKzjPIIMrtHP1w6ZpLraPej72a9fZq8Eb3nNcSunC
         7fQAeMLIdbBqP/GNHu0QQKu/GoKvPzHMDEabq+rt8ZaI83L478CmIuCEFu292HXGLF/+
         oSr5iYODW4a3AKWYksSYP6kcNCruh/9TiCyn6WBVKGjXtHmoBRkrGb7YGL9W2N9+hWOr
         85Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUpktjPvKF+ebcam4qEg9NXix7cT4iP865uDPYQgmeCmQDNbVgho3VIT2OQJhTISlayYVASslUU78gZfKbtoR8c@vger.kernel.org
X-Gm-Message-State: AOJu0YyabFgxM5TvxdG5Kz92h8XsPGidUi+rBGCaVXrmPjmjcWUrqZ15
	N9sKY3oDSi+igiVE7Xq67sOalu29ltZ25QOwyFWWx1FYAa9VyyOLytSIXqxKx48Ipm0lmxDmRNk
	E50gWiFE+lw==
X-Google-Smtp-Source: AGHT+IFT1U0MlMaA4gQNz5KQzuVH4tab70rQutRTJR46tLMPWDKCUCuZI05XF/rgJDn4c5J837kdXrmVmuyN
X-Received: from dycme15.prod.google.com ([2002:a05:693c:240f:b0:2a4:59fe:f2fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2304:b0:294:f30f:ea4b
 with SMTP id d9443c01a7336-297e540a0efmr111599945ad.8.1762833884788; Mon, 10
 Nov 2025 20:04:44 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:09 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-11-irogers@google.com>
Subject: [PATCH v3 10/18] perf stat: Remove "unit" workarounds for metric-only
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

