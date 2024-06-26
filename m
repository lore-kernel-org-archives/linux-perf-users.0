Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDF195FD5
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434243; cv=none; b=rzfJRskh8fxlFlDSO0TMUoO/zgTZ8du7YvS8Xfk2kBsIyph7PoDyAQ8igYCkZ5MBgTGjAygm6SpLEXMjGY203hMozJffW+XimahHYcJtFt/EYjpNYLSj4pMgIZXl805HT0n7UbjYRKcqBzmF6IWwJOw3+j6ZMYCdejppDjhFXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434243; c=relaxed/simple;
	bh=p9FimwsA8nPd48DhGiskfbVWvAqnuMjqgwp7sG3YyCI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=huvTwNbDx5zMDrs7NPKAzUEjgXNxu4LIKOQ4eDtmZSuI2zm8bQKvVFxY2VevVug8Qqa1Fjn+sBuuRkhC1cebr1iRFeezarQiHGsdpy5DLRmxvVl4KK25Q/5ElD2Kum0g5VarqXV8zetV+ehj/6hRYmAKIqrVBrYQPybDKDF+nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK6+App9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK6+App9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62cf0ed7761so11325457b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434241; x=1720039041; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noJh/0tjGkNOuuOrbqQtPJsWH5lRqwZr7bjDIe61TeY=;
        b=AK6+App9LxqCSmvmlt+bwOtcZbat2YFXee4EKciOtTUtNj1y3iX2PxJ4EeOiFD1QRP
         PBGE7DI0LJl7y6vEiMitudAOXs235jADAFWKBBF2Q7WzvUyALstI088IuYaNskPGCphF
         VhGsWt5jsgXe86Bb97A1/tX0Y+U7crJMfWLMGQln60PttIUyP7M3T6q1LGCMPnVx01a9
         PwvwtKW8Toz0uzSlCJ2hSY3x2kO3y29oLk1L6sRSx/RqOIUAFZOELsYrSpcft8cEm9CJ
         LXkOz54mndP0bqlsvTNm0zwnzkTk6cuygpj26VYvfXCFelgPG/30hLEuTWzc1pxTi1Hv
         AjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434241; x=1720039041;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noJh/0tjGkNOuuOrbqQtPJsWH5lRqwZr7bjDIe61TeY=;
        b=skqDCnnlwBTzUptJ3TZUmRo6xADSeSnLjlhe5dzslWAtb7mGAE30azEzCJlxlWX1+Z
         1RwvRhQT3K3RFaVXpAu5OHzqSzkoJPUMoSH3cdDNVcvzXjZJMBEjiu1xQJ8hPQe9Kdw9
         rSgBDENKR4LfkvJ6/WtfM+/V3xnohHT7I5NIc30axDY9Ryax5Wp6tQjHJyrS/wppLfGY
         x2Vhp5QLxDPEaFdrT8ENANdUs9TcE1uaqfZil0dWyXHDk3pwsTfcQwqU3WbCwpgDIdhb
         FJAVuDy3RkvPsexgKTrMQbZ/o0CZS9hTF9ZrwctrXfMldJeOuYD9UpvblJpNKGuSVs4B
         y4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWCyPzBg9FvLOwjYTm0R4q5rD7pS4uJstmh8arjeR9r/dnlr/88MEKJvIF2speQYFZF3mb0IkOyUJAJvkZDG8S4CnP2SYD5ioRcY2onys1a4A==
X-Gm-Message-State: AOJu0YwRBy+vx0GTpnWPzja540rYAiP9J8fbTlR+wueYQaH0UF1VWnAh
	B3biEhF1+33bsESFm/F+opbkMflZoF1SQFxtEB2JEl1F3BwkK8crZv9VPZTFh+yQ+/2+qELb2Tl
	McVXx6w==
X-Google-Smtp-Source: AGHT+IGiGW+2TJjLsVxDfeBzcOXXY+C6/W3uoEMYOZ3zt3pmoGji/Ifg/sPaursww2GTCUQox0G8p7+0iMLD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:ad0b:0:b0:e02:7c5f:e0d5 with SMTP id
 3f1490d57ef6-e03451b46ccmr89276.4.1719434240611; Wed, 26 Jun 2024 13:37:20
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:20 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 18/27] perf sched: Use perf_tool__init
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
 tools/perf/builtin-sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2d24250f60fa..2b227b01d64b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3013,7 +3013,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3511,14 +3510,6 @@ int cmd_sched(int argc, const char **argv)
 {
 	static const char default_sort_order[] = "avg, max, switch, runtime";
 	struct perf_sched sched = {
-		.tool = {
-			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_sched__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.lost		 = perf_event__process_lost,
-			.fork		 = perf_sched__process_fork_event,
-			.ordered_events = true,
-		},
 		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
 		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
 		.sort_order	      = default_sort_order,
@@ -3635,6 +3626,13 @@ int cmd_sched(int argc, const char **argv)
 	};
 	int ret;
 
+	perf_tool__init(&sched.tool, /*ordered_events=*/true);
+	sched.tool.sample	 = perf_sched__process_tracepoint_sample;
+	sched.tool.comm		 = perf_sched__process_comm;
+	sched.tool.namespaces	 = perf_event__process_namespaces;
+	sched.tool.lost		 = perf_event__process_lost;
+	sched.tool.fork		 = perf_sched__process_fork_event;
+
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
-- 
2.45.2.741.gdbec12cfda-goog

