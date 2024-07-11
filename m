Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50916DC08
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720829; cv=none; b=WDViAmi/RCg/oohq8nQGf8HtniKrVcezRExksntSZTd9e5KyjbvX4zocRVB4eGjPrVc8+LONeUUHluHDNlJozjc5nFPaXAoetkkcAgMSu3B7KJ4ZAHBb0HJt718V/HJpo4Gs3pFa3Ze8GILHZo9KbgEYsA/g2rI9v7sRGzBLnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720829; c=relaxed/simple;
	bh=0sUGypKycMkQkspjkBVoBrgTbEB/yfeNI4tZZobPQAE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kvyWBazs1i3lnxWbK9VpG7ad8u0h8ANx2BbfcZI1qsR9f24Yp5dUE2+EXDTcUk6HnjBkYHxXjZl/MQA1UI9cJ3Z1JDbOJLf97jDvxbN2efL+Dh3OGWbdo58VnM3mOLb18g9DdYNcVVk0jKTXm7qUpEwDqFPa5JucrZHA6L1Y9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppyPFD+W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppyPFD+W"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650ab31aabdso19208257b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720827; x=1721325627; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUbNGHbJusTOA2CgJOpkojrr3Ag9eG/HXr7a91E5F44=;
        b=ppyPFD+WeU9PlFJ4c7YMoVnVNKecUKzucpvTVkXxIaBGK9kC58zxnEOn7Fr8fuDizw
         zd62W/SyQdAOrpYiY6jN6zmTBKEtN2ly+FNddVBl5XHePryThqmET/09d2SbFf9KoZ/Y
         ucQSF4VrsMwEFaxXb4NhcKX2DNuw8qyQD3+f0L3wLP/k9gYpTTDhIm5L3DkC/jamDzTZ
         eq0Aar674zG1oRT4FYth4wDGP+1HDuAb8hzZ83Pj0NhEyUnMC3CChep1VLPGFx86tCZ0
         yJrib7dJ4wKPlDIPPDapT9abSkly/cIejGGbAmGQWzjDmiw58wi3oS7W0xwk/ZudAdb1
         N+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720827; x=1721325627;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUbNGHbJusTOA2CgJOpkojrr3Ag9eG/HXr7a91E5F44=;
        b=U9lo5hktThO6m8k+243V2Az4xb71lME1C3W1QHIZelAl+908ZA/XNxLWyLnkjYDgFW
         PhxpYd/SWbqBUiPm+u8cAQh85Ri8uqNSWLbjamN3otk7rIMrDAuE0TICkUaFqQzdKPKY
         VH2CVSTS2ZKT6mXvQchwjpdNMF5nnbEt2b0gtPLXHKxJXThT5AIK3MckoWRiTAs/FBTU
         AM6LbSsApSOQc/a/jUinu4OwRBTKUaSBdxIByV/BJDpUg9unMT/xwnfBFamHtveEYppo
         FIeqnQU145TYJ4Ou8ZQS+t2I4qOSlc3P2gxtYGTByAfwuaWwFe9cyN7E4xZBAb3xqkAu
         tahw==
X-Forwarded-Encrypted: i=1; AJvYcCWxEpMXy6RXk50q6ICgpn7evlojaldI/KNVd8OWrTFc7KxUzAZgbKlv2OZtiBsBVieOy//nfJFIaHxLhN92rocpvEJylp+M65Cdaf04shQJ6w==
X-Gm-Message-State: AOJu0YyJGsnJB0bx+FsXbkjqLJWKTfJe2euKnjxL1QEcArAb0oFayPbs
	JnSrZ3piX3frD6CzJMS0/64vqp3LX9bm3S0XySsZc3ddqXBQU4pEoJy40FYWJJxHIzcOWBATJVo
	n7ZCnVw==
X-Google-Smtp-Source: AGHT+IGpjmXnPZG6ET95BcM0LX++X4FSpZehPMsvXd/XHk3OIv4vX9bTses9QahK6eBa9XlUvUAYslXgj71k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:360d:b0:631:d4ea:3749 with SMTP
 id 00721157ae682-658eeb6e079mr421397b3.4.1720720826737; Thu, 11 Jul 2024
 11:00:26 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:46 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 06/28] perf tool: Add perf_tool__init
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

