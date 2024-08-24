Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9D17BED2;
	Sat, 24 Aug 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517211; cv=none; b=h+eu540LqpNw2c2OFk2ud6L7lFjmcpsW2xaaEtcogHTzymxkEKRLaeE2AfsjTcwAZeSWB1RMcTno2591BSC/mN+IcBpIjFVNPUHl8S5hHdHELX1FM6WMZ4GUzhrxr967eHMY4ulWkDRaY+aiqoSy58sWrMcoPMY8LuTs3NVj4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517211; c=relaxed/simple;
	bh=DhvbL1P1QdBR+sRLyNlNmk0DRBaHP202JuLTh7457Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfW4lIXdg+02gyGDJKyZnA7a6sF6ZNgyxidiIJLpvyNJ/OGIAm9i7jjwHG0yqCKZ6cJhIwIgdHxexzgKK1bRUalg0Lygb1Xvs+y7Vw5JSFY8sLi6GCXvcTZQ+7B8yNvcH37MnctJjtTAJe3MlT4ri+dehrA/Rro4AXrpt7qZV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q//a0wS0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q//a0wS0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso2910123b3a.0;
        Sat, 24 Aug 2024 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517209; x=1725122009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiGTpTFrW930dnsO08eww04nlYiG3CY1GeWlH+yxrak=;
        b=Q//a0wS0GW3g+V6jYtQ06US4De5WBg0QeBWZm1Q0C6Qg5/luzqUZk+cTwjyswCh6rM
         iSGS8meJMdnByMTy1KxccnFzdT4i6NfIO+GXn7Y+ms+qWmvCgwC5v8v3ocSAS4AzPlO0
         XsZhCnm82iFTj1MiaPvkFU4qdB7B1+NvrnMDoZGys26/fF0ON6EzCCAiePLFZXTjx1gU
         f7ZAekFcGWudEOFg7Z1PyPtDAXOY87DRzsvUspI0JnIDgfBUpnTUrBdpXLFumv+SBhDH
         YljT2JSGo19RHinUHTvknD+qLHJfrcTlVX8N8F3/nkxfq/PNofc6M4SIB7Vh4JrzqIlS
         f0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517209; x=1725122009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiGTpTFrW930dnsO08eww04nlYiG3CY1GeWlH+yxrak=;
        b=r90EPTrO9FVcDfeXrt/Ob07afdRvPH1bPUgU9jgCjHAyBZbHyXPGwsoLnz/0ThzUxZ
         Bqs3knObXcf5CyqlBea0zaASO4Ie8Ze+Q56IZ5lzdp+rwqEu4dNBWEMZbsWdDPJDpd8q
         U7jrGrhqT3fP6F85vi49rNhBJHS/CQCGz38rCJ0/FPaWMTz1G1Uo9Xc5dKzqlvPE9Ib8
         5V8AoSaPIr/W/cePPFbz3OyLYNgmOCbEVI7fendA8fN6YTe67g3PReBsSn3/AvT49geq
         0Bn4NtEULY68dJOCVpkFsyjKnHd6T5/P+BatarebZdwH70+Xd2LW8R6QuepLj6dZYElj
         9glg==
X-Forwarded-Encrypted: i=1; AJvYcCWK9VwdGxWmHmmVhvvLTUMJQtXfTOjvB2vfFHTuAslssgRGib3BWs3IFS8lhVmf70QfxAxoPCUZkrnrlYE=@vger.kernel.org, AJvYcCWuENnUHTZGu5O5YX2aMHxl2bKgQq2LeBuziRTfEu550tdPQfBDrHtUVwbM9Fy+dRRMPklV1m975QD0Kbn9rL0HpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXQ3KOgzmmA6cbWRQzK88oR38KnBfsaS4I9E3kMTW2L3zUQYr
	JlxfikZo7x1z2dtzlGr/JIhBDMPYdX73hel5DmBTZJ/kIodIOcPF
X-Google-Smtp-Source: AGHT+IEZCltjk7dbDEj3mX13JhOKjxJqj7mTtabsH2y6E6bCqxovXsICCmbmERO3ZVSEIfyWYS73nw==
X-Received: by 2002:a17:90a:ad82:b0:2c8:f3b5:7dd1 with SMTP id 98e67ed59e1d1-2d644ab7f2bmr9597234a91.16.1724517208749;
        Sat, 24 Aug 2024 09:33:28 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:28 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 4/8] perf trace: Pretty print struct data
