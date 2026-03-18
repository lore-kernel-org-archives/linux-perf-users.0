Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F0376479
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856711; cv=none; b=CLCOBcxdyRS2e7Fe/fkCdsOZGgo4t3CY9K85ve6iiv6tcNiAke6FSLCMbRSCcovI+JAACLSb6VHxniBCR8ohYbCeoFbuOv/vU3YMyTnefL0rxa8gxJaS9egtDDagjglzFZpooaoEWuErmJlx/y1KOJZPEvxNkJG6kAGPtJ7GQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856711; c=relaxed/simple;
	bh=VynHbodWwy+JK/PZXN/ZPJWSVpu2Hji+rVLBlhNBGT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UCmhaDzKlgjwQD4gwAEQP9FIjZylppWPtYiUHf8HPzxvGFNKNCTW+RaAT71dq5kJzMATeq5iyV5u5M9xbqRV0O/fW1Zz2wp9XvamAjkDe9e8tkYJJD8x4Wl37H0g5claXeULvEvSESk0PI4d9eYr9N9TloHXRZhIJK3mCGdz7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/QqyG+e; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/QqyG+e"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127876be621so34521c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856709; x=1774461509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6hyJgw4C1gVTP8Dmq1+Zj6/J2J6L+bYpeRT5I66L9Q=;
        b=W/QqyG+e5MWmQAI/+UAfWQlb0eFbtwD+Fbm0+49j7PTZQJHwSVVKSmiseTvkzrfI8s
         Vdv28fd0lCkxlbHp7ubiFmKZkuaDNiCGLSSR4AGg8omuxVaADshUPAE/SQVHaUI2zc/6
         CvOOujAPmJpD3G4VOFtMHqXawKrJwSDqGPueXAGBYCiS0wi+H1F/qAkybBCE1gjZ7tAD
         eT7CvT9Z6IvEwUKm8tvk1vtGr1OJmiGt3IE0SKQWqp8Bd2osdzlj/6SLPLf3Co8VA5JV
         XfG8sqdPm59vAQXqwVy56vitstnfVymWh7HmqFpFkJBCWQS3nZj7T8AqdLNU0aidMZM6
         5ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856709; x=1774461509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6hyJgw4C1gVTP8Dmq1+Zj6/J2J6L+bYpeRT5I66L9Q=;
        b=oapFhA6XPja3KFv83X8vAoQic5OvBWAqXzDOowdCjlZNxBK+qKtpM+J6aotlm3rwqr
         gAR4AdOfI8nO601h5S9Js4CEO4LeVdAIdL2WUvGlZos5z0VvFcmxzAzBAlrr0z9x/4HB
         QakJmqSljYGISnyfj1dE0a7jTv0eUer/OOWDthZ5yPH666SipEghgMZ4qQwXathnXhou
         ktYMKu71IaTBBNeB54TDvmP0lCTVd0fZVFHBb5QT+k4ai66C9vcC8DP3RMbmIGWu4+SN
         gtN8h9jFADCmU0ebXzUqjIq/JKCBnnOVt1yfwQWUY08NTX9GYpmQnvoxOylB/UIX/QvD
         2haQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6yaSTwcsqiH7yd3YaJwpcw/xH2HVIhzpxPjWQPd585VQujig5Q/fNA1m3jGvlAbQJItUzMmBrwYC81cnLD3pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrv+Mz9i3ZV6166bJDdqW0vuK/bLMjk/w3QdYJiGo0dU74zAhU
	N1iF8wunp5S96uMco+ys1HXfK9Ntcwlkb1/hmiyFb0Dw3asYTU9s8chGnyVDcfr320sYFGMosFZ
	HTuC7xryHpQ==
