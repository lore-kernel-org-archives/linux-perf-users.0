Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C493D0930
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621654; cv=none; b=lZ6nMHT9sbeLQyv9t3N3SSHEeWWiJtj62Dy6JIC7u0TqwGqpwli1PqUPa3jyz3pLtrmZW6coVmYE+TZ99K2187tKa9+xGAk7dU+kdGh6vr8PeoYqzEPHZFrtF+6I3/k+hflkCiW8dJmPRNUn3O4evdhHC4FLhUOr1a7e20xk2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621654; c=relaxed/simple;
	bh=nhpdusWbhdEv0uUkVbzv7Ifyh0sDI5xvdEEu4isXR2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBFYWOTaJhZFCt+gH5GfZKao2LYTVR9DDuKNl40tK++zbna7LHtaP6MGh58ZOHwprMEXUXHg7lWSZeXedEdtkGfccfa+Xu+dmT9zFzJEAvFe7XAvZKQRm9FljaGD6bFY1LniIqAdaLENrfPuaApRxV5gM1N6S4WcdxMBs1fAmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgqXUHOo; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgqXUHOo"
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6c748676f6cso636148eaf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621651; x=1790226451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZXw8PFrIX8WTt/zqe0kLNmTON9KmMIa/fUp4teCkjc=;
        b=kgqXUHOouI5EEHfUsOt3dwk9gavtxY0+v7JRGPTrxsmFpvuYyfL8PAr4KvRkPLeIne
         EbejRfZYNnZ0QnsnxFVYtOx1nhTB54lX/dZl5Lhc+eEUnem+SNwMjb0e5xAkKOAnrZna
         7vNj/ECzENhddZm4Q6pn2zDjhmGt+945w220LArKtUW9AIAvV7c1kk1ghy0XG2XhRqow
         /MOoLsAJy7Mz09FtGCPHeywTDcxziOqkQm1SNbx36iUgI4FW/V9pHRCm/ED6uak7Edky
         YOD8OM2MlJ3Lmpa1epOiS/sfWPjP761VZYaXWnXrC4alYXbBI1mM4OCljzKpiEaRTACz
         /alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621651; x=1790226451;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZXw8PFrIX8WTt/zqe0kLNmTON9KmMIa/fUp4teCkjc=;
        b=A2WTWERgm2Yea5DAPZZw5Tguho2BjZtI+d3ol+AWah/CoYW9u0p5KTdHlB5JY56ovz
         ahepuUHhYtkvpj5SgzT6J6YFfBJwJeH4jATjS7lXUsbSF77UFRKwL06msJWZAWLLkBrn
         iyYX8vgGPvfHSSLJe7LGZKN9EQlCwAEydwQ/RurPo23P8m2GC5b/BLu1WtDzTQWls8Ic
         l0WpqryFLcrAcduMNky7dB9euR+IKZAe3UBbtDM7VaCLTlGlw2M21SBYLIZuBSmx89T+
         WirNhEFIIBxJG7/Fzw4UA/1vGRKrbaIQgGNdbaKkzpvTTN3O2HYa0+5GWnLlWyN9mJkk
         M2fA==
X-Forwarded-Encrypted: i=1; AKwUvBw7exOPJyS+agBHWBM8cCMLCBBhYFZQn5YY79/L7adMlHh3DPhHGopzrpozLyqfcVNS8rzk4cRBk3wDG3fpBoLE@vger.kernel.org
X-Gm-Message-State: AFuF++nQurKWcBU8VX81ARs61qdeeFivbKH2oJShCFoq7Htki81mIIMF
	V1oW4jMhZJ2NDWtY+yPPYc29jdOVrM4IxL6ZN9/BFp77V4WYJ1U6cFdL+NqaIKn/xjGuf4kF5rk
	RcF3teTjK9w==
X-Received: from dlec11-n1.prod.google.com ([2002:a05:701b:428b:10b0:13f:c1b7:470])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:f035:b0:6b1:9e75:6fe2
 with SMTP id 006d021491bc7-6c7d15ce097mr5633176eaf.12.1789621651406; Wed, 16
 Sep 2026 22:07:31 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:02 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-4-irogers@google.com>
Subject: [PATCH v4 3/9] perf tools: Expose opt-in --hybrid-merge
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

