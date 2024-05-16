Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2854A11
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898667; cv=none; b=ZbORADgUO3tx5hC942fXMj52IGQO1gZQgbVthuGdtfQcwQK7S7sGvaN/Bn+jd+G0Y1LvwgkKboduMbMtHrrODzo2JGqT8ttlD1l1z7ShiRIfY2H3ajYdP2RBlOld2RcqiV0S4Wz37focNXQpzH1mCcBFd13o7dXQnsvrgYbLyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898667; c=relaxed/simple;
	bh=xwIOMlHe1Z7kFcLRG1xSrIudTNqh7gDy2OljfsgpMm4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=dDnN+byhI7/TMVZVC2PGAqjH6zhP0AlYHdVCJiV8MyzUEtUDxhe87WRDecDlFHEgCdPOQMB/sxvCPL2qlA7UmhJHBKNXy77Wr854+YUtsjxyZAHdsrei9QBhqwqG+cxYfUYEpICGT1WfhbtZ4iW8LoG6EzyjV1OQX0tJS5TQn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XdlZeQA; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XdlZeQA"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-24547dbc414so926013fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715898664; x=1716503464; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kS1/X+BHtKjnwKrgy5/KCu8x6nUxO4PCq3/9gh0hd3E=;
        b=2XdlZeQAoxxnWxQWPhBdSGxiwehYa4JNh3lfu5oSNRhaawlZZRjI+KMld+J8zsSyTl
         sC42EEZafVABOL7XWOpqgBCAl/nhcY3hNk0XPIyUDQPR5HHlMHWcTfiiGGQOvyqS/VT9
         rvEguPRTUj+mZRQ73b1F54u81IYNiR/mfwcfqBwi5Y7CUKPcTACgzYG9LyJ4K/P0oMnC
         jPnESWixLKRVmn65MWoDKEg+rR7M8XlMqUWRZVQydW3iS5MjfsP9CF4ROSPyTO17/28q
         armEoZ9lQ0Iv1NT5I0WFa4d5AgtG0ufNBBFfs7wAYhXvHxiwz6CVZ9LwLNw++zFg2f58
         s2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898664; x=1716503464;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kS1/X+BHtKjnwKrgy5/KCu8x6nUxO4PCq3/9gh0hd3E=;
        b=mKLL9WHz+CFglsRFEBbi+SQTM/eM9MKQJ+wExgJHxwMnZYgoVaWUnK+9fA3vXvm0OY
         kvgtjQz1UAUey0vOdGgquDkogEiDFr9GcI9m5hEqmifjg8o5bqPIwzPIjtKmcbNHcjbt
         eqPfwc5shoLVZakjObS8n1AlNynH6LgA8S3Vx1j0gxQm8Ym7wn93gqhIo9T51uURwpVQ
         75v5aeSAnMu9mPJDmMn1heZBZjvIJM2fHjYvJ/jxseSfpj53rbXUyIsWY8ASsG8qVxkN
         A41C0lYWamYLZifNxsV/5z4o0p18TUSw0EDiovjYybVhQ7v+aJKYAV1HAJVha+M4Mg9d
         xGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCsLwwCC28GxzdS4gTLi75pZUwWTUNOyTRFiK4y2htfgBK1gmaDvE7nM2oWWeR0Pb8lyT5HtgimipRvefTgaXc7o4wSWpYF7oNXNkOyN06ZQ==
X-Gm-Message-State: AOJu0YxijZeIOCScNZqXIzH5Y2csXcj0I7dvdTcf+u6uVJIOjkHlFZhn
	kRyalIEECjbH7trxDyV57RtyDeW7k5TyjJ0omj6cGogm6l3+GShc2fF/vEBC82lNfD8xnp3SVZs
	I4GKxaw==
X-Google-Smtp-Source: AGHT+IGyHj5/KAonqNbCkyv9VaWFytpRqRehbN4/G52bXb5EdLvGUH0dUYwTV/xyGtXdcYO6SvycFQR2EnbF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:9eab:1b1c:e1cb:27f7])
 (user=irogers job=sendgmr) by 2002:a05:690c:360a:b0:61b:e253:31ad with SMTP
 id 00721157ae682-622b014b7a6mr42075857b3.8.1715898130260; Thu, 16 May 2024
 15:22:10 -0700 (PDT)
