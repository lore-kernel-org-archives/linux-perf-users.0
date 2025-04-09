Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B931E2613
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179068; cv=none; b=YyNYWTmkmPWbcMXxRJ9TGEYTOk5UM68crP9VA/NctBhMEEIkPtFsZamnCurScGLhJI4craqzCjmL8+ZDs8S613L3xdcmyja3Z9dQnZQ863Y6oBJZbX8s0qyp48HcUJkpj8o1VrS85t1kSlcoSpMu9JrmEyNgqc3cyVzhhH29gB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179068; c=relaxed/simple;
	bh=dmk99xLT8Nx0mz4ddF1+mWBkWibkJI69saN0P2VeVFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OY9deZmAQO7XusJ93kCABlkqm1MX1Yc0rXaAnj7J4JsGXGK4SUPI9JC3YEABQvp1Y25VGoLu2+s43/62N4indcl+iOAqv2WrPPAMg0ukm0agoEKU8XWgH3ZJ9HPIAXaGjrFoOLSi/J16MTP95RN1TldSonyV7V2Y3fUBJvrWgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HS2Y1X/E; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HS2Y1X/E"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c0306242so8388061b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179066; x=1744783866; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=HS2Y1X/EG1Sp5u4SEeGgcVMwvO3Ut/k9JuB1Og3hL55ND258S8N5H4m960RDmo4WGT
         oISP7EhofptxGj6QqeKfrynRfo1eGfTRuOcM1xKVc0emKZYeLJpbED3xkkLL54zTwa/y
         p/6yhfKvCL9NCq3i+ZDwaVSKPjIGhGJpB/a5SHxif781OkYLrW6ZDy5zxLnDDHoEq3b4
         m1OyXMGmfI2nRsCM0NVQ137tgknTS1d0efNeZ/9Ww1UEYQNMGLKjvT7smRupQK6sQGGB
         9FsS3aCD5hVN6xO/MiSGdMnabbvs+1HvuP+s0M/SYoYKbOdXaRTFSMlfa9ei5IwUpk4p
         B3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179066; x=1744783866;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=af+Z4jy4N1NJ3C+cHfkwFQ3AY+N5X4yHaF0bQs1ebA+UKaIVIADYSKY1SOIqCZboXJ
         eZXiUaWBNfJm+3b7MoLJ82mKmbo7ZzVc5PupiEctzS+jsytHWtuwKUpLIjri8GkWPRY8
         vBiXAh6PnFoQtPeoB+r2txj4UihgcmMXImVWUAabU3dKQrk8MLmWmjJHdw+HyAJIhJz+
         zfpmRHsG1KoNuSYy8oDhRiuBDXa0qNbC7QoEqLyU/4n6t9DsXyAZrVurPtwBZbCd1ufz
         B+L0uycwqNJf3twImHCwbLASkW8dk78V4Ho6q+eH8pMOIr8CM6/SLaSVjg51XC4H1ZCr
         Qrpg==
X-Forwarded-Encrypted: i=1; AJvYcCXHPpHZdspTfGcCw16OKEIAHH37btEWKywhaYinQwp/NlxxwkWUcvUVwTVbQtsA1haKs7tGugbJBNJEbMbjuuWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ieGAlvwoEwNtTqIFKENX83FFnZYOcJ6SfgdMqzInKNCMcv9D
	RjqM39t9+v6a18g5ezWOrdH9JrIJduU7oWphFetEVCHoQhJPXUJjh5lnl3OXAUfrCoJfjAbFmN5
	+r+rt3A==
X-Google-Smtp-Source: AGHT+IHIlVWKyvLN9AtN+rEwT88vbBZNLzA5K1Liojv7je6hNLCGDN0pW+2T2x4f89F1wPSVYdpKiuST2b/v
X-Received: from pfbgp2.prod.google.com ([2002:a05:6a00:3b82:b0:736:4ad6:1803])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1310:b0:736:34ff:be8
 with SMTP id d2e1a72fcca58-73bafd3181bmr1423652b3a.19.1744179065639; Tue, 08
 Apr 2025 23:11:05 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:34 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-8-irogers@google.com>
Subject: [PATCH v4 07/16] perf intel-tpebs: Inline get_perf_record_args
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
index e3bed86145b9..c4c818f32239 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -47,72 +47,53 @@ struct tpebs_retire_lat {
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
2.49.0.504.g3bcea36a83-goog

