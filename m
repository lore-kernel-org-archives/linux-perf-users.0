Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826480BEE
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636893; cv=none; b=mUCfDppYij7JlISEDP4c0tV86YHe6kdhpo06vz7fwNnfkPB3G2kS+t82cIMp2C/gh5hvbsNrQq4q6hGb/2WWGyTzdTzgfDAOt2Tx/Chw4olfyv0/bUwJGk0OiZPUGC4XBl12L+8KkYBcXSZcM9oTiCaCR/gMFneHN3+kNJaJLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636893; c=relaxed/simple;
	bh=5bGjenHzvkBdHGe1T3S6yuOWnmAgJsbPGbu6ZHogcQ4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=umJOORK/v/kSQLHT+TysY2lQvH63yHHdXcxClinhe2YYeZEWqkL5V+7CsksHY3ZeqA/fOprCTa82wYHare5t38+x+eWs++NoTpvoApZ7nkBGE4DC0Dm+yGVUFT9bChIlWWiVCq0kibi9lcy9wxhvyDegIReVEON5FONVfegBMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0Z8V8PK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0Z8V8PK"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63a988bdec8so20494457b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636891; x=1720241691; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xU2ePkaYwaxsMEC4nCf5nFkpnVScQ7Rq2Qy7spzAkPI=;
        b=o0Z8V8PKpsS5Z9zyTq7enMdY4wmZzRyA0rg38MgPNIo7XDYT3v3psjH9uiVJqweiWG
         ARE9h3IZWEeZXxAm5UVx6LK+ZwKMDxxGsIRu/cbEisrRljt6K96cxxjnGQGfLc58kkoW
         oMIhoCbTHAUe0rYoL8HLFGVHVEJuq6u1t6zoVpTa5YG8em2OGxK7T4DKXS2EZlGii/6z
         09UFrauQFyVoGZXkVrHpEU/AO5+tw8i/e+pksBxzwZTWXLQUCIJJR2NR4SJm4zQI/170
         sV2WxZS1pQizxlC1kr2suhxkq2MBOlYlZe+nESnUClOzms9mBK1CD2chuzLf+u0wu90u
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636891; x=1720241691;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2ePkaYwaxsMEC4nCf5nFkpnVScQ7Rq2Qy7spzAkPI=;
        b=n85ZOgR5Ffc1QJFwci+iDZGJqkpYZB463nv5jAi5HdeFVWntffOxFAy/qBgL4QJpjh
         LyF850DlA/+u8EMYi4QqXq96S1fxQm88onGQM6euXgztoUmFigfGqtctd2NWZDn3+OyA
         kxl/O7yYvX0QjRLq7usAV+aZ1+sQsi7PqaOpB9NL4qsu/tOZUANM8gLfitaBJr2NQEro
         ITuF/FmyIWWg9UDdhFXojC06ussXubNQC0TFfxypWt0PAaVDtfJF34WFjZ3FcqsRz4pv
         qIVzNPvqZFaAVxy4d0s7gqgUuA5avb/W0naAEYJ7WEzNJinpxVFVccpmAp/tRcAdij6E
         /1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWbTbMeAxwupAD2T8nqUD/KoJBJkjjqYXIMT3UdEBAk44/gZlF6m1feK0Pc4zIj5rpCRP4bJxTs73GWA/3nu9H4Sh4aMT5xvILpXydimXR0TA==
X-Gm-Message-State: AOJu0Yy0H+Uy971FF/grKkRlRPA/Ba3l3iPr4H1LoDvQX5CsYX1c+cXQ
	0l5WP7O3QgBnA3dh4HS8UkEOOyRfB3jQwc14I+OrEEDng+CWMpzWDYyaLFsIcnl5iF0x/tYMxw/
	jM4HPug==
X-Google-Smtp-Source: AGHT+IEEzCHRAXRjWuifRznTNR+xXUr1B6FYJ/XrEjcgKBjsRIQ7SVEp4zOMvCJbSvzApWprz+jwV/4JbeL7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:e03:2bfe:40c9 with SMTP
 id 3f1490d57ef6-e036eadbdb8mr579276.3.1719636890559; Fri, 28 Jun 2024
 21:54:50 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:41 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 19/28] perf sched: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

