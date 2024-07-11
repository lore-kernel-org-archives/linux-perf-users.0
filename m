Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229317CA0B
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720875; cv=none; b=dh+OHRT1qtLMm6eDaqFw4LEseyAzuWkeL+XFFpaFifvupCqskMSHn6Cx0NlYu/DvxPmS7wrUOxoXgVQU6qZqzK5U+LYXUCvtCD10z6nnZnbAxBzXuSaHWj4RlY4TFfA9+05tVQ982gUKFyowHNntrmzJL2p/jNkDuBO3yVHv/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720875; c=relaxed/simple;
	bh=nog9HAZnBs/Uc6gA5S1tlyf5AbSf3UPE1Jgj8toxgcs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=c6dge4w4ZyEA9ZQdt1xJ2sk+MvG5xhwNxMp3sNOsvOELXvrLtzWuAGvay9dvf5xH/yaKxXIuJ95sCYyzbTTwgsegXCh56RLOAK/BKBLdzuUppUmVqRBKU3Xtzok10Vq8sFIHhVb5V7uDkjXmWNyyA/bbD2FaYoMXc4WtPaM7FW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCs4POAJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCs4POAJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a92302d1so1852492276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720873; x=1721325673; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XS/BS2tmrMYCpclJsc0ik1l+h9pEP1QMQPO1IiW0Pw=;
        b=lCs4POAJlsu4lHu8o6Cpj5wY+cmdM3j2tAykT+Vs8iwDkaHVDsK9wav8wV11w5FvJh
         Pl/CBDkBe1JNSOs33g95vkrsri5oCyVm/uGwuwLqIPFx8i/s8v+Q+3bwghDXyuhqcjEh
         7jZ0yHGWJ67/xud9KoMW255OUtL4n0XtCOZOHTrcXm291R+p3trBB2X8WSnhjihQ49p6
         Lh+6ZOuqeGbjRLrfEQQHnzENxb/z7LxKc6nypBCd+5fmHoumKkB0u6hZr+FzCOBVxbkS
         uP4fiO6QTPfpFUGSwJk3ab4p0IdiJmtcNz/SG6o0cL+KJFNnfnjRn0wgiCFkOjzd1tD6
         bGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720873; x=1721325673;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XS/BS2tmrMYCpclJsc0ik1l+h9pEP1QMQPO1IiW0Pw=;
        b=OrGqRrvggz77XPDTMvnQbwO2o9R/tBUwzDLq8IGuaUsJrSOLtBW2SYnd0rOLqhpMNJ
         al05gWgs82Cm9QwBW/qwOVgAJlKF78jFmLs3XTkB2hY5g2rVyjKWyGXANBYP0YyoxI09
         vfepZAjgQDMNSUkpwxCohPPsvAhElCE0pmSNRTtpmYdbOgbLLvanCuCmWVPbXaX6iNvG
         mOnVlJhclekdO67tN/scLYcCG+mihItLzvORpxsusSMrjtyRx/d0yCz/xU2A1eE3fa/X
         uhFGQz4bA5q3pw3nS4m1SI9Z+1MypjThncGf9Am2wP37Mbrl/2i4z27RJ2XXE1phHx+S
         Kg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUDVq4SGsMSCyx9NuWXoAk75yvr/fF2fuYfkKPwINHyo59RQNzvWHuG7zd2HwlRZa9bDI0oGztqyckoTjfF9NDVYh+PzavuPTnOBL43vcSS0A==
X-Gm-Message-State: AOJu0YxHqNEzDOq3FzTpsOYnk22QFo5PX05DAW51zityuQK19PJuDzGB
	M60uhHq7REtIXL3QY2YwMSWTw4I8nKMd+H9AmX3a/i21iavXeLKNeSPI1THx9BePUqmvuOQLqVo
	h+IOQZw==
X-Google-Smtp-Source: AGHT+IFkKG3IgwMxEt/Bk8goVcLqtdaHlpvAh6+KBMB2W8t4X5lnBMdhP8W48LriLi67E/9Scm+C0af9WkpB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2403:b0:e03:554e:f396 with SMTP
 id 3f1490d57ef6-e041b05b915mr366236276.6.1720720873191; Thu, 11 Jul 2024
 11:01:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:07 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 27/28] perf tool: Remove perf_tool__fill_defaults
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

Now all tools are fully initialized prior to use it has no use so
remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c |  6 ---
 tools/perf/util/tool.c    | 89 ---------------------------------------
 tools/perf/util/tool.h    |  1 -
 3 files changed, 96 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5359ee055c85..ad5da61d2330 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1776,8 +1776,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	void *p;
 	bool update_prog = false;
 
