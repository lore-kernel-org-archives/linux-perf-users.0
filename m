Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551747799E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060019; cv=none; b=fZfGftEQtlNwU8IabLmbWtjVIV24M+gB21qRlcZ5GEbIM/YkfCPPa9ryIvUKuEwc89IPicxN2A5W2eiLHks2kL2FzZmgo1xXiQvbf0sQ1mY/M99RKZ9LrKfNzZsTCHhbw4nGcI2Mo+U94ITb/RdA1jTRteebCIOJzSDLEClw/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060019; c=relaxed/simple;
	bh=pQw3DSGto9YWSkBY2nT7ZjSAEw73RvDiI42ofQz12bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BCjZuVOcMApguGrd3nrZmSMFlGpkTC49Uo7JOnQQVARlbEuaDGNrLqPWAkAYAEs9hgbSndTktyXsAAJrGspnI8REqaxRDHga9FHZBz8IAPHH5tpYYGZAfy6FOvySKCXCjzWrM6z7yTOp005KU6tqLjvrxVeTX6lHcar2q28lgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hi9pKJ8m; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hi9pKJ8m"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so13555124eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060017; x=1775664817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6aSMFYxARFqb+s5PRfj6hVV83IM5y47yqCQJKiEqaA=;
        b=hi9pKJ8mYiZQ7HFh5voxeqSOWnnTIUFCRrGOz2Bfe3wmxJOiuzzk5oplYtXoeQWgU9
         pMnd3IGqlvIsUZoP+N96N26byQDKuaOLwljXG4O5UuzckcS5XFlg05HEhhYWb++1ei6u
         HCpmUueZbUYm9ajLhrYzVcAYGmBABihGsoQrsII5PRKLB25HeNDszdMvLAVc0P7bR9CA
         TPXAAHDWLv4BKpXa/OIUGKW4LMlTRBbbK5zW5zRkuLNyIvavgFVtRlYwQADFHB7SRgDA
         x3ZlyOU5Ap718uY2lUuw9xTL/U4tW3Es8gnB2GBCluhlEmJi+bGC/NL8naiznF1jQkJt
         qHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060017; x=1775664817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6aSMFYxARFqb+s5PRfj6hVV83IM5y47yqCQJKiEqaA=;
        b=kU/KTku/EjMERja9DNelvPaF1Sj93tJ6JqCIaNB+b6cFi6QalXz7VnVX3QPi1aGLn9
         UUMH17GMy3Qo4u5duQcpZuiL6SVAUj4lgB3zRO13eL79cXOrN0BmISTNBAOw9P8g+7pk
         l6Q50PdywwpQzeZ0xNnKFaKOYfmJmxiSHj4nx3rgM4xl7VBQNhRTD4xVaCTPzKocCkaJ
         WPim07R2/lICxov9CJ3CuZyhZDJ839F6+W2BJMWdrNyyaegrM+7LD38rmrBCZ6jXxcBz
         6iNDa/tihTlPB+sunQY5Di3KO3dUi/iwKPJ3k14VMPi3ZBkZOvxrFd7nnYaLNQ4ioHzM
         zMeA==
X-Forwarded-Encrypted: i=1; AJvYcCVC1oaHYfY6UBqseqEme7c7lAeHHxHAPJbhsbTEH7V0AU533rfKPYEwQr7HCL4GJMvk2PdziD/q/vXJivUu63rQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzltJJCuy7KrctdYR2MkTDOYSzqgjpf1oE1eLllGRwew3HQdKPQ
	53lywbvedFREgWg5N8aN9JJMlkBqMBAdXeRJWWHgVzZr87lSaFkUjsrRvIWPdysWHIA9KvSj6LZ
	sX7odnxa8Pw==
X-Received: from dybir8.prod.google.com ([2002:a05:7300:c8c8:b0:2c0:be02:79e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3724:b0:2c1:27c:75bd
 with SMTP id 5a478bee46e88-2c92db587e3mr2528654eec.0.1775060014789; Wed, 01
 Apr 2026 09:13:34 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:19 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-4-irogers@google.com>
Subject: [PATCH v4 3/8] perf header: Properly warn/print when
 libtraceevent/libbpf support is missing
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

By removing the features from feat_ops with ifdefs the previous logic
would print "# (null)" when perf processed a feature that lacked
builtin support. Remove the ifdefs from feat_ops and in the relevant
functions print errors/messages about the lack of support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 70 +++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fcd53271e189..50c006be895f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -306,16 +306,19 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	return 0;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int write_tracing_data(struct feat_fd *ff,
-			      struct evlist *evlist)
+			      struct evlist *evlist __maybe_unused)
 {
 	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
 		return -1;
 
+#ifdef HAVE_LIBTRACEEVENT
 	return read_tracing_data(ff->fd, &evlist->core.entries);
-}
+#else
+	pr_err("ERROR: Trying to write tracing data without libtraceevent support.\n");
+	return -1;
 #endif
+}
 
 static int write_build_id(struct feat_fd *ff,
 			  struct evlist *evlist __maybe_unused)
