Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78793BFAE8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621662; cv=none; b=DLFktCYiaqKfiPBXgrF6rWlfEluzeEMsbOgS8VkDHMS6KR+Iaj7l5tZ8Xcdu9fRXb1Z4RFQjPV5KWU0wbv8mQEI+/LzQ13TOkWhUbuJjFcNcgh1RNW9DwDazFX8IIk5EIwFmvFI85Qe8jnMzFg764hKBJCKAeiRAErndXOBgdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621662; c=relaxed/simple;
	bh=VGFXHwKE8RvMe5GcM8/eT8IIPWWCH+vbmRVym9AjVaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhFjhHkCOM7T3pBgL5TXGmAbBCZ8SGLyzFWjXcytD20wMDOS07bFZ+k9ochG0or4Wg1AC4IBXWTICwT3B6wNOkbrI4dXGI3449LnP6MuzrKUGxgjGpmoL/sDo5KvhTqimQHH/ihLFjuPc9KarGyjrchwjQ8qsCswDvvtzmBOtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TH61lbk4; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TH61lbk4"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso811140a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621659; x=1790226459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=modhGu1HXmet1RUOxxEs2p6aFj65PAjxPzqA3IIZT/E=;
        b=TH61lbk49ORK/mS2Rgtkut5aEiqzri2LNoC6Ir//rh7lEqoda5csmw+3dKzta70Gdg
         bj2w31ZBLy9A7Bqhb0dSa8BVaio6wT1xevfTV9nUaZNGbEfuvxeTW4+abEbCoWeGAXVt
         469DQZ/7FqWHTe69ErB/8wz7C7pWTV1I5vhYgXF20zewgXI2oMZjoEK/ZO5oaHgQebdn
         aKWdMAmtcNno0tCDnY/tl0k/rO3K+z+fWzcS1fVaUJEhQTe7xvpTcOId+je+ddlgKn3e
         uZ5ODZzpXdGqc2qP7yyEk5R2+Iw3zP9xQhOW448BVH525uWz6DTmReB9ZX6c7GH78HRH
         XSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621659; x=1790226459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=modhGu1HXmet1RUOxxEs2p6aFj65PAjxPzqA3IIZT/E=;
        b=WkuuKUA+K5D0xa/aL0Pucqqf/+rgBcvmrA5zXN20B8NJ8zUVSSXgBl+jjpTvQ8eVUo
         oxAUIGvNJKaOVN/v5X5ipexJFiUChoOE/GjSO0VeQUYc+XhDkDCKrFvNnn7s2ARIDy6k
         znMBqRadtNIbc1J1gqnEJehMAjeoXX3rLZNV8tX5PpAND3S6Zk0FxszBJ89Hi2zDknUD
         BEWv1ivspJkAhLXYWskG6LFfRsFywnfbafT9R70WUh14kkDTN0mT2LYs4hSCOzitxu3T
         lFQfvlgDvMKinG3yeI5hChdLIO8ab8b/TggOSfTupZCz/3Qz2AcjICCbBkRLitjbCcmA
         N6/A==
X-Forwarded-Encrypted: i=1; AKwUvBwGOBIlBams5nqoPwRUyY+gXz51aLBLoqDsc70KPRXsDTT5RptvyA8psWJnmlLRLC+30T2YfhnUE/4j3KLb7n4K@vger.kernel.org
X-Gm-Message-State: AFuF++l95IGFl0V64EphUsOtsk4dVKwH1Ufej9tYObW81nPJcQhjlti4
	qfqbTaHGS94lkV/2wjO/sWsqBxCmhWfXQoXxrRSnoXhp89nTZw7V/V3ZndYYUhlJ2oGLlw2E8jt
	QOqQP+ZSGOg==
