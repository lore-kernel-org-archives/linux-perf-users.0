Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDA4E2F33
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602440; cv=none; b=DI72bVwwtbbzkgrcNNdu/9NbMJ0QmUCqgjdwjKjNsW1ltiKuYr5CBhXkdOdlMJps93r+CUar5rx1pg6N4Io4LulM/ZkNznOlc2fMNKzNaNc5z2VuUKCjkHNTJfnEnr63sFF10KGxTH0o4BEGipSSlF1CspqBAhJtNF+wIfhdqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602440; c=relaxed/simple;
	bh=mxb9MjYWhNm1j9yDL9Hh2QOhlw5UT68cPCQ00O1vzvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ttT71alqOr4Ea08CJzk1lTB8UbHwZgsxlmBOZZmN5ty3UgA0IybbCXt4b5UJgcTSe1YAu2oKLZGLIPlYegbx13E6K94v1muomNNquUT6y0uVDoknabAyuLz0Sq7JUzVMDgYNCsKJOjcjZW79PG+XMbum0z7D1NKFsm6g1pd0m8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uhbjwdpe; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uhbjwdpe"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3d832827so3338795ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602439; x=1790207239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOmTPim5ODDrqvbjuUKYYJOZEgagJbIQP6b8vfiRLKQ=;
        b=Uhbjwdpe39Vz1CG5GPARndwhE/XNOqVfkWhRlHUSGgKIecp2Uz3NugSkocZXRIetZh
         1J3twhLG1HTlTKL6qHBnWwfYoG1AfFhaU5KG06KQfjiQToMwcMd8fuuKlPMOk1QiOqaq
         mJMdUwESq+W+B5vN9P3WsjIbqx6b8qRBvax1wyZ0IDUy60NjlgChzMCcJyaLM8YMh60B
         ETPiWYOyqVs2Q402ve8bl1iSwQIMnK3LOv8G8jmOPirTSpHxo6oLJ/Eu+aqbPrYe/ztv
         tCsUNXJ93NiyaxBHJ2DkzWlwlLl04tLrSf5glIIj5N+TbjJclL1+JrrDnLrwTLPT4wji
         Kv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602439; x=1790207239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOmTPim5ODDrqvbjuUKYYJOZEgagJbIQP6b8vfiRLKQ=;
        b=P2vuXlkQvZyMnP8IY1SU6dnoU7IsElFW5/II0HHEBoNX5NsHLhp2fUnoFQqT1NstQN
         T3Lx0cdNBIqWH2/BAa9dnlcZsXIyG4fUhiby0yLqY/9jgw9YkX9sylzjIHHQTtgkNCM/
         Q7dPZRYY0gQlJUKycJpvnUD7+HYL3GZK8mpqsThLY74xvs1dvdxAG88tlGbLvcG9eRhx
         zkAEBZ9gLm1fxuCA6Zk+WjZVaJ9xjVH7TA0Tl9nBxvzqRiODplZyCH2QBnl9pEVdKSZ2
         nUGuthzmRG9tzGcsaTI6CqlbQpwN5VeiUBuD+ghf96jDR4ax65KnpdBiyezBXY5LBVDz
         7lVw==
X-Forwarded-Encrypted: i=1; AKwUvBz4JDwfzp580tvOeoZDkgnUGksYLlmPYEL/3/rUp1wRiMqFK1paKHUKi6TkU680snN/8RqIydCj64+1HiY6GdOW@vger.kernel.org
X-Gm-Message-State: AFuF++lTzZBrnCWAPQcOsVgMBB0cZbJAJYz8aj94ZjrquFR7lwFVScjc
	mGsFqE3++Usj1xGiDEED5/8ubP4AKFNiW4HFCTRMx4dYYxZTk/eL99gtTk9qqQLNw8qMArENM3W
	YguyCT/lKQA==
X-Received: from dybhv8.prod.google.com ([2002:a05:7301:2b08:b0:338:2e29:754c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccf:b0:2d9:4358:73ab
 with SMTP id d9443c01a7336-2dd8e7778bemr93366965ad.19.1789602438687; Wed, 16
 Sep 2026 16:47:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:50 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-8-irogers@google.com>
Subject: [PATCH v3 7/9] perf config: Add core.hybrid-merge to configure event merging
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

