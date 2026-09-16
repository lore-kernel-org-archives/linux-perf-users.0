Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5D3EC69C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541589; cv=none; b=jPRlHULr0xCk6yj2WEDag8hUsgCJjJ3OXEAyOQnKPvBLEWX763zzucxd9pMfRLFa0vYIDjcJCGjs4dW/pBgiDwSAAHtlfqeXC0tB+OXEXAKyi2Vc8O9G4sJyY82/qq2ecwAhUMKWByc63zHpYkH9T5Eq+rv9RWxaB4Bi/PcuOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541589; c=relaxed/simple;
	bh=BKyTd51t2e5Cxj3jJg/TappJONxcTkjP26rugOpT10w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+aCRiPoYqEUiLNKqvRtFoamsEv8xrwTZvjmPIMHwbkXHjXPzcqIdUscgJ/Qufy/ZM5CK5efUcSVWCMlwr5senSRwH3bmFHLqOuxrm7MWqy8ouCLVk/KKMLJFoQ3VgTNw4I502MW2mozI4/feZRIJ5LOEbPsnOia1zZFbp2GwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJ6mfILy; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ6mfILy"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so9015481a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541587; x=1790146387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9WqkkejsQfQTZ0hsJ7KZ+NWa2V5FukX8wz10D5FHnQ=;
        b=CJ6mfILyWf3KV4oplkm4aL9KcolOI0SX6gNls/MzZ4QBV/iwpQjDcSlelbLv3T0HuR
         sTpNVJWFGImpeo33lB6e1IjRdljeVChqI30QLRMqJp5ozr243xE4aFS5xdl4QStcxzZh
         N7Xrh8/FOODGU4c8IFQpRGXjWkXHIFIAjg5gKCf8MRxJYHm/H3ZgYnUJV59MZYZqz7zk
         9ddZetb1cu02KmRBzWoQ6WnzCqy/jbkgA2yeUTbkr5ejQoH5rNGgPEcEQtiuCFvP6nKu
         nObonuELVLPAyvkOqf2OPJ4SrObH810G72gQZUuRIJKQ8KBb+dp0GeP0baM9MorCNeun
         RmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541587; x=1790146387;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9WqkkejsQfQTZ0hsJ7KZ+NWa2V5FukX8wz10D5FHnQ=;
        b=mTivuV+CXTYKMwDm/RDfTxaFcuWV+hv4efipIwtr4Pim2scU93ahAPdlYtepEGH9m6
         1yVA5WLUISqCR44FLjMLjjRKAH+D5DOshZr3z9z5uPHIq3qFveWxFhVzmH267aayMI0K
         9YwIUVB2g929RgrFp1Ug4LsiAEQvsfD7QwZzV5xDD6OJvE4uW5+qohZ/PiRm7AryTphD
         4PTawYGx0JS6WORpVoNF2t24yAIeTeoJhuR55bALIU591hxO650MngEhSQ3obxg41GEK
         8rshFuOoVRseMndhq4+51vq+BNvRfSCZLqRJLECJDq07NfD1zxqCiaOW5TVdlG+6pD00
         HEsQ==
X-Gm-Message-State: AFuF++nW6mvWAfwfFgvixGarDYfhnhHeJA8NiM3AJ1PPMU9hfp0LC1JX
	mCZQ6TtuWTJhj1sy4ZZFRHLC+c13jjq5sXODjq9XSiMBdKoagjuS2IDpueGNhdtS3lsuQSYqeqZ
	kEN1LfN1TmQ==
