Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1183C4559
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935101; cv=none; b=IPyqzu3f3xh9/hTB9BLC193U49sjtLYYjXJlU0UU3dR58EREsdpepd4LlQS016pkCQYSk7GtCmXmDNOYi+IGA8jOLDAR5i1vq40rz3WSMJCjUcmOipZStdIyCJkEck6/k+t5hthORiuEARnFLOuKEiqJDg80WiQd+XqnQ+8hbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935101; c=relaxed/simple;
	bh=AhVzzCWbIrOgzDTW4kDVy2c1BohAQENNularfrmecuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRWX+KwEOHV8DgH6QED3tx/mGj8KBMfutlzwH1Pvcmn4n9MIl8roDtBbTtoiIKqZ+LMQ8vybUGHvr/1mHQSMzbMLukzZjgaU7pgG2R3I47ot4H3VTWH9a+YK0tFRyK9VrhWo970kykWgeYniEYrsR83Br0YFV7QOpPR8Cpz99Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUuwRAa2; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUuwRAa2"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-126e8ee6227so4517667c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935100; x=1776539900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QtNboS9t1D02oP5+ZDqEPjvbJuCZxOYWpoj1EJtrHo=;
        b=IUuwRAa2RKhipw0S+WTAnrm0hCueHmp2poGsuxGUeVmmBfVFQ3+S7NSdV0RM43PH8d
         D4IkAfDB/ipeqAsghaIVTQ5cXQ05t1euJlKD0Vbo8r1UCDw8FiCKxHWIBiZ1b6ojTeuW
         IX5vM+hT2EKcu6WCvSytgJf+28BJFjXvR0PKgmTCeToYvq9Bt8fdt6NRxzvMpk9W6ecC
         MPo4uCE5hm+iq6X6gqrv2XilP9tQGt9STHqqzEmj3adylChVTXTYHv6DeT6QsCD23uK2
         8SYehdhfmUdIIBfgS9X4WyLcWHP33YvscGkOjXKdlNHM1PgU4c/jhUxe8oZi4reKN9Nt
         Z/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935100; x=1776539900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QtNboS9t1D02oP5+ZDqEPjvbJuCZxOYWpoj1EJtrHo=;
        b=FqRgRs5g4PLDVu/zN7Jb1FHqbUdBxRZkgHN5oSzDWe3RC8yGWBDqkmVPG5u0oT/1Ge
         dxeFkMQ5Bmx2suF6GQVB5i6wEnG1koNAPSDJKFgLAKoCjmi8dIVOffGYp81pKXX9QxXo
         eCArrJ/iQLHbIRe+wgwjLmNldogh4+Qw+ZEPe0c+ShJUVkTrc3BeSePjqqk4+QeENFdz
         oE9FB3zk8OePkNMpDF/6EUTEJZHdwWe8aZHMCvmmoFudZInYdekuHkTcsTTuAY/dXM9n
         WMxSTB+j3PUEhAjlbJM5O5Y/YlXkMmmFW26h62kceCl34x7ipafUR2oZ9mOkn8A53rcr
         s4DA==
X-Forwarded-Encrypted: i=1; AJvYcCV+GiT+VDIHI8Gpag4GzPIxJTgz4Pw+pT0ENeKscIRSl/wOMoEUAbI5Bk64hCIVH5kXxuBo6D5U/LsRABdxxytH@vger.kernel.org
X-Gm-Message-State: AOJu0YxaV5C+0rXnnAwjkDY6D1GN/jfP7k6ztzDu8eqSqBGZ71irh7wt
	dkgl6g5ZN/TaoEioq4aEq2z7p8AA6h5sotYEzCHaWXh3oni2wRti8WiS1pQLHyltyHiIt4DxZeP
	WED4yVRXnoA==
X-Received: from dlbvv21.prod.google.com ([2002:a05:7022:5f15:b0:12c:177a:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec1:b0:128:ca83:5aa1
 with SMTP id a92af1059eb24-12c34ea25e4mr4643715c88.16.1775935099385; Sat, 11
 Apr 2026 12:18:19 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:09 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-29-irogers@google.com>
Subject: [PATCH v9 28/29] perf kwork: Fix address sanitizer issues
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
index ab17d3198b93..dfc1d43f20a5 100644
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

