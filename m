Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C5352F99
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896159; cv=none; b=jPlDiMYQ9181PJH3nA/ALXzP5Ga3BD736Pgy1E0b9pwkFSepYawsSaX9v5F3idMgc5icPXOvpBmw60AMseoS1gsCa35eW94pypfrWAl33VRFGpYtYzCcCZJurbz8fpNPws8CbQTpFzpDQ5NVvuHdncWjKPSv4E4mv9l/FkJr5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896159; c=relaxed/simple;
	bh=3kfszh9GvrFi8Y4HcNCDpFFabOoNANjoDq9+KWDc9ZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D7eFPFnU5P2pUtwjYEqy47OmquEfh+C9XhRmgrm8Dac8503p55RJp+8KJjs+wFYPtpqATLXs+oCxTYue5yEZ3rxfB/BYMn/o5r8R7j83MpFKKOJN7one3Btf8KtZnyfiJwYgEsmwrm1ZQ2VeLJgZDDkFuJ3yaTubEJCSFZBpSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPkkqJa1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPkkqJa1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958c80fcabso3382715ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896157; x=1763500957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=tPkkqJa1RtVY+zJAZm91C85lkpfy9l8PJwOp0LRwrAap3QF5Ol5CXmc4dXzbt3qANg
         iMTmuW3uDMr4GkTSk4AMFVPzH6CxKLEUzN0MWtC8puJBLvzg3XYXgoMcGeTwEoZGc+2J
         1F52egISSozyyzltroRbU0X1WjCLKF4H6PRqTaukf46aN81VLn1JlLgi2CUt/vkXTzma
         MmSmR9+DQCivWjYwl9qHylmvsbRQV6iZRMKl2Ai1k1SP0qap2YEzeNEjmrH9YEToCv1A
         nwXlm8u5s0MzWqlnu5XBWMNSKY3Teoh/owWWUQWEBjMjICbFzXse4/VvWWo0xFcUUtr4
         SyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896157; x=1763500957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=mRU7qTAEtemtTSG//RzRYxYoGG4PkfcoCxgPaYE4H+6v8bgYq9iLd18/aA0XKhpnrD
         6CPgNh3mZZBkAlYdPM+H3to7bxGQ1jp3+4PMX97a8i2md8u//HmbyQjrDXm75ZQlQ1gJ
         zr+ll9kNeq4JzfF1ySt6OKA/080FRQ6N3fjzzihZ359pb14gcPhYTLxIqSp7W3//jRWU
         +olooDdz91hf07NOanIAVgJ5AZKNWNc0S+MAJK8T6CoNY4/tcXn7notLcqMNAOesF+s3
         a0Yzg2OaVy3uQMwj9/Qh1VZpSYVxg8yzDPbAlUh9f9V7a+3DQbVu3WAk+DvG/dxikzPq
         u6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVzLsuChrsitkUaHNRxrQzPJUApUtKJbHvqtAzErQCa4rlSVkkz5+7vaFN92H4vYS9YIyS5o0PH7Jmp1ktcm+Bm@vger.kernel.org
X-Gm-Message-State: AOJu0YxLujkdgypwYSiFtvvvY2BHsPx/8k1nx2Ncrl515NETc6uyKMkf
	TtT9rcrh4KXEwtVeInu5BxS3IkRIG7+DZtE69ie1niTWVBrhMG73md5LAw4twxfOcaoRmRValG1
	3gS1DhVS2QA==
X-Google-Smtp-Source: AGHT+IGlvk0Ir0z2hQxDkU2feXx3djGCYRZJ2m1lMdgreqJokqzXuwUOkvWY6DU16C+um4U8SNaWHMk1RUxE
X-Received: from dlbtu23.prod.google.com ([2002:a05:7022:3c17:b0:119:49ca:6ba9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84f:b0:295:19e:487b
 with SMTP id d9443c01a7336-2984ed7a164mr8888875ad.5.1762896157019; Tue, 11
 Nov 2025 13:22:37 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:58 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-11-irogers@google.com>
Subject: [PATCH v4 10/18] perf stat: Remove "unit" workarounds for metric-only
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