-	perf_tool__fill_defaults(tool);
-
 	/*
 	 * If it's from a file saving pipe data (by redirection), it would have
 	 * a file name other than "-".  Then we can get the total size and show
@@ -2201,8 +2199,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ui_progress prog;
 	int err;
 
-	perf_tool__fill_defaults(tool);
-
 	if (rd.data_size == 0)
 		return -1;
 
@@ -2255,8 +2251,6 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	u64 total_size = perf_data__size(session->data);
 	struct reader *rd;
 
-	perf_tool__fill_defaults(tool);
-
 	ui_progress__init_size(&prog, total_size, "Processing events...");
 
 	nr_readers = 1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index a4ca16e5eefe..3b7f390f26eb 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -288,95 +288,6 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->finished_init = process_event_op2_stub;
 }
 
-void perf_tool__fill_defaults(struct perf_tool *tool)
-{
-	if (tool->sample == NULL)
-		tool->sample = process_event_sample_stub;
-	if (tool->mmap == NULL)
-		tool->mmap = process_event_stub;
-	if (tool->mmap2 == NULL)
-		tool->mmap2 = process_event_stub;
-	if (tool->comm == NULL)
-		tool->comm = process_event_stub;
-	if (tool->namespaces == NULL)
-		tool->namespaces = process_event_stub;
-	if (tool->cgroup == NULL)
-		tool->cgroup = process_event_stub;
-	if (tool->fork == NULL)
-		tool->fork = process_event_stub;
-	if (tool->exit == NULL)
-		tool->exit = process_event_stub;
-	if (tool->lost == NULL)
-		tool->lost = perf_event__process_lost;
-	if (tool->lost_samples == NULL)
-		tool->lost_samples = perf_event__process_lost_samples;
-	if (tool->aux == NULL)
-		tool->aux = perf_event__process_aux;
-	if (tool->itrace_start == NULL)
-		tool->itrace_start = perf_event__process_itrace_start;
-	if (tool->context_switch == NULL)
-		tool->context_switch = perf_event__process_switch;
-	if (tool->ksymbol == NULL)
-		tool->ksymbol = perf_event__process_ksymbol;
-	if (tool->bpf == NULL)
-		tool->bpf = perf_event__process_bpf;
-	if (tool->text_poke == NULL)
-		tool->text_poke = perf_event__process_text_poke;
-	if (tool->aux_output_hw_id == NULL)
-		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
-	if (tool->read == NULL)
-		tool->read = process_event_sample_stub;
-	if (tool->throttle == NULL)
-		tool->throttle = process_event_stub;
-	if (tool->unthrottle == NULL)
-		tool->unthrottle = process_event_stub;
-	if (tool->attr == NULL)
-		tool->attr = process_event_synth_attr_stub;
-	if (tool->event_update == NULL)
-		tool->event_update = process_event_synth_event_update_stub;
-	if (tool->tracing_data == NULL)
-		tool->tracing_data = process_event_synth_tracing_data_stub;
-	if (tool->build_id == NULL)
-		tool->build_id = process_event_op2_stub;
-	if (tool->finished_round == NULL) {
-		if (tool->ordered_events)
-			tool->finished_round = perf_event__process_finished_round;
-		else
-			tool->finished_round = process_finished_round_stub;
-	}
-	if (tool->id_index == NULL)
-		tool->id_index = process_event_op2_stub;
-	if (tool->auxtrace_info == NULL)
-		tool->auxtrace_info = process_event_op2_stub;
-	if (tool->auxtrace == NULL)
-		tool->auxtrace = process_event_auxtrace_stub;
-	if (tool->auxtrace_error == NULL)
-		tool->auxtrace_error = process_event_op2_stub;
-	if (tool->thread_map == NULL)
-		tool->thread_map = process_event_thread_map_stub;
-	if (tool->cpu_map == NULL)
-		tool->cpu_map = process_event_cpu_map_stub;
-	if (tool->stat_config == NULL)
-		tool->stat_config = process_event_stat_config_stub;
-	if (tool->stat == NULL)
-		tool->stat = process_stat_stub;
-	if (tool->stat_round == NULL)
-		tool->stat_round = process_stat_round_stub;
-	if (tool->time_conv == NULL)
-		tool->time_conv = process_event_time_conv_stub;
-	if (tool->feature == NULL)
-		tool->feature = process_event_op2_stub;
-	if (tool->compressed == NULL) {
-#ifdef HAVE_ZSTD_SUPPORT
-		tool->compressed = perf_session__process_compressed_event;
-#else
-		tool->compressed = perf_session__process_compressed_event_stub;
-#endif
-	}
-	if (tool->finished_init == NULL)
-		tool->finished_init = process_event_op2_stub;
-}
-
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 {
 	return tool->compressed == perf_session__process_compressed_event_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index fb7e32d98dda..0874e7924687 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -89,7 +89,6 @@ struct perf_tool {
 };
 
 void perf_tool__init(struct perf_tool *tool, bool ordered_events);
-void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
-- 
2.45.2.993.g49e7a77208-goog

