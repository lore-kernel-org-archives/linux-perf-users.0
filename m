Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45B395AE6
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348287; cv=none; b=iRN84c5d+Bc0p70TgAvpbyhOUMUfzcBaKAmjzmlBn2wns0vQ5/i/lfp7cOcgDHZDKj4FvPsdvDJZEfpv3ltTTSCVum/pLnEgzUnfeZk3q8h39jzYS1TO+HNxCkhlZcIMXJaEtD949S3UYTC57qrL1S+62vGIxH2ldqVEvaNdJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348287; c=relaxed/simple;
	bh=Z4k5aPDSUnZVyff/4DWQFPnTg8uNxhX33iZgLEmRQc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KC5PBIOtJjylUoaO7WVxrHPglqxdUmZroF7IAmW6m4RNjCT8bkeAvXBuBJfy/odSx0ut5jDHdGUe1TVmDfHYl7RmTrXtjVOVrxlZL1AV/49OlDJ+e8QQhEbjI/niWG8NwWgw7PtLFxHB30/YoygdDXOnbtJMXFicWAZmpY5lkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKUGOL0K; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKUGOL0K"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso7033327eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348283; x=1779953083; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WaPoD3mwOT0QqFAF1FBTEvv1PUPRMcMoIqd4RO4LvQ=;
        b=uKUGOL0KHy+mKx15IeNXaX2oLzclJL/4CRqJmKc5wEwTLFh8m5YTmE52dF1yGCk3Y2
         FHmtvdSIZWP++5Xw9op7jIXzrvY5g3HxEhmcSspJDMgs1eBe3LPHDi1rPYyFQq0PsCRL
         sPSSVB31L+XWHdI/gz7h7BFgEDt3/DYb/UB+zNYRoyjESYduvhBYwlkOj2m0g5F8riul
         n4N3IFoGgBr5nd/+DnXKcoWs40AmhQi+uq6bUqbMWCRa8kM911gGAW6/XhBYVoL/CCIO
         GlbA3/JoGNe0tBJ6jmD81pGR4ILOJ0DdIdPVZXZwwy3RnYlwNhEYgvyMTrzG6hi4qn46
         FMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348283; x=1779953083;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WaPoD3mwOT0QqFAF1FBTEvv1PUPRMcMoIqd4RO4LvQ=;
        b=LHdzW7Hb9zcqsyONNcWEXToqwypmF+py39KQaZOBq/KTOOsQzHVt/jOaOcPIkCFRTx
         RTwzSJ7XIwR0X7c5bcp3lcDYbIr6vL4apyCiIv2h9BRaqlpcP6EHzrWW8GNkYJCtSOsK
         s7It0L9qJRO/BXPrGtnKkfetjODAsDo3FGkx0WB4ZRfD6A8LzFntluGCRl5g3aVmuS5O
         rDFYn4pj6eBJH2GlNqk3oN4swDPTYcZPhgT9o8i4HtnOfyOCi6g+jRi3SZwHTY168kj7
         /uo/gD0slC7jJ0IcyAa9M3AyaEfQaHhKQdAroLTzv4Ao7ilQ3FQ0wMMEySbuOQT0GmVm
         eE8A==
X-Forwarded-Encrypted: i=1; AFNElJ/1djWf0dt1xy4nHoYz9gnNGcpgVuNB6dmangZTkGW3yifan6KRT47wUKUiI3q1XfxuA3+/e61jqfau7ADuRUTc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2z6LrHZGsiGPuRphJ+ISkSgVOmIRCAM/1x1DcxRJEtyfNI/u
	Z9LQj2h3Bjw3DDXaxIl2Irbr/uRKx7EGF89smwjjMZlj/9nR/Da6Iw0aVohKjvdIAEI/YMjNxYb
	Ul3KJJS+WPw==
X-Received: from dycns20.prod.google.com ([2002:a05:7300:f794:b0:303:971a:154d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a897:b0:2e1:e3e6:2909
 with SMTP id 5a478bee46e88-3042f5c28d5mr1000547eec.9.1779348283394; Thu, 21
 May 2026 00:24:43 -0700 (PDT)
Date: Thu, 21 May 2026 00:24:28 -0700
In-Reply-To: <20260521072429.1283423-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521072429.1283423-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521072429.1283423-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf kwork: Fix address sanitizer issues
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a double free in the record array due to how parse_options
will mutate the array. Fix by keeping an array that isn't
mutated. Ensure kwork_usage is freed on all paths.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kwork.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 59a54d11f7fa..a4604e152002 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2258,7 +2258,7 @@ static void setup_event_list(struct perf_kwork *kwork,
 static int perf_kwork__record(struct perf_kwork *kwork,
 			      int argc, const char **argv)
 {
-	const char **rec_argv;
+	const char **rec_argv, **to_free = NULL;
 	unsigned int rec_argc, i, j;
 	struct kwork_class *class;
 	int ret;
@@ -2295,16 +2295,27 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 
 	BUG_ON(i != rec_argc);
 
+	/* Save the pointers as the array will be mutated by cmd_record. */
+	to_free = calloc(rec_argc + 1, sizeof(char *));
+	if (to_free == NULL) {
+		ret = -ENOMEM;
+		goto EXIT;
+	}
+
 	pr_debug("record comm: ");
-	for (j = 0; j < rec_argc; j++)
+	for (j = 0; j < rec_argc; j++) {
 		pr_debug("%s ", rec_argv[j]);
+		to_free[j] = rec_argv[j];
+	}
 	pr_debug("\n");
 
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
 	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
+		free((void *)(to_free ? to_free[i] : rec_argv[i]));
+
+	free(to_free);
 	free(rec_argv);
 	return ret;
 }
@@ -2447,6 +2458,7 @@ int cmd_kwork(int argc, const char **argv)
 	const char *const kwork_subcommands[] = {
 		"record", "report", "latency", "timehist", "top", NULL
 	};
+	int ret = 0;
 
 	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
 	kwork.tool.mmap	  = perf_event__process_mmap;
@@ -2463,7 +2475,7 @@ int cmd_kwork(int argc, const char **argv)
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__record(&kwork, argc, argv);
+		ret = perf_kwork__record(&kwork, argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
 		kwork.sort_order = default_report_sort_order;
 		if (argc > 1) {
@@ -2474,7 +2486,7 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_RUNTIME;
 		setup_sorting(&kwork, report_options, report_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__report(&kwork);
+		ret = perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		kwork.sort_order = default_latency_sort_order;
 		if (argc > 1) {
@@ -2485,7 +2497,7 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_LATENCY;
 		setup_sorting(&kwork, latency_options, latency_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__report(&kwork);
+		ret = perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
 		if (argc > 1) {
 			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
@@ -2494,7 +2506,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_TIMEHIST;
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__timehist(&kwork);
+		ret = perf_kwork__timehist(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("top", argv[0])) {
 		kwork.sort_order = default_top_sort_order;
 		if (argc > 1) {
@@ -2507,12 +2519,12 @@ int cmd_kwork(int argc, const char **argv)
 			kwork.event_list_str = "sched, irq, softirq";
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		setup_sorting(&kwork, top_options, top_usage);
-		return perf_kwork__top(&kwork);
+		ret = perf_kwork__top(&kwork);
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kwork_usage[0]);
 
-	return 0;
+	return ret;
 }
-- 
2.54.0.746.g67dd491aae-goog

