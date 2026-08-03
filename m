Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A03389DEC;
	Mon,  3 Aug 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753206; cv=none; b=BphCAgHek+ulC6UqX2Xh+NZlrQGvCSa4xznN1FHu/GIVu1aswl30Y9vYNW+5k9wqXyUlVymApwenWqYQPP8zPJwBmidoSliNiZ8bMo1l/3PIV8P4jaaWAkRtt47OdYjAJ30KHJjAeXdfTAT+7z3RknJgtMo9JpbVFbh8fHKOHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753206; c=relaxed/simple;
	bh=ze3/aIIA1Z656V9GipRlbTXw90aS1EjG5KR5o6i1Kvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSlGsxT+2uyOJBOWZH48miVaRa1HyonkjRCbZCKpCZJ7WyjUO5UC6uiH2iKEQn2P88aAx7UGUJzMA4HvXiC3PsZ8BvQcSwOugyrI8U+nmADIEOBpliDlQm36rQGDZ3RTI8/mKthtr7lPhoyiJbxpHoFO59CwjFujiFCuhGeYb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYFlnG8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYFlnG8u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C280CC2BCFB;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753205;
	bh=ze3/aIIA1Z656V9GipRlbTXw90aS1EjG5KR5o6i1Kvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VYFlnG8ueth9oLL0Ux34ru2jZ9XGPNiLLv+iww6Ejb9GnqnnSWigZ3wcX3I80f4+a
	 TRmNgFNR9qZlS6vYvFJ7l7SreWR9aNDiuaGxhI9GVI14z4zuWHaBChpMneX7EM03tg
	 T4AtCG9k/Osy235a7OSqT3FQYXxVoFXOl6hr/uq4cm6gvYhgqeNw0Lqrcw9/s6KrZi
	 FPBuoMBBs0vKxaSj3ffrBw+E9IG5OuSiWlfFCSxbHziCAchomhuj+60ufmn28FSsI6
	 jh8cyMZT44yJ+a8Vv8Ka9k619+misWKOw7C4EcDrnxwwESNslFIVsiG3UbcASfd0Wq
	 8L7D4PrUVKLvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA79C5518E;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 12:33:23 +0200
Subject: [PATCH 4/4] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v1-4-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753204; l=2666;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=aAXwiliLnci6ARcvdP09SP99aBXKZEyzobOz6tm8hbA=;
 b=1HQJR92TTBq0FroPdOZA3NsqlEbOi/eh3gya1ArmHe/YqCqXG/yB1xKKbd9s4KbDvgWa9eNj8
 uu4K3EbE7WZB7ScJc+nn1uROs3i2P9Hsn7Hce3RKQ72cWvH1r0zqN3M
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
 tools/perf/builtin-kvm.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 189ef3576e34..56062c305db1 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2145,6 +2145,7 @@ int cmd_kvm(int argc, const char **argv)
 	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
+	int ret = 0;
 
 	exclude_GH_default = true;
 	perf_host  = 0;
@@ -2163,29 +2164,39 @@ int cmd_kvm(int argc, const char **argv)
 
 		if (!file_name) {
 			pr_err("Failed to allocate memory for filename\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto exit;
 		}
 	}
 
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
+	}
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


