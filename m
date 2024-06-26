Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B29198E71
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434261; cv=none; b=LiVF5RNxr8V2ZmiAWiH8V04ZiiU+OSfRc3CIonQLpYsRQ5Je/akofLGHtuJPNe5p8H79pnRRkKKt+BeFrSjC5qke1dPDKDWoSvPdSUxCpmhaTIIRW+1u1g/Ht5umyAqnRo/jf008lbgc1fls7gR9fSuRRbP/tfY6bRFexiL5A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434261; c=relaxed/simple;
	bh=OpyFDAZT1rvjkAy8/+JR0tp9/7ny2BvFcr8PIIn+PJU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CLZjB5aLttrlEub+7as0EmCEU3mLdhgPSlOJ7YhpFwFUkmeSPBYXUtZo4zG3Qw7t53Rni+xEB/3vray++tKpRtPBzb0Nu/5E21JhO66FqSjU6ro28DSAM1AZ09bYW+Huf731NbxWzwTddc4/zxrpOYrItYgcz3D3+I4xHcDofbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCAu9+/j; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCAu9+/j"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64530966cd7so73889507b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434259; x=1720039059; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvdcuIvHOTbN4NA0rBgDWwfYbhOhRSMmjRRTx3dAb4Q=;
        b=dCAu9+/jA7TCs4uzI916un2bdbq+vmRCNUP/E/inIB6Z5zFclaak60vO6lYilJiaYm
         G2cq68ucfBXoldj+xzUBoKtGLUAQ0DMca7kGNwSd7s+N6wI9go20coqZ31Jy05wEANRX
         SMffVug7t4Y9o9VEFN/MLdP1I8PZb3cy6in6BnWFdgwflQ7ftlTxVO0Jf9ie0nwtkyzX
         zZgZNPx/aSpZcTxV9VgE2jQThSV0HxFe3mUo1IdgzmwhVwNtMqyAiRVnoSrr4zhfy5dQ
         QCKo8d/yKd2PIpksP0IMTSETRohsDAyGV6Zseu2nl+Y3/z0wBTD8NjXXz21zLvj3bZw2
         Jb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434259; x=1720039059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvdcuIvHOTbN4NA0rBgDWwfYbhOhRSMmjRRTx3dAb4Q=;
        b=SeDYWVCT5C/V+lqeg0mTRLiML1igCqefjETBgD4Lv247i801cFmQrzsXQeDDVs74x4
         wEZsCc266Az2DfSuL2GIxCF3HF3WwMHG1sqe9XZDT92sC6UbrWL1zW+4C1O1W9a+wP8J
         5jPwMriI+ADGS1hjIUrDnsAAA61uDvg62cGEIxUStJCCMcTCX1+k79RDDw7HD9FA3jU2
         2Q5phFq2WY/V3187n+KMXSl2DxSbYCnew+0EqrP+0zu1hFl2UvBZxFRCOvKFs2RLwz/6
         VPw+QKD8K25h0u2IMdByl/yQlGlN1qtR0bDWopIk4+VSAkpzxZT+vdGqVhMqwUPEmqv3
         MpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ikpN2rE9BagoT++VnSXtCdYA+G371QJe64egf7O9KM+EE8KWeqX2HAfqi+3WGn33cDgF9Ox3CcwpJnZ+yjUEIrL2C2tpkgeyNbRA4GLFIA==
X-Gm-Message-State: AOJu0YxmbH94kLimqhffcumx5a/+7Mfw/tMrFVE3m4/tukCAZ4QSJaZR
	gxfJd9iIo7ILLV62OqUDcWCHie1C2WL8UGlmB3jCPM20JLlkYLm8RGwiL4as1LA6GNBGiQ4vtB/
	xB/HHEQ==
X-Google-Smtp-Source: AGHT+IGDtcxpssxKa5bfLqqp5Vzn7OUbtF04Sj3YluVL/K7/+jI/EtJ6x+K2sSfGKg/ky6LToJZjMKYcK9Dq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:7201:b0:62c:f01d:3470 with SMTP
 id 00721157ae682-643ad4ce738mr1556127b3.6.1719434258885; Wed, 26 Jun 2024
 13:37:38 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:28 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 26/27] perf tool: Remove perf_tool__fill_defaults
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
index e1d38d91a1b6..54f0ba9b065b 100644
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

