Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42886197A91
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495658; cv=none; b=WFm/+7fVE4HAFmcn8UxlULkIadiU1okFzjEAoqgmJyba8LEynY4NJWQx5KGfoB2ZxDomtlY54bPtgBnkiM/+Z85AaZUsi0ArvclOb0uEN73IEqGHeLTnx91Uu2940GH74YZ4Mtwo1ODAsJmsH5CnThu54IlqyF5UgzShLYdeMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495658; c=relaxed/simple;
	bh=kZ7cYYe44uih2DKNAfDOwvKjwiQuD8132impVjdxqZo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mTQO5u2ummv7e8p5qXEg+4LmKoryqmqhaYmQ/HB1xM7Ema+GrpGLEVczCBLXZjqf2gLlhFf+JITikiYen7W/8BRGrSdbmmS/WZHgwxbLyiuHLL9JgRNVeOKIDWel7O6IOrzgj4x9hY5fwTFegAUrIbHMeT6EsqdazYm867HY7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0BzHPOV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0BzHPOV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66890dbb7b8so110580767b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495656; x=1724100456; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5QskrwEwgJh1SEHBPySv+b4dUG/k47lipRxRjevwjg=;
        b=M0BzHPOVUko4vFNzWDpOqf2l5RSL7blj9v4Hxif8rLRQ5wnY6HhooiiG5BWLXvSfzN
         6oZw3KitJlXy1orbOm8oo3kwwhjEoZWwJhSTrpIpnZXu9pnsVbfu3roEhWizkCGrLaDx
         3tVRCzYshXAH6ItwwYxGzIdSAHpZNNTHGnk02ZTa3m40onBsxCX9zSHo1jpoSYGL1DdW
         gKE+H/3XIfmfE3mV4LcQMQm20c+tma3cYDQQjT7A2ZjFU0GFiBAYG9h+yuIgEM58KNzc
         UcbPQA1LtE1ThuJ+7Oysw9LyVtS8sPiKxVgp6qLczPTnNXIApPPo0O7tXIR23hTIq1Ov
         jOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495656; x=1724100456;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5QskrwEwgJh1SEHBPySv+b4dUG/k47lipRxRjevwjg=;
        b=dZ0ortboKMxTRrCE0EOvaEY629iZ7AOn7BzVqtTatTPJ8BnHbwUq0nX353IlNc054o
         1UbCOnaTnsy3qXEEX9C7P4whqWROOCB8Nbuh/+Hy4hdkTnPbIrbL15clLo/tAKDR96ym
         keWJl9zNMJctW3a0seEw/4ZNCQOUpffkzVP1rNpV4D86oanrHeR6r8Zr8ePo6uD7bAMf
         OqCjQmvWlr00xPaSygwEtWraiAKLy0E0rup4GpKwt0UVf38tRaZWW/1KA2OjOMhPStNS
         lqWaBnnfy3v50PBM04txsSDPGB35Fg7AkL6G/X3K5TJ+FCgm1cKmD4lgQ7F8ls2pnYbH
         /6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUZw6TABFHhEZOM2YvOCjHzBcJaxmXkhwIYLttj6XWC1JhZuNk8C6zpW93wnVPqu53juYE5NIEgfHIzCH6aDokMeLHhkHlUzTfBtJwEvp/tRg==
X-Gm-Message-State: AOJu0YxKY7xnsr9T4RclMNdn+ib/SBycSqR3PpSVfv1lbcwLwpebVlRw
	dVQXi7iU+wbaNDWph2dNBPcmJWDxF8m7aJT3LsKoKhcInbbU/SviTCSuI1UcgSETKas4e4GCtSJ
	yYrcgHA==
X-Google-Smtp-Source: AGHT+IGYzX4ib/mbR9sRiEgZk4S2Ro0LhXD3PEY8JFZJzNim6QhGI9Yre46z0AplBbBDzJBKz1DXJDGI2in6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:e4c1:0:b0:615:32e1:d82c with SMTP id
 00721157ae682-6a97732c587mr106997b3.6.1723495656210; Mon, 12 Aug 2024
 13:47:36 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:57 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 05/27] perf tool: Add perf_tool__init
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

Add init function that behaves like perf_tool__fill_defaults but
assumes all values haven't been initialized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 17219ecb8fa6..cbd9b888bd73 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -230,6 +230,64 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events)
+{
+	tool->ordered_events = ordered_events;
+	tool->ordering_requires_timestamps = false;
+	tool->namespace_events = false;
+	tool->cgroup_events = false;
+	tool->no_warn = false;
+	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
+
+	tool->sample = process_event_sample_stub;
+	tool->mmap = process_event_stub;
+	tool->mmap2 = process_event_stub;
+	tool->comm = process_event_stub;
+	tool->namespaces = process_event_stub;
+	tool->cgroup = process_event_stub;
+	tool->fork = process_event_stub;
+	tool->exit = process_event_stub;
+	tool->lost = perf_event__process_lost;
+	tool->lost_samples = perf_event__process_lost_samples;
+	tool->aux = perf_event__process_aux;
+	tool->itrace_start = perf_event__process_itrace_start;
+	tool->context_switch = perf_event__process_switch;
+	tool->ksymbol = perf_event__process_ksymbol;
+	tool->bpf = perf_event__process_bpf;
+	tool->text_poke = perf_event__process_text_poke;
+	tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
+	tool->read = process_event_sample_stub;
+	tool->throttle = process_event_stub;
+	tool->unthrottle = process_event_stub;
+	tool->attr = process_event_synth_attr_stub;
+	tool->event_update = process_event_synth_event_update_stub;
+	tool->tracing_data = process_event_synth_tracing_data_stub;
+	tool->build_id = process_event_op2_stub;
+
+	if (ordered_events)
+		tool->finished_round = perf_event__process_finished_round;
+	else
+		tool->finished_round = process_finished_round_stub;
+
+	tool->id_index = process_event_op2_stub;
+	tool->auxtrace_info = process_event_op2_stub;
+	tool->auxtrace = process_event_auxtrace_stub;
+	tool->auxtrace_error = process_event_op2_stub;
+	tool->thread_map = process_event_thread_map_stub;
+	tool->cpu_map = process_event_cpu_map_stub;
+	tool->stat_config = process_event_stat_config_stub;
+	tool->stat = process_stat_stub;
+	tool->stat_round = process_stat_round_stub;
+	tool->time_conv = process_event_time_conv_stub;
+	tool->feature = process_event_op2_stub;
+#ifdef HAVE_ZSTD_SUPPORT
+	tool->compressed = perf_session__process_compressed_event;
+#else
+	tool->compressed = perf_session__process_compressed_event_stub;
+#endif
+	tool->finished_init = process_event_op2_stub;
+}
+
 void perf_tool__fill_defaults(struct perf_tool *tool)
 {
 	if (tool->sample == NULL)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index b917b1fa6204..7c7ce395e573 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -89,6 +89,7 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events);
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
-- 
2.46.0.76.ge559c4bf1a-goog

