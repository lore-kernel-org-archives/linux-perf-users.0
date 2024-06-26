Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88249194AEB
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434228; cv=none; b=Mxuvtpd/WOmRUU52hb3nB1ISVKWAiLVDFI7wrHwYXSYusb6ny5lYFOadUY47VrDvMHb9jm1UefJf4pfnlK1QT+gJjVhDGlFbOWhauQ9ryBtxPTN2bZ6IyRhjImLn+qH9d5ujd3Du+qjQyJ6cqD9MpyU5eRE+bsSUQ+4MDvO/7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434228; c=relaxed/simple;
	bh=xTDdcKAsM0Ri5uMJZogx0bCMWjSncnIkrWNhWgEEO0w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qa5rUPn/lCVRQ9XFDLv99DBUe81Lq0UhdoF2xmaYFmgdAOa6fZNQsOP6vETWhkyb73Z+C3R/BgDM/iSAmPtUUniNb6HWp0aZhOCz8EMD5R7/sGfPYKKoSeaZUic0fqy9XjDqNyZM8WxLucYr6BTgOifBSBcyTGDlPm8u43b/6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJR68Cu5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJR68Cu5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02bb412435so14996581276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434226; x=1720039026; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=gJR68Cu59FcANsr/UFKwJwonHx9jH42Gd9XwLtzXNDc5/M4sHJ+ccp1X/1wofCk5PZ
         x+t/PJshpTMZe0k7ajn2XtrouBf/95Iko+yqpVXAe2wfR/vXE6qcTpy10s51kmYTtb4c
         uScpttRhDDglzBQYY4lM18NYxv5VNidXLE7gB/skswqT76b/TSpxrNW21TfA9khH4//R
         5K2tARckE97LOrRIkV6oPjyjkS9xjY5XQlq5NAggCVS5Th/hKHKS+tNtGClU5MZlWB/b
         YwDeTWu0E6tGLcZPQNmwXUCYG2L6D681pIZXA0JDkDZhCxuSz+gCO3w58QnhTjelmGCV
         R3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434226; x=1720039026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=MiZ9KlY3ojHNScbZU82MAAjd8/e5d+pUQi06OQzwzfQvZ/qLNWDZ7EwXpP+ctUvo9A
         waheznHyUOBAlIw8l3DmuOXoYjNeNO9P61s5Nr3ZC1iqYkg0lqEBN3SzxBzChXb90+RX
         /PKXw//HBEUsdWjkkgJllAj8NqCmbxPf85NFVZzv1aeyhxBTKKrGmCpyKF9zUPqSP3/z
         SbGX4a3OFvQQRt1aKlbyBOTEw9nj/9BQqrHAMq5v5tqOf/Q+OGLjHx6h2prhnGYDEvU9
         9Zk7r/9aSX1R8ik6Abcz5+lLESnqiUOLAbWjpFqV8/uA6eqH2qEUH4SAVhNOYhFl+DMM
         SF1A==
X-Forwarded-Encrypted: i=1; AJvYcCXBbsRtdfb/BHWpUxnnpRleVIdej1sSawLNTpKalX5fZVTZrFmWMOi/q4onyWGbc4ihnPVtHaKOj1wqLLou7MUH9EyJ8y6RJpEkqE+JQOUwig==
X-Gm-Message-State: AOJu0Yw1RRCEarC9F6zmtameZFcb/mVr8qAX73AqwITXiGB0mtM85a6O
	aFqIb+tzb/jTio31q6e7iPerUSbIDAvohi7aJO/ssx5zl4MR/yo9+Qo0q/BPliBuTi6fs1zUAIq
	KDGEC6w==
X-Google-Smtp-Source: AGHT+IE4+2WDwaOh4Ud+JjaxVM0mGpm4/Kn91LBXC8OyTMn8BlzeCAAbjSSYQBawrYF1H1vHwId3MHU2iRRz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:e056:0:b0:e02:bdcd:3bd4 with SMTP id
 3f1490d57ef6-e03040e5ea3mr359356276.12.1719434226584; Wed, 26 Jun 2024
 13:37:06 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:14 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 12/27] perf c2c: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog

