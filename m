Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521E409102;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762363; cv=none; b=uzx1UtLOwRNoC8SDpGFDXrwg9hwejcH9iLeEsGe3AXhn7l2INAYIIhEi5LpAmvN+XH2PH6qtN2n0FK7oOYsz+Lu0wK77J1sawz4KSeHBnd417zaccY8xUO2rV8JAsrhvhMXa896Td/f0KF/K0lKZm8asvgvSWYNdpZI8tysnehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762363; c=relaxed/simple;
	bh=TWe0OFK7porf8g+khMEL63DGnOEpJVLYvbl4lIZaGs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+9j8lM4u8eDps97kzghKMCGooWaVAHUIPAK/32n1boDTXyI6ll1Udql1X9d1UbfF4WlP3EqFn9vhspwHSBP9FILN7KLR+B4EA7qTZ64i5mF8IMpR4edoW6Zn2D8Kcpdv3DSzBfYQXhW+IW98GGrsuCnIg4vIMZAWp0yO9UYuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNLyklV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNLyklV2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FC87C2BCFC;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785762363;
	bh=TWe0OFK7porf8g+khMEL63DGnOEpJVLYvbl4lIZaGs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NNLyklV2CirbZK0T66NS/RMBDNJfMJKNBYR4gUHz8swLtK+Q2xO1U0XwnN8xfD+KU
	 +8VE4tfsXzUcz9wfqc2b/L9VWPyMFKcGf1lLaQ/k4IR2QXM6m5vImRkVzR7L09sl/o
	 V5EHrm0MsxcP94w6EiziPGYWbse4rmquPIbIohKIGgdsgIMS+VRXaTxxaaZ9V4lD+h
	 SgLblZAu4HW4z8DVEe+eBlfVw4JlGcbP7K9VbVYlDLlgdQGz8qMgK6/Vr8zIQ8tJlI
	 U1y//UsAzYbNcefVbMU68uTNWEn85/A/BGtXhNTS6JgnnfMmAuh++z3kGku/3JtVpv
	 zIejp/K+3qvKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEAC55838;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:05:42 +0200
Subject: [PATCH v2 3/4] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v2-3-1b337189fffc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785762361; l=2755;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=HkNw5v8BoZZtsCQmPPshnIYOOv6PLxL6oX956SB8+Qk=;
 b=U7o4nEEy2TcRMK0E3t/qCT4uaSg9nA8hMKaUSgQGOtytMrRKFcv+4kb30hM4eGKB92QGestwF
 YwU7UEvJ61pDrzPP8q79Iptbk+oCNCKJVULlkq50tk42oWh3QIQP9y9
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

The usage string is allocated by parse_options_subcommand() and freed
only on one return path. Using a single return point guarantees it is
freed on all occasions.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 45c92ab74fdd..9504c83e2074 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2142,6 +2142,7 @@ int cmd_kvm(int argc, const char **argv)
 	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
+	int ret = 0;
 
 	exclude_GH_default = true;
 	perf_host  = 0;
@@ -2155,34 +2156,37 @@ int cmd_kvm(int argc, const char **argv)
 	if (!perf_host)
 		perf_guest = 1;
 
-	if (!file_name) {
+	if (!file_name)
 		file_name = get_filename_for_perf_kvm();
 
-		if (!file_name) {
-			pr_err("Failed to allocate memory for filename\n");
-			return -ENOMEM;
-		}
+	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+		ret = __cmd_record(file_name, argc, argv);
+		goto exit;
+	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+		ret = __cmd_report(file_name, argc, argv);
+		goto exit;
+	} else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0])) {
+		ret = cmd_diff(argc, argv);
+		goto exit;
+	} else if (!strcmp(argv[0], "top")) {
+		ret = __cmd_top(argc, argv);
+		goto exit;
+	} else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0])) {
+		ret = __cmd_buildid_list(file_name, argc, argv);
+		goto exit;
 	}
-
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(file_name, argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return __cmd_report(file_name, argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
-		return cmd_diff(argc, argv);
-	else if (!strcmp(argv[0], "top"))
-		return __cmd_top(argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
-		return __cmd_buildid_list(file_name, argc, argv);
 #if defined(HAVE_LIBTRACEEVENT)
-	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
-		return kvm_cmd_stat(file_name, argc, argv);
+	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0])) {
+		ret = kvm_cmd_stat(file_name, argc, argv);
+		goto exit;
+	}
 #endif
 	else
 		usage_with_options(kvm_usage, kvm_options);
 
+exit:
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kvm_usage[0]);
 
-	return 0;
+	return ret;
 }

-- 
2.55.0


