Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9D178380
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336378; cv=none; b=njx/VFf+fI/jFuocY15Lp8KGR5LUBBVcbbQWKyc6dHlrOYNx2CRzX0dDLMAGIwl6WnzamTFTvqv4TABe3hAVn4cKRSv5lpYDKr6o78wiSUk4D7+za7myi1aCv3apG1B5qjicsSUw4Xx/eHzfbL+eTFBbmF40YQxK0V8/lotOjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336378; c=relaxed/simple;
	bh=0aVHJrC08XhbCG4RutjMTYNM2P5O2raGsxoyhdcFWYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G7iPN7yxC1A33iJjcbTDfd28olQzX8hgwpS5hDQirq7uZF7hDWLLE3mBO0GCCFtmfgd8UCrE0T6Tb7Gvn+8B0LvoPbRBDaSULR99ZWfg/GNQhDQNxRclhyH99RZk58N5szh1234U1qP1+/Ej1HDWP10g13iU5TYUojMmRduXgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYT77i6L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYT77i6L"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bca8ce79eso124100807b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336375; x=1719941175; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFiPugBk+wYhM4/j4Jlr9h9+wpX8LHXAYZExjKx1mqU=;
        b=pYT77i6LmUw8FDFMxfBQ5QzchSB++u/nUVK66q2vBoPkzk6iq4Ebue+x29BdPt/7KG
         2993qzZw1ZDJI673fedSJm1fJ6JxUDpCADweqRRZbPwBcNJ7kIwpo98xsqIMzfWSqdjF
         6bOCvOs3dWCPRjN5IWWEcaV0KYsbiDUsL5XfWzhbfRCPUtwSTC0c4X6vt/VJ0KTcG5AO
         Q21BCqzIF7oURxquMVfHeLi5SMES/Z2a3m6I0WXoTfyqmGVyDFlbVC5qcPbPFZvEvfSk
         Msp15zPmQdIbMb6m7yGkwSAvCupV36stPtYZQlwT6nXFIlHjRfhDYCPWIPSCVVDN4vcC
         nfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336375; x=1719941175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFiPugBk+wYhM4/j4Jlr9h9+wpX8LHXAYZExjKx1mqU=;
        b=bH2rDU1/YIANf5lGm3HZcszCU4KupEaFwTNNeM6qULEGqE20f5kWwv7rCCDStTMWDz
         XqtgwnSAfJ05pB2LY3hcK/p8OK6jfzIxtrUvExQVAEsal7FgHzczZSeh7urH1yXDGwAP
         G+ohGgBIHjCc19nxHYOgWr/SmAkJUPJbUlusoOPmZeSGttALPtcI/H3Mdj3Z/BhH5E4p
         WhxY6a1BSaIRUcMw/KJdUQ+ktCzuWd7CQfuWV9r6kmdydUsTXNpT2pRcQomjjoDFWD2L
         YpIGRP2jw33bk91ikZdo2NH5u9iJCz3pV8jsclLelDzy9dDfX0vZgt7E/edA1Nk7WXOj
         qc2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQZB2fATwwI/a0hRq82jyHaab19OAXD2NnyYLx3271nN/tEHCtcghFoXfC3wNag2OaHOUNhOsV8KQSkOXXthtpQPEhVQ+3ZFfHECPcs0heXA==
X-Gm-Message-State: AOJu0YxfhAgzKZbbnQ/8SSP1bj4tbwqADbJYzt7hQacPBvDtcozezeso
	VcRC6jyD/thz/zxyn5tLjxD/NO0frqAhmW9jys3Xjd+IAIcxrKMRPGJoZE6r4pn/Nx9YDp7qdrP
	J3z8Gug==
X-Google-Smtp-Source: AGHT+IFByilFik/CPNWQ170WVhkuObe+y3OLlOyaUqrpnCTLZdKDJxvfXmIvyNn3iqiG0VAtu17jUVZamArn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:154e:b0:dff:4a8d:3c70 with SMTP
 id 3f1490d57ef6-e0303edb6edmr30835276.3.1719336374702; Tue, 25 Jun 2024
 10:26:14 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:40 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 03/26] perf tool: Add perf_tool__init
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
2.45.2.741.gdbec12cfda-goog

