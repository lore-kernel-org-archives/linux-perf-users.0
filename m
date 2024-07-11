Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255016DED4
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720850; cv=none; b=HDk/W2SHLO9MC6W159mdiZrZ3vU5/dvjEccU8M80Ke0UElz6YyMDd/n9/7HE4rbE8ik7RlLo3KPBXvuMQ68VhZdrkkA+OhLrayGTfWbKTevWqrKPP2n66zkAAJRZi/TNdVdOj2SQIaWSi6kaHx9/NLhGuH9cc29Qzdu4fWbeHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720850; c=relaxed/simple;
	bh=Poyvi9HGQwQC12qF/8SGE3BV1oK/lWq58PuPKRxVztA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dEsH3vllyJ0xqV50G7Y+YmxVkCfRXhaliz65PddeIifR2v2Y80ceZjSrzFU084g/AgMz59l4HBY2bwU+7bS4HxdfqOj5BVcLS4M4WA1xNakjIY6dVHXba8otYVVTK1btiEy+EGhVwd0kvqQ9ejb0V37KvB4e91D/uLOutX9lcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqZdmlmt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqZdmlmt"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05600ade22so2354630276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720848; x=1721325648; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTSkE2wJ/0ArGbZAlv+dCStory8B9jtqpGvumW8ARXs=;
        b=mqZdmlmtTRksASY8sGwnMjZqJBv18zosDKEGMjsUA3Oa299TFariNkPYHBlZblBh/A
         JYkb1B4S3kFCd+gR0Rgies5QNlmUD5M0cYt+JvmGx6y+Drdw6iR24nncvJd/mIp/5+ba
         UgEpuT+U7I8zmJAHAOJWIS70q1rG24RkWdEBnQDXzxd7nIqYmEtEBO9xvM5FO+nzQZZX
         3tNhPvWddAIGJve7cmzsJc8Y0OfgcskDEf27CvavSXipj3qI4qfMWwbMjnRG+CGsp95j
         /C2WS0/0pOXyWxEHMLrppJIfzud94rtrLJUQ/qpow3HJWdeqrHk7FfS/t7enuBA/NkgT
         dTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720848; x=1721325648;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTSkE2wJ/0ArGbZAlv+dCStory8B9jtqpGvumW8ARXs=;
        b=h02Up9jyOri4m1IcloVJLHI23AaLRNu0J18c7rIhwP652EQ72U2zCZG2fRGGA8i/ge
         W4UlGC7ezuYI8vSrhrSvuQaI1wpDs0DBm5q1VnhI5XCn+YbDdOAtrYPnwo8zMz1meaUS
         /MFWC8b/em2O5fEahY4Peb2WJGjyym5tFhsKSk5DGm/fwne0gRkcoQtgxlTM/wZ7OYcD
         Wv/X4OLJ4MmiV+7RwaS44H4A2LZPt50yKNx4nRfAAyZ1R5YYRGii7M+Nm9XYsJii9TJd
         +qT2DS6bCGTX1bZQW4sjb2zEc2VqfMpeYfXeb/WqBY7Y1DXkwnIKxqEitGgj5NBfcch6
         r66A==
X-Forwarded-Encrypted: i=1; AJvYcCXHX4lKkrpkQI4pRoBV9TzFqOjErSw8/x+Afuqo6nHEZTM31dfbxagGiBRuU0y1lxIYcFD/VJVH7OvIpVj9jYzy+UeMYg+X6wpeiTGn8Ys5/w==
X-Gm-Message-State: AOJu0Yy9VdcemhzH9sy/viRrbcBCXDcTBh3OPjUhowwTsyZmKIWc3Wvt
	ONhY7Of5lGln9WLMek2au6TTAcDTb5d/8AorFpsfNuFe96NTnIG6R6Cv5wIlw8kv0ntcwDMz1w+
	1TS5xXg==
X-Google-Smtp-Source: AGHT+IGlt20vZYur011SdPu6+QS+oJZqOUoXE1o+BRrQgv2s0bzDCcgJLzE/EenlRtLxPWLHv7UOmrxEaNS4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a25:7d42:0:b0:e03:61bb:6032 with SMTP id
 3f1490d57ef6-e058a47ba0emr1176276.1.1720720848062; Thu, 11 Jul 2024 11:00:48
 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:56 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 16/28] perf report: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

