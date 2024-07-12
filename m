Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEF17B428
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807957; cv=none; b=cykd3ncO/21azgh/DBSmorFvNca2m7T7Fy0NWJaumxDgDmbi80TFLYLLGDsZW+tozPsgrtat6lWt/2JieMAyuYpfuWwvyHZ3d3Ko+allR3GRDxmo4ZJxla7OM/Acz23wPz9lJqfk0s6n5yh/NpQS33q1L+N/GPY9ndvQHsu7JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807957; c=relaxed/simple;
	bh=PB51RKImsC3lHPo6fW3ScTVlasWqH0blF1j09wP+J1U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=c7XpC+Bb7Z1w6IsUiPSqts1EZqG09Cw74zMeQMWG2DPNjxGqOsjfmxtBemEdSmUPhjfIYnHIwR2OGLiZ9mt0OPQ9vJcpJEnikNxkH0fr13rsK2Q6ZHUXrdoYDtaBA21oy9lXnzL5URi6dMnCfGuG2LD+3aLqFTt6j5Mcvd/myeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zLS0Dulk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLS0Dulk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6501bac2d6aso25816107b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807955; x=1721412755; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3N+sXEIdDW4FZ9MEavkeCx7Ak5mBAvz0H4sFCDbHeI=;
        b=zLS0DulkNiPjIzwZEfrNkafhuYq9lp8559BiAfy8u2cR05sblxZ5RwEEp/aEpyJDg/
         E0DT0ZlNfSN19/IpnMMI4IuM49O2G8BNA73heYW55vL0p53stIfg4n/6koUbLXZKE3uU
         CD8it3zvNUhcXreDEZ4mMgcJ5eHPuPsOqEz5tnkdfSSY+uCQ6VCcj7WjWf5WFx/LRL9S
         ZZJ17TUL8oPm0v8SuyH2xocWDuiuYrbOuHLSXcuPKP2f82LA/wyy2But/ArkWCT/tk+D
         czbjCVwfq8ki4pQpRDDYxRdQ2BQbsmwEsIv7vnAU+GxATz1giJasKTi9rbttJwRGQEAH
         x8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807955; x=1721412755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3N+sXEIdDW4FZ9MEavkeCx7Ak5mBAvz0H4sFCDbHeI=;
        b=WdctVm2bhR7rECBqdtlBcWPKKbBj3JOGpqb5NENoI2LPy3G7jxFzxU1z/MtTaVwwkB
         wqY+UgGu2x9Edu5Q8PEdwcRUQd69v8aXlwKHmeFZRuLPFLR24BjMc8AeuXD1UtOtok2U
         U5dMwlDq4SXg9fu0oiw3IyXcIv5v8OVXJdT6G4rllAc37Thxa53FhuzAVCJb1QJ1fDaR
         0cosq+iIe5Xd6Td3tJy5gGxX168a30feLoM/xYYbqtGIfabu9g+J6IxfemQggsyO0SYk
         kPCKcQiyt6kKNVJdxNaMqn4530UlIH4lrkSAxqGzi0ZbTn4jQu2XLXMAEIJ5M+xucCsk
         Ad5w==
X-Forwarded-Encrypted: i=1; AJvYcCXhfgDHsPlOIvEH6tb8rxkiHEtn/F/Hqs1qh7cgTu0y3f4IUIwtVMLsHKztEqDOnljcJ7xie9zzd3m0KMeXCDvKNTiRjQl71BYKHPDBFPUUKw==
X-Gm-Message-State: AOJu0YzJnv73Gs/7+sgVPDIFzVsRkjv5qgvanKVY+z4Zi50UMKkU3MN9
	n+0Qp+7xXE8N4F5fVnIHoxRVihmR1AZSffTd0hunpl0ANT0L1IAhRAsux7mTvvGQZs4rsx9ZJMV
	bvSrR1Q==
X-Google-Smtp-Source: AGHT+IExEZhqBBcIexchHpBnvFmTKUgMli03JoYZcn32JuoHYiPGuJJ58g8CD6QprTxwGaZs6P7o4XHXSCM9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:dd3:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-65df661ceb7mr703737b3.0.1720807954828; Fri, 12 Jul 2024
 11:12:34 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:52 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 11/27] perf record: Use perf_tool__init
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
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++-------------
 tools/perf/util/tool.c      | 10 +++++-----
 tools/perf/util/tool.h      |  6 ++++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f27f725913d7..12a5170d9193 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -193,6 +193,15 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int build_id__process_mmap(const struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine);
+static int build_id__process_mmap2(const struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine);
+static int process_timestamp_boundary(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine);
+
 #ifndef HAVE_GETTID
 static inline pid_t gettid(void)
 {
@@ -1458,7 +1467,7 @@ static int process_buildids(struct record *rec)
 	 * first/last samples.
 	 */
 	if (rec->buildid_all && !rec->timestamp_boundary)
-		rec->tool.sample = NULL;
+		rec->tool.sample = process_event_sample_stub;
 
 	return perf_session__process_events(session);
 }
@@ -2386,6 +2395,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
+	perf_tool__init(tool, /*ordered_events=*/true);
+	tool->sample		= process_sample_event;
+	tool->fork		= perf_event__process_fork;
+	tool->exit		= perf_event__process_exit;
+	tool->comm		= perf_event__process_comm;
+	tool->namespaces	= perf_event__process_namespaces;
+	tool->mmap		= build_id__process_mmap;
+	tool->mmap2		= build_id__process_mmap2;
+	tool->itrace_start	= process_timestamp_boundary;
+	tool->aux		= process_timestamp_boundary;
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
@@ -3326,18 +3345,6 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
-	.tool = {
-		.sample		= process_sample_event,
-		.fork		= perf_event__process_fork,
-		.exit		= perf_event__process_exit,
-		.comm		= perf_event__process_comm,
-		.namespaces	= perf_event__process_namespaces,
-		.mmap		= build_id__process_mmap,
-		.mmap2		= build_id__process_mmap2,
-		.itrace_start	= process_timestamp_boundary,
-		.aux		= process_timestamp_boundary,
-		.ordered_events	= true,
-	},
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index cbd9b888bd73..a4ca16e5eefe 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -99,11 +99,11 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
 	return 0;
 }
 
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
+int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel __maybe_unused,
+			      struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 897c6c44b6b2..fb7e32d98dda 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -93,4 +93,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
+int process_event_sample_stub(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct evsel *evsel,
+			      struct machine *machine);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.993.g49e7a77208-goog