X-Received: from dlae16.prod.google.com ([2002:a05:701b:2310:b0:129:86:ce7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a81:b0:11f:46b4:449f
 with SMTP id a92af1059eb24-12a68594d79mr220833c88.24.1773856708771; Wed, 18
 Mar 2026 10:58:28 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:07 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
 <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-5-irogers@google.com>
Subject: [PATCH v7 4/5] perf callchain: Refactor callchain option parsing
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

record_opts__parse_callchain is shared by builtin-record and
builtin-trace, it is declared in callchain.h. Move the declaration to
callchain.c for consistency with the header. In other cases make the
option callback a small static stub that then calls into callchain.c.

Make the no argument '-g' callchain option just a short-cut for
'--call-graph fp' so that there is consistency in how the arguments
are handled. This requires the const char* string to be strdup-ed in
__parse_callchain_report_opt. For consistency also make
parse_callchain_record use strdup and remove some unnecessary
casts. Also, be more explicit with comments about the '-g' behavior if
there is a .perfconfig file setting.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-record.c | 60 +++++-------------------------
 tools/perf/builtin-top.c    | 20 ++++++----
 tools/perf/builtin-trace.c  |  9 ++++-
 tools/perf/util/callchain.c | 73 ++++++++++++++++++++++++++++++-------
 tools/perf/util/callchain.h | 12 ++----
 5 files changed, 94 insertions(+), 80 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40917a0be238..26223f9505c2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2975,65 +2975,25 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	return status;
 }
 
-static void callchain_debug(struct callchain_param *callchain)
-{
-	static const char *str[CALLCHAIN_MAX] = { "NONE", "FP", "DWARF", "LBR" };
-
-	pr_debug("callchain: type %s\n", str[callchain->record_mode]);
-
-	if (callchain->record_mode == CALLCHAIN_DWARF)
-		pr_debug("callchain: stack dump size %d\n",
-			 callchain->dump_size);
-}
-
-int record_opts__parse_callchain(struct record_opts *record,
-				 struct callchain_param *callchain,
-				 const char *arg, bool unset)
-{
-	int ret;
-	callchain->enabled = !unset;
-
-	/* --no-call-graph */
-	if (unset) {
-		callchain->record_mode = CALLCHAIN_NONE;
-		pr_debug("callchain: disabled\n");
-		return 0;
-	}
-
-	ret = parse_callchain_record_opt(arg, callchain);
-	if (!ret) {
-		/* Enable data address sampling for DWARF unwind. */
-		if (callchain->record_mode == CALLCHAIN_DWARF &&
-		    !record->record_data_mmap_set)
-			record->record_data_mmap = true;
-		callchain_debug(callchain);
-	}
-
-	return ret;
-}
-
-int record_parse_callchain_opt(const struct option *opt,
+static int record_parse_callchain_opt(const struct option *opt,
 			       const char *arg,
 			       int unset)
 {
 	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
 }
 
-int record_callchain_opt(const struct option *opt,
-			 const char *arg __maybe_unused,
-			 int unset __maybe_unused)
+static int record_callchain_opt(const struct option *opt,
+				const char *arg __maybe_unused,
+				int unset)
 {
-	struct callchain_param *callchain = opt->value;
-
-	callchain->enabled = true;
-
-	if (callchain->record_mode == CALLCHAIN_NONE)
-		callchain->record_mode = CALLCHAIN_FP;
+	/* The -g option only sets the callchain if not already configure by .perfconfig. */
+	if (callchain_param.record_mode != CALLCHAIN_NONE)
+		return 0;
 
-	callchain_debug(callchain);
-	return 0;
+	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
 }
 
+
 static int perf_record_config(const char *var, const char *value, void *cb)
 {
 	struct record *rec = cb;
@@ -3525,7 +3485,7 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
+	OPT_CALLBACK_NOOPT('g', NULL, &record.opts,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
 	OPT_CALLBACK(0, "call-graph", &record.opts,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 710604c4f6f6..5d2587228975 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1386,13 +1386,6 @@ static int __cmd_top(struct perf_top *top)
 	return ret;
 }
 
-static int
-callchain_opt(const struct option *opt, const char *arg, int unset)
-{
-	symbol_conf.use_callchain = true;
-	return record_callchain_opt(opt, arg, unset);
-}
-
 static int
 parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 {
@@ -1413,6 +1406,19 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_top_opt(arg);
 }
 
+static int
+callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unset)
+{
+	struct callchain_param *callchain = opt->value;
+
+	/* The -g option only sets the callchain if not already configure by .perfconfig. */
+	if (callchain->record_mode != CALLCHAIN_NONE)
+		return 0;
+
+	return parse_callchain_opt(opt, "fp", unset);
+}
+
+
 static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
 {
 	if (!strcmp(var, "top.call-graph")) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1c38f3d16a31..f487fbaa0ad6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5300,6 +5300,13 @@ static int trace__parse_summary_mode(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int trace_parse_callchain_opt(const struct option *opt,
+				     const char *arg,
+				     int unset)
+{
+	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
+}
+
 static int trace__config(const char *var, const char *value, void *arg)
 {
 	struct trace *trace = arg;
@@ -5447,7 +5454,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
-		     &record_parse_callchain_opt),
+		     &trace_parse_callchain_opt),
 	OPT_BOOLEAN(0, "libtraceevent_print", &trace.libtraceevent_print,
 		    "Use libtraceevent to print the tracepoint arguments."),
 	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8ff0898799ee..f879b84f8ff9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -30,6 +30,7 @@
 #include "map.h"
 #include "callchain.h"
 #include "branch.h"
+#include "record.h"
 #include "symbol.h"
 #include "thread.h"
 #include "util.h"
@@ -170,7 +171,7 @@ static int get_stack_size(const char *str, unsigned long *_size)
 static int
 __parse_callchain_report_opt(const char *arg, bool allow_record_opt)
 {
-	char *tok;
+	char *tok, *arg_copy;
 	char *endptr, *saveptr = NULL;
 	bool minpcnt_set = false;
 	bool record_opt_set = false;
@@ -182,12 +183,17 @@ __parse_callchain_report_opt(const char *arg, bool allow_record_opt)
 	if (!arg)
 		return 0;
 
-	while ((tok = strtok_r((char *)arg, ",", &saveptr)) != NULL) {
+	arg_copy = strdup(arg);
+	if (!arg_copy)
+		return -ENOMEM;
+
+	tok = strtok_r(arg_copy, ",", &saveptr);
+	while (tok) {
 		if (!strncmp(tok, "none", strlen(tok))) {
 			callchain_param.mode = CHAIN_NONE;
 			callchain_param.enabled = false;
 			symbol_conf.use_callchain = false;
-			return 0;
+			goto out;
 		}
 
 		if (!parse_callchain_mode(tok) ||
@@ -214,30 +220,35 @@ __parse_callchain_report_opt(const char *arg, bool allow_record_opt)
 			unsigned long size = 0;
 
 			if (get_stack_size(tok, &size) < 0)
-				return -1;
+				goto err_out;
 			callchain_param.dump_size = size;
 			try_stack_size = false;
 		} else if (!minpcnt_set) {
 			/* try to get the min percent */
 			callchain_param.min_percent = strtod(tok, &endptr);
 			if (tok == endptr)
-				return -1;
+				goto err_out;
 			minpcnt_set = true;
 		} else {
 			/* try print limit at last */
 			callchain_param.print_limit = strtoul(tok, &endptr, 0);
 			if (tok == endptr)
-				return -1;
+				goto err_out;
 		}
 next:
-		arg = NULL;
+		tok = strtok_r(NULL, ",", &saveptr);
 	}
 
 	if (callchain_register_param(&callchain_param) < 0) {
 		pr_err("Can't register callchain params\n");
-		return -1;
+		goto err_out;
 	}
+out:
+	free(arg_copy);
 	return 0;
+err_out:
+	free(arg_copy);
+	return -1;
 }
 
 int parse_callchain_report_opt(const char *arg)
@@ -257,14 +268,12 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 	int ret = -1;
 
 	/* We need buffer that we know we can write to. */
-	buf = malloc(strlen(arg) + 1);
+	buf = strdup(arg);
 	if (!buf)
 		return -ENOMEM;
 
-	strcpy(buf, arg);
-
-	tok = strtok_r((char *)buf, ",", &saveptr);
-	name = tok ? : (char *)buf;
+	tok = strtok_r(buf, ",", &saveptr);
+	name = tok ? : buf;
 
 	do {
 		/* Framepointer style */
@@ -328,6 +337,44 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 	return ret;
 }
 
+static void callchain_debug(const struct callchain_param *callchain)
+{
+	static const char *str[CALLCHAIN_MAX] = { "NONE", "FP", "DWARF", "LBR" };
+
+	pr_debug("callchain: type %s\n", str[callchain->record_mode]);
+
+	if (callchain->record_mode == CALLCHAIN_DWARF)
+		pr_debug("callchain: stack dump size %d\n",
+			 callchain->dump_size);
+}
+
+int record_opts__parse_callchain(struct record_opts *record,
+				 struct callchain_param *callchain,
+				 const char *arg, bool unset)
+{
+	int ret;
+
+	callchain->enabled = !unset;
+
+	/* --no-call-graph */
+	if (unset) {
+		callchain->record_mode = CALLCHAIN_NONE;
+		pr_debug("callchain: disabled\n");
+		return 0;
+	}
+
+	ret = parse_callchain_record_opt(arg, callchain);
+	if (!ret) {
+		/* Enable data address sampling for DWARF unwind. */
+		if (callchain->record_mode == CALLCHAIN_DWARF &&
+		    !record->record_data_mmap_set)
+			record->record_data_mmap = true;
+		callchain_debug(callchain);
+	}
+
+	return ret;
+}
+
 int perf_callchain_config(const char *var, const char *value)
 {
 	char *endptr;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index df54ddb8c0cb..06d463ccc7a0 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -9,11 +9,13 @@
 
 struct addr_location;
 struct evsel;
+struct hist_entry;
+struct hists;
 struct ip_callchain;
 struct map;
 struct perf_sample;
+struct record_opts;
 struct thread;
-struct hists;
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -237,14 +239,6 @@ struct callchain_cursor *get_tls_callchain_cursor(void);
 int callchain_cursor__copy(struct callchain_cursor *dst,
 			   struct callchain_cursor *src);
 
-struct option;
-struct hist_entry;
-
-int record_parse_callchain_opt(const struct option *opt, const char *arg, int unset);
-int record_callchain_opt(const struct option *opt, const char *arg, int unset);
-
-struct record_opts;
-
 int record_opts__parse_callchain(struct record_opts *record,
 				 struct callchain_param *callchain,
 				 const char *arg, bool unset);
-- 
2.53.0.851.ga537e3e6e9-goog

