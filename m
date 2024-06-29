Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D21CF9B
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636863; cv=none; b=f63ccoWr6Wk+NveftL1AwuFjw3ulHM8Fh20lTZEh2tByXqmHOJ3PaIRsHjhfJGOOcC88A3LaNdqFGEN6yW6MzY3XbLV90OMPuyEJwqydlpqU3yLpfZPyg9V/MfBoH2OKDiEBvkIKgrYoj3UoD0eJyn5zLtt+Pury0dgI34g8kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636863; c=relaxed/simple;
	bh=Ct7eobmoNLLhcK+dU3oy5oR8L5Mlq+9vyxSN6kjO6us=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZjX2bv3MFE68hZP1dhbWe73fGtRVNYh4FgikhMnEtDKp7CfD3MY2oMZvevtih89sYZA9QEw8E2rfkNfeDtmkmBy1KcxnRDAsAhpijuUgDT4B8xGHmzPdZ+swdzwcg/pRW5usbhkSWA3lrjrsIm7aniMUOXaAe3fhm+nOjn3kLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMSYf4Ti; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMSYf4Ti"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b8c0c2c9so2364024276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636861; x=1720241661; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CejvhujW7C9lvSf9k2pOiVuZZrM/i60EXGBcHN6m0Cc=;
        b=MMSYf4TiE0/IunRkD93e+YpqfDEdSIZq0yq1Xpkc8PY9Vl6FivMr7voYZh4Cmf4Zqj
         9ju0EYC2G+i3usAgXpUtLnZjFH+/JoTWXqmI9wobvgXE5RzbDSEmYMM9Q4PfPeUe/dL6
         1r9/T5at7H3ePNAscJECXubWOndr7T/8O9s8V2CpvU4dVXigp6PHMyiXUCTbbM8AEyRB
         xfH8tEBTXuET6GwTHgcb8Q5fObTyQa9wnO/FBQJor4MoRo3Ltk4l+S+ughSGqIz44QYG
         6d/fC3mijVsrsbDHwL3yx2egKvDNC3evPzeqE7RsO541eJGo+L0vz0nXC4nKTh9f8nH9
         yYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636861; x=1720241661;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CejvhujW7C9lvSf9k2pOiVuZZrM/i60EXGBcHN6m0Cc=;
        b=T1id1ba8YvHlAnv6naPlpLLEsDAzkW9NHG0bg4UAUEV6AT/ZUXYoWfK6UZIcGqbccU
         MpEFu4Hxcd9lb9GJM1eMuKwDW9aOKFkDQgB6eBJLEzyAAo9n6vXIMcf+AyRLxi10O3h3
         CY89EXfk8Nmm6gZeK0n1xisL7A0tgWVZUeq3HMbwbjOCcFlbAPqLdTSdfiUksq/xlr1/
         3vZ2lmo2/izcn1vqcz228QWVsBEIxRMksj10oLirGn2VpMwVr5lSSpQvIgnFfQQik8ME
         1BBGENTh2YD0Iv1d5Yfrit75QmVs/1JM/D9klEvnf7pWLNfiwsCLv4KwmBxg4Cxn5ZpR
         Gebw==
X-Forwarded-Encrypted: i=1; AJvYcCUrRWE+jOXMZnQxHsaQoAKxa14ciWlfOGA8YlhWfAEhx68U+joEB/vrrNLJceA1tBh83d31BGaUPyIIUMN9Txk/afpnF8Xy4QfjV3EpzNOcRQ==
X-Gm-Message-State: AOJu0YxOCRwrJ/ugxZYFJ6ug3anZi5MdLiAcj+NuS4ba1Uu1EjzijnzJ
	cyZZHPKhQSK+afN4e1LlLdVnALaZc4eCBlaf7rfhaiZFQHlwHuPSo37XActD5sFmaIhLYr9NHZO
	L2BLhTQ==
X-Google-Smtp-Source: AGHT+IEOvw4w9NS1cMkcImD2gpgtf1Iy0EUMyJNe5I5vzZJccqIfuhxbCu35w2qKJnpQaukQHj4sXjsts0BH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:298e:b0:e03:54e2:4ca2 with SMTP
 id 3f1490d57ef6-e036eb1b316mr617276.4.1719636861355; Fri, 28 Jun 2024
 21:54:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:28 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 06/28] perf tool: Add perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

