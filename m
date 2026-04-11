Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119A346E7E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890711; cv=none; b=ByK1JnThuhaReARWeFoq+FPVgdVa0Xzsut+lMgdz+z9RruixdWkve37mS3ETXfVqSp/4ZuD8jSsUVUdYM/c4l6+jB4jmbiNHMgpnZtVg5ykz83LFpKjv5YllaMO2Nks5SU1D6YiD47OkH/+4VqyxrrzzKOf9Uf5WavCukvgvtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890711; c=relaxed/simple;
	bh=zfGZAJWU2BQFTm93lpWy1haXcjHKon5TrlP2h6xOQqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cdsls/t/spg4wPEYseW42ekfoUnd7DJLo0eNkoxVTlFj7MTmw0ZcfbZJlS5W1+akfAxJS7fnyvl9NjQdrRSfo74QEJzexswwx7GkoaZK1DIcGN2hl3iZ/hBaS+XuBU5/EAjXU/SFr5Aa/aESxJ/ZpLQUnaUDdP6sW1Cj4SmXo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CosY0wav; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CosY0wav"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c895e7de52so8579950eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890709; x=1776495509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knO6Q3Qzbr0DksWoyH2XRDyuHYQRjRm3FvEd91Er+34=;
        b=CosY0wav95yihd+U7GLatmQI1jDkK+7i2trjymhH3bvgj1XRr8Wo86H9apkvugPLge
         x15h6gLorzxxqWhkM6a9cpcVrRKPbEKgjGlvOHPc+KlFCELJA3y400pk0H0opE40bazA
         00kcTwFUj3PBNiqi/+MRTyS5FXilhK+R/VXoXI5g1qy3Z2H9xhqRGxsgyiUaYq70RbwK
         daqiSMj99yn23JoXAqpXNtZ4Iuu7VRu4UfyGVTosYmerBTL12Zta1D/mas3w1MHOW+DS
         d+TyhU8pEqbyitMlV7kGW4sOU56Ac4NxVNGNo6t4E/o/GW+WYE9ilXhHZtCrsTpjLn1H
         Lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890709; x=1776495509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knO6Q3Qzbr0DksWoyH2XRDyuHYQRjRm3FvEd91Er+34=;
        b=S05RXaqZsHRc4ybTlCCDKcudFIIQ8469heeeuEEs/YxQVLthSlbVyHwNaqBg18y32a
         Xv6GVpWL3IhqEROyvCO18l+Q2FBbQVWC6yRBy187duAXP77Kt4EavMysWg+a6GHn/sUf
         fq7X3Rgozczn4Jsxc3bCJ9PuPlaTXbv5rTcqUBPodhHmbMvWAa6KQut+lYI1wCXa5HIe
         JOESbnUtM+l3SUDrNrWgNYymbRTBUUismNxB+jQN4DkEdS8HojMNDI/qBE2yQSoIZ1V3
         zOlyyG036oCtO42vssg2MkQFJADjZm70DlZ9YuxFsfEgoc2nG8fkNatpbihCGuDFOm+Q
         u9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVrnzTxVIYQdiFcQe5+wk7HJpjpZ3xiube1+EI9CvPcOpzOC1MFipWwxyWLYrO9J/UsL/tNn7DHT/M/M1JO8t34@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhiEAQDTykFMwHxtXZcUreGvbWM8SwSOhQxbw0J/ir6sI2U6d
	7vuI/suFleVq0OdVRUfWl8zzo3F6xwWDG+PCT0JjmRwbybDZdPBIuEtHNFq2FzAk2Trs4BfbwqG
	igeDhw3GVHw==
X-Received: from dyr17.prod.google.com ([2002:a05:693c:4011:b0:2d2:de31:8da0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:220d:b0:2c5:ed1b:c8a
 with SMTP id 5a478bee46e88-2d5871bcb9emr3846515eec.5.1775890708904; Fri, 10
 Apr 2026 23:58:28 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:17 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-29-irogers@google.com>
Subject: [PATCH v8 28/29] perf kwork: Fix address sanitizer issues
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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
---
 tools/perf/builtin-kwork.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index ab17d3198b93..8430a79a02ba 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2258,7 +2258,7 @@ static void setup_event_list(struct perf_kwork *kwork,
 static int perf_kwork__record(struct perf_kwork *kwork,
 			      int argc, const char **argv)
 {
-	const char **rec_argv;
+	const char **rec_argv, **to_free;
 	unsigned int rec_argc, i, j;
 	struct kwork_class *class;
 	int ret;
@@ -2279,6 +2279,9 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (rec_argv == NULL)
 		return -ENOMEM;
+	to_free = calloc(rec_argc + 1, sizeof(char *));
+	if (to_free == NULL)
+		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
@@ -2296,15 +2299,20 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 	BUG_ON(i != rec_argc);
 
 	pr_debug("record comm: ");
-	for (j = 0; j < rec_argc; j++)
+	for (j = 0; j < rec_argc; j++) {
 		pr_debug("%s ", rec_argv[j]);
+		/* Save the pointers as the array will be mutated by cmd_record. */
+		to_free[j] = rec_argv[j];
+	}
 	pr_debug("\n");
 
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
 	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
+		free((void *)to_free[i]);
+
+	free(to_free);
 	free(rec_argv);
 	return ret;
 }
@@ -2447,6 +2455,7 @@ int cmd_kwork(int argc, const char **argv)
 	const char *const kwork_subcommands[] = {
 		"record", "report", "latency", "timehist", "top", NULL
 	};
+	int ret = 0;
 
 	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
 	kwork.tool.mmap	  = perf_event__process_mmap;
@@ -2463,7 +2472,7 @@ int cmd_kwork(int argc, const char **argv)
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__record(&kwork, argc, argv);
+		ret = perf_kwork__record(&kwork, argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
 		kwork.sort_order = default_report_sort_order;
 		if (argc > 1) {
@@ -2474,7 +2483,7 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_RUNTIME;
 		setup_sorting(&kwork, report_options, report_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__report(&kwork);
+		ret = perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		kwork.sort_order = default_latency_sort_order;
 		if (argc > 1) {
@@ -2485,7 +2494,7 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_LATENCY;
 		setup_sorting(&kwork, latency_options, latency_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__report(&kwork);
+		ret = perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
 		if (argc > 1) {
 			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
@@ -2494,7 +2503,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_TIMEHIST;
 		setup_event_list(&kwork, kwork_options, kwork_usage);
-		return perf_kwork__timehist(&kwork);
+		ret = perf_kwork__timehist(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("top", argv[0])) {
 		kwork.sort_order = default_top_sort_order;
 		if (argc > 1) {
@@ -2507,12 +2516,12 @@ int cmd_kwork(int argc, const char **argv)
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
2.53.0.1213.gd9a14994de-goog

