Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42F3909B5;
	Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242083; cv=none; b=FBE+9qWJ0Wp2OkgbwCAbaDkw0LZrhUjR+FWxKy+C3mNH0x1uoAq6xLjQXwDYprWvkseW+KJ6QE2TOo+0K4yB+gKAER2ssKncRPEbrSelJACGOcs59LAxvSg6A0F2lm4rRG/gmKaYZGW8dERqD6jo9Ruq/stBWPPCfzYkwU4a/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242083; c=relaxed/simple;
	bh=YXP5jx3iQohNFGREhFtXawsxrE6QQs/Zq9LgeMM2jvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4yJs2l04qUt5lrnip2GIjydDB6sAnoAtfWCKwpsjcTXvvAeBjT5Md+rQ0GakdKY7EzRuGK87dVeWv/IEhjCc9bcGlGoYDzAk5hVwJm+ZRf/jEjswp1/Gy8uYV/R7b5uO/01SjMHPCYQjM9snYrq7UIR9RdNgMtVGJqRVkB12WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDpzpi9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDpzpi9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0B11F00A3E;
	Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242081;
	bh=w6brHnpupxfvOAehfvBfZ2Y7LDh/jvzSSLqQAgQh0hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDpzpi9Mwcp2/B7QWWE/2PW9YrNBbQCOQiz1HDgmzc2179Zd/BHZcVcbQ5vukfTb5
	 QkNu7rsyzcE3QzXfa1nsA/WyytulTXTuv0BG4P5Pn/CtxcJmGh4VCUxht2x7PKmOAK
	 GqEv57ovPaICwqIkQnXI8NYsJsXnvunnpsF6Q2wc6ACjutNDrqv2EOcjgNRyVz9y/8
	 7R0l3u733sd3+TnWFsG446IhMj7zuGq0TlBCXpyeHIBdVKI/royv0wHjI7gxgtDuXA
	 7S0vxD6A9nsULrbDNUOTLXtwT0Acejy36uC6eh299soERNLvNkqh4aK7LyL8mxsCPq
	 78YtxgfTupnpg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 5/6] perf kvm: Fix a memory leak in the usage string
Date: Tue, 23 Jun 2026 12:14:38 -0700
Message-ID: <20260623191439.3621593-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260623191439.3621593-1-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first element of the kvm_usage string is allocated dynamically by
parse_options_subcommand() if it's NULL.  Callers should free it after
use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4200bf899b51c2a9..15a1fb8075de6602 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2135,6 +2135,7 @@ int cmd_kvm(int argc, const char **argv)
 	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
+	int ret;
 
 	exclude_GH_default = true;
 	perf_host  = 0;
@@ -2153,29 +2154,31 @@ int cmd_kvm(int argc, const char **argv)
 
 		if (!file_name) {
 			pr_err("Failed to allocate memory for filename\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 	}
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(file_name, argc, argv);
+		ret = __cmd_record(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return __cmd_report(file_name, argc, argv);
+		ret = __cmd_report(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
-		return cmd_diff(argc, argv);
+		ret = cmd_diff(argc, argv);
 	else if (!strcmp(argv[0], "top"))
-		return __cmd_top(argc, argv);
+		ret = __cmd_top(argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
-		return __cmd_buildid_list(file_name, argc, argv);
+		ret = __cmd_buildid_list(file_name, argc, argv);
 #if defined(HAVE_LIBTRACEEVENT)
 	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
-		return kvm_cmd_stat(file_name, argc, argv);
+		ret = kvm_cmd_stat(file_name, argc, argv);
 #endif
 	else
 		usage_with_options(kvm_usage, kvm_options);
 
+out:
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)kvm_usage[0]);
 
-	return 0;
+	return ret;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

