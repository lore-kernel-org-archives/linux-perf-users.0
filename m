Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092E3EC687
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541581; cv=none; b=A/cguTUo04b/XMSUFvqB5TX6rTGacji52NdGnZw8qUdgOZihnCVT48IQ6ktneBHX75cDEZNh6RmNilfB86x5gt17f830hj6ui4W/uiXQZdUWZCczti5WHeIg4pRE2LhiN9sZjys1+wCNEFMs7BYnN3Kb0LpAg0jmnCuAbggi3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541581; c=relaxed/simple;
	bh=SPjvDE33SP3107t0m50rVcbULq9SBmWFFa6eifsusuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2OCt5uZTieOcHFFffP1B8yFrwqoQXlUz+JdMfCksU61wHbiXFKDrm6fgb/wK4vIqm+bw+Q7eDaPF5Soo4buPDH7g0B7rVFfy2mUsvwZYULx+UBX5iHt0wMq9WybRmJwF/PnkM0U2bspxXgUmRIjZGsh8bWS4/FkBl92Cha1eAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0OiFmlZ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0OiFmlZ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so1428262a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541580; x=1790146380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XiWRLL3r7FPvPXSArVph/Q3qGT3wbMpgFpFrlHz/wZU=;
        b=T0OiFmlZyS7eAaAF2eQWTyfwwUc2P5GwE2E8lfXINNB0ULZohvXnTiSiQLNmF4ZJgY
         L1QDJVV4cJyyzgDs4GJdmZqHhksuMB69NA/fDQF+oe+iqduAqfSps9qgnFvkTcaS7wyC
         3zDAscgUlrTE4+Cv1KMz4mAd85sBzXWgz17PNEdBP/iGMHwZzS/qfRX5M6gPLNKvmv9k
         OBfvaLN0xBCIXPrFFbCCkhgon0IAfTJ9I6mRChYFz/o/VMH5e+ppa9a77Eb3tbwtWoiC
         6ONCX+Y4sF37As0eJdcecaTcYRkc0S7h1T6Qe6Q3i09VmLgZnZaRpr31rej4+3pfqlMH
         TBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541580; x=1790146380;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiWRLL3r7FPvPXSArVph/Q3qGT3wbMpgFpFrlHz/wZU=;
        b=cBhRoemHdvvu/1AcoWPyfFYcNWEKIftD2BONE1bj4sJu6AZvMOnD7AmbLmfe75/NfB
         NxA+m8KQ4oxMViPCmg4t/7lbuDqRLBaosAK3XcJupAX8Mtca9TePYW54zDic2bXRfqiL
         tUgYV1w8HRdrceNsR4P8zARFFnAJh370pKXsV3cHst2RTfJuUTwCgvYWV4qfyoXBunq4
         7BmhXoholFNh8ZpSxZDQ9BJOiK9bMgVbcGuFCqOXe1qOlQaDAxgueVxZkrU4HHbr2i+y
         fX8ylwbOG7XpabWle9Dc82pwBp8rYBbKnUaxsBIW5fEx7x0GUOJ+HAXJE76SY+NfNZwj
         QTiw==
X-Gm-Message-State: AFuF++nGt3lXULkayDuUjopkaYKz61lla5nM4SuFLeDkbr7iOTy1Pasy
	elj5uJHGnEInWWOGGeR0ZoVyJwII0tFMPBG66K/fPQWWvlgSt9e6Mn1CaIZJv26jfAp5LAVGITu
	8Jy0dp6NpWQ==
X-Received: from dlep14-n2.prod.google.com ([2002:a05:701b:458e:20b0:143:9704:de05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a49:b0:396:d28e:b53
 with SMTP id 98e67ed59e1d1-39dfe188d2dmr10470245a91.20.1789541579678; Tue, 15
 Sep 2026 23:52:59 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:42 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-4-irogers@google.com>
Subject: [PATCH v2 3/9] perf tools: Expose opt-in --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
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
2.55.0.1032.g73a4cd73de-goog

