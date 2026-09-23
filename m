Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B44455602
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147667; cv=none; b=Ysds5YHna47GAmXCaPNzI+4Rj4rdaNvzgB5mkknG743kdHPk+D2ILdLp2+vcwvNIXNkFkk9okHGUvblnuaUw7udJbeojBe3gg+Az8CbfzMH8YZ6BpNF6ZfHiuGqUjgGNAlmqsw6/KpTslVgYtCwnizeKSZBBR2nGWMBlZfypvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147667; c=relaxed/simple;
	bh=ZFu28bTIZtHoVVmRm8bIPfJIFnqmIuxAuxjddZbdwck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BGO9rjW9+VFEXUpjuLRaYMWvOaszQQlg8nhnoknYUUDL0Wa50C/qM6/B7kryTECkG2wJ3gJ9ZDEejLK3kyAp30wKYJJjSAYlzmYkhkv9Wx0N2B3daLETVX+HSusFD92UbAINhzLRusGcIn6JlxwaKp5Lhd4D4BfcwjVKVs9QhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cuq4fRJ+; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cuq4fRJ+"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14371f7ba1eso942391c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147665; x=1790752465; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AtiWY+mIovc0ii7uMQ428LIkWxsAI+yH5okNrkOa1c=;
        b=Cuq4fRJ+wrr22Se61VE0RWjHB17vY+CvOZU/LQEk24Djm9WfdhQXhyoxa/qCfP5V0X
         W6qsYxjnXd3qpF5uNSOM664Fe/ywTALqxbrSEc+dABwWYvaigCGxfdXcZl2gXBVKekGv
         1XlyZaS+XnYGcbvbcLI1l3n0XgLlrukwWLjUirBHUZHwdRyiOcd7Jb/wmoV++y6GNd7d
         NPtePQcwbt8DGmP20IcC9E4jemlGsydrzI1RbIPssmHNVVJn6mGDCgUpvV0CTN/jSs9T
         ly0LF7WLR17AQ1arVEP3BQQnsvNq88IMljrELaR2YE4pFnMZKIrdiot7K0yqnyU7az3v
         WrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147665; x=1790752465;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AtiWY+mIovc0ii7uMQ428LIkWxsAI+yH5okNrkOa1c=;
        b=o74PcLfqghVk78Iyv8X98srwfCclD9u9OxTPgc8fzLz0ev7WVOkHOBTCBS4VoQNE5N
         qMISgVYKZyiQMy3cS+BLw/BWh/om/iwFE1lI0jWhYHnDYr6prtsye66VRkgRnaeQBU8D
         Mngp2ps+3GL3VmcueS+9KSh9+VA97ZMQN0e6a7UtRvh6ICFD26NF93wLk+wqqn3FQ5qB
         aJq8Srm8xLi8n+pwHi+UdeYTDPs2Epsb+AYDPHerbkxAAplT9vhGYvHgW5I+cHoVVdQS
         QW5N2HM4oAbIw/sSuIegevp9kcnWv2jXMtPSWLJuVwRgAJVFADrt3Ynq2mj543M6DVGI
         v17w==
X-Forwarded-Encrypted: i=1; AKwUvBxthXtDBw1MW0HB0QrpvUxCQjg9yktIziezsSNbSKZvGfQnRd8Bm5EYrDpOvpQSmR7G7T89qnCQccu0nHVLm3fc@vger.kernel.org
X-Gm-Message-State: AFuF++kPhtHvG9ixIY78bBsKR4gtJSR4gP+/s8TK3f2CKExiS7vbDgzu
	tmVWwLBKA5Udu+ZYPQhpxBwQJvBJ1097fjz1MAAgCIb8JwgPSmlesdk10Rl6/rC2+L3fFcVDYop
	IvrEjMjbWUw==
X-Received: from dlae4.prod.google.com ([2002:a05:701b:2304:b0:144:db76:3e5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6298:b0:144:f096:4dda
 with SMTP id a92af1059eb24-144f916f00cmr3314921c88.43.1790147664407; Wed, 23
 Sep 2026 00:14:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:46 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <5289bf094c7e9d37990d2d36fdf2deb025478c1f.1790145937.git.irogers@google.com>
Subject: [PATCH v5 06/23] perf trace: Start BPF summary before starting workload
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
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
index f67557e7a254..f90c6bb4d8b4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4844,17 +4844,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
2.56.0.rc1.315.gc6ed9934b7-goog

