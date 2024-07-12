Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBD17BB08
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807963; cv=none; b=LD++9mpy+kB9jtcSGgj2HHwQRntZg4GakoyG3pYHl0x5i6bBEAYysuCbJftyM0hLkclF5Q7ExE7rZkIFAciXFERZVJppR13HowIFsue4tvxPEoRFNl2XCsFuf6KsPxuEXkO0uswY9lQToUu/Z+MkgFga78INQ2eqADUmUoKFp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807963; c=relaxed/simple;
	bh=4jN3iUFdg2T8oVK3z25P8DkRtidUU7UFK1/cu+ERcs0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kW279L0HOKJ8lvka2JUZGo4d2jDKlO/05Z2uq93qfYD9+YseQ+laFl/MFpVmREcDIzSTqSVYdH/wt8EJmH8cjQekkiDKo4ZT18MGskN0pR1BbkCWvWYBEd2Sq1bdjofqCOdAPM9mQlVAu/QKJzMKuuxtx2smTsqHLmmQAMCBmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBgUKvE4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBgUKvE4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6501bac2d6aso25817697b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807961; x=1721412761; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Ae5Vk3XcnDdaj5BKYKsQnIS/haF5dLJg944D3m7A54=;
        b=lBgUKvE4d54CtJKX8vAjzb0R6BSQ4vNUSPUIDfCNnrEcmpH9xI5Ny+ByJ3y+sfXOvp
         s77+6oKZLjWLjLXY5qEONDHCpvCAbpjTIH5WtlhLOigm45AzDNmZC+WPzNAV/wUOsUuX
         0fKHp09UcLu2QQG3gAXep2lImlUw8kofLVi2OC/6os6lBXiTVirxYYoF/XXtxEEV9qj9
         sgVkB2xZKXXu8nli+Jb3ZomHg6c2B7IbvoHSU3vBLJYpq7P8FkoejSkkt622xmoPqOf+
         rBPDz2G5emYXAiW5n8R1m2yXvQCYeblJv/e+E1y7q8fhvIrlVa0peBUcAVtSROtCQ36d
         Vnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807961; x=1721412761;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ae5Vk3XcnDdaj5BKYKsQnIS/haF5dLJg944D3m7A54=;
        b=h4/rzxiXmO4nTXvMmqlGRyis543JnXg0LYnALcGhpzgAS3xfBniCx6EQz+d3ABLt1o
         MzoDXlJ1lPyGh3EBrnrPxo8A1HxMLDocKLiYnH6WI+ZuNpYZO1HAWxr6m4gw2r+TqX7A
         wjxgF3Bjb3JaQ3ul7RU44lvaO3exD8UtwZxuZgMtflvkx7DH4DUaeldxEY9xTJzuoYAG
         hxqHbuiU4Y4unHAyc7dtQg7u5HMNvwyKZyPF6J7NGhyaYeBW1IfPD1o5qzmjbX5DMj0E
         pY2vrdXofYU05R96pgC6nMjTS/V/ylD7RoSk3zy67DG9GXFNuCcSVV4xDsLUYVAUBFrV
         Xr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKb/77lmuCIJH7zR9VucLaXcr8QY4jsJVCvMN6tHGWbn6CIdPgPEq9xZ4VqTDR2+XgQ97iWR9Rb4dPVo+oQbRrrmPtliwiGGuXVPW7YLZwSg==
X-Gm-Message-State: AOJu0YzCqk7m3iWWA746Nvdw74qtAT/kifkOqb5JLlc9p6ytvKB8xLNA
	n76LHTqIfRM2E6iymXhyv0JMpq7KIOHGCEnNIjjBs8l3kYcJM1IJkr1FVmK0gSXGL0VjylfkLXX
	BrdxoSw==
X-Google-Smtp-Source: AGHT+IFS1r1FmLnw95nK6fekqupiE/8fso8FKO9OPR/6xFjZmjb3YizoL3Mqh3+zh+gKZgF8dAs4daXgaaxI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a81:4404:0:b0:63c:7fa:86a7 with SMTP id
 00721157ae682-65df4ae7d19mr124097b3.3.1720807961168; Fri, 12 Jul 2024
 11:12:41 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:55 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 14/27] perf inject: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