X-Received: from dyau26.prod.google.com ([2002:a05:7300:601a:b0:335:65c3:a0a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4408:b0:39d:ec24:5ffe
 with SMTP id 98e67ed59e1d1-39e1e284fd8mr11448900a91.9.1789621658959; Wed, 16
 Sep 2026 22:07:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:06 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-8-irogers@google.com>
Subject: [PATCH v4 7/9] perf config: Add core.hybrid-merge to configure event merging
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
For the same reason it is silently ignored when there are no events to
merge, as would be the case on any machine with a single core PMU,
whereas an explicit --hybrid-merge still warns. Record whether the
option came from the command line in symbol_conf so both can tell the
two apart.

perf stat has its own merging options for counting, the sampling
core.hybrid-merge deliberately doesn't alter it and its
--hybrid-merge must still be given explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/perf-config.txt | 10 ++++++++
 tools/perf/builtin-report.c              | 24 ++++++++++++++-----
 tools/perf/builtin-top.c                 | 30 +++++++++++++++++-------
 tools/perf/util/config.c                 | 10 ++++++++
 tools/perf/util/symbol_conf.h            |  2 ++
 5 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9b223f892829..6cff6f26af8d 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -217,6 +217,16 @@ core.*::
 		Sets a timeout (in milliseconds) for parsing 'addr2line'
 		output.  The default timeout is 5s.
 
+	hybrid-merge::
+		Merge matching events from all hybrid core PMUs into one display
+		by default. For example, if a wildcard expands to run on both p-cores and
+		e-cores, this aggregates them into a single view. This applies to
+		'perf report' and 'perf top', it is ignored with '--hierarchy' and
+		doesn't alter 'perf stat' where '--hybrid-merge' must be given
+		explicitly. As a default it is silently ignored when there is
+		nothing to merge, such as on a machine with a single core PMU,
+		whereas an explicit '--hybrid-merge' warns.
+
 tui.*, gtk.*::
 	Subcommands that can be configured here are 'top', 'report' and 'annotate'.
 	These values are booleans, for example:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bda4836fc524..57225bc87731 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1120,7 +1120,13 @@ static int __cmd_report(struct report *rep)
 		if (evlist__can_merge_hybrid(session->evlist, env)) {
 			evlist__merge_hybrid(session->evlist, env);
 			evlist__merge_hists_hybrid(session->evlist, false);
-		} else {
+		} else if (symbol_conf.hybrid_merge_set) {
+			/*
+			 * Only an explicit --hybrid-merge warns. A
+			 * core.hybrid-merge default is silent, as most
+			 * machines aren't hybrid and there is nothing the
+			 * user needs to do about it.
+			 */
 			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
 		}
 	}
@@ -1460,8 +1466,9 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
-		    "merge the same event across hybrid core PMUs"),
+	OPT_BOOLEAN_SET(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+			&symbol_conf.hybrid_merge_set,
+			"merge the same event across hybrid core PMUs"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
@@ -1562,9 +1569,14 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
-		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
-		ret = -EINVAL;
-		goto exit;
+		if (symbol_conf.hybrid_merge_set) {
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
index 3bb3337f1244..a3442d2d6edf 100644
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
@@ -1340,7 +1342,13 @@ static int __cmd_top(struct perf_top *top)
 		if (evlist__can_merge_hybrid(top->evlist, /*env=*/NULL)) {
 			evlist__merge_hybrid(top->evlist, /*env=*/NULL);
 			evlist__merge_hists_hybrid(top->evlist, false);
-		} else {
+		} else if (symbol_conf.hybrid_merge_set) {
+			/*
+			 * Only an explicit --hybrid-merge warns. A
+			 * core.hybrid-merge default is silent, as most
+			 * machines aren't hybrid and there is nothing the
+			 * user needs to do about it.
+			 */
 			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
 		}
 	}
@@ -1500,8 +1508,9 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
-	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
-		    "merge the same event across hybrid core PMUs"),
+	OPT_BOOLEAN_SET(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+			&symbol_conf.hybrid_merge_set,
+			"merge the same event across hybrid core PMUs"),
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
@@ -1691,9 +1700,14 @@ int cmd_top(int argc, const char **argv)
 		usage_with_options(top_usage, options);
 
 	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
-		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
-		status = -EINVAL;
-		goto out_put_evlist;
+		if (symbol_conf.hybrid_merge_set) {
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
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 50317bdaf2b6..37d35f42dcc1 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -39,6 +39,8 @@ enum symbol__weight_mode {
 
 struct symbol_conf {
 	bool		hybrid_merge;
+	/* Was hybrid_merge given on the command line rather than in a config file? */
+	bool		hybrid_merge_set;
 	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
-- 
2.55.0.1082.g2b9226bbc0-goog

