Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68234AAE3
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959793; cv=none; b=YOdRZtN+xbX5TXn1Hg12XBtzGzOQ5JkXktaYePT4VgvxJRglwE+3ek7bG6ETIBc1Z86oRX++pL0vIdF4wtBJRZO/zaaH/Leqs+F5L+EGs1JMgonR6ADq8tD/qJZTw/LMCnOJTesmOVeD2hmqKCHg9FGpNXttChNtTK/UW4XGGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959793; c=relaxed/simple;
	bh=AhVzzCWbIrOgzDTW4kDVy2c1BohAQENNularfrmecuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CSEGQR9usUvy1JCvdprnZCrEULvI/Vc+BDS1csQQa6d+oeGpjhASmCIyO8FApH++YBTVBtQo6Jh1AifQu6HUlWK1Lkqmzyb/gGTCEBoMGqR+mKpUHinKEGVrlHofR0x9Cn1ip19IpP9lvelJ06d9aTUjnmSn4UFJlh4WVVLvW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyZrFszb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyZrFszb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2eba42b8dso2103585ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959792; x=1776564592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QtNboS9t1D02oP5+ZDqEPjvbJuCZxOYWpoj1EJtrHo=;
        b=tyZrFszbHXok/oHL1iIex5k3u0OXqb82rHW0H+wIulDKoQGAFljVQJEs9/jsN/Jovq
         3PDg455+fDgBCR3ui+JekjEnZJTzxrqBJLTSEZlfTqPhlgON/zKVoEvYHEc/aZPqwwMN
         a3AlddyHoZqDVfbJCjVJUaMrTX77eXJ+ad9zLvKqnpKblDgt5ReWiya15+vT8ZVf70Lo
         gQuPr6w4nCWyIw3QX6L2zV6Eya1Yr9q8gpd8pH68RvSNpwQ03P8X6rGcONgkxtJt7s+k
         pZwlnBiLMQF6CkbjwqJ3953KzmkVo8J2NxfOkNPDhxycAs/p1kq1RLsADtC6kyNcOfAa
         r7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959792; x=1776564592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QtNboS9t1D02oP5+ZDqEPjvbJuCZxOYWpoj1EJtrHo=;
        b=KjEeYmppeP9zam1gNJGCb2r0az/3stpVA0tCS7BKNde3cGg5hTaNhUT2OHBONmz5NI
         Cs64eW8TUNNE8A4xZTTyaD5BD9VEM7U0USb78Aoc2cER9t40EtshICvqEDA5v+diZ906
         q/l7ysifi56kkg5BD8mNPWvZJSnFIT8LCahTiBALZVBIvY2mJ683PeyBfhG2WRJSP6NH
         k97qF6y1irc6lzlEZYsfzeZwm9XfYssjs5TTOJLSYW4XxkD7wr554kH7YJPIdo2uqTVp
         C3nVtiSQe0nLoU2OhIuTr4wr1MPmudQ6wnzeVt4dYzwQEYUNaXcUOLPUktDYhowMVCr7
         mRag==
X-Forwarded-Encrypted: i=1; AFNElJ+2Sd/uQuklkaUKjEL/l9uPjvRA3t+N4KvKgsfCc3ONqXwaN4beqRZ0vtdiuSwsXkIMiHkHdE1yg+qHQr9bJbvV@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaaR1UVGaDVf00+9qOpJHMTEx1NtbPWGHQg0vGYwiNj4xsXM1
	64Cgp8HmmfDl7/dALlMRbEg4EAn4j1IYTIgXhPSycQ7QhQBfPuLZICGHcNZ2VmTqdkjQD1dqwTy
	Pm35zo1rdCA==
X-Received: from plod3.prod.google.com ([2002:a17:902:8543:b0:2b2:a6b9:31cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1207:b0:2b0:5ec1:97c1
 with SMTP id d9443c01a7336-2b2d5939275mr90438295ad.7.1775959791279; Sat, 11
 Apr 2026 19:09:51 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:31 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-29-irogers@google.com>
Subject: [PATCH v10 28/29] perf kwork: Fix address sanitizer issues
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

