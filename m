Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556A181B87
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336430; cv=none; b=OIFFoAmqjVnrrkY+sQP/pHh/Je8GPmMsXoKP7X0ZBc4cvjkSefuT61/DSssobwCQAmBf/A4iY/V7TDrvF+8wJueCi7+XnZbN2Lhg2N/uW9WgJkej4ihM8qMdpTR8lAVWqwda+UzGhml0Ad6lQsWqhw6z8SqFPkivL4pWii9bCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336430; c=relaxed/simple;
	bh=zBc2uvOJtPq/nkkHeD/XQYuVocuaC7TNJYbowcyriQc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U2yymfPFKIoeao6NGKvONjrgJwWbDGTe9rrSCQI08cDrJICammxN3pReX/fZndSJSY2V1eHPWOe27Sohl2oSPGctAEB4x1BKxwtSDOmfQDfJbQ8p3iQqVzRFKy1iCsIuphCRjd6j8ao9r6h9g1jOjMgNBJkWgReF398AfSM9l+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=optzBCfl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="optzBCfl"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64501d163b4so56812267b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336427; x=1719941227; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iE986kQkDs5/NJBRf4cgh631/et/Bs7ZiXxgZySXLM=;
        b=optzBCflmkSRIyUHSYpyX25tndsJ38u64aNu/s7LwIBBJv8K6P/3Hd0HaqZ/whxYIC
         7tIgRp8NkizpkCts/5215NjV090WG7MzAMJOjdFnj8WGiybNiOJUsoY3MrD0CVGr99e9
         mtSKt/Mm2NHEXI3rwIWRW4VKVX8XAGsA2zm7v30xRZhzllhr331scjx03c16HylsYC/m
         HRu0LRudeYv1C61kdffSkVH3Dj/jJtxWWi8PjjsQ8KPXjXbpgBGbjK0ZWMqbb+8VRBH/
         siqw/KzR/t0c6yWgy1aSjkRpyh95h/+X1T8p2/ZpVxOwPDsspXeeLUMduU/ZYvKh7jIG
         HQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336427; x=1719941227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iE986kQkDs5/NJBRf4cgh631/et/Bs7ZiXxgZySXLM=;
        b=VPFOKc4aQj5DXrBHOQEYji6rp7wdt/tdP3NC8nzxMdkHp9O6vgmbSEwQyPYFCxfLEe
         fvb0SvrG/POTOQ6xd6O4wAWS2cb+1MqpmXFMZojemU3BCrDLJhknnzr6S4X/CTNWJFfw
         rgA2Ol+7SXEG7U0fneAI1jMk2aZ+QW+yMjUiHFAI1ZMSXVh8mymf5ZFy8/URCe35wszh
         Ed/5NgqAw2Na6jsGwxYdQ7QJE0gVL93bRmGVaYTKhKYzVDhw89SUE5oSe+7IluWlbtjt
         6ZdT3IF5yqzRFivoQsyhqMYpxR3wSvSTQBlKX2rkJOaM9UbKUpuJgtqQs5aM06k5N+N7
         tPkw==
X-Forwarded-Encrypted: i=1; AJvYcCUqh/Kpn7G0dRF+rPCP9XYGtddqfpIuHTF3oRbRha30VNShu5uz4ah6henuucjoukcsHcnI/l/YItrneqiYJd3KFHyU4wrhT1ee+pPAbDfm2Q==
X-Gm-Message-State: AOJu0YxMXGZiXzZOC+6hHow+nwO3x69WuyvJ0+MgkwieBtxut1atwDak
	wCc+wxjGjtnCX1an4A0rXf3+60+hVs4Vfr1ymeDvlwpM56mP6Pc70UUOnJsh+5KxMNeCfmbsI7+
	DPdU5vg==
X-Google-Smtp-Source: AGHT+IFVccGq12p3z90FxxfCbb9Z1BYcHe+rBZSwJCNoU8cnhklsujvqjEk+IZyJF5UdB6GkIYXsoj+erzAr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c03:b0:627:dad9:bf54 with SMTP
 id 00721157ae682-643ae545126mr3852307b3.10.1719336427556; Tue, 25 Jun 2024
 10:27:07 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:02 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 25/26] perf tool: Remove perf_tool__fill_defaults
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

Now all tools are fully initialized prior to use it has no use so
remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c |  6 ---
 tools/perf/util/tool.c    | 89 ---------------------------------------
 tools/perf/util/tool.h    |  1 -
 3 files changed, 96 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4febff1db5b3..c84a060b588d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1750,8 +1750,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	ssize_t err;
 	void *p;
 
-	perf_tool__fill_defaults(tool);
-
 	head = 0;
 	cur_size = sizeof(union perf_event);
 
@@ -2159,8 +2157,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ui_progress prog;
 	int err;
 
-	perf_tool__fill_defaults(tool);
-
 	if (rd.data_size == 0)
 		return -1;
 
@@ -2213,8 +2209,6 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	u64 total_size = perf_data__size(session->data);
 	struct reader *rd;
 
-	perf_tool__fill_defaults(tool);
-
 	ui_progress__init_size(&prog, total_size, "Sorting events...");
 
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
2.45.2.741.gdbec12cfda-goog

