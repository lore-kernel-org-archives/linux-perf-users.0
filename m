Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D349499F22
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602425; cv=none; b=PLczRsqG2RUVEJh0NGCLiMmzp+0fY6jFf9O7UwKqtoZvuaCV3Hqie7Qf3djUu/HreninvlMfaxiNr3qAzmHKZE3Vm6vVF2L3FdTHbXc9ztcliZC0wk9JLsK8hX3NrUGFI8rqkCywmNbMKIxL5sbhT1LkPUGHzXS3eog2UkOmdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602425; c=relaxed/simple;
	bh=nhpdusWbhdEv0uUkVbzv7Ifyh0sDI5xvdEEu4isXR2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pu1lhRSVWUESE4WEqzfWcV95nteNx2NplrTrlhlszDodQlziAWGmjuVcA5zexAmdJ5owNnCLli8tto5KKY/FI7dERF4tlcpELRwewAt3hHKbuFVLrzH34TwZ3GZlLKEXUfqNsmNmiPSA48b1ivrbX2fs+z/OKtXag/FpBU3yC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgghH1ut; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgghH1ut"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso294619a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602423; x=1790207223; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZXw8PFrIX8WTt/zqe0kLNmTON9KmMIa/fUp4teCkjc=;
        b=HgghH1utAvk86NoS2HEv1BqkHeUf4oqOVBCEqqaj5ZOYxXPxSmfZC0vbhXKS6E/4s7
         8EYCjaS9+Y/seeixp7ERqCd8qHytWGnOtnvYzfdZg7wrma2VWPYbxMca6j7bQsPZ+pQ+
         WqMYRY14WFRPPwSoOtokrDEkSuttjt1YiC+kipe+OfyMg07y1fC1Sc+l/sP/U+B9M6ur
         799u8416t3YUrdWt5IfsooXFiinj6BHg7MZJQSIgkyVWEF9CQSU06DFimI1NnAsbCJzQ
         x6ujW0iyv4rZokFr/uhLHEhfw42iSKbF8Y907hca639F0dwzhT4zH+acUZ0fWIS9gl7p
         Ewbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602423; x=1790207223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZXw8PFrIX8WTt/zqe0kLNmTON9KmMIa/fUp4teCkjc=;
        b=KjzhJ9HC4KdjafaZKJTwOKAOrF6GXuaRnbm/Y7TPpZkIDjOrksdYBjELTr3lDpK+6/
         hQGJn/CRLZVx2CmU9DUqCoXFR9e57kDn4uPakev+1BY/ERFT3xW1zSxd98a0ocaxkpCk
         cvk4AGEx/P3HbtuwqM0ywE+U+JShCOt5zLvK5MgjmoEcLrkj3tSpWRbg4lyff7tJ8NBd
         2w1zyhwMk8I5EmWpdNI9ALT6jbVpxqd8OTyyaFlyenTWw7NnNK36I9ZbJb8Ky+umgiPX
         ebSbiX7j6zXm9iB/Lha0PMgJR9VS5/kIl+WyRXZbwn0t6ZHSNWrghm/0DMfNtwCJVmSv
         La1Q==
X-Forwarded-Encrypted: i=1; AKwUvBw5yUEQ0VZK1yaPtaGCw9qUzNdh8UPhjAvQVqPSd5ZBFGsQWidXvZ4XKtpve2/0JrLIz7SPN5kAgT7UO94El+zt@vger.kernel.org
X-Gm-Message-State: AFuF++kVwfdFcvBdcgzFeWTajo7A5IA2LvTEFwZsZKM3FN3LMVFZgoei
	mBStLz0rTJ3VOrLWwOGAu9jUXCRhpp+A6z2AX7fbYzN/VAFAPjwKmsIbQKBF4H0Ig0lkpWc5aGY
	H37ocns6KKw==
X-Received: from dlec16-n1.prod.google.com ([2002:a05:701b:4290:10b0:144:be75:f389])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:39d:ecb6:8d40
 with SMTP id 98e67ed59e1d1-39e1e277458mr9607980a91.4.1789602423233; Wed, 16
 Sep 2026 16:47:03 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:46 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-4-irogers@google.com>
Subject: [PATCH v3 3/9] perf tools: Expose opt-in --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add --hybrid-merge to perf report and perf top. It merges the events a
wildcard expanded to across the core PMUs, and their histograms, so
that a symbol which ran on more than one kind of core is reported once
with the total rather than once per PMU.

