Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7B3B5304
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625094; cv=none; b=SYJj69RAuzmi0WJF+PoU40yQRy0+YCdK77HIUKbhhUl3F7ryK/NmT6RZ9CJY2C8qvXhnp7N59k1uibw3NhKnJP1Pfft+oqa/9hWWKins4F5jg4YRbh9I9kTjXqMRW2uz2TeaGQburv1YiwjbOldblNdgqvWJq3s0CeDmvGrtRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625094; c=relaxed/simple;
	bh=J+Y/mPacVQSHAb83VbNZlRjGzXFOtEgvMkoiTDdNR8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJxCo8+y/r7541txSjsWG72Ynpr4mfZA+CfvPspR1kUgNjym/WfgvlUzVaC0PgEO82CUf7tILkaw0+AbT01XKCplyLJkTVv0aQpccEpffRVFwDiaWlCo9vgTBF/hIzaAPP/O/pI5Kh6mk4bjz4PrfjyS0//8a6DLjcl1HxiFOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF8gjsYA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF8gjsYA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132c3280e03so598150c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625092; x=1779229892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIbVOdOOX4K4nsDYgP8z1J4MAd6oqf0Q02C/dHVBqc8=;
        b=lF8gjsYA5IHlQYVr+3f7StYmr+En7JbDH+mJ71hTJ609voojc9xmUlmIxbY3OYwtrh
         7hOQvl44XKoX05JeDRU1XjEdVOM6yUty0syr6pNiYOxZHZT4naZB4addaaBlWwL1vkGh
         kWSnoWGQ/OfSZEkCPu1BJy0yBumhFRilFM8F7b+kdk0M4EClwxGC6B8MJN8WP57e/ShP
         +qLM03JFpwNogOde+LPs/4+DscrYYTb52CHL53JcGMlfUaqx+9ryrvaz64iQVBd9Iot3
         HxFDqfNNG5bxx1M6O8Uavol/tk9R083MouPZ8SmLDy4G+r6Ih+26PBVyBGTA6bcVIQLk
         5DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625092; x=1779229892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIbVOdOOX4K4nsDYgP8z1J4MAd6oqf0Q02C/dHVBqc8=;
        b=J0aIOLDT6mIpESQWQ7oeaf7fqtRn2c3Ci9blBeJ4u72+/vrKJUYoGNpE67jt/p3p7f
         Ur9rcT3uyWvXZ/huVgt5EJ5BDpB3+OiupDolp5VqYoEPEPgocoU1IApI21uQrbdbmjoj
         aWlUqSPKxN9FXulYvbCfC6iSs73fPbOzN94BDCBS5RJhnLrlo10U2m0qpcHYb1nuaPFP
         4F7VshbfAvx8YhnpziSgeZmGRRYQNStjHQZNisJaKItTCWsjqp+8QdhNCjv6uEsUnE5D
         9UJNdOfhBxzHcC3iZFXe5FpgmoOu2IUgTefPgDD0jm5Q3KIOPpOKz6+XvWlATgqhpjZ/
         hrFw==
X-Forwarded-Encrypted: i=1; AFNElJ85oOrDINbVKR624kn+SV0X+ejyXFOcmEZEA9mDv0QUCSoCkOTPNaXoVJMCWINgr73cVzM6SopMWts0RBvlNv3q@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnO+uHOVFXTimG1TZm4IeJDCOZlWHcgflhT/MFM0EoeI1kN8K
	/yb+LgGyXc7/V/53ecbBtBcu0KktXNWv7kx4k8jTKDM35gXgjHDsGUPi/CzFCjmX+lLmmCcxGce
	HtR/XmP4nLA==
X-Received: from dycoi4.prod.google.com ([2002:a05:7301:da84:b0:2d8:1265:1a34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2385:b0:119:e56c:18ab
 with SMTP id a92af1059eb24-13436780a2dmr532688c88.19.1778625091650; Tue, 12
 May 2026 15:31:31 -0700 (PDT)
Date: Tue, 12 May 2026 15:30:00 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-32-irogers@google.com>
Subject: [PATCH v13 31/32] perf kwork: Fix address sanitizer issues
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

There is a double free in the record array due to how parse_options
will mutate the array. Fix by keeping an array that isn't
mutated. Ensure kwork_usage is freed on all paths.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

