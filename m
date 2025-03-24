Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CD1E5B86
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855711; cv=none; b=doveT5habglwZvDcWRlTKGz5m6tsFy/b5i//ZwtujhHrkft87LVh2sXFp3nP4fEfxHGbv61jiIZ56mA4lOb4iC64hUPeRLXhpGUskv+1JR3G/Yi2uaZJ+8qde9dejzbSA3GbBTrYhj96kdl5MUnVbNup/6cbNN81y+c+Itz7/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855711; c=relaxed/simple;
	bh=jq5PjJ/ugYrx4xcRpoE6fLhSyd7TK8mfub7jd04bhO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=X+gSqxLx8eV48MsW8k43niq1Eza7rW6iOwQulyLHCS+nFc3pqPkbrh1HIPVt/W2hUWgtbMOmuYLQun+3jHJW42S07RRkNK1bzL3XAmXXIHGT1oFBy0vKULze8Mv/S59844JjXJxBoDx9jEh6L6RmmWsbqdeySZrkAv1sMUheqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STSKn9zx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STSKn9zx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2233b764fc8so80363065ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855709; x=1743460509; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hi9qV/98s3GAaLJGCI97xHdsmqnmvPcBtjZEurAgWmA=;
        b=STSKn9zx6+srrxS9qyjWdUA0eBvYKEvCd8GOYBRTp/d/v/gVi3lj7xAK1UaZo7Jrq3
         YnmWdwTsaBq0xDA2+hJ4o4i2Kjt9iqC2ETNadjwLrsDDTSHU8wSud42r3Z4Cc59rNzjB
         mJHUlmayxvP9wwSaahj1FjW6mXD6A3TWVP20xF1kC+zWMhpKbZyesk5bFSbMh2SbnuPf
         0b3E/7lLUmZuolVUmAxNJHfUyFYjPORT2QbSutBIt1gbJ2ljnVKz9fUNKlK/A2JhCJC5
         P+DxTo99NZXOlVcw8Zp88CS2iimY4ZX44neE3XgFq3lkRNUaVi+7ReFosF/EOKfyjVBO
         rbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855709; x=1743460509;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi9qV/98s3GAaLJGCI97xHdsmqnmvPcBtjZEurAgWmA=;
        b=grS9A4Ms4B/fZQxi+ajxNMk1QdsAaDktn6y1K2F86QYMuZ9bDbE7qrRd/1ksIg5NWD
         FGOAGpH5FjsdVLnqyA9dNXM/GO0Vljzgy3NuTTmlGl8EeNX6jMB5GqbyvLYV8Xgogi26
         Wx2aOS6gv5OZ12vn9K0VdW3W2UZx8mDm1eOgjq39nH0F2CJBjbckgQ08GtDgKtKl0dx1
         nC8cZp/dqkv3PVuZLndryagx8zD5HhA3bTaRtazqrhgDEpaLHa60zGxjMmeTio+pQqZG
         /FW4eVngSUU/F346MLf4saUJvMAXg/Bt4x++wqueUV1y2ThmbdJXJb+RZTnftDdK229Y
         6vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVke08Up58dWoBbYqRF1MM5QQuBFdBRNA0/rpnyytXf7FOUK8XyOv4Z0MIfwuFNphL1agyfuizHC3I8neLKOt1h@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXLSqTAPS2po2KxNcN7xI9HBNCALQP+FUU/+tJYEi5eDXR1eP
	VXbVMdbK4bF0Km+DFHrPo7UNYfH+JCE6CRVTuDS4Sg/oLMU+eCK2sTE+gdesHSjMo7g9Ee+f1Rv
	EKOiBog==
X-Google-Smtp-Source: AGHT+IGFxmafsPpLyD17+00wez3sX1EFe8IKkFijnkrwpG/ZYSYE6tSXfbTvjzfIcsV17fEt155JaIjS1hm6
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:af2:48c3:360f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d84:b0:1f5:7f2e:5c3c
 with SMTP id adf61e73a8af0-1fe42f0920bmr20802083637.1.1742855708807; Mon, 24
 Mar 2025 15:35:08 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:44 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-7-irogers@google.com>
Subject: [PATCH v1 06/14] perf intel-tpebs: Inline get_perf_record_args
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Code is short enough to be inlined and there are no error cases when
made inline. Make the implicit NULL pointer at the end of the argv
explicit. Move the fixed number of arguments before the variable
number of arguments. Correctly size the argv allocation and zero when
feeing to avoid a dangling pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 75 +++++++++++++----------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index e5ca58599b5f..3141b7d2e94f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -46,72 +46,53 @@ struct tpebs_retire_lat {
 	double val;
 };
 
-static int get_perf_record_args(const char **record_argv, char buf[],
-				const char *cpumap_buf)
+static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
-	struct tpebs_retire_lat *e;
-	int i = 0;
+	const char **record_argv;
+	int tpebs_event_size = 0, i = 0, ret;
+	char control_fd_buf[32];
+	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
 
-	pr_debug("tpebs: Prepare perf record for retire_latency\n");
+	record_argv = malloc((10 + 2 * tpebs_event_size) * sizeof(*record_argv));
+	if (!record_argv)
+		return -ENOMEM;
 
 	record_argv[i++] = "perf";
 	record_argv[i++] = "record";
 	record_argv[i++] = "-W";
 	record_argv[i++] = "--synth=no";
-	record_argv[i++] = buf;
 
-	if (!cpumap_buf) {
-		pr_err("tpebs: Require cpumap list to run sampling\n");
-		return -ECANCELED;
-	}
-	/* Use -C when cpumap_buf is not "-1" */
-	if (strcmp(cpumap_buf, "-1")) {
+	scnprintf(control_fd_buf, sizeof(control_fd_buf), "--control=fd:%d,%d",
+		  control_fd[0], ack_fd[1]);
+	record_argv[i++] = control_fd_buf;
+
+	record_argv[i++] = "-o";
+	record_argv[i++] = PERF_DATA;
+
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel->evlist->core.user_requested_cpus)) {
+		cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
+				 sizeof(cpumap_buf));
 		record_argv[i++] = "-C";
 		record_argv[i++] = cpumap_buf;
 	}
 
-	list_for_each_entry(e, &tpebs_results, nd) {
+	list_for_each_entry(t, &tpebs_results, nd) {
 		record_argv[i++] = "-e";
-		record_argv[i++] = e->name;
+		record_argv[i++] = t->name;
 	}
-
-	record_argv[i++] = "-o";
-	record_argv[i++] = PERF_DATA;
-
-	return 0;
-}
-
-static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
-{
-	const char **record_argv;
-	size_t tpebs_event_size = 0;
-	int ret;
-	char buf[32];
-	char cpumap_buf[50];
-	struct tpebs_retire_lat *t;
-
-	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
-			 sizeof(cpumap_buf));
-
-	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
-
-	list_for_each_entry(t, &tpebs_results, nd)
-		tpebs_event_size++;
-
-	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
-	if (!record_argv)
-		return -ENOMEM;
-
-	ret = get_perf_record_args(record_argv, buf, cpumap_buf);
-	if (ret)
-		goto out;
+	record_argv[i++] = NULL;
+	assert(i == 10 + 2 * tpebs_event_size || i == 8 + 2 * tpebs_event_size);
+	/* Note, no workload given so system wide is implied. */
 
 	assert(tpebs_cmd.pid == 0);
 	tpebs_cmd.argv = record_argv;
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
-out:
-	free(record_argv);
+	zfree(&tpebs_cmd.argv);
 	return ret;
 }
 
-- 
2.49.0.395.g12beb8f557-goog