Date: Sun, 25 Aug 2024 00:33:18 +0800
Message-ID: <20240824163322.60796-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the arg->augmented.args to arg->augmented.args->value to skip the
header for customized pretty printers, since we collect data in BPF
using the general augment_sys_enter(), which always adds the header.

Use btf_dump API to pretty print augmented struct pointer.

Prefer existed pretty-printer than btf general pretty-printer.

set compact = true and skip_names = true, so that no newline character
and argument name are printed.

Committer notes:

Simplified the btf_dump_snprintf callback to avoid using multiple
buffers, as discussed in the thread accessible via the Link tag below.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240815013626.935097-7-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                | 65 +++++++++++++++++++++--
 tools/perf/trace/beauty/perf_event_open.c |  2 +-
 tools/perf/trace/beauty/sockaddr.c        |  2 +-
 tools/perf/trace/beauty/timespec.c        |  2 +-
 4 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43b1f63415b4..048bcb92624c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -990,6 +990,54 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
+struct trace_btf_dump_snprintf_ctx {
+	char   *bf;
+	size_t printed, size;
+};
+
+static void trace__btf_dump_snprintf(void *vctx, const char *fmt, va_list args)
+{
+	struct trace_btf_dump_snprintf_ctx *ctx = vctx;
+
+	ctx->printed += vscnprintf(ctx->bf + ctx->printed, ctx->size - ctx->printed, fmt, args);
+}
+
+static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg)
+{
+	struct trace_btf_dump_snprintf_ctx ctx = {
+		.bf   = bf,
+		.size = size,
+	};
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	int type_id = arg->fmt->type_id, consumed;
+	struct btf_dump *btf_dump;
+
+	LIBBPF_OPTS(btf_dump_opts, dump_opts);
+	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
+
+	if (arg == NULL || arg->augmented.args == NULL)
+		return 0;
+
+	dump_data_opts.compact     = true;
+	dump_data_opts.skip_names  = true;
+
+	btf_dump = btf_dump__new(btf, trace__btf_dump_snprintf, &ctx, &dump_opts);
+	if (btf_dump == NULL)
+		return 0;
+
+	/* pretty print the struct data here */
+	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
+		return 0;
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	btf_dump__free(btf_dump);
+
+	return ctx.printed;
+}
+
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
 				   size_t size, int val, char *type)
 {
@@ -1009,6 +1057,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 
 	if (btf_is_enum(arg_fmt->type))
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
+	else if (btf_is_struct(arg_fmt->type))
+		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
 
 	return 0;
 }
@@ -2222,6 +2272,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 		.show_string_prefix = trace->show_string_prefix,
 	};
 	struct thread_trace *ttrace = thread__priv(thread);
+	void *default_scnprintf;
 
 	/*
 	 * Things like fcntl will set this in its 'cmd' formatter to pick the
@@ -2263,11 +2314,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
-							   size - printed, val, field->type);
-			if (btf_printed) {
-				printed += btf_printed;
-				continue;
+			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
+
+			if (default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
+								   size - printed, val, field->type);
+				if (btf_printed) {
+					printed += btf_printed;
+					continue;
+				}
 			}
 
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 01ee15fe9d0c..632237128640 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -76,7 +76,7 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	return perf_event_attr___scnprintf((void *)arg->augmented.args, bf, size, arg->trace->show_zeros);
+	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, bf, size, arg->trace->show_zeros);
 }
 
 static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 2e0e867c0c1b..6ecebf776899 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -47,7 +47,7 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
 
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args;
+	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args->value;
 	char family[32];
 	size_t printed;
 
diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
index e1a61f092aad..b14ab72a2738 100644
--- a/tools/perf/trace/beauty/timespec.c
+++ b/tools/perf/trace/beauty/timespec.c
@@ -7,7 +7,7 @@
 
 static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct timespec *ts = (struct timespec *)arg->augmented.args;
+	struct timespec *ts = (struct timespec *)arg->augmented.args->value;
 
 	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64 " }", ts->tv_sec, ts->tv_nsec);
 }
-- 
2.45.2

