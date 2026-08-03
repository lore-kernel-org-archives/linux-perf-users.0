Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968840DB25;
	Mon,  3 Aug 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765120; cv=none; b=EnIDabtZtvp1FJDSwyHDvtjsVzy6mU9ify+mnOV8NxPlLg8qVGLNdIRVxZYxIboHeImLvToJVVSee2qd7lPbW7hdLmz2wRNfjt4+EaKF/w32BbDRrDJH1IWvdLCHqwA8vpgDmPW2vvTCmEwxOQZMZgTJDW2ULgZRIy0yRSt/2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765120; c=relaxed/simple;
	bh=PJ1AXo1bE4Xib7XSRHSemd8i5WPgCv3avsMGp3YygL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkXCTl288RMY3w7fwdR1feO/FarowRJGKEASHqj9/ADEvLrMO3jm6P8xIZ2M67MSspVTjF9aMMORRjuvGawBYx5aNPyFmWB6tS4Opom0v3wow4im2lYmv6bFPutyQIchSw+FZwkpdc37xoIN+WrZSPoPyGWbaltza6JjH+TTrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iljXzuR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iljXzuR+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCA85C2BCFD;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785765119;
	bh=PJ1AXo1bE4Xib7XSRHSemd8i5WPgCv3avsMGp3YygL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iljXzuR+5OmfdH9dSaAaiEzxSIH11uqyrp+TPTOzX+fKUSvvKqhLQRX4c2owm1EcP
	 6sx3XANfPnbnwv2Qc68EKfJCwW4Q/LxniBUrIbrUNr0Cbk9qhvZ+NjIiHLya+sCfg/
	 l44actuZxot2amIsyy/G5CHdtSe9XCqg5xa9LrbpUg1YQZSvcCCdfcYWdn6sq2EgOM
	 XKE1oGSDKNYUZMJRzKz8ENtKhowQVPSSNv/IO8oBfp8SKfmEYNt9+Hzn7QY1FD6t56
	 lQBEshVwjriDSsaEJKx5CEOYki4xNxGPbUbAwSOZ26MOYTaqDOqFe9c/e7Mtx2yM6W
	 ZxgpiScnTZKzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6143C55179;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:51:54 +0200
Subject: [PATCH v3 3/3] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v3-3-e06268ec06fa@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785765118; l=2577;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=B7Sv0QwuZKxlNQr0I80Lih/KewWi/BiAYs14XtbWNDU=;
 b=cFuraravjFmqBCMXVT84PwL5QT8273nbZCySTuEdsjJMW0LBZyoIfW+j3L/qqXkQcF3FtbCFn
 TQTFSENnlZ2Bjndc8DJDxNA9pzmaxFxRxBVvD6AoXNe0cYRCV7UiF7t
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
 tools/perf/builtin-kvm.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 8e14d037d7d9..04cf9bd5b595 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2132,6 +2132,7 @@ int cmd_kvm(int argc, const char **argv)
 	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
+	int ret = 0;
 
 	exclude_GH_default = true;
 	perf_host  = 0;
@@ -2148,25 +2149,34 @@ int cmd_kvm(int argc, const char **argv)
 	if (!file_name)
 		file_name = get_filename_for_perf_kvm();
 
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


