Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523D194C82
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434231; cv=none; b=AgRopZlvHeV/To3VpJMEi7cKxYLYi+f2pbcTYfVAdYQWh7GnvOjw1IaIFK4O28vXbUc68c9bPh3xUFMxl9VPE79SEB0zew7u5MJ2cMPOTgmVXF079wY8mhRGDao2yG4ljb26dzNk7Qz1TWQSslMli/qywu7LVql2QCLcqrN9e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434231; c=relaxed/simple;
	bh=WRHMheJp7s0UW+rmOQwKCmWPOpwEdqZ0h0girqg29wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MBoWnsSfqSEECec1F6EsLKGgx9oqwsyKfkeZPeeGMZeykPJG3I+FM9pW/hjeU0t0oVMfnVnEGts47NjdjNr2raxKI0t/ruZIS+prw0zmIaP/PIi+RCfFImzh/jBHjuc6KH2zKeyY3HW3T5qn1AoiJFwSKU8HIkb5M5FTsIL808k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxJCnQ/Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxJCnQ/Z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6452f8f2942so77868727b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434229; x=1720039029; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=VxJCnQ/ZnkxvM3BTZKrUvE29My1KiTQ81qn5b8rKsmM2nfmrlXdIRVh0T6RuseK9SJ
         XG84I1xefDMLVeK/nisRJNvyqRgtrkrRuQ8cwIz7fdPRLzT28qOxNXr3AyFf8zsqtqhT
         VfQzo7txoRLaATCFmbs8yuXrOFQ41vBrWROklToKuvjgVGsAVkbSucvBG0JJFVb3gZqu
         f+eF2g4J90HiZgvt+VuRhGb4EN/ONsjEvWdJXS8KkrTHDgyES454XuML1HFXXcQ3xgbo
         JLtt12odBfQvPhm61zCHwYGBa22w6wwY1510o9/6JkUIpKNv9y5sDfqR2EIp8btYD2xZ
         wRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434229; x=1720039029;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=WDQDi8ET9ZbU2CKolQSK/toV8437sa6O8+XbfsdOyEnpz/kpHgWnM6s3rrK9sP32i3
         mBYCiZ8OatB6F/QI/w4SF8bLkHgPiuQkSqm0Wcchv1CtTimco8pO8toTOnLuJ8hwQfHf
         uHlPIOa69HNK2HVktDcbDDV/KuWCXW9G3g/nlCK+Q8SF0hLeeBuDkdvXX2y0w9qbTNg5
         WdJxgZksY77M1stJmzy32EsUratEZSaBH1PSQGk1rjctEQ0y+e7TeZQkdABGyfVNwOWP
         juNClEA1US7YQXI9D/e7qt0A0aYoESiVLqlKsvWIsjmuRLzbYr8xp+LDIsfK/59/lMAm
         +qXg==
X-Forwarded-Encrypted: i=1; AJvYcCWUf2ZmjSB56dESQn6bXIWpnwKovkMga8YWhL9Nv+7cZlvTk9jFcLsyzi80eE1dwWtor8L1x6s+NpW4O9UDR8JXWGA1GRAzEE8WRombJNbtvA==
X-Gm-Message-State: AOJu0YzK9BB/tPZlnwDj6+Lhw+h7To9IjNGABK85eHR2wY7FStDrauEU
	Ta7hH0zARvsKwVjaLC5UUeNHkn36YgMbZR9L09uUU4zfFEW7dkuTWdBKOBZ/TIjpN3zUVjghcIP
	WkQDyvQ==
X-Google-Smtp-Source: AGHT+IH1b3uFlZAh7FTc/51pAkYfxg51uKntN5OfGNVc33hFT9YDlTkQu0cV0WTSjlTWeCeXHSLPMoyx/Wog
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:6ac2:b0:627:a961:caee with SMTP
 id 00721157ae682-6433f0e2122mr405277b3.4.1719434228939; Wed, 26 Jun 2024
 13:37:08 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:15 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 13/27] perf script: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 65 +++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 394bce9f5338..b4fc2971335b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3899,38 +3899,7 @@ int cmd_script(int argc, const char **argv)
 	const char *dlfilter_file = NULL;
 	const char **__argv;
 	int i, j, err = 0;
-	struct perf_script script = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.attr		 = process_attr,
-			.event_update   = perf_event__process_event_update,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.feature	 = process_feature_event,
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_script__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.auxtrace_error	 = perf_event__process_auxtrace_error,
-			.stat		 = perf_event__process_stat_event,
-			.stat_round	 = process_stat_round_event,
-			.stat_config	 = process_stat_config_event,
-			.thread_map	 = process_thread_map_event,
-			.cpu_map	 = process_cpu_map_event,
-			.throttle	 = process_throttle_event,
-			.unthrottle	 = process_throttle_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_script script = {};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 	};
@@ -4102,10 +4071,8 @@ int cmd_script(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-	if (unsorted_dump) {
+	if (unsorted_dump)
 		dump_trace = true;
-		script.tool.ordered_events = false;
-	}
 
 	if (symbol__validate_sym_arguments())
 		return -1;
@@ -4296,6 +4263,34 @@ int cmd_script(int argc, const char **argv)
 		use_browser = 0;
 	}
 
+	perf_tool__init(&script.tool, !unsorted_dump);
+	script.tool.sample		 = process_sample_event;
+	script.tool.mmap		 = perf_event__process_mmap;
+	script.tool.mmap2		 = perf_event__process_mmap2;
+	script.tool.comm		 = perf_event__process_comm;
+	script.tool.namespaces		 = perf_event__process_namespaces;
+	script.tool.cgroup		 = perf_event__process_cgroup;
+	script.tool.exit		 = perf_event__process_exit;
+	script.tool.fork		 = perf_event__process_fork;
+	script.tool.attr		 = process_attr;
+	script.tool.event_update	 = perf_event__process_event_update;
+#ifdef HAVE_LIBTRACEEVENT
+	script.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	script.tool.feature		 = process_feature_event;
+	script.tool.build_id		 = perf_event__process_build_id;
+	script.tool.id_index		 = perf_event__process_id_index;
+	script.tool.auxtrace_info	 = perf_script__process_auxtrace_info;
+	script.tool.auxtrace		 = perf_event__process_auxtrace;
+	script.tool.auxtrace_error	 = perf_event__process_auxtrace_error;
+	script.tool.stat		 = perf_event__process_stat_event;
+	script.tool.stat_round		 = process_stat_round_event;
+	script.tool.stat_config		 = process_stat_config_event;
+	script.tool.thread_map		 = process_thread_map_event;
+	script.tool.cpu_map		 = process_cpu_map_event;
+	script.tool.throttle		 = process_throttle_event;
+	script.tool.unthrottle		 = process_throttle_event;
+	script.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog

