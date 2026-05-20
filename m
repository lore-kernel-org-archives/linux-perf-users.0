Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1B403EAA
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304010; cv=none; b=GPU0z4GFXNBCEhgFaJcJ/tFCubH4nfd6NgxKQw86WrarA/lvxBYrG5gFbr/PW3wbttcfRJTlxJIRheYSnAq5CG/hK20kPtXN3BP0And71G3RRZwtxQtohO8ewopbuEHkRoexyd+bZpVE0J2Rb9xevOM5SLzvdPQCYwY/rqwZ1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304010; c=relaxed/simple;
	bh=Z4k5aPDSUnZVyff/4DWQFPnTg8uNxhX33iZgLEmRQc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbJwq+O3wjVPA40NfI6YtJ4GAqZqytdAwxmBs7KjuQgXZBoTgyUoJQ7soqKASy4LeHC3eV9CFK35pKjbypRb7Ur1QDdDgsNEoVR3kG9HvUMEjJtqgB3jN6VM9oR2dR24QsVLnYetojkU8CVb2GmfAD6FlqEpmPtzyw2urQYK7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5PWJ4Bk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5PWJ4Bk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so5209747c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779304008; x=1779908808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WaPoD3mwOT0QqFAF1FBTEvv1PUPRMcMoIqd4RO4LvQ=;
        b=g5PWJ4Bkix2TClSClDynuBYmNveu9CENNfv7FQejJoxdbicHn+tVCdup71p+M63Yeo
         l31Vn/HcW/ryQA/2S+Dd+sS23v9eovYF9f6kpyVKAbxq5EWqHXx+p/qgYQPGwqw2jSr0
         fdBDvXwIMDVQxQNa606jON/2//ohBczbC6cR3y2s3Il8AYXbZierRNNSP2o+3hWP824u
         9ho8hCloJkDt3E1N34E/syMWWQnviHpb1H0mczP5h+8yJPsmM/IUAXtxOHmsBgGUdcU4
         MFveLxHwCZdxrjGjzKOXeUDlk5hfFwCAiR7d7vkVLAOvITbEn1iJWC0J7SWxEIR6UTHK
         Or0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304008; x=1779908808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WaPoD3mwOT0QqFAF1FBTEvv1PUPRMcMoIqd4RO4LvQ=;
        b=WPT/akJZGVrnxRTOd3PhJyCch4dFaCtOyymT7/bseL4qHaL4stglDIgDVfVDwgzaUk
         J0IrGcQwhCEljm3N6PziJKpkeSCQqjWZAIJIox4TqjgLIRubBcge60XzpXyR4AxUJSnk
         de+HB091fSN+SyjhqacZlbhCWWDvhV0LVfdObPYcENBepEw4tyU73WuL9oqmjg9zxLlp
         92YdxLfAbMMRzYlIoXZ54Ma4KzFqZjGtqDQO+4oO0IPAhZ246AoCoMUC8DT7OGLTdu5j
         nMl61Sa0ImspWku8/EzVzTq0Dc5TPJJxc+og/vpmFZ9pd5kpaCtsX1MyKJQxhj9K/5Bh
         OZFg==
X-Forwarded-Encrypted: i=1; AFNElJ+q9SstrhcaMQBR/LjU1RwQ5KG0eZQH3JJ/CadMRgf2vsr5mNaC3WkWLDgV/cYLxliYvzoDNr7lDiKvD2aL7s+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2/Qm+1rHrSP06BvLF7WC4Z4ALDHcCGwrbRRSODjIYgpmRLof
	6zizNVkvy4jURGXY/XZo+Wb/z1h8yG0HKGEN32pF/dMuEj2Ph5VkhnXeSHNQeFwuovhD1zi/qN7
	qd/H83p9eRw==
X-Received: from dlg13.prod.google.com ([2002:a05:7022:78d:b0:135:484d:8881])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa1:b0:133:54fb:f563
 with SMTP id a92af1059eb24-1350473aa89mr11573491c88.23.1779304007495; Wed, 20
 May 2026 12:06:47 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:37 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-32-irogers@google.com>
Subject: [PATCH v14 31/32] perf kwork: Fix address sanitizer issues
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
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

