Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F07346F
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264474; cv=none; b=iUUGFG2WMSO3eWwhCYL9IBATLv18KOiCypupsglFqr95Z0PuXqEPku9BEXH2c9LWXvELXU8n/tjaueiNJu2vZtVOgJ4kzaUyH4h9gFeWSkVFTBgDWAE1THV47jTLcRHt6F9zakioYi1eN7B1dXp8UpRzHecta4wWqjUnw3ZvKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264474; c=relaxed/simple;
	bh=haQWI5ixWfY5L9Onf5Qhr5TFO+OWkA5CcjaLU2DCVsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TSvpSP3aaqzZW4p32KmdOtGBNSP/x5caZ5fDD1W0FVeyQpk7PQfBZWqu2hTYkj7RMeDAXdwz/TFmr1px7draIhljGNjT9IQDoIWvxvEaYftDaIwUsTokcTjd8cMrAOEyc9c+JG0Xq51i85xGvAMT7TLeq5RYCYBuiCwGFFuwVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjoSDZ9N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjoSDZ9N"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64c3f08ca52so5726597b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264472; x=1721869272; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydpPh1ZiMiP0pvro6tyDS2/nf8jKqmo5vUIGWKndW+c=;
        b=pjoSDZ9NO6aEmG4VWbmpDjCLW7pb/4KLib+RshN7jtUdt1AOlgdJh18UKGV3/Qrgq0
         vGYpxlPrivtY/EeEN0v5GdebJsgpzgXyKPxCQMD4V1j7+MPDri2PV16zKv7+sKmW34Td
         gJdQtFWs/dzsYyiv0EN3B4IVfHn/lByCFWYBUkHio+6/rKu8TfoQvwiKTBQZkfcmZbm7
         olGHEKlbo4NcazvrU2HrDzJHAo8NH2MuT4Xiw3iAwj2nEO5C+XH08JH3wmReYc4NUmC8
         FzLHN4Sw9oajR6Lb6loCff761R5uOyFGPZ7LwQlEu+h4I+bUwNaKa7yQ9a8tNtctEDKe
         UIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264472; x=1721869272;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydpPh1ZiMiP0pvro6tyDS2/nf8jKqmo5vUIGWKndW+c=;
        b=ta9lcox2+GQ5EUhl/esKGMog1sjDJibkHm/QwNTaCirh7dXQJyXLrplE2JyYi4c5HK
         J5o/uOPIeIRtATWNderFB7bogVV76YP2e+xJA9dhmsm1+dlsCuIObS9lcXd9dLH96l71
         I7q0ltmi6kyK3EWUqEOT0wAQzdB7HAMc3VJfABM7u0R9bkK3j1Cvg4aVUwir3Zvw3WAr
         M1ESSzd0OpVUo/+Z8CqhUYxO0nZixEjzelTZImYqTdnxhaP3wVztcDYSNrF6ypGgG7aY
         CAGigK124Q5L/zDo2dOecYp/Fg+Y7wljrtvklPrJEO4+ct1tTR/UskJca3bNt5KkV7Gm
         zfMw==
X-Forwarded-Encrypted: i=1; AJvYcCUFAZFgSKTNqpmSI//hzd00nx/1yLp59QnwoJkxbD3jF9n6OCYLS1o2F2wlFVIrvNzeENDbLW3MZwbjafmlMslUC5ma4k6nkC5YguUl7SMLpQ==
X-Gm-Message-State: AOJu0Yz/8uUGEtkG8rW0bMswq7N5JgnIcqK32KiW5MRwY/3oLEGtnlT/
	/krmw0A8Yb9meM5Th/7WirmbC31MjjIhXnKBS3ymoC1pcYnsOKzTe76QrC/WdKEITyHwv9zGOT9
	7VSwTzw==
X-Google-Smtp-Source: AGHT+IEC7jMCN1PYvXYSFjQ+yMmz4uzntJ34atRdjn0CJuW8F47EslAtvO50ljkTVZhuGVg3mcO9QZPODSju
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1504:b0:e03:510d:3b6e with SMTP
 id 3f1490d57ef6-e05feb30c26mr8201276.3.1721264471615; Wed, 17 Jul 2024
 18:01:11 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:11 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 15/27] perf report: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-report.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c402d9b3dca6..cd5caf1c974c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -799,7 +799,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 
 static void stats_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
+	perf_tool__init(&rep->tool, /*ordered_events=*/false);
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.lost_samples = count_lost_samples_event;
@@ -817,8 +817,7 @@ static int stats_print(struct report *rep)
 
 static void tasks_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
-	rep->tool.ordered_events = true;
+	perf_tool__init(&rep->tool, /*ordered_events=*/true);
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
@@ -1272,30 +1271,6 @@ int cmd_report(int argc, const char **argv)
 		NULL
 	};
 	struct report report = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.lost		 = perf_event__process_lost,
-			.read		 = process_read_event,
-			.attr		 = process_attr,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_event__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.event_update	 = perf_event__process_event_update,
-			.feature	 = process_feature_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
@@ -1477,6 +1452,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	int ret = hists__init();
 	char sort_tmp[128];
+	bool ordered_events = true;
 
 	if (ret < 0)
 		goto exit;
@@ -1531,7 +1507,7 @@ int cmd_report(int argc, const char **argv)
 		report.tasks_mode = true;
 
 	if (dump_trace && report.disable_order)
-		report.tool.ordered_events = false;
+		ordered_events = false;
 
 	if (quiet)
 		perf_quiet_option();
@@ -1562,6 +1538,29 @@ int cmd_report(int argc, const char **argv)
 	symbol_conf.skip_empty = report.skip_empty;
 
 repeat:
+	perf_tool__init(&report.tool, ordered_events);
+	report.tool.sample		 = process_sample_event;
+	report.tool.mmap		 = perf_event__process_mmap;
+	report.tool.mmap2		 = perf_event__process_mmap2;
+	report.tool.comm		 = perf_event__process_comm;
+	report.tool.namespaces		 = perf_event__process_namespaces;
+	report.tool.cgroup		 = perf_event__process_cgroup;
+	report.tool.exit		 = perf_event__process_exit;
+	report.tool.fork		 = perf_event__process_fork;
+	report.tool.lost		 = perf_event__process_lost;
+	report.tool.read		 = process_read_event;
+	report.tool.attr		 = process_attr;
+#ifdef HAVE_LIBTRACEEVENT
+	report.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	report.tool.build_id		 = perf_event__process_build_id;
+	report.tool.id_index		 = perf_event__process_id_index;
+	report.tool.auxtrace_info	 = perf_event__process_auxtrace_info;
+	report.tool.auxtrace		 = perf_event__process_auxtrace;
+	report.tool.event_update	 = perf_event__process_event_update;
+	report.tool.feature		 = process_feature_event;
+	report.tool.ordering_requires_timestamps = true;
+
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
 		ret = PTR_ERR(session);
-- 
2.45.2.1089.g2a221341d9-goog