@@ -1026,10 +1029,10 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
-#ifdef HAVE_LIBBPF_SUPPORT
-static int write_bpf_prog_info(struct feat_fd *ff,
+static int write_bpf_prog_info(struct feat_fd *ff  __maybe_unused,
 			       struct evlist *evlist __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
@@ -1067,11 +1070,16 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 out:
 	up_read(&env->bpf_progs.lock);
 	return ret;
+#else
+	pr_err("ERROR: Trying to write bpf_prog_info without libbpf support.\n");
+	return -1;
+#endif // HAVE_LIBBPF_SUPPORT
 }
 
-static int write_bpf_btf(struct feat_fd *ff,
+static int write_bpf_btf(struct feat_fd *ff __maybe_unused,
 			 struct evlist *evlist __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
@@ -1100,8 +1108,11 @@ static int write_bpf_btf(struct feat_fd *ff,
 out:
 	up_read(&env->bpf_progs.lock);
 	return ret;
-}
+#else
+	pr_err("ERROR: Trying to write btf data without libbpf support.\n");
+	return -1;
 #endif // HAVE_LIBBPF_SUPPORT
+}
 
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
@@ -1980,9 +1991,9 @@ static void print_dir_format(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
 }
 
-#ifdef HAVE_LIBBPF_SUPPORT
-static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
+static void print_bpf_prog_info(struct feat_fd *ff __maybe_unused, FILE *fp)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
@@ -1993,7 +2004,7 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 	next = rb_first(root);
 
 	if (!next)
-		printf("# bpf_prog_info empty\n");
+		fprintf(fp, "# bpf_prog_info empty\n");
 
 	while (next) {
 		struct bpf_prog_info_node *node;
@@ -2006,10 +2017,14 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 	}
 
 	up_read(&env->bpf_progs.lock);
+#else
+	fprintf(fp, "# bpf_prog_info missing, no libbpf support\n");
+#endif // HAVE_LIBBPF_SUPPORT
 }
 
-static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
+static void print_bpf_btf(struct feat_fd *ff __maybe_unused, FILE *fp)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
 	struct rb_node *next;
@@ -2031,8 +2046,10 @@ static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
 	}
 
 	up_read(&env->bpf_progs.lock);
-}
+#else
+	fprintf(fp, "# bpf btf data missing, no libbpf support\n");
 #endif // HAVE_LIBBPF_SUPPORT
+}
 
 static void free_event_desc(struct evsel *events)
 {
@@ -2644,14 +2661,17 @@ static int process_e_machine(struct feat_fd *ff, void *data __maybe_unused)
 	return do_read_u32(ff, &ff->ph->env.e_flags);
 }
 
-#ifdef HAVE_LIBTRACEEVENT
-static int process_tracing_data(struct feat_fd *ff, void *data)
+static int process_tracing_data(struct feat_fd *ff __maybe_unused, void *data __maybe_unused)
 {
+#ifdef HAVE_LIBTRACEEVENT
 	ssize_t ret = trace_report(ff->fd, data, false);
 
 	return ret < 0 ? -1 : 0;
-}
+#else
+	pr_err("ERROR: Trying to read tracing data without libtraceevent support.\n");
+	return -1;
 #endif
+}
 
 static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 {
@@ -3330,9 +3350,9 @@ static int process_dir_format(struct feat_fd *ff,
 	return do_read_u64(ff, &data->dir.version);
 }
 
-#ifdef HAVE_LIBBPF_SUPPORT
-static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
+static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct bpf_prog_info_node *info_node;
 	struct perf_env *env = &ff->ph->env;
 	struct perf_bpil *info_linear;
@@ -3402,10 +3422,15 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 	free(info_node);
 	up_write(&env->bpf_progs.lock);
 	return err;
+#else
+	pr_err("ERROR: Trying to read bpf_prog_info without libbpf support.\n");
+	return -1;
+#endif // HAVE_LIBBPF_SUPPORT
 }
 
-static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
+static int process_bpf_btf(struct feat_fd *ff  __maybe_unused, void *data __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct perf_env *env = &ff->ph->env;
 	struct btf_node *node = NULL;
 	u32 count, i;
@@ -3449,8 +3474,11 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	up_write(&env->bpf_progs.lock);
 	free(node);
 	return err;
-}
+#else
+	pr_err("ERROR: Trying to read btf data without libbpf support.\n");
+	return -1;
 #endif // HAVE_LIBBPF_SUPPORT
+}
 
 static int process_compressed(struct feat_fd *ff,
 			      void *data __maybe_unused)
@@ -3726,9 +3754,7 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
 
 const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
-#ifdef HAVE_LIBTRACEEVENT
 	FEAT_OPN(TRACING_DATA,	tracing_data,	false),
-#endif
 	FEAT_OPN(BUILD_ID,	build_id,	false),
 	FEAT_OPR(HOSTNAME,	hostname,	false),
 	FEAT_OPR(OSRELEASE,	osrelease,	false),
@@ -3752,10 +3778,8 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 	FEAT_OPR(CLOCKID,	clockid,	false),
 	FEAT_OPN(DIR_FORMAT,	dir_format,	false),
-#ifdef HAVE_LIBBPF_SUPPORT
 	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
 	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
-#endif
 	FEAT_OPR(COMPRESSED,	compressed,	false),
 	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
-- 
2.53.0.1118.gaef5881109-goog

