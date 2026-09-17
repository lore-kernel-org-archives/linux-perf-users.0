Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34375187C7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663166; cv=none; b=mEa3UQZ5ebYnwqsbw6ov1JvzAwxC6B4eLWMhgUsUqI9b6lw6G4uO2CZKa7NHBCsomgpLAG1aKfklCfMF7pMwV8Vad345VgXMvH+tBrAgIwix9XaYtyh75lIfHEJ4PzcY6BFWcS87hqLdWh5S0ZZJCU3PED7tItT1+Mxuwxdy0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663166; c=relaxed/simple;
	bh=AIhDuxYXm6TPBGEUGmeWMYRdVi5UgiMgDR7MkYv1egM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OiOcNV8o1IoosT7wQToNaW6jScdig8PoG34a7NPM8MRDVgj7JFBl0uGjuBwzon1du7tUWI+0vawcaRvcBzHxgwiDksXgFsPClkZmlnQ92ZcD3p3u291Dxyg5T6/BydpwVsfYWAFRAFwA9vkTAsQx5y9QOvoxkav0DtRZCnJbMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCNyeA3k; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCNyeA3k"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so2041272a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663164; x=1790267964; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZ4suTwVR71QEmnzgMO/8pQXqTLVqgY6KmKt7zHzuV0=;
        b=QCNyeA3kw2/dmW0tSZ3jU+dEaiXdjCTeIhd1F6NZ1czaKtoqQDMgvvdD/Uc9cqMEz9
         Uz8GrUrIpWxQlrSSelg60ZGaBFziLsVo7AbZ3uQKKzE6bmrYLbZ8dSiBHJiZ7CcFS1dw
         EzpAw/a2FOqmaIcHVyEQzuctsVpFyttdxkaGLuW8+yNjGByCbqNk5auGer2hZxoHQtLz
         pqN6lM6Em+FHNgu1RmEvYKmFnerUKFff76cWYNvS+lUhrNe+RP/S9cVz49K5+E1Irzc6
         1bfVGRlJFvmsWVjxi3/bcvxD1UF6OHr3jLdmGNrloFiWQlrUxOe7XVR7XAE9FmaeRp11
         xpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663164; x=1790267964;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZ4suTwVR71QEmnzgMO/8pQXqTLVqgY6KmKt7zHzuV0=;
        b=TKFZp3fjDGMNgx57LGTl7CPuSbjggqpKDj7QjDIfGDWsqU8MQhckKvntLs8hw2SqTo
         zUEK7G2RkTFITLfaqZ9cAUK5PNfn1IZpqh2liBiPw3LKz3nNZRJ4IdXwTev2XgQUYV3s
         CFZWKAU465fTQTi9GvehnmWhpxH1XU9da58IdrWMFjWMptQWgYSgrG4ch8TUMD3f8jko
         3IZmb7mh9+g0ntIkn2gVFOaR1w8R+tqPe9RbATQj7h+qmbCTuughWS4pDoTtMAHksYqk
         x54hqUA5kVb0N3Wc6Ngc6G2uqBuvz2v9T52MJY3xofWMZo4pFra3DIgJTZ9jBFy09Qxz
         NzDA==
X-Forwarded-Encrypted: i=1; AKwUvBzVP8frBPOiDWTYBZahkRZBUzj1XmJnh84pMpAzcCpzZufdiFIcuA97YzjMTKOEeFMvIlGHoGCv+NThYfIMH6UP@vger.kernel.org
X-Gm-Message-State: AFuF++nDOComQUfj6i0KpW/pNvxeSao3dtsS8V12Bl4Qu0Piya1nccaD
	88ObxIVfR7ejfgbU1qvjdBJBj2w5lXMWHwySbgUZrvkMVpL+3XrrGoB+KKvjLY4sYoKwUXdLsB4
	c9n/6if8/YQ==
X-Received: from dlii2.prod.google.com ([2002:a05:7022:4182:b0:143:926f:ba09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224b:b0:39d:eda9:febf
 with SMTP id 98e67ed59e1d1-39e1e4c637amr15458764a91.18.1789663163910; Thu, 17
 Sep 2026 09:39:23 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:50 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <ee1ddc3779258c12aa0df06eefdaed2d1f025fc8.1789662556.git.irogers@google.com>
Subject: [PATCH v2 02/14] perf trace: Start BPF summary before starting workload
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When using --bpf-summary, trace_start_bpf_summary() sets
skel->bss->enabled = 1. In trace__run(), trace_start_bpf_summary() was
previously invoked after evlist__start_workload().

Because evlist__start_workload() immediately unblocks the child process
by writing to its go_pipe, short-lived workloads (such as `cat /dev/null`)
can execute and complete their initial system calls before
trace_start_bpf_summary() is reached by the parent process. Furthermore,
under high system load, the child process may finish before the BPF
summary tracking is enabled in the kernel at all, causing syscall
summary tests to fail. Additionally, if initial_delay was configured,
the workload was started before sleeping.

Move trace_start_bpf_summary() to be invoked before
evlist__start_workload(), matching evlist__enable(), and ensure it
respects target.initial_delay.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..8da0c51ec380 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4838,17 +4838,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
 		evlist__enable(evlist);
 
+	if (trace->summary_bpf && !trace->opts.target.initial_delay)
+		trace_start_bpf_summary();
+
 	if (forks)
 		evlist__start_workload(evlist);
 
 	if (trace->opts.target.initial_delay) {
 		usleep(trace->opts.target.initial_delay * 1000);
 		evlist__enable(evlist);
+		if (trace->summary_bpf)
+			trace_start_bpf_summary();
 	}
 
-	if (trace->summary_bpf)
-		trace_start_bpf_summary();
-
 	trace->multiple_threads = perf_thread_map__pid(evlist__core(evlist)->threads, 0) == -1 ||
 		perf_thread_map__nr(evlist__core(evlist)->threads) > 1 ||
 		evlist__first(evlist)->core.attr.inherit;
-- 
2.55.0.1082.g2b9226bbc0-goog

