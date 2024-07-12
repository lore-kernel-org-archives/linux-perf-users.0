Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD7177982
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807944; cv=none; b=n9Ei7jXEAv99Czc8qMyVYQRouWQnz99fdC98dwUZQ2PAvVUqGaS87gKptkAh1qehD/NSdrtp4fvnbYN1gpZv7GLZJrJJPYqWSm1oXDxGNoWD7jrY2FUu0+yzLpVtm9+ILfGqBdK5aOpYgQzdXCoV+9vz4+t8aSsqtWaUz7zhoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807944; c=relaxed/simple;
	bh=0sUGypKycMkQkspjkBVoBrgTbEB/yfeNI4tZZobPQAE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WFKUjPd+dScuDpPZrmNpAVngF0SJO94yBTD+p1ok8MfX53fcqL6l7yvib3sa2kT0RiwMR45aN0vYdooLHW2PGCB8vcDwwo3z7p2t785fTwUuS46NKanaHLJC0uSoZ7IRJe8AYZh5WB482FTvYlBnlgRtqYhLUWe7o66xDhNyVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/Eaol+u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/Eaol+u"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4138547276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807942; x=1721412742; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUbNGHbJusTOA2CgJOpkojrr3Ag9eG/HXr7a91E5F44=;
        b=i/Eaol+uUPG7jEAK9rbPgRQZshpunNSczO2Z9pknNOUtl/cCWCD3d9716KSQpGOjr8
         0KFwwnFuCbNah0RxXADz45nfJ/VzQR+HtPtTKrCmeuimMMuW4pry1rGPZjYCz+wVA7uX
         G8Htuh5wG8CeysUOoHAlZE7VfykkGIS9q6o0nDRun9QLAvHKyvSSUe3BVotvuETc6fch
         ogKBzT+/pUAdsco56UKusshdRO364e8BGJVvb2PN8nl1ZEVG5Kchk+GT/WAIH5EIrw37
         TmufXV2MfA51Ezu/iK1dQcGSlV0t6pjz8OWEtdFrl8WEWTgwCvZ8e9KTza9gJxun8P+S
         j0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807942; x=1721412742;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUbNGHbJusTOA2CgJOpkojrr3Ag9eG/HXr7a91E5F44=;
        b=qI0jPQVZn8LjoOX9YacNfnKpxKHxl1qclUyu4w+O6Kc6vZqjsKdmN74AHLKBatbLqF
         mG1dzWes9ar3lmGy4aONRN1VRkazA27PP4er9yJvo1U6MyGXTXArdOkomY2Efoy1uiA7
         CxJTLGAq6l2rnQCT6+aOYG81CkenBheJUG2KFouwheGZ/ul7ONhzTVYffVcdGEEw6t6h
         QOXeTopEbDL0R0vaOjOwoKr8jdffTgk9LNnwcxsz3w7qQZm4cL1ye3nrPdLhhatZ/4sa
         WyNPqnSMZKIcTwJr3/93IQwBniU4fJVEKXhy9ceMokocAAc+PQxrDrFrC1eJm0pUlO6+
         Bb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVivxfh9k2Tag7DupBVCWMA6EFqtC6GLVpNZROaTs52FDex57mn9S2FYiyZvs66S7BZ0/X2Zl1UhI13Q3G1imZOY1gsBgTpxZd/aq9Rtu2mAw==
X-Gm-Message-State: AOJu0YyTkLwmqDO5SSyvba8HZgq1beJ4wboBMZr6NYx4ynEd6SDsdJ0I
	s6Id/ktwUi7kAmZQO12D2J+PS5unoPkMOvWr1oIHQDVHYGYVvRVynZ86OK253p/Oa5UgWiwdM9B
	wEuyo6A==
X-Google-Smtp-Source: AGHT+IEn4aL7gAe/A8RlgnAdU+tNwlNq+Sm/494mGsbEklzNlhOPqAJr26SyTCQFnLjLoMPuNqG7qpfWvCca
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0d:b0:dda:d7cf:5c2c with SMTP
 id 3f1490d57ef6-e041b17798cmr23897276.13.1720807942024; Fri, 12 Jul 2024
 11:12:22 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:46 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 05/27] perf tool: Add perf_tool__init
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
index 7913b698033a..897c6c44b6b2 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -88,6 +88,7 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events);
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
-- 
2.45.2.993.g49e7a77208-goog

