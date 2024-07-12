Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000917C7C3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807972; cv=none; b=rUQC5tYS6XFUUzGXN4fu6bE8u3qokjD6a6x/LhCbh/ZtLC3a8qpYAyyF2KGeW9Q03WOCiaccmH+zOAX2LCteHLJWbHRLp+0Hop2S943TANnDlT+yo2yGxkENRcnxfLJeH9EIvS6Heb9DFiko3SHmiIRigeK1PsdAOUM4ANqtTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807972; c=relaxed/simple;
	bh=D3YBUpPEwBmyis+zCkqbR93QP3d0FEANSJQVPRT7Pgk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dUDQL2hEOuDqTqjc853/XHwX190vW4amruIIJRfo2v4zu1mAYBGGwoOlYrqJ2ceztS8cpoJV7mBwQZW4b7NJCYunQk/2Zapy0BkqCmDpof9bwvC3eKa/JVSdQvMUzHoccWnfZTzRZBB88d3cRXdewr82ktWVpO9FtvyhTAEywc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjU+BudP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjU+BudP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650fccfd373so36221727b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807970; x=1721412770; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfGB4qYIWwtakjvzGQZNS3+imagxPcgxRVJoCFymO4s=;
        b=cjU+BudPbZsBUSeaGHx5zaJTmI1KeNJHyNvyR9kWfrKnaDL+LwD5INDi3e2Qpt/Gr2
         CB3WEPaG0k9tCCNXJ+NwPKv1qkogToVagt3/bBcZZHvxsJqN5B4MGz3BnTqgoQETyPv0
         4vJypz5IUuuYGIdvqpgR3ohHHm05w2UDgwI0+vbe73eX/5r3hPUKpVV/4MXIsXxXRvZ3
         Uft3Aez9mMFo5U5264xkTza2/3thRI+n6qmlNe+WJdA5GN8p8OKgh/BKMN2u/ttQoPPZ
         gdOfF7I7n7coxJeAWXF3Yrbt2PxR6ZfcGPwx5xjts1xnuerL32rXTOoT4yKdreJpBAYC
         hZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807970; x=1721412770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfGB4qYIWwtakjvzGQZNS3+imagxPcgxRVJoCFymO4s=;
        b=Q9kzwx1wKNDtTpklEveda3DOicLdwfXGg90UOx7UYOE+aTdTYH2np8ND8EYw4PXVWJ
         QJsASrkHbSd5baMEdsVniR5q+WBBoOyEPLubu2p2P4Qy2Z6UWzm7tQbq8ciuzq7R2TZd
         zfhOvNUwz6DZp4gvxKxJCBfOcnSclh9qLn8NJ1GlMAA8PHMJSIKkExkhbrl/sLEtf7Fx
         ff8R1funrt4sbzfIZsaGZtlxatE22ZLYrid9DTSlI996I9eJW7Z909joV6w4Kz3drWi6
         TDqERAli8yAAKDIYUfyhgE6hg0s8WoXmeWRG91s+GJbreeQ0cdyTyqGIi7JBywdOhBeD
         /ldQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqTrFBVr7IqkDHfdxycL/a2cEk0Nus9E1ynB4VGc48G/DDiaOtfVi4qWUP4A4XGrMZP2+tfQuJPAqjWzhIUqlKUOHdm/B66TI003fxTqXFiw==
X-Gm-Message-State: AOJu0YyuiO2Y724A76580BmaIB1/OqEJdsU+veSY2rIa5lZAkVUu34o8
	3X9aNIG299pwVvoX+63M2T8BQ1JNLntYBgdB/DvWm1FtZsk/Fw/KdP4xe1uTJIGqXCPy7d++lkH
	rl58GHg==
X-Google-Smtp-Source: AGHT+IGwm97iX/hGe03hY3o8dBT3RVSvlUNVeKVGrABZ6gQou1GSxK9awtmr+31vBv1Cj2NXc9MdjmjFPQQ1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc4:b0:61b:e103:804d with SMTP id
 00721157ae682-658ebbb801cmr734427b3.0.1720807969781; Fri, 12 Jul 2024
 11:12:49 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:59 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 18/27] perf sched: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