evlist__merge_hybrid() links the events and evlist__merge_hists_hybrid()
links the histograms. There is nothing to merge on a machine with a
single core PMU, or when the events didn't come from a wildcard, so
warn in that case rather than quietly producing an unmerged report.

Merging collapses the per-PMU entries into one set, which doesn't
combine with the per-level breakdown of --hierarchy, so asking for both
is an error.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/perf-report.txt |  5 +++++
 tools/perf/Documentation/perf-top.txt    |  5 +++++
 tools/perf/builtin-report.c              | 19 +++++++++++++++++++
 tools/perf/builtin-top.c                 | 17 +++++++++++++++++
 tools/perf/util/symbol.c                 |  1 +
 5 files changed, 47 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a4706329c6c..3718ebd297ce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -578,6 +578,11 @@ include::itrace.txt[]
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
+--hybrid-merge::
+	Merge matching events from all hybrid core PMUs into one
+	display. For example, if a wildcard expands to run on both p-cores and
+	e-cores, this aggregates them into a single view.
+
 -H::
 --hierarchy::
 	Enable hierarchical output.  In the hierarchy mode, each sort key groups
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 2da2a16bbf26..c5e96da6ed82 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -49,6 +49,11 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--hybrid-merge::
+	Merge matching events from all hybrid core PMUs into one
+	display. For example, if a wildcard expands to run on both p-cores and
+	e-cores, this aggregates them into a single view.
+
 --filter=<filter>::
 	Event filter.  This option should follow an event selector (-e). For
 	syntax see linkperf:perf-record[1].
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 279e61c2366c..bda4836fc524 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1114,6 +1114,17 @@ static int __cmd_report(struct report *rep)
 	evlist__for_each_entry(session->evlist, pos)
 		rep->nr_entries += evsel__hists(pos)->nr_entries;
 
+	if (symbol_conf.hybrid_merge) {
+		struct perf_env *env = perf_session__env(session);
+
+		if (evlist__can_merge_hybrid(session->evlist, env)) {
+			evlist__merge_hybrid(session->evlist, env);
+			evlist__merge_hists_hybrid(session->evlist, false);
+		} else {
+			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
+		}
+	}
+
 	if (use_browser == 0) {
 		if (verbose > 3)
 			perf_session__fprintf(session, stdout);
@@ -1449,6 +1460,8 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
+	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+		    "merge the same event across hybrid core PMUs"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
@@ -1548,6 +1561,12 @@ int cmd_report(int argc, const char **argv)
 		report.symbol_filter_str = argv[0];
 	}
 
+	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
+		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	if (disassembler_style) {
 		annotate_opts.disassembler_style = strdup(disassembler_style);
 		if (!annotate_opts.disassembler_style)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c2562d49be46..3bb3337f1244 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1336,6 +1336,15 @@ static int __cmd_top(struct perf_top *top)
         if (!target__none(&opts->target))
 		evlist__enable(top->evlist);
 
+	if (symbol_conf.hybrid_merge) {
+		if (evlist__can_merge_hybrid(top->evlist, /*env=*/NULL)) {
+			evlist__merge_hybrid(top->evlist, /*env=*/NULL);
+			evlist__merge_hists_hybrid(top->evlist, false);
+		} else {
+			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
+		}
+	}
+
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
 		ui__error("Could not create process thread.\n");
@@ -1491,6 +1500,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+		    "merge the same event across hybrid core PMUs"),
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
@@ -1679,6 +1690,12 @@ int cmd_top(int argc, const char **argv)
 	if (argc)
 		usage_with_options(top_usage, options);
 
+	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
+		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
+		status = -EINVAL;
+		goto out_put_evlist;
+	}
+
 	if (disassembler_style) {
 		annotate_opts.disassembler_style = strdup(disassembler_style);
 		if (!annotate_opts.disassembler_style) {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3206929473a2..163652f071c6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -74,6 +74,7 @@ struct symbol_conf symbol_conf = {
 	.symfs			= "",
 	.symfs_layout_flat	= false,
 	.event_group		= true,
+	.hybrid_merge		= false,
 	.inline_name		= true,
 	.res_sample		= 0,
 	.addr2line_timeout_ms	= 5 * 1000,
-- 
2.55.0.1082.g2b9226bbc0-goog

