Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916B23B63E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043424; cv=none; b=QQdOZcYNVK2j7x0x0w4xSIFNXk7XycnSqutWWaQxCSKOjBL0u08y1LjKPPKi2E687kQ4tbaCoMRzKCGShW9ZVrIiVmtUG9W7OR10xHnEyaPXOP7KIM8V7QUCn9GWzV1BoKp3qlGAb24JpIByafVjgVAADbjESPG5hnN6Mzl8+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043424; c=relaxed/simple;
	bh=66xqwU8TdrCM+0qRvoOnzdTygtIXMVEt2vWeBM6SfY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CtZZM4K8lwcMJkf6iRLjZTAk1f1oH2dbFxzsnPFJh6+aIwXfLFwsEvodYL4DC5n8zHLRw2utSwSZEbrEq+kSiwu9HIgI+zoxdK3VZFuFPgalAddZvCggf1jcHgWzBuwSrgamrvRxT0HnWCUCjBwyxOBWRs+DF+i/C/xmWionLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hehu/7oO; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hehu/7oO"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so12531852c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043423; x=1776648223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiPToYQ7s8nRwPjlKmCIY6nHfGV8vY3NR0sUv4YSbrY=;
        b=Hehu/7oODL37Bk2iXltaHmIB/IjNhzf3Rh2NHDsOhBgApAOXhL134ejhbAJMWcw+Oz
         xcPdft28BgMWDZKaWFVsmNb/evbIoLj2q68H+u500f3dCf+ZxdBRC7wa4NOh0mpoTmut
         rPbPo1OPL530BGIo4Pj0MFyuBTBorgVmSnDdQ05bjRPzRu1vEgo2oKCSNzJnVm18mgFH
         wrEZM4TaUfZox/Y5cprV62CDESVXoeKURYb9Dd/h2JklacVsmH9moAV4UWmSWe6v6fz3
         BqOJa/plhu/a1JpDMGfzWRGy47EvqPxa65kz2qy0taRsiJ6kaMBBI0WlhdDthw34adpD
         vUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043423; x=1776648223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiPToYQ7s8nRwPjlKmCIY6nHfGV8vY3NR0sUv4YSbrY=;
        b=rnLH3vx5eXAHYAekzsRkBjfxyUN+/tKz7JBtKkyBC+dE5D7aMcohQ95Bch2Z5swwMN
         4IO2ZQnZ5MjJ1tvRYSO2Ux9jYqtQbOLarBUv2QZKtxTdVz9uHUwhTwt7dpipD7sGPiyt
         NxfA9Zow4CtzOuiMl8SA0i0qV2qpu0ciL64Jbg385mz5WORsOanUWCwReBww6zEHz4Ef
         8ktXyYBNq7fbFrfjbvxAs6+0WqXWl2ErmXlbBwax/fuznJrI4c5uPlb1xBWp7h3CDZUd
         AVfl74fGElD5OZJJ1Xxw6l/xkASdtNVqvAD1aIC1qvkUtVfTGA+PV1+kngPMlduqyNjb
         ofbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h3mnnmz2870gv1E5y0pF9Yln1NovYnyn5g9P1a/Z80wJQh6Lsh0GIcuTj7KHfZuwoaZ2sVB8THBMfk3GsIL2r@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYW74lVdbiEj25pFxewWRGWpbR2OtCgcQ9lkN25hHx04CjwPh
	RqSpg4JM7jCFCet8qF7s+gSPSdxg8nmrw70Kpk/GC9nDqWkZO/MmILz6YoaX1+7FyzVQG5Ixvjw
	DlBRjYkKqzQ==
X-Received: from dys21.prod.google.com ([2002:a05:693c:8015:b0:2be:4118:56f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb0e:b0:2ce:f3d7:221
 with SMTP id 5a478bee46e88-2d589463e5cmr6290307eec.17.1776043422464; Sun, 12
 Apr 2026 18:23:42 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:26 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-33-irogers@google.com>
Subject: [PATCH v11 32/33] perf kwork: Fix address sanitizer issues
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

