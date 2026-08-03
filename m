Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B341A4F8;
	Mon,  3 Aug 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765120; cv=none; b=eB7Au1sW4vCyyg9oHOHx2Gph6fypT7qEQOzv+ENUpuSAZctXjGw4f/zaV+GUIke2goirZWkbWgQIhk0oE/GZJJMK4li/RmU0eqf5zwzhaOF5SV7sr+J1dM11Gv+UQ4VRLyeYYoQ1Qh+uOSiXHZVbeQBqxVyeQdBOi6jV/u9mu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765120; c=relaxed/simple;
	bh=bjd+dx76baLZRoTBIv1V7NebSOO9zBQIv9I4rk4CyfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hY/jXc2nHjTdSssQSIPlDz0CAFcq4+DTih/kPBU3dKghKDHFAup1j/BbGmMTdRjiAEVBB/akS1S4A0fMEibgtBjnVfW71QDM9YyS/RPAhY8FP9jcmrl617a/HZ7g+gifoq+mWdjwk8/HNd1Xn5UcXTH4FnsIMYpjYCvGXS8e09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL2CRTHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL2CRTHk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D245AC2BCF7;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785765119;
	bh=bjd+dx76baLZRoTBIv1V7NebSOO9zBQIv9I4rk4CyfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DL2CRTHkyif8ee21N21p5XqBs/ACNsuFyiQEGmyNG6EZ4QcANBz2yBHtmFvWH0pzr
	 pwCza5ciTNJc/+qb3IvYckzOheg7WfJF9vkYcCqCWDOnDdLkFEGsfhceLAxsSV705H
	 ExwIq1YJv87Bz6DnuGB4tgkOVZWaK6ujHGXMcnoqkpETUGTWsqKC8OfjCy6x1WrT+5
	 QmA1qSmIrfDVeMpqhORTd8X8/W4QOQ8aK1F1OiLYtFDQFhogesXFjoK96bnEv/9ZWy
	 TclGqOa3yV0GawiDW0af7MDM0OZR5jOSVQCur6/Xr76XLKAT8vCvzL/y7DsY+oM0hZ
	 Wyh0kIpSG/e0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B664AC5518F;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:51:53 +0200
Subject: [PATCH v3 2/3] perf tools: Fix double free and memory leak issues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v3-2-e06268ec06fa@gmail.com>
References: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785765118; l=6450;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=pJlrs2g9K4W+VPjPzId6fOvC6ZaAAwlqcisBbFjHGDQ=;
 b=wlwDVDvesTS+7ow5n9HZXUAhYE/xzE6YaTzvh7Lh6YDlOyj9tyqBAUW0v23osz7d7Sa0fC29/
 rTaiu32VXrjAs8ZUVfN6ctdpzEu947hY0zlSIk7oCoFUFt9afVUNyBK
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

parse_options() reorders the contents of the rec_argv pointer array, so
its entry order no longer matches the order in which the caller
originally allocated them. Freeing the contents of rec_argv by
iterating the reordered array results in some pointers being freed
twice and others never freed.

All the entries of rec_argv come from literals or pointers that are
valid for the lifetime of the respective call. Reference them directly
instead of duplicating to remove the need to individually track and free
each entry.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c                         | 51 +++++++++---------------
 tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c |  4 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c     | 10 ++---
 3 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 16cfa7ce7856..8e14d037d7d9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1681,18 +1681,18 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < events_tp_size; j++) {
-		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp(e_machine)[j]);
+		rec_argv[i++] = "-e";
+		rec_argv[i++] = kvm_events_tp(e_machine)[j];
 	}
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(kvm->file_name);
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = kvm->file_name;
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	set_option_flag(record_options, 'e', "event", PARSE_OPT_HIDDEN);
 	set_option_flag(record_options, 0, "filter", PARSE_OPT_HIDDEN);
@@ -1717,9 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	record_usage = kvm_stat_record_usage;
 	ret = cmd_record(i, rec_argv);
 
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2006,11 +2003,11 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("record");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "record";
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = file_name;
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i + 2 != rec_argc);
 
@@ -2021,8 +2018,6 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2037,19 +2032,16 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("report");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "report";
+	rec_argv[i++] = "-i";
+	rec_argv[i++] = file_name;
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i != rec_argc);
 
 	ret = cmd_report(i, rec_argv);
 
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2065,19 +2057,16 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("buildid-list");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "buildid-list";
+	rec_argv[i++] = "-i";
+	rec_argv[i++] = file_name;
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i != rec_argc);
 
 	ret = cmd_buildid_list(i, rec_argv);
 
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2097,7 +2086,7 @@ static int __cmd_top(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < argc; i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[i]);
+		rec_argv[i] = argv[i];
 
 	BUG_ON(i != argc);
 
@@ -2108,8 +2097,6 @@ static int __cmd_top(int argc, const char **argv)
 	ret = cmd_top(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 96d9c4ae0209..37f36c6bf895 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -196,8 +196,8 @@ int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv)
 	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
 	if (!event) {
 		if (perf_pmus__have_event("trace_imc", "trace_cycles")) {
-			argv[j++] = strdup("-e");
-			argv[j++] = strdup("trace_imc/trace_cycles/");
+			argv[j++] = "-e";
+			argv[j++] = "trace_imc/trace_cycles/";
 			*argc += 2;
 		} else {
 			free(tmp);
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 788d216f0852..67babdd3daf1 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -213,7 +213,7 @@ int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 {
 	const char **tmp;
 	bool event = false;
-	int ret = 0, i, j = *argc;
+	int i, j = *argc;
 
 	const struct option event_options[] = {
 		OPT_BOOLEAN('e', "event", &event, NULL),
@@ -233,17 +233,13 @@ int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 
 	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
 	if (!event) {
-		argv[j++] = STRDUP_FAIL_EXIT("-e");
-		argv[j++] = STRDUP_FAIL_EXIT("cycles");
+		argv[j++] = "-e";
+		argv[j++] = "cycles";
 		*argc += 2;
 	}
 
 	free(tmp);
 	return 0;
-
-EXIT:
-	free(tmp);
-	return ret;
 }
 
 const char * const *__kvm_events_tp_x86(void)

-- 
2.55.0