X-Received: from dloo7-n2.prod.google.com ([2002:a05:7023:a47:20b0:143:75e4:2eff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50c7:b0:39e:b15:7950
 with SMTP id 98e67ed59e1d1-39e1e4eaeacmr3740803a91.23.1789541586829; Tue, 15
 Sep 2026 23:53:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:46 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-8-irogers@google.com>
Subject: [PATCH v2 7/9] perf config: Add core.hybrid-merge to configure event merging
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provide a core.hybrid-merge configuration option in .perfconfig
to allow enabling hybrid event aggregation by default, avoiding
the need to pass --hybrid-merge explicitly on every invocation.

The config value is a default rather than an explicit request, so with
--hierarchy it is ignored with a warning, while giving both
--hierarchy and --hybrid-merge on the command line remains an error.

perf stat has its own merging options for counting, the sampling
core.hybrid-merge deliberately doesn't alter it and its
--hybrid-merge must still be given explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/builtin-report.c              | 16 +++++++++++-----
 tools/perf/builtin-top.c                 | 22 +++++++++++++++-------
 tools/perf/util/config.c                 | 10 ++++++++++
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9b223f892829..73a320861dc1 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -217,6 +217,14 @@ core.*::
 		Sets a timeout (in milliseconds) for parsing 'addr2line'
 		output.  The default timeout is 5s.
 
+	hybrid-merge::
+		Merge matching events from all hybrid core PMUs into one display
+		by default. For example, if a wildcard expands to run on both p-cores and
+		e-cores, this aggregates them into a single view. This applies to
+		'perf report' and 'perf top', it is ignored with '--hierarchy' and
+		doesn't alter 'perf stat' where '--hybrid-merge' must be given
+		explicitly.
+
 tui.*, gtk.*::
 	Subcommands that can be configured here are 'top', 'report' and 'annotate'.
 	These values are booleans, for example:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bda4836fc524..30c6664507a5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1324,6 +1324,7 @@ int cmd_report(int argc, const char **argv)
 	int branch_mode = -1;
 	int last_key = 0;
 	bool branch_call_mode = false;
+	bool hybrid_merge_set = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
 						    CALLCHAIN_REPORT_HELP
@@ -1460,8 +1461,8 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
-		    "merge the same event across hybrid core PMUs"),
+	OPT_BOOLEAN_SET(0, "hybrid-merge", &symbol_conf.hybrid_merge, &hybrid_merge_set,
+			"merge the same event across hybrid core PMUs"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
@@ -1562,9 +1563,14 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
-		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
-		ret = -EINVAL;
-		goto exit;
+		if (hybrid_merge_set) {
+			pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
+			ret = -EINVAL;
+			goto exit;
+		}
+		/* A config file default shouldn't fail an explicit option. */
+		pr_warning("core.hybrid-merge ignored: --hierarchy cannot display merged hybrid events\n");
+		symbol_conf.hybrid_merge = false;
 	}
 
 	if (disassembler_style) {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3bb3337f1244..02b76f6bd0bd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1314,9 +1314,11 @@ static int __cmd_top(struct perf_top *top)
 	}
 
 	/*
-	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
-	 * and hybrid_merge is false.
+	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE.
+	 * Merging affects the event names as merged events share a name, all
+	 * other stat_config behavior is unwanted here.
 	 */
+	stat_config.hybrid_merge = symbol_conf.hybrid_merge;
 	evlist__uniquify_evsel_names(top->evlist, &stat_config);
 	ret = perf_top__start_counters(top);
 	if (ret)
@@ -1493,6 +1495,7 @@ int cmd_top(int argc, const char **argv)
 		.evlistp = &top.evlist,
 	};
 	bool branch_call_mode = false;
+	bool hybrid_merge_set = false;
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
@@ -1500,8 +1503,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
-	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
-		    "merge the same event across hybrid core PMUs"),
+	OPT_BOOLEAN_SET(0, "hybrid-merge", &symbol_conf.hybrid_merge, &hybrid_merge_set,
+			"merge the same event across hybrid core PMUs"),
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
@@ -1691,9 +1694,14 @@ int cmd_top(int argc, const char **argv)
 		usage_with_options(top_usage, options);
 
 	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
-		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
-		status = -EINVAL;
-		goto out_put_evlist;
+		if (hybrid_merge_set) {
+			pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
+			status = -EINVAL;
+			goto out_put_evlist;
+		}
+		/* A config file default shouldn't fail an explicit option. */
+		pr_warning("core.hybrid-merge ignored: --hierarchy cannot display merged hybrid events\n");
+		symbol_conf.hybrid_merge = false;
 	}
 
 	if (disassembler_style) {
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index b2972c35c1ec..8fe43b032e9a 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -470,6 +470,16 @@ static int perf_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.addr2line-disable-warn"))
 		symbol_conf.addr2line_disable_warn = perf_config_bool(var, value);
 
+	if (!strcmp(var, "core.hybrid-merge")) {
+		/*
+		 * Note, this is for sampling tools like perf report and top.
+		 * perf stat has its own merging options and the
+		 * stat_config.hybrid_merge of "perf stat --hybrid-merge" is
+		 * deliberately not set here.
+		 */
+		symbol_conf.hybrid_merge = perf_config_bool(var, value);
+	}
+
 	/* Add other config variables here. */
 	return 0;
 }
-- 
2.55.0.1032.g73a4cd73de-goog

