Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4A6BB39
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636886; cv=none; b=GyACEqOh+aq8182qywkVWBRXdcSVAoDAblX4T6KqfcRuKsg2pqclTM4egX/fpwqb6PeHxt0NnRBn0NdKfkKq1dG8keMuY6fZNhNQ4xt5XnCoHWUdaBXJEAHYivB/NvbXqjL6S/mP77dGuF4hGdFLwaN0qegMJEYNkTzS+LopjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636886; c=relaxed/simple;
	bh=yOOuzSCmcUlEUBW+tGOizP4UCgpJ9AIC5EZOnu2IiVo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WYIMHSrOyggPU6WD1w5AlwtHthjMgR1sW9OBntM+Yn7tADkXju6Wv809EAlUMywJvqXJ3Fju14+2p2fwYx+Q/UJeN+m+5dSsBgabFaZMIxqqOAlogZmt5X2luGLKDgG5iYLolXqCP6KQT8KjgWJdZ5gSINY/Sk86fKAIyF63Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2e4Tcjr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2e4Tcjr"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bf44b87d4so13769197b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636884; x=1720241684; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwYcrkEXaidwd4Z5roU7UK2PAYIesHAmyGq2F/bho4E=;
        b=H2e4Tcjrp6XsMDywIUDm+x/Z1jNb4V+baMQX+r43b0T1LaiaefRlT0jWQ6JDCPBbyk
         wZGDR4iRuNGnb7arZhLZtT/hsqv+V50RoXXNxS3xluLJNM0FXC08cMCPgaQyUNAlT8IB
         ymhO8Zlc9tNw/un42Q+GvoG0CKShpeZ2nuKLyDUctpreXWIAWsGkvSCMoI4JOX71P1CM
         WKCBCbTsGQiJQfELh4lc+at9yAfNvQhBA89pO2I/QBkZ9e4MR7qVPaIb9QmqZQlC/zry
         EroBsz/EHGFRNdh+BKTtUtKu02ZlORA0uyoRTmV2/I6S/OKXDc4ykv81KHcczG1jqWHV
         aqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636884; x=1720241684;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwYcrkEXaidwd4Z5roU7UK2PAYIesHAmyGq2F/bho4E=;
        b=LDX4PzZbSRfvJGy91/JyLCnfjxADciWHI5YlNEpW0T+pk2LVK4sqZy6ZHTFbTIcZFk
         BDepskArXvw1Sr/uGaysP7v/ruy322VO4ILTHLmMXZn/fSG3tm7eSHhGR+aM1KYv/2iV
         v43G1MLzhHkDT2E7ToIjOWt6E+IyrKljn5I2iUgl1DerAFXQvCs4jozTTDtzU06fOvpx
         Hy87gxZK45hfUj9tT3IA9zS6ywdrykH0NurdLiN9IeXzeUb7rV2GVm9KOGYx/vkayOI9
         zN6EeiyWHpxxEUO3yFXl6m5+8q+FfZrjLhfeY0leNZEQMWjianztjO+yciwsI2u8x5z4
         37HA==
X-Forwarded-Encrypted: i=1; AJvYcCVf5ZUoTn0+ekSvRcjLeTLdHy303g7fO3u9+LQUJq6RmJI1QP3Kc3l0B9q6R09bxQ6njwBnrpkqOpI0qNv9Ok5u8GyrzMqJUCWXcEvzk2bT2w==
X-Gm-Message-State: AOJu0Yyr+N2XLKG9LOPgU7ggCnZmxwUXj2IGyP6vWfm90/IWTVIQt5F1
	LXR0BC8C+FbkVs27kXOCE3VtTC0J+XR3l3kfkdXX+rXr0tjwpauuUtCTeqCCMzmrzHkwtQJq7aL
	A7L8F8w==
X-Google-Smtp-Source: AGHT+IFoH1LQLq/Q7zXZZNDrbDM7uUS6jL13oj5uD5gOMYkfL3tHUvM9RMCDuhIAY6WBZpQ2ynmy6kqUusL+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:690c:7647:b0:644:c4d6:add0 with SMTP
 id 00721157ae682-64af3134c36mr462217b3.1.1719636883810; Fri, 28 Jun 2024
 21:54:43 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:38 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 16/28] perf report: Use perf_tool__init
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
index 2313bacea0d2..86501edd5a7d 100644
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
@@ -1273,30 +1272,6 @@ int cmd_report(int argc, const char **argv)
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
@@ -1478,6 +1453,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	int ret = hists__init();
 	char sort_tmp[128];
+	bool ordered_events = true;
 
 	if (ret < 0)
 		goto exit;
@@ -1532,7 +1508,7 @@ int cmd_report(int argc, const char **argv)
 		report.tasks_mode = true;
 
 	if (dump_trace && report.disable_order)
-		report.tool.ordered_events = false;
+		ordered_events = false;
 
 	if (quiet)
 		perf_quiet_option();
@@ -1563,6 +1539,29 @@ int cmd_report(int argc, const char **argv)
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
2.45.2.803.g4e1b14247a-goog

