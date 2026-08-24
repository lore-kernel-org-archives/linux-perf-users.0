Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76B3E7BA4
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553486; cv=none; b=j1jAVJQr0Fjg51U4MHNPsY0IahL/nLMRshTea493QsKWAc75wqiFfsoOJBDIeJSR3nVfqigBvGmPtC+aAXLhXHn+ams+UQ9BrpkctGvccHJG5sOv+ajBlAXjo83ehT1nRkR0o+nJl7Z5kCtQAKvxIfk9SaQfUo8g1squ36b8Ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553486; c=relaxed/simple;
	bh=NvY+xoTL9RCfZng+uIyyzwNl8M+hTe/uQUnKYTRtSmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1tWbCmmut1qdEpWLNNswFJqPhayaPchSPOHTPRUEfy59SyOe/5T6juH26l6Y2gZtTwBszqezqzV6fpV7gVwxemb90ohQzBxGKDpBIpUxWL3Ri2Om+6L5dJU6xvPF1UE2Qyn/PdAcKOzX8djYGXYwNR9FDSxU9Qc+Bo4uL4cm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Afj+dpxP; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Afj+dpxP"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3954def0191so5434068a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553483; x=1788158283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ic3+QI3RZFUsEWI3cfknR+pmNVErREa+t7XS8Ahee/c=;
        b=Afj+dpxPvF95MlMf+3mJBeKKM5mdsJMKMxd72k/GWTEr1saIK1fURS8+q05mrdvYmz
         PeVlQrQBZumR5DnobCG171yez4F+gHP6mlDJxmEBaih5wf7/KkdJnMdRNed18GUcwk3N
         orQsYEUmgjuH3+zCtNqtXL0LqMKq7EurEc2aPY3XeykXh/ScAk1CwuPKz2hix9dQ6+gF
         9fiCzrPmAdCzPGf8cY6CbsIsqybXCZSCLJqpWyeVdNbeH8g5CY1q0eUeIEVzW01dA8WI
         nmGWPPQkzFo2DkY5OSGNQ7BijtLo1H2ptbvis/O+YPGOascvpnEpPnC5oVVOvg0H72mE
         C5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553483; x=1788158283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ic3+QI3RZFUsEWI3cfknR+pmNVErREa+t7XS8Ahee/c=;
        b=Ihbo2hCBptd16ZB2qBNIUc6Xeb9xmTs5BFBHUqQSp0eQ9pH1Oo2YPF5oxZ6Pw6ftaX
         jnMecUG/CMenMz184M4R6ms+7D1AyjnbDiSOtARBg6D64WJT42/twPYu9Rmas4txj7hO
         fQN43BA6L44xkEvHY3CccYfBb6fYJuR2h0Uyw+ZJCTLe6iiUT5sqjLG8pc+KABv8tqCM
         2z57GV9bqnGZPQdtybjd95ff0DrHEoYEgBIg77XmG7shfULSHsAPukpKuYsDssj4kzFx
         Yy0+NSbp+OiLpJXgrfow2WK1/V7j5s6JIQp9KFeSUjusOhg4GWs6Sqpn6ulya4kKZ0Lf
         F54Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqp+HeFo4/Bl/1sWtJ5z+uuEirHyEjuuVo4ACNmuW+/peWLISTSwBndGZ7/OX6IJVTIpso4krTyqgwPqEUgfG7G@vger.kernel.org
X-Gm-Message-State: AFuF++lPaTfsQHyi71ou5BSw9pZqjdz1c4eKhlwNtwIXjPuTFNn+q6fD
	rvQ4bsWA2oh3mXiIl1kL/hiv5yQrup5O99JLQSoKTKNUC4O44t3ze0snNvj35tB4y903ytOasbC
	2N4i+NRRxbQ==
X-Received: from dlbvv18.prod.google.com ([2002:a05:7022:5f12:b0:140:f5a8:30ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c90:b0:393:19a3:4f1
 with SMTP id 98e67ed59e1d1-395c351d788mr41956665a91.6.1787553483075; Sun, 23
 Aug 2026 23:38:03 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:41 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-5-irogers@google.com>
Subject: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add --hybrid-merge flag to explicitly trigger event merging
non-interactively
for both perf-top and perf-report.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/perf-report.txt | 5 +++++
 tools/perf/Documentation/perf-top.txt    | 5 +++++
 tools/perf/builtin-report.c              | 6 ++++++
 tools/perf/builtin-top.c                 | 9 ++++++++-
 tools/perf/util/symbol.c                 | 1 +
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 22f87eaa3279..b7775b9260b7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -573,6 +573,11 @@ include::itrace.txt[]
 	When displaying traceevent output, do not use print fmt or plugins.
 
 -H::
+--hybrid-merge::
+	Merge matching events from all hybrid core PMUs into one
+	display. For example, if a wildcard expands to run on both p-cores and
+	e-cores, this aggregates them into a single view.
+
 --hierarchy::
 	Enable hierarchical output.  In the hierarchy mode, each sort key groups
 	samples based on the criteria and then sub-divide it using the lower
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f..05fe65cd77c5 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,11 @@ Default is to monitor all CPUS.
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
index 60d1f166629e..2fc81f4517e9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1113,6 +1113,10 @@ static int __cmd_report(struct report *rep)
 	evlist__for_each_entry(session->evlist, pos)
 		rep->nr_entries += evsel__hists(pos)->nr_entries;
 
+	if (symbol_conf.hybrid_merge && evlist__can_merge_hybrid(session->evlist)) {
+		evlist__merge_hybrid(session->evlist, false);
+	}
+
 	if (use_browser == 0) {
 		if (verbose > 3)
 			perf_session__fprintf(session, stdout);
@@ -1446,6 +1450,8 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
+	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+		    "merge the same event across hybrid core PMUs"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 570410599f1b..cf7ac2712696 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -320,7 +320,7 @@ static void perf_top__resort_hists(struct perf_top *t)
 
 static void perf_top__print_sym_table(struct perf_top *top)
 {
-	char bf[160];
+	char bf[512];
 	int printed = 0;
 	const int win_width = top->winsize.ws_col - 1;
 	struct evsel *evsel = top->sym_evsel;
@@ -1321,6 +1321,9 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		return ret;
 
+	if (symbol_conf.hybrid_merge && evlist__can_merge_hybrid(top->evlist))
+		evlist__merge_hybrid(top->evlist, false);
+
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
@@ -1490,6 +1493,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
+		    "merge the same event across hybrid core PMUs"),
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
@@ -1724,6 +1729,8 @@ int cmd_top(int argc, const char **argv)
 		evlist__put(def_evlist);
 	}
 
+
+
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
 	if (status)
 		goto out_put_evlist;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 94f9c8faedda..5cbb899e8fbd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -73,6 +73,7 @@ struct symbol_conf symbol_conf = {
 	.symfs			= "",
 	.symfs_layout_flat	= false,
 	.event_group		= true,
+	.hybrid_merge		= false,
 	.inline_name		= true,
 	.res_sample		= 0,
 	.addr2line_timeout_ms	= 5 * 1000,
-- 
2.55.0.766.g2966f0265a-goog

