Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57142837D
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264485; cv=none; b=NS3DqCGW87prfC2T0g2kDBJxVM27wQeCDZX29mOdIFH6feSLTCD1Xm+/Hy0XW3jxw5Xxf40iWhRttr9RbT+hlUvLQ1nMNSx+c3X2JGSJd8x2TKKxbEcO1q7l/JT6pddM1gJXZ2GkiodLvHBcFKfBiGzQwT87sNQxMH46ByylOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264485; c=relaxed/simple;
	bh=33Aau11uuNpJ23sq1I4eyTYUefvdpQsh49HkERecgwM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ed/64a0mT3VVo09UVZHt5U8bs+CiRwlB9QXW/DJCVYwPtE3uEQri60t9E9dHrfEXkhN/7GAkrjUanFnG7b8UqMyGFHXwNamm5rRz9eTUCF6kvVVnNVYgWi/2juhucqr9hFqbv5QBRohpwLjgAacHik/FJXK6dVJHM3zp5ab7Q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DxNbC8J; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DxNbC8J"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso717096276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264479; x=1721869279; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIDIj8ohh0nflT4KD3kHem3lEjHwYWuoIZyNVV8EfDA=;
        b=0DxNbC8Jhto3QHlP1uXLFskjKmhzhO3EswqdpyEE8DreTRwj66V+b+SLmQ3y3P0BTu
         35SOpY13hULFbdDUZpg/7beWfdA+7uikFnAQgHWmLH9zTMuGU+4Iils0ru9DqdP3lGu9
         KktHTeLQkI/afRVvIEz+Vv2tLfl05Ud5/yG9i0KFL6+HwWgsC7l9swQagIHXyhXcizrr
         ESXkxfmpAgfpoL9w9HwU7SAgExcnpSXiuRSyUzTz0U0so35cLZLJ1htgdezlmx98cipN
         hp+jVqh1ONGg9o2cq92kPHKj6kfUnxR8pGHpN2XbUg1PcX6MZAoloZlh1PyVzcRYb9d6
         JHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264479; x=1721869279;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIDIj8ohh0nflT4KD3kHem3lEjHwYWuoIZyNVV8EfDA=;
        b=UoBDxsusQ4eDGeQqKS3C6Q5GA4NHeIvw0KZHUrqa8u0UurSQiGJ+X6UeH2roVoWr5F
         hJ1PmtXZfYr45T9k+WCFYAVdc+0I5CkDrWsCZ7CrlxYPTHtOTvb3GAtInDFh9x8lcuRI
         PvzeyGe6QmEPDr8X655bAiyV1chPGZ+3F6gQmr7AxrN+I95JPyqDDDAKGzLFZ7QAQFMh
         SyrJ5tTfu+rS+4tUGrzl4vfmJyd40+G8dvV+g1fe+z61yW7Z1m2IW7+1IUeaRsBSPtq4
         vmpNxDXL65pmyPMpLxPbbGHzwRG5Rqa6oMPHom60gfi6rbfNpeG5vRmF8USFrIS5MHI9
         d7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWIcoeffcpI6vqAyBE922k9jOwgN7hmu16RWhjM7N4QqjjARsU8D7XN+5pawFf5yumP7SBeL5b13bBEYooMWlpkhZKpfKEkAoHHtMxdSNxAtg==
X-Gm-Message-State: AOJu0YzokpzZVJI68uAMetJaDlf2u+q062l8vNJJf6dhEqPf9NdaN15n
	WdyPK6JnPzRjrTCyVpChiMmaDhDg1K+3p5hUICbbvZc1ti/3pZGbmMn30wsayHZnxIpPmDJ9GfZ
	RMPIqdQ==
X-Google-Smtp-Source: AGHT+IE7eyYkV30IAuJJyVKolxf68gGRG23Ds+4kcgr2lLuAa9Klg1hxPx68W8tgqNMyLyGzarxdoaI7qyDF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:e05:a890:5abb with SMTP
 id 3f1490d57ef6-e05fea8885bmr27243276.1.1721264478691; Wed, 17 Jul 2024
 18:01:18 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:14 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 18/27] perf sched: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2c60bd3a8149..34fe8e540c43 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3100,7 +3100,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3605,14 +3604,6 @@ int cmd_sched(int argc, const char **argv)
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
@@ -3733,6 +3724,13 @@ int cmd_sched(int argc, const char **argv)
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
2.45.2.1089.g2a221341d9-goog

