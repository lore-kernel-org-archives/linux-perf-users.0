Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA317D88D
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336396; cv=none; b=QHKfZZmn/F30cWtieFKvZo0tUBmO4abZ37+d1F8zNMa+bKfeHAEBSeKH69H74P+gCImXGAiMpU7yGL2CfyGhzAJzsUjrIJPWJQt0NB27TnwZIEukfebfzc2EYjEnD8ar2s+g8yQ9dJacJHfYN4aIzpNUELwRkWcad25/VKNxD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336396; c=relaxed/simple;
	bh=WRHMheJp7s0UW+rmOQwKCmWPOpwEdqZ0h0girqg29wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X7XDAYpjNPckYWo1mQkJRAcUTRO7A53mU3vjeeNI/mD7MgSR8DdXGz+Mi+A9JnE7uBvOK5lel3MXIRnWDrRrlWklPoalFfWPtoSoWH30N5+4I8vVk2szgncOelqmozdczwiVkmJvdS+VKs5wCCdoXVfgR/aiCy3OpchkudF24pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mVgnJyi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mVgnJyi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso871976276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336394; x=1719941194; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=3mVgnJyi80byeJuBxXAPD5QJ8vDBV0hh+0sSnb+uFWqRlPs3MWPD2Gz9YbFmVoEd20
         OEzEiL/MQNBHDcRfT5YbceGhmvvdxeMitttJTeVAglnK14bsJHvyFFxLSWXcB96uXv9L
         /104T/0boftYvD7u2z5HtWdNNpNSkFJneFWPxa+BULOycyzhsD/9k+xJmxS9oVHKDWpW
         wVETBaHVV82WgynAoMcR15Ywohw2zHUu180NNZRZKacEUPDeRNYWZ01gMU65ZGBmdypg
         kGhzV3XwWvQ+GHTXvY3nLf4GV2dPOHevBkMzoHuK0Lf3Ltz4PXq6loeSpN0L7H2Um6JY
         k/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336394; x=1719941194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=AdALy+tBQfo/VLyQCIFNO5RWQuGtf9L/2h91qcSzyZAsISJtronfxIFkKxaPkXLGWI
         Tg7xfIfIgVUvzMPPOzlStsPt1uoYWuqkVAXOf6OEZcH8JUIJZj9TOvTdgxG976rF/cWE
         WZ94HF0KveeDxnpPqYcQ3AZdvn2z0fJAJCCe4twx8IkSyPbbsb8krJn+3q22FVWBxkyU
         u2hxKcTyRA3RPOx67VTog55VTOEUnUvv6zNSzK3O3Ko/AM37kn5iYYmWJs+snxk5WQfG
         0mxTL+a0rkdhnItJXxpZh7/RjPQmgKarWtHfrcUflE+WPeTsBk6mRy0UTdA+xTw/OkEB
         fatQ==
X-Forwarded-Encrypted: i=1; AJvYcCURlr3kDw8tZ13lOw8QfIEaVu4g8Vhz1bSBv6ND34UTi2Q+o7XGdUXtVumO4DnvGZcoYrRzguWM9va4wD703MGjH8wnaAgW51h7//BPLsX15A==
X-Gm-Message-State: AOJu0YwKTu6aVb+oULmrfktiTXDp2RDvoLrNXzLqRpNh51gqcnBlkwlM
	V43YRkpN8Zu53NsTaaOCac9K0vV6+7rbvSmkCZkyb8PzFEtStu6mFO8VnMGKxgnWNcUFweE3fBy
	Pc8q5lQ==
X-Google-Smtp-Source: AGHT+IEUAqxicES2UtcaEb6UDQ+bDldZC47HTYRjmbObzHA40nFed+1pv/51vSijPeWYxPRv8nv6BqF9dCbq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0a:b0:dff:83e:b259 with SMTP id
 3f1490d57ef6-e0304040464mr259080276.6.1719336394399; Tue, 25 Jun 2024
 10:26:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:48 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 11/26] perf script: Use perf_tool__init
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

