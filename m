Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898E6F2E8
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264472; cv=none; b=Y+hjT+ROLwysG4ETZ7h4/h6lFrCKTgvdj3JZ+K9ihTizOi41IDbwC0hiUexWu3JbstOvO+FcwoU/yLv0dCnIhQ1Ho5B8f0mGFJLujx6Xg+yNqhNEvBfBg03q8HR0W1kefvtuQG1RkJ+c+gytdahPJhAPCtR96kONch4e8QuUHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264472; c=relaxed/simple;
	bh=ooLVBh0y1TjTeQLVc1IMKMPYr1fiYJWWWYFVwgoiAr4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RH7FhyqbNhFGz672nwYpFWZ1qcY73gxpZypfdsfpHDEgx1WiWuIlLTvPG2qKzJ3Pj0lQsob7Cegm99ymNIxhjN+JJcCI0SB+vSyJ3MPTJ/FQNwTJzYuzU8vQf6cPYgSH45FlsGKs5UVd/TCTGiZW1EoQPtuS8NgMLG5AchB424g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZov9dd7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZov9dd7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6524309be45so6654817b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264469; x=1721869269; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3n+jIbMDyTv9OsUu+Yn1PYjr67tOBgDw7h0k4Rcb5A=;
        b=AZov9dd7PwRFoH+wcL03JGmKJBjHiIbYBagrnIJSPHMwkaOYu+KckBaYpL9TbpHqMx
         IjDulWzCPaJgj6b/w8Jbs1nQXZejNuFJA1h+mhr0I0FRg+j8swkJl2HhT/oRxtlVpn0L
         ISQqJ2Tok3EXgrLpw8XjCooW4/lN+YquWZQ3CeDQ46vAJ+5tOSI09rkeckyIln35z43a
         q66AkV+qBzwWaouQeiPry8Qon+KAME7mlIbXWWi69W/U/MhdFwD/ZyY7dNvWAduZbq/8
         ypEHtORlBByA8maBjHloK871MmZYs1X4pkcykMu/626pZRJbi9PjWXzJkRlvscqeOJHR
         n9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264469; x=1721869269;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3n+jIbMDyTv9OsUu+Yn1PYjr67tOBgDw7h0k4Rcb5A=;
        b=NNrYymSGDbmPaA8YoReCbuNLCplySSA5mfSRDPU+PvUF35+J5FwYEcbcrF5oIDjOaZ
         7YHNYFX85+dlRfipiczLdrUUuv+eGqV4OBdT1i4HWfcI2FBfwVxy872ELYn3KjGz1xNJ
         QEq+VzjOsL0jimKsVxbtx5trqMBbOUy7MIudeIexy74ftgI8poJV5sqeVpjnOUZ/J7+E
         GDRmyU5yyp3xy3Ixvg+U28dkQKsRzjHF3+fiShJpl0i146D5T1pphvkMQHTBm48RXmZn
         aSpRHJs3xqV2rGI5SPb6H+tuP/hYFg34Jl5TBKQoR6Xe9UwuImG2jr3WaigSd9UnSlUT
         qcYw==
X-Forwarded-Encrypted: i=1; AJvYcCU0JNuXjoN5bbC+U9CNP+WeuZ5LmR0RcPAYhpw+t1J3QVV3erztMA2GaRf6II5nj6Cf25cjjJp4l9s0Ce7/JCSp0oCQA33BVh+wsb8zaCIhHA==
X-Gm-Message-State: AOJu0YwSnmoAA/PveV0HeyodR8P6wbDnbaS9Bo0vlQOjZXJDWIVPIpP2
	WQO/SCK19ygHdBO6+QzsS68U2CMtyKNvd1OOYkPLgrnObBwEtPh56/a8vtuLkIrtfh+M56OeMiN
	FbvH0gA==
X-Google-Smtp-Source: AGHT+IFlQGqFOHeHMR/DGL+G6fjGn0fdEKvd5NgFiT0bl+zqTRXmSKSTl9yhxhzwBha6DARQbLlP2reD5spx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:e05:f6ba:1982 with SMTP
 id 3f1490d57ef6-e05fe83bfd0mr6992276.0.1721264469346; Wed, 17 Jul 2024
 18:01:09 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:10 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 14/27] perf inject: Use perf_tool__init
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
 tools/perf/builtin-inject.c | 89 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index be74e2bf1f00..2866756d5060 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2165,46 +2165,6 @@ static int __cmd_inject(struct perf_inject *inject)
 int cmd_inject(int argc, const char **argv)
 {
 	struct perf_inject inject = {
-		.tool = {
-			.sample		= perf_event__repipe_sample,
-			.read		= perf_event__repipe_sample,
-			.mmap		= perf_event__repipe,
-			.mmap2		= perf_event__repipe,
-			.comm		= perf_event__repipe,
-			.namespaces	= perf_event__repipe,
-			.cgroup		= perf_event__repipe,
-			.fork		= perf_event__repipe,
-			.exit		= perf_event__repipe,
-			.lost		= perf_event__repipe,
-			.lost_samples	= perf_event__repipe,
-			.aux		= perf_event__repipe,
-			.itrace_start	= perf_event__repipe,
-			.aux_output_hw_id = perf_event__repipe,
-			.context_switch	= perf_event__repipe,
-			.throttle	= perf_event__repipe,
-			.unthrottle	= perf_event__repipe,
-			.ksymbol	= perf_event__repipe,
-			.bpf		= perf_event__repipe,
-			.text_poke	= perf_event__repipe,
-			.attr		= perf_event__repipe_attr,
-			.event_update	= perf_event__repipe_event_update,
-			.tracing_data	= perf_event__repipe_op2_synth,
-			.finished_round	= perf_event__repipe_oe_synth,
-			.build_id	= perf_event__repipe_op2_synth,
-			.id_index	= perf_event__repipe_op2_synth,
-			.auxtrace_info	= perf_event__repipe_op2_synth,
-			.auxtrace_error	= perf_event__repipe_op2_synth,
-			.time_conv	= perf_event__repipe_op2_synth,
-			.thread_map	= perf_event__repipe_op2_synth,
-			.cpu_map	= perf_event__repipe_op2_synth,
-			.stat_config	= perf_event__repipe_op2_synth,
-			.stat		= perf_event__repipe_op2_synth,
-			.stat_round	= perf_event__repipe_op2_synth,
-			.feature	= perf_event__repipe_op2_synth,
-			.finished_init	= perf_event__repipe_op2_synth,
-			.compressed	= perf_event__repipe_op4_synth,
-			.auxtrace	= perf_event__repipe_auxtrace,
-		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
 		.output = {
@@ -2269,6 +2229,7 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+	bool ordered_events;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2333,7 +2294,47 @@ int cmd_inject(int argc, const char **argv)
 		if (strcmp(inject.input_name, "-"))
 			repipe = false;
 	}
-
+	ordered_events = inject.jit_mode || inject.sched_stat ||
+		(inject.build_ids && !inject.build_id_all);
+	perf_tool__init(&inject.tool, ordered_events);
+	inject.tool.sample		= perf_event__repipe_sample;
+	inject.tool.read		= perf_event__repipe_sample;
+	inject.tool.mmap		= perf_event__repipe;
+	inject.tool.mmap2		= perf_event__repipe;
+	inject.tool.comm		= perf_event__repipe;
+	inject.tool.namespaces		= perf_event__repipe;
+	inject.tool.cgroup		= perf_event__repipe;
+	inject.tool.fork		= perf_event__repipe;
+	inject.tool.exit		= perf_event__repipe;
+	inject.tool.lost		= perf_event__repipe;
+	inject.tool.lost_samples	= perf_event__repipe;
+	inject.tool.aux			= perf_event__repipe;
+	inject.tool.itrace_start	= perf_event__repipe;
+	inject.tool.aux_output_hw_id	= perf_event__repipe;
+	inject.tool.context_switch	= perf_event__repipe;
+	inject.tool.throttle		= perf_event__repipe;
+	inject.tool.unthrottle		= perf_event__repipe;
+	inject.tool.ksymbol		= perf_event__repipe;
+	inject.tool.bpf			= perf_event__repipe;
+	inject.tool.text_poke		= perf_event__repipe;
+	inject.tool.attr		= perf_event__repipe_attr;
+	inject.tool.event_update	= perf_event__repipe_event_update;
+	inject.tool.tracing_data	= perf_event__repipe_op2_synth;
+	inject.tool.finished_round	= perf_event__repipe_oe_synth;
+	inject.tool.build_id		= perf_event__repipe_op2_synth;
+	inject.tool.id_index		= perf_event__repipe_op2_synth;
+	inject.tool.auxtrace_info	= perf_event__repipe_op2_synth;
+	inject.tool.auxtrace_error	= perf_event__repipe_op2_synth;
+	inject.tool.time_conv		= perf_event__repipe_op2_synth;
+	inject.tool.thread_map		= perf_event__repipe_op2_synth;
+	inject.tool.cpu_map		= perf_event__repipe_op2_synth;
+	inject.tool.stat_config		= perf_event__repipe_op2_synth;
+	inject.tool.stat		= perf_event__repipe_op2_synth;
+	inject.tool.stat_round		= perf_event__repipe_op2_synth;
+	inject.tool.feature		= perf_event__repipe_op2_synth;
+	inject.tool.finished_init	= perf_event__repipe_op2_synth;
+	inject.tool.compressed		= perf_event__repipe_op4_synth;
+	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.session = __perf_session__new(&data, repipe,
 					     output_fd(&inject),
 					     &inject.tool);
@@ -2372,7 +2373,6 @@ int cmd_inject(int argc, const char **argv)
 		 * mmaps. We cannot generate the buildid hit list and
 		 * inject the jit mmaps at the same time for now.
 		 */
-		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 		if (known_build_ids != NULL) {
 			inject.known_build_ids =
@@ -2385,15 +2385,10 @@ int cmd_inject(int argc, const char **argv)
 		}
 	}
 
-	if (inject.sched_stat) {
-		inject.tool.ordered_events = true;
-	}
-
 #ifdef HAVE_JITDUMP
 	if (inject.jit_mode) {
 		inject.tool.mmap2	   = perf_event__jit_repipe_mmap2;
 		inject.tool.mmap	   = perf_event__jit_repipe_mmap;
-		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 		/*
 		 * JIT MMAP injection injects all MMAP events in one go, so it
-- 
2.45.2.1089.g2a221341d9-goog

