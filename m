Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB01E3774
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178889; cv=none; b=IC3DQbZhj64CQPndVJvzdFSA0kbHMpsWNOtp54qFoqKLuzPKSxvzpYgRwwu3frLQwUvQnZI0RHO1oFBJ2lhFpidq5f+Mn/5YXxoFyJBP7uIZVgeAvV7kAMxM6yu+OkLENWXHdq9vFABMe1UDjcryeOhSaZB52RNzA0EaZlmipDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178889; c=relaxed/simple;
	bh=dmk99xLT8Nx0mz4ddF1+mWBkWibkJI69saN0P2VeVFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ndzrqp3IvrBOywchvsGN0+WOEU4Nqpgh+YF52us2Y9KEle2jRpcod0lw/ikKhfhcGB2YiFJXrExYILoM7yWn2SdD3tjCXPnb6mEVwPQY+lzOk8kRuys7UNbGEU7YZ3ZiA4YF7kN9O5C+besjM3yF5YGLuCaufe4cv/JBgv7nOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+rA8mRv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+rA8mRv"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso9735702a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178887; x=1744783687; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=a+rA8mRvJ5OTqLMAKKcvgqXTTFlz9gqNXx+Seq5jJmMvgceQa+BLSvKgVHG8k5EM5j
         zSEXGQuHxghXgSqZ/aLBwfTEhjNqMBJSYe2DHdz5vqmAfGa4ZKL/XoZupaEkXGR/0wBK
         BLbHICr5B03kAvcfZeGBKLmqarmSnPeVU+kHKUBYMaWQ1Tt/lU7fwFu+3V9B/vnBNbGh
         8+U2V2hmcGs75Ak0nkK/636nN0piVLhOT8ew4U7FVqZ1A74B8kSZBvGiq++v/SPAAvWL
         Lp3t/A24RxRm4ncqk78Vy4SHtgxj8tBQ50RWsJnDm2Uc0/pff7rn2dtGu9aYx6+uBHWs
         FLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178887; x=1744783687;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hurkMSaqLGDLbW/1AFRFsncWr/nyXd3OBuzAUIRrz+4=;
        b=qklwVKP/EEOnNejJZR6Vpv0pwgl0Rt07y/lzqwD1i4ZuWN1NssLaZq0X5KsH82a9NS
         ajhhD61Sf4O5nWf3I2/8plIay1QVtlqk9wGD+e5Jl8mAtT7uU9QmPIZBtUdIeB6+kg0A
         DmI0rxyzv02E8vKxcwvKIjZ8ktekZGvIP1EGM0Q9ayB7Xi9f4eRN3r+4oW50uoH7AqJF
         CcvSbi3x5WLbYXINOTmE1JDHLQHzPi9gRhnBVYfOpPjHBUA2O4QrEQOJ5qOjXohWi8Tv
         o/Xp5Qn25XIVFA5xkGk3mpL0liGiMY6gxZNErasE8pRhyzBIJXVFUojC42EfOhKyzY2j
         RvDA==
X-Forwarded-Encrypted: i=1; AJvYcCUQm3nj7yrPamIaJpf35OTmm45a2M0U89s2z/AX/ruVx6WVyMfaUeENWhYCJ8a2V1i22v9nGU8d9WlEa/vyOEGp@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkqfExwlog03Qxq1IFxL+j4JQk8B7tfvONnwG10ribcC76lfT
	9SjGdf1dQ0ctq7JUI+WD5DBbXVe/FOIUNZ1J5fFS0rw75guKb/FQo2c7IM4iXJVV3xIvTpEvBkd
	o0MH6jg==
X-Google-Smtp-Source: AGHT+IGDBd1RJDjnp6C+cFyERKUExc5ASS2VzUckmoLnYpHkRVZBs1hw2I96gdK0fDr9JWUQ4ACs+bhXeAVK
X-Received: from pjkk7.prod.google.com ([2002:a17:90b:57e7:b0:2fa:1fac:269c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ece:b0:2ee:5bc9:75c3
 with SMTP id 98e67ed59e1d1-306dbb8db11mr2441976a91.5.1744178887340; Tue, 08
 Apr 2025 23:08:07 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:34 -0700
In-Reply-To: <20250409060744.698511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409060744.698511-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-8-irogers@google.com>
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

