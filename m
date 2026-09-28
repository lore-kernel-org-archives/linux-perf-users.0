Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC439CD0F
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620017; cv=none; b=rwpvIUM0MqYqu3DROE1ee3bdFuUcAUASsE2ZNEYgu9JY+Hy05dlgTPMkKY37KziW34XcGl4SYTBPBNTTs3itjZOWp5TUuATV4RBf2bMGaj7Vy6HJ99zifvalvX9Y83ZN3nRnfja3lHsY1TdEhyEcBM58oLFgR5WqauyEHV1m2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620017; c=relaxed/simple;
	bh=vzzupWZapnqBF3Icu4bFA3vKUyNYOaUPs9wIBEM04sA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cyB5fAhkPn7iTovVobPLOIWP9+sLw342QrG49LTMn9jhvvOO7FNKdaugEjEsL7J8V3Jb0WMVhrmsQZquLXex63GncDoIWKAkwJU+gDKUsbmnapyVpfjAkSHwBvXRnst+nzXM9mjyIbFRlACP7Z/0MtICVGP1HLt7GWSftRGYWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx9t2Vq7; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx9t2Vq7"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1438492fb40so4903788c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620015; x=1791224815; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FR31L2UgMfcbk0Df5Pn/DTzvOue27NcqfcAwuvviXn4=;
        b=Lx9t2Vq75CmmzoYratsCD8LX4Dt3oLbKTzexyYsiapJF/xJutg9kAqDUpgx6Msa3XG
         K0CxII03K5I1/pwAWtLXw6mAbgzKvr3RS8c37AWFNg+dG73Atm3v7ROWWwHo916ECrDd
         akXW5x2NRZtLQLA6Qpad7D0dAhUD2bTau+0IMhhSVlyh7oUXxt7LBMuukka/ae8imOMt
         8qQUoyyanI+u0uyXjiSVAK8Di4lhOir3NJR2W1p1QsRDMWVIbi7sCKawscueNEDeXWAL
         9yMe1OHf+68Xj0QtxRxBU9ORf5CjjCt9c3LwilsXDP/ZvSvvTTWoyy4rw2G/RFEc1Hn5
         3F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620015; x=1791224815;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FR31L2UgMfcbk0Df5Pn/DTzvOue27NcqfcAwuvviXn4=;
        b=dO4KJQ6uWKGTtjDK3pA35bpcq4gAn6HZRwDZsIFDanBrCVq4M6WsE9DKYSgLWzMENz
         SYRAOzlxxXYl5IYzk28mE66gxJAWIKGu2j9qPaslOJwSEh6cKXeKDyZxwp/7E+AZAF2K
         n3pKSMjB6GMXDxg3h8ogLjakteapBn744yByEULAVaY6oD2bt6S+pQ1NYOcmeXfCUyGi
         ML7oGRKuiHKEG3GvqeaD8kpeL7kkyRfkL0gTigb7lafAVFMFQTvMMM5NyAEac/DI5w2y
         sIyFLr03+319qshFffLAHQmuboDbOVVgEMwTQeDwSIpBCBIWJnIrlXAFF+T4kWJmD+NL
         DoLw==
X-Forwarded-Encrypted: i=1; AKwUvBzXrH7YyG8ZeaLKbQT6p9CLZDbdswn4rUv/IKcFmwuEE1sx1ka0xJKQJL87QO615Ry3LPKq5DvIQR3lpLFQN3Qy@vger.kernel.org
X-Gm-Message-State: AFuF++l3Uz706aogF12JgIzHcvlfjlLdywAtZW8v2dkHUcwrmUX6T9te
	3UmlCsa44kiIndaqxtr5rIAEHF02vflVasPzPBJfW7gPiBfIX0CjnmL6zMzKee6NwcvNUNqVMhk
	M+MkQguP82Q==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:cdf0:6a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:455b:20b0:137:eb26:10d
 with SMTP id a92af1059eb24-146cb311338mr9543879c88.0.1790620014267; Mon, 28
 Sep 2026 11:26:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:58 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-20-irogers@google.com>
Subject: [PATCH v6 19/26] perf trace: Add an option to disable syscall augmentation
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf trace falls back to the raw_syscalls tracepoints, filtering in user
space, when the augmentation BPF programs can't be loaded. Add
--no-syscall-augment to use that path even when they can, so both can
be tested. Suggest it when tasks are lost, as the tracepoints' per-task
events don't limit how many tasks are traced.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-trace.txt |  6 ++++++
 tools/perf/builtin-trace.c              | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index d20b43ea3d37..fabb37258751 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -172,6 +172,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	Trace system calls. This options is enabled by default, disable with
 	--no-syscalls.
 
+--syscall-augment::
+	Augment system call arguments using BPF, the default when BPF support
+	is available. Disable with --no-syscall-augment to use the
+	raw_syscalls tracepoints instead, such as when more tasks are alive
+	at once than augmentation can trace.
+
 --call-graph [mode,type,min[,limit],order[,key][,branch]]::
         Setup and enable call-graph (stack chain/backtrace) recording.
         See `--call-graph` section in perf-record and perf-report
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1be355a3ae22..c34c9f129836 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -216,6 +216,7 @@ struct trace {
 	bool			print_sample;
 	bool			show_tool_stats;
 	bool			trace_syscalls;
+	bool			syscall_augment;
 	bool			libtraceevent_print;
 	bool			kernel_syscallchains;
 	s16			args_alignment;
@@ -5002,7 +5003,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	lost_tasks = augmented_syscalls__lost_tasks();
 	if (lost_tasks)
 		color_fprintf(trace->output, PERF_COLOR_RED,
-			      "LOST the syscalls of %d tasks, too many to trace at once!\n",
+			      "LOST the syscalls of %d tasks, too many to trace at once!\n"
+			      "Use --no-syscall-augment to trace them without augmentation.\n",
 			      lost_tasks);
 
 	if (!err) {
@@ -5788,6 +5790,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_arg_names = true,
 		.args_alignment = 70,
 		.trace_syscalls = false,
+		.syscall_augment = true,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
@@ -5843,6 +5846,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
+	OPT_BOOLEAN(0, "syscall-augment", &trace.syscall_augment,
+		    "Augment syscalls using BPF"),
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
@@ -5982,6 +5987,9 @@ int cmd_trace(int argc, const char **argv)
 			goto skip_augmentation;
 	}
 
+	if (!trace.syscall_augment)
+		goto skip_augmentation;
+
 	err = augmented_syscalls__prepare();
 	if (err < 0)
 		goto skip_augmentation;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

