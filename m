Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D143499F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627372; cv=none; b=LDKtfVWlCZu/G0TQ3tMFjMH3CK9QZiR+oC25nmIngo949Ub8Lf3Qgk2xNsaV/1g8S4xtuF9jgPsBm4kXa/L6hVVKLd8KwDnqBClJGUCCOWGbrJVp4FoveHEmUAA9o/NO4QGlMgBjRWm4mIZpIdwLbWOLZXQpPPD2QsXGi7Xk18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627372; c=relaxed/simple;
	bh=AIhDuxYXm6TPBGEUGmeWMYRdVi5UgiMgDR7MkYv1egM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1RYx5UHXC8k7i3EZMISH6ZvO9Y4bBwcJ0Gt84NCQGynwcriu+CjjvRCIsQ4xrYsdWdDbCSVgSMXJqHjXnrzEeyBjWeWraYmUPu+nd922IiPQvbdbnTjmmt8yLwx7wqG2wcVQYK8iG2cHRHxoaggis3hj8rL2pn9pvoBRBRbV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6X5waKt; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6X5waKt"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so869069a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627370; x=1790232170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZ4suTwVR71QEmnzgMO/8pQXqTLVqgY6KmKt7zHzuV0=;
        b=N6X5waKtBrJ3DFkBvIxotV62jCMLeBTvHVZEA7vl/y3xuU6aoeA76Pbms3qPYLRMMP
         BbuFqC5XNAhEBUgduPeaqfSXffpD0tWQWufDwxvghPpBc/6eF3o6un5pFfHBg1dBm3yb
         ZWX1piL2aojnbC3Hb3fQx60+ieAphoAQH+fKd1Rvvwv8NH0YVO95MR+aMTydawuwKbqS
         dHKpwhPH6a3f5BDvJlbzVmli1Tai11cTPys2fSURNr4Lu394QzhuMzvvVp9ydLfSoEiE
         0u9vy9I0WNd4xasa3ua8t/ixbWjB+WoPyNAnpiKQSKNSDELKZHbBl8oR6PmRWlgFv5+e
         4u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627370; x=1790232170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZ4suTwVR71QEmnzgMO/8pQXqTLVqgY6KmKt7zHzuV0=;
        b=eP6KIA469Pro1HWZZulvuVePv/QHZAMMnvG6wBSkUVRgiYaX3nEa8PfvqVXapjKSeY
         x2wnywg/lM6zjaG0wh1wc7LzRR+i3IXy3gSgK2Z2vQ6zlKyFsbyqRDU6FugEHqy1AtlJ
         Qmjg1ZiTQwTWm/pMNunYITIeGW/ddPNUG4X+3fRkTRsu47Dmv5S7mYotwBEXYI02aeaF
         aA21uNkvWHZ68B/t5sSkVHi9h6sDn7YOelQRO7mf7KGFlVrCgFij7PeNHg4aH2VexbBw
         tAdFu7YhO3tef7+0WBCusf7MLmLJ7TfqZwxbGuQi40uLSPt/zdyI94Km/lwajMvkmGv/
         ALpw==
X-Forwarded-Encrypted: i=1; AKwUvBxQXB+N7c1nKH4tydpx5Z04WxEAoISHGpMh19UWy/YT3qELOZYMd1xxWsK7hAZFEoTtzzClmVNHkfMsf2runR28@vger.kernel.org
X-Gm-Message-State: AFuF++n9/sPFoQK8aBWacM1NjFIGAez+x+RnxLxZj+WThjKihU0yZmbL
	eg1/ai7cCb5jbW80EwNXxHRVNRgQjN61NFf7ewe08cEdbI3THmQVmuCj3owcrm9KVJ+bi6zD+i1
	QYQy1sni0gQ==
X-Received: from dleb1-n2.prod.google.com ([2002:a05:701b:4241:20b0:144:4896:d41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cc:b0:39e:fd1:bd46
 with SMTP id 98e67ed59e1d1-39e35da22efmr4205823a91.7.1789627369960; Wed, 16
 Sep 2026 23:42:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:23 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <91623303ca281e878444068063fba4bec464bc60.1789626978.git.irogers@google.com>
Subject: [PATCH v1 01/13] perf trace: Start BPF summary before starting workload
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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

