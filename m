Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EF1779AE
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720857; cv=none; b=dyPSrQTbfsZIHCC30MdagQnhQIgXB8Uuk1JOzW++vJ0qQYHH4sHUgwS5XVaIH8dYCkh6M528AZ2OBo2p/UTJ6Xp4XLlJnyKnC5i5dzly8NlcIuEXlvCOCdXlcKbI18ktl+2uDH7Hi8miLwvgZR0xZa9k3q9DzsTkFj9xr+rMZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720857; c=relaxed/simple;
	bh=gNOBCSXUt6q2RNMyq4ocRalcmgQ3v89szoAVlhw4o0U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kRxQIVvNRfej5PbxGtOJrn78/IiY2cAOh3XuZPY9alBiMfdzUBYplf+Uii3dVTdVlljxd1xyA3vDe9bVLaDcg8ZMm/t6821Q6LwhYx81t2cjWFghyCxh8QjsZBQ9Ngr/HaHp850JGvDNsEsK9UhM2pSGjHQVv6qaYqsOrHQQ2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFafmqok; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFafmqok"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-651e54bb41bso17361827b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720855; x=1721325655; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2p7tcOr0jm/PV9j5iKk7FyAUNGqEU9AzkGnAwI7vp8=;
        b=pFafmqokiqHkISFYh02EMeeOysOU5/Q6voL6hfkkqvTAo4KCQFrWyAPQIBP7RCZFrt
         uZoujR2IYRXwLe8dil1UK1wWjKsntZJXqqpKaFdyGgW0HrWmo+m5vSDAZCoBLDT07DYi
         f8ymHSXCzBRIlug0H2YyWkcrvvmS7BUom5YpP2c6/II8o0X8vyHtQCTEMb38snT1zyQy
         qjOQBd4Tvm3/NF2nEuDBbgcpB+DrsMWzm7E5ZNVU7ohEGzVHCeU5FB8eopGC8f6feyq4
         BeB4/hp4a9Fj+upRU/2vbn19tC+L7yTTDdbRyksLtJ8VBx/2RkN+EwCAcmQox7Bkdqdx
         Og3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720855; x=1721325655;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2p7tcOr0jm/PV9j5iKk7FyAUNGqEU9AzkGnAwI7vp8=;
        b=SeUThw2x+1yksRiWU1aKCVDK9w/c9PNPoBz8DdcMXju6OmTuA7oCTxdjHNc7woqtKO
         NOsXQaQisj/xIPLW4NoSOysXAX0TJee0gbF9V+7bvxoV4d08Lzc2CLdbvk/chnYd37M6
         BkEBmuPJxn8LstXOU0GZOj9A1jCcrmUcszsOuGW9AL5OHoxbvv/hyLeDKQlfQ5LLcmC0
         Uli67TjgypRBntde4pWxFKtXV9Jdv76efnhlb81dHfboFZv/ko7tJzaPVzQzREtF6MiP
         UJJYbdsUv32KIYinj2d07gc+Rf3ta99rHDs8amegn2F79q+ZhML29A1FMOQ6jnUisWSJ
         9y1A==
X-Forwarded-Encrypted: i=1; AJvYcCXyS2AUSbSYQ26LRqPsQGZ58SLY2D+hed1MDU0bGJefh/hIEdkCZYOWn/29kHdWmk3eeGUT5VhRSCjsqFmO9vFKfuOcqMQXisfwGM4RtxigwA==
X-Gm-Message-State: AOJu0Yx+HlkEIqZlPqdlJco96qXR4/2DHKb6t+HR45qpPkOWaMhmwXYL
	XIoUK/S/HzpSnXnPbUpX8OxgmurgMob8yX+JdVQeX1Txk6ad2F20+5DwxKlHQLdKilCYBmMP3pv
	OBy2hyQ==
X-Google-Smtp-Source: AGHT+IErKn7vIcO/EMczv8pt4H8ZLfTYCzTGeuAeHkDtRqbCFgVHP61ZAZdJy2vh7qsOzMlOjPpLcCM9CM6N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:60c8:b0:630:28e3:2568 with SMTP
 id 00721157ae682-658eeb6df10mr472117b3.3.1720720854737; Thu, 11 Jul 2024
 11:00:54 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:59 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 19/28] perf sched: Use perf_tool__init
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
index 2ad28c49d31f..fe2bddd63d96 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3013,7 +3013,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3514,14 +3513,6 @@ int cmd_sched(int argc, const char **argv)
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
@@ -3638,6 +3629,13 @@ int cmd_sched(int argc, const char **argv)
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

