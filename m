Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9317A5A5
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720864; cv=none; b=mFGdqW5xvNjU1XQN4EMlBoLUqCadat85w5kT8dsMSvq02RD7c/kfHS65qDRkPhf/kh9g4py2rnkaGb2bquanwWLwQGut2FX6NJ8LgAFuuhFnQGIkja7j2YEBgvp7Qq2FEFxxWu4CGrabgYcU434pZwrI2m+X7gPb7nuj9tIY5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720864; c=relaxed/simple;
	bh=voKswfKfj3xVUdanTG/Vv01I1kScl7Vgd1gUmqiYueA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bb6fTIprsLBkH905sYXjD+5S6CZWZoomitMJUxxayNpj/j4AfOqX6wKAi6/DUsf1ndd6uMXzDUwa0t3A8nQfUmSwJ7TJMLP4nBjnVDwfyP72ikjMSHI25NwhgbxDDU6U0K9WZdKiJjBH5HrngltzZk8waX/E8M27sIbiIiYxf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njjrVgWa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njjrVgWa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-651a0aa7463so18944977b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720862; x=1721325662; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt616h8hRCivHeAdqJzIY5ztVTyVV8Crah5Wq3Zf1UM=;
        b=njjrVgWar1PupsOHTA9f4dyQsKwtocH1cP8j0ptvkmjcQ+awOX1prnKnHPayGPzwJy
         EXxvsilQA7/K+9tjnCXJKvqsxukLGmLqjjEupSaMWQfP7eNC1IzTNiQiRNBWRzPXtQrp
         qazr0vvZ85UrevU5UjyrPeRool9O8Q32aF0yJ2YCtgEIYJEI6In66W77ospxE0bBHN2n
         nxVKq9G2EZwwx2k46OLXFsnUAQKFUWysTCcG8QkOf4U86kAmw+dnW9DNjsVACp9MMHge
         ntBV1zq0ioz8gj90ZTIqqFYlx3SHmR1KWd1mhvbsN0DbvuuHPW4p1QZYAFhTh5jM9ma+
         WpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720862; x=1721325662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt616h8hRCivHeAdqJzIY5ztVTyVV8Crah5Wq3Zf1UM=;
        b=RrSFew/ELgRSOga8PjQHeuYCBgdl3k/GCm1pkF+wl1SCSZNhgslqSVZjK6esRhJMra
         vJiWk0B8fUNmpOAU4Qi/SSl3rK8uKK0ng4nnRmjdjXjM26IWm8vKF1srtU/RbUfqZ8hR
         /wf9IDBLQ7cb3M9SMlGLVzc6lQnb0oglaYoyxofGkM+LmZQ62sZB/nsHEMyEzuvp+0nM
         zf8aL4DOIH/UxoHowXNWkELzFOUy5F0MBo33x1Blo3M+QReDeLUdSClD6/uPJBv/STVI
         izyHAAfk9TNpBEWVOPyhF7en7WfsBb7YxF82aKudpaylSXiNcxbVdWvVnV2jfFEzJ184
         F8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHOCGUKnhZy2g8HlL2hDwKZVAAkmaooOwktJaF32I4Qmxs4ptWpC4e7SHh2v/+uLhFRdEPGYjqWr+Dgo0wbJayI6NoE14d27Hsk0wXOyngqA==
X-Gm-Message-State: AOJu0YyJ6LxQgg9jJnOVzAUGH9rydECwd8adIRyzyYYs6Vl/9f5YkOkP
	+V9hrtNZmaaryOogDLd27Db5s4Ac1tmjHTcnKsFJNUeymfmzqHjfce2y89oPl9zGNlqe0CTCwyE
	DS5caRA==
X-Google-Smtp-Source: AGHT+IEX9oO7/QxRJKOh3p4hGI/yZCLEqpz98Pi8rexdVxqsNShjq1Lvluub4NnTvVJr1wr4NjxC6/p3kgg0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:d17:b0:627:dd6a:134 with SMTP id
 00721157ae682-658eeb6d6demr1963327b3.3.1720720861856; Thu, 11 Jul 2024
 11:01:01 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:02 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 22/28] perf diff: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 4c0567882a7a..28c5208fcdc9 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -467,21 +467,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static struct perf_diff pdiff = {
-	.tool = {
-		.sample	= diff__process_sample_event,
-		.mmap	= perf_event__process_mmap,
-		.mmap2	= perf_event__process_mmap2,
-		.comm	= perf_event__process_comm,
-		.exit	= perf_event__process_exit,
-		.fork	= perf_event__process_fork,
-		.lost	= perf_event__process_lost,
-		.namespaces = perf_event__process_namespaces,
-		.cgroup = perf_event__process_cgroup,
-		.ordered_events = true,
-		.ordering_requires_timestamps = true,
-	},
-};
+static struct perf_diff pdiff;
 
 static struct evsel *evsel_match(struct evsel *evsel,
 				      struct evlist *evlist)
@@ -1959,6 +1945,18 @@ int cmd_diff(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	perf_tool__init(&pdiff.tool, /*ordered_events=*/true);
+	pdiff.tool.sample	= diff__process_sample_event;
+	pdiff.tool.mmap	= perf_event__process_mmap;
+	pdiff.tool.mmap2	= perf_event__process_mmap2;
+	pdiff.tool.comm	= perf_event__process_comm;
+	pdiff.tool.exit	= perf_event__process_exit;
+	pdiff.tool.fork	= perf_event__process_fork;
+	pdiff.tool.lost	= perf_event__process_lost;
+	pdiff.tool.namespaces = perf_event__process_namespaces;
+	pdiff.tool.cgroup = perf_event__process_cgroup;
+	pdiff.tool.ordering_requires_timestamps = true;
+
 	perf_config(diff__config, NULL);
 
 	argc = parse_options(argc, argv, options, diff_usage, 0);
-- 
2.45.2.993.g49e7a77208-goog

