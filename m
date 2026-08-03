Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C616407CEF;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762363; cv=none; b=TKzDHXx7+640s31pKEGdI8eERvYO6HCC3rpmBYtCYhhBuF3LCLTqfOs7rLNkJpKbef1LQJm0uynULWZnhCLVK+aW+NuTta1Yk1miJGbUb5HX38HNkIrnZqyISez7lLBOKJGOk+LA0ObnwOln8AIeNs5uMjem0iOPOKWbbKZWNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762363; c=relaxed/simple;
	bh=oDdJJMuKNO3H+bCiHiwxsjq3cEGataF07+cCdOiEYCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3ZX26s972ykpJq9+SqoCYriZbXRjsurRiIRoDI1XPG2jx1sxhQXasG/dWazP54mlt2IY/faP9eLJJGR+5vkp+iLY5OO+ZYUlUH+3ma+SpWtLPsKf6wZUAE3tEyTTf5Y5s3BchvmOvz4ii8VhD9kUbck1WlKnHgU7zf+btAMV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2r1glEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2r1glEN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C3CC2BD01;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785762363;
	bh=oDdJJMuKNO3H+bCiHiwxsjq3cEGataF07+cCdOiEYCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L2r1glENIz+k4brdSn2aPNfQsTxv2Gu5HUNveg4H3u10ENRX0q+ntIgtByOus49a7
	 VMKT8JfdyLPioYqm5Rbvt3JumwDajdfxW+IL7pjdyl+/cAWA5ogyPD+iT+tkryDBHU
	 n9E9ouHrp/TQkI2pjTOuxdUAgj/WPb2414deWDz7H0Dv7+cTwGIGSwj/BLkHHXnwBY
	 VHVj093SZlvUHsc8L+4ddVLY86EgTKQBuSbeNEN+MPmUrICouj66PNM6MyCNlGwLeh
	 3XYHLpM/imADrsTbU9xnCT2kmsNifrBx7CiMFAg+FZZ2Vh+L2mSflrZrpg8+tcqbA3
	 dBuGOaXqvrCrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7BC5518F;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:05:43 +0200
Subject: [PATCH v2 4/4] perf tools: Fix double frees and memory leaks in
 cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v2-4-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785762361; l=4794;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=z6X3oSKhsyfdnOLkccB8N4HoUfze0laWnW5PzY5GJoA=;
 b=ymrMWY4X2sAw10OkaJmxwti/3Zhw+en9SfBnDjAtgfYlnUgANPBild2Zu6TnkbyqewrvpnwZn
 XS2I72ygwhDCNfMU91h2Aai4aSZHLfmMcsz0CYE5kfa3+a41x7YMPkG
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

The involved functions follow the same pattern as kvm_events_record().

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c                         | 36 +++++++++---------------
 tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c |  4 +--
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c     | 10 ++-----
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 9504c83e2074..04cf9bd5b595 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2003,11 +2003,11 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
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
 
@@ -2018,8 +2018,6 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2034,19 +2032,16 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
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
@@ -2062,19 +2057,16 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
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
@@ -2094,7 +2086,7 @@ static int __cmd_top(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < argc; i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[i]);
+		rec_argv[i] = argv[i];
 
 	BUG_ON(i != argc);
 
@@ -2105,8 +2097,6 @@ static int __cmd_top(int argc, const char **argv)
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


