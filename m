Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D438C2AE
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053597; cv=none; b=IlCB7JJx2/hNA94liU5isHy7gqsFV7phdHQMz//9MiQyxHGgtI0J3HtHL9kLtR/QCVvE3vqV+6VzcJ0tFxruor0G40vylrUBCbEpS4g7161hLAsri1zl0imX9ZuKnK3x1RhQjewky1LncEcOHVkD64UP1NNLA+XGcOxFckJgAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053597; c=relaxed/simple;
	bh=66xqwU8TdrCM+0qRvoOnzdTygtIXMVEt2vWeBM6SfY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTaF9Je2Qn8NPVEp7CWF+YjPX5ocO3lXWPfIuMq5lw1Rwn4bME1Pj28ccgnW0tiMeqkHOBmQnQ9TCQnmS5TtmzLNG8mAO9WMNfBypgT6zblO0gr/NuhNit/7/q66rlRi9iiXEjDG7NSjzbjUQrnZe9b9HH56Dl3IvRf8WFqy/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4x7/xtr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4x7/xtr"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so5234527eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053592; x=1776658392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiPToYQ7s8nRwPjlKmCIY6nHfGV8vY3NR0sUv4YSbrY=;
        b=H4x7/xtrNAsmKhvwq2dUkzwKrRx30NWHv93F8eQf98qaP1iEwjE5dosRPLk/S8nCLZ
         1kpkuSp6LIYZSekXLd+vTUWDEG17xnCZL9nck7pqZpCIicTmLzEbI5u08a0jCK6VvjNv
         B2vJh1jQf0fVXOY3iFPP5zJuKP5KpQsX01mC8qOnTgYcDO76FDHUp3jH4q18IOHRZa97
         b9HEV1VRMZDmoPi0nKjmGAGk/YPwLHh11g2FVqXb7a+5C317up7xGwhTJdv9UJhTHZPt
         m4ZK2yYTaFeSFhoQVveotuImNv1jtaJVkzebkJ/+AqeIQVIkgvx2l/Y5bGVdqKnKi53L
         OxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053592; x=1776658392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiPToYQ7s8nRwPjlKmCIY6nHfGV8vY3NR0sUv4YSbrY=;
        b=ZQv/fzV33091qA7NfwFmau+BvBKoN6ria48kcMtpUylV+NkaLyNUFNdv5vZc6hLGMG
         cbt1aAkyPzA92rrV/31MQ/LEUt9xCSnTA80lPu+czswEzVlPdWlDRrX2K1PPjk6XimLX
         HDiwhp2VXCEDUgbP3ITu4CAHnL0QqSvaT6WLPeFArrrkSMxrcRSrfU1VOuXR5UibsWPB
         +LMdX5QmUrIt36NM8H4Zcj30v964CSBxaJ/0u8uYkMglYEhJB+aXGT7tgIFMPyclpA9+
         vNbwie0jNehSQcyuqYk+BDtmgxOmtFsfYpTyrY87paZ3EYaqDlzCcA8lNXtmsP4IG+Te
         0hXw==
X-Forwarded-Encrypted: i=1; AJvYcCWhLLOkXONt5dpyJ0ef/HnHDfypkfzE/rqjcbcpKDvTmc12FUtsLCzUoUMC0AKw2SosnkBKyK+JSixBbfLgSnMH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zzn5vsqT/bkkRcpLvN8e1nAhabyeZpkeY4amViLaeoxzSCMN
	7FsCdJh2mW5zSmj4ecVv6NvodRg5PFL2yXnpOtqPDIr2/wguRLI4E+lk54nhuHEq+2LIRcZT3oJ
	BLWhcW14wQg==
X-Received: from dlbur1.prod.google.com ([2002:a05:7022:ea41:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d12:b0:128:d967:4678
 with SMTP id a92af1059eb24-12c34eea0f0mr6408094c88.23.1776053591851; Sun, 12
 Apr 2026 21:13:11 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:42 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-33-irogers@google.com>
Subject: [PATCH v12 32/33] perf kwork: Fix address sanitizer issues
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
2.53.0.1213.gd9a14994de-goog