Date: Thu, 16 May 2024 15:21:59 -0700
Message-Id: <20240516222159.3710131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf top: Make zeroing histogram on refresh the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of decaying histograms over time change it so that they are
zero-ed on each perf top refresh. Previously the option '-z', or
pressing 'z' in tui mode, would enable this behavior. Decaying samples
is non-intuitive as it isn't how "top" works. Make zeroing on refresh
the default and rename the command line options from 'z' to 'Z' and
'zero' to 'decay'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt |  6 +++---
 tools/perf/builtin-top.c              | 23 +++++++++++++----------
 tools/perf/ui/browsers/hists.c        |  7 ++++---
 tools/perf/util/top.h                 |  2 +-
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 667e5102075e..f1524cc0d409 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -124,9 +124,9 @@ Default is to monitor all CPUS.
 --verbose::
 	Be more verbose (show counter open errors, etc).
 
--z::
---zero::
-	Zero history across display updates.
+-Z::
+--decay::
+	Decay rather than zero history across display updates.
 
 -s::
 --sort::
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e8cbbf10d361..8f06635cb7cd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -266,10 +266,10 @@ static void perf_top__show_details(struct perf_top *top)
 	more = symbol__annotate_printf(&he->ms, top->sym_evsel);
 
 	if (top->evlist->enabled) {
-		if (top->zero)
-			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
-		else
+		if (top->decay_samples)
 			symbol__annotate_decay_histogram(symbol, top->sym_evsel->core.idx);
+		else
+			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
 	}
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
@@ -292,11 +292,11 @@ static void perf_top__resort_hists(struct perf_top *t)
 		hists__unlink(hists);
 
 		if (evlist->enabled) {
-			if (t->zero) {
-				hists__delete_entries(hists);
-			} else {
+			if (t->decay_samples) {
 				hists__decay_entries(hists, t->hide_user_symbols,
 						     t->hide_kernel_symbols);
+			} else {
+				hists__delete_entries(hists);
 			}
 		}
 
@@ -460,7 +460,9 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 	fprintf(stdout,
 		"\t[U]     hide user symbols.               \t(%s)\n",
 		top->hide_user_symbols ? "yes" : "no");
-	fprintf(stdout, "\t[z]     toggle sample zeroing.             \t(%d)\n", top->zero ? 1 : 0);
+	fprintf(stdout,
+		"\t[z]     toggle sample zeroing/decaying.  \t(%s)\n",
+		top->decay_samples ? "decay" : "zero");
 	fprintf(stdout, "\t[qQ]    quit.\n");
 }
 
@@ -583,7 +585,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			top->hide_user_symbols = !top->hide_user_symbols;
 			break;
 		case 'z':
-			top->zero = !top->zero;
+			top->decay_samples = !top->decay_samples;
 			break;
 		default:
 			break;
@@ -648,7 +650,7 @@ static void *display_thread_tui(void *arg)
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
 				       &top->session->header.env, !top->record_opts.overwrite);
 	if (ret == K_RELOAD) {
-		top->zero = true;
+		top->decay_samples = false;
 		goto repeat;
 	} else
 		stop_top();
@@ -1502,7 +1504,8 @@ int cmd_top(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
 		    "symbol to annotate"),
-	OPT_BOOLEAN('z', "zero", &top.zero, "zero history across updates"),
+	OPT_BOOLEAN('Z', "decay", &top.decay_samples,
+		    "decay rather than zero history across updates"),
 	OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
 		     "profile at this frequency",
 		      record__parse_freq),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b7219df51236..bcc4720f8198 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2305,8 +2305,8 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 				     " drop: %" PRIu64 "/%" PRIu64,
 				     top->drop, top->drop_total);
 
-		if (top->zero)
-			printed += scnprintf(bf + printed, size - printed, " [z]");
+		if (top->decay_samples)
+			printed += scnprintf(bf + printed, size - printed, " [decay]");
 
 		perf_top__reset_sample_counters(top);
 	}
@@ -3209,9 +3209,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'z':
 			if (!is_report_browser(hbt)) {
+				/* Toggle between zeroing and decaying samples. */
 				struct perf_top *top = hbt->arg;
 
-				top->zero = !top->zero;
+				top->decay_samples = !top->decay_samples;
 			}
 			continue;
 		case 'L':
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..b2c199925b36 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -32,7 +32,7 @@ struct perf_top {
 	u64		   guest_us_samples, guest_kernel_samples;
 	int		   print_entries, count_filter, delay_secs;
 	int		   max_stack;
-	bool		   hide_kernel_symbols, hide_user_symbols, zero;
+	bool		   hide_kernel_symbols, hide_user_symbols, decay_samples;
 #ifdef HAVE_SLANG_SUPPORT
 	bool		   use_tui;
 #endif
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

