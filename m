Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38874199EB1
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495679; cv=none; b=g7xWQR4o9gqEoIIu7CZ9hKUGuGMN11GjjuHfw7J81NIGm5Q29EtqSfdCNC1LeDXVreoPzMPAqRgXTJh+4XSRPD6z+bcExXxJJTy+9FkV2TIL7JV/Vw/X9Y0MWImIP5lAznyzhCVDu6cpFjTQAAWt53X4TdZK7gYuEmxlo6MepjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495679; c=relaxed/simple;
	bh=lCDnk2L8CnAFqDRR02YlRR7gUfyEXDc0sFq8M1oeGZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a3lytXpCiCipGCPcCgdg8pIo8tqbGy4nlPOc05A9wOplHrfzZDE8EKumAkm8cgrj+fG2SuhRGKi3rzoXvMd2UxxhGZiz5c3fowqzwDklVPc2aoUcICGZr+rCrIi73ZRDDl4gbv3Qo0SetEk9KwSXh6ghPxj1ZYlA7EjupCAcwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3bmXLoJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3bmXLoJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68fd6ccd4c8so110130857b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495677; x=1724100477; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLGoEGeBqdlZH+CzmCpwGBT1pMro9nL/vjVTf7hbTvA=;
        b=m3bmXLoJALqIzxlUE+38TQISyrZBUSCT8asWvrHHpiV3C6hsdCrngTc/gIscTfLPpI
         7xVp4A565o6jkcrx4CbaxT1vpk51cyC4QyuJAp4chys9SIqa7/3HtLPpblemb5qjudsE
         tLd+RPF1vzQujwgynELkcXrBhy6vPm2y0yRgtgvjOcfRFNGj8kH4BhzDUdymxWiRWtAD
         YAGufh9zSpeBKcojeXMpRQC1OAnrTS0v6IQmr8TOjoITD+dBFIJFiAzj1jRzARbqVtRQ
         tLEOT6zLF7dKBj+pkuoD56ybRrbge3mIdcwrETAocYHDkpEkAmOXU84ogUFhxiYXjpBp
         VPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495677; x=1724100477;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLGoEGeBqdlZH+CzmCpwGBT1pMro9nL/vjVTf7hbTvA=;
        b=YWltPC9XFs9JFkF1mfgrpiiapU2vPJrA0kGID8AiZWZf/RFIB09R5C/NRY650XrHRo
         XJpyRyqIwGB/u29GCEqICiDGDLMp3x9Cn/QZi1+gqPaqH13dWZ2ZgACRO4UmY1PqN3Ss
         1wHkZMl+nmgt4aU2LmXO+RPetkTBcUQFFU6u2LS/xbM8sjSsSxCUkv4FhKbm1sSdgpX3
         eESNWUzetdTdOdnnTppA+7nryoRLHiRfAJX7qkXczoujzSLGcJWvgy4jwqyMGk0rY9fU
         wx7f+TnU9gBawaNECJWX1vYXIe6zlqEP2wbo57XyO9vYQ2Fjv82bKtxC80dExVo6XUAT
         wsrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BcFxIunGDuMkvag6YS/jgto6WY/FS0fXLfN5Jk/SsS7fUmdNLmb5qLCmgLnWTIbCLenyEmdWjt7JvwYuXQYvxgyE56lCR4BDLxMe2ofIkQ==
X-Gm-Message-State: AOJu0YxFVIz2VFjRCItE7UrotmMWvGNywCQB5u1tX6qeHqFgrjm/g+g/
	ueDxMGfhk+Ym8KnP3HISp3R4QSqAHMAXb50+8ytGid5Qfl3j+OVnc2YIpv3Y7qW4ARsOSD5YXyJ
	KB/Jckg==
X-Google-Smtp-Source: AGHT+IHTOUyrEnHmyoPgJ8YR7IU1g4sZiy+xELUvMPvGchrr6f7uxmiTpmzY0G9mGLF8prFaHdZCREmlbbyW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a05:690c:4501:b0:690:d536:27e1 with SMTP
 id 00721157ae682-6a9718f53d5mr264607b3.2.1723495677364; Mon, 12 Aug 2024
 13:47:57 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:06 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 14/27] perf inject: Use perf_tool__init
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
 tools/perf/builtin-inject.c | 91 ++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 283429ccd034..ef9cba173dd2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2165,47 +2165,6 @@ static int __cmd_inject(struct perf_inject *inject)
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
-			.dont_split_sample_group = true,
-		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
 		.output = {
@@ -2270,6 +2229,7 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+	bool ordered_events;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2334,7 +2294,48 @@ int cmd_inject(int argc, const char **argv)
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
+	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, repipe,
 					     output_fd(&inject),
 					     &inject.tool);
@@ -2373,7 +2374,6 @@ int cmd_inject(int argc, const char **argv)
 		 * mmaps. We cannot generate the buildid hit list and
 		 * inject the jit mmaps at the same time for now.
 		 */
-		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 		if (known_build_ids != NULL) {
 			inject.known_build_ids =
@@ -2386,15 +2386,10 @@ int cmd_inject(int argc, const char **argv)
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
2.46.0.76.ge559c4bf1a-goog

