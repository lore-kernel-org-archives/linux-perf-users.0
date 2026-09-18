Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0554F93B3
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740438; cv=none; b=Hi/H6eATkxFHFDM+Lfwuj4q5fvP3W6Jz7geKS5a4KfMFkNs5qnjSbDnm9NaxqfzZ9cnKlpjR0+GFJ8DoRpsWn76nVkNIfg5G1uOlOEY6jgrSTw5vDGuMBo2BsYcUMqufGrjxnqWRxfDSwHqtyftIv+jbyq1XFJKtO0V0MWtZd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740438; c=relaxed/simple;
	bh=9No6g42lrB6QKcCBOOEFSgMqI1po/ZrRv9DIdc2oFZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdj9lNP0ETEcvf181I8RzzGCYGDPqDLTz5Q9nuyWSIBPJAOsGWs662aiBQT5m4Y5cxITAroRRi+4MT5jlyu120Tf0tHnIQ9dtsFWK9KccM9rIlWyQVxXIdZgPyZHaLo4J4QfAO2EfvystWtu+m9B5yCIfAjvBittmvtDSxF6cJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiEaB5FV; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiEaB5FV"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4fc935a11so714399a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740436; x=1790345236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWUdAqwnRNViqY1JbSim/N3szd89pQRjSVQzSYadKOc=;
        b=AiEaB5FV5mNMjP0j3x8wl55S9XOOz8LnhIpBBRjtMc8OfNSuDKl3FMyEJq6eUO8FeN
         K8LaBvSmvTnG+i4ayzBsz6x38Z6zBQZaVbGOayTnR09SS2NtppsQCTknQK7bA+5RRvJa
         0uMker55JkdBzxkIY4g7gTx54qTaWx9NRhJK7+GrV28CiUTQSEpygVw39KOqsJALyYLM
         jd20psB0UM/jFN8QXTEj47eqrYEvJai/YfgFLX6N25yLvYE0LmzOrrp8BSBACI0rKYAl
         8uOHSknWyPzo0YKCWJK0cdVEujFW6Rg+a3ew/ChLyuMUvx/Ak5wSbbVYqv2inFsswtQY
         EweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740436; x=1790345236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWUdAqwnRNViqY1JbSim/N3szd89pQRjSVQzSYadKOc=;
        b=Qy4Vf0u2g5HQr2/2jQyhOLARmqOb+nIh1b6Hdxtct/VUI66MaeX0CR1kn2neHxciuQ
         XODQJzWNLA67FKRey62KdU8PzDntWjxeI9XjqxQDmso8F4pj7K7Gr/PSp8V+QEHj8NN9
         LFZPG+bvqn7OQ0cPPBK8JSN5dx4D9kqDYY+a1TF4krshsu0iqNdsrKxHvUxOIvA0ldm9
         VlahxaFNAgVLP4GH/r6TRl2XZZgL7E3JYHSKb7Rsd/wwZtP8Dc/YUBYJKJMvv6MqzsKn
         dKio7+n0X5U19uxjvt0zb6UNbzTYs1sqhuNB3j4LczczMylBOJPSKPsJD/txCCwJu6Ek
         tusg==
X-Forwarded-Encrypted: i=1; AKwUvBxu0c0EnzBerUErQ95rji60vNPBb20yI/5TRWb0r5GT9Z8hCXus4FyKG0tNh5cWgCd94DxlewdDaqR07wocRJoV@vger.kernel.org
X-Gm-Message-State: AFuF++l9sykRFqQylOE0Yuq52TqI1HXp7mUKJ2x/zMEIEkXvfr5ti4Ut
	3+C31Y7jJXaZjiZo5vlrFz80oHNGxVNWdjMSDyUu2uWnc/L7eEllqkSeI4+KumyPR21DLPuTonj
	jYVcWCJMTow==
X-Received: from dybfx26.prod.google.com ([2002:a05:7300:c39a:b0:33c:2bb7:a004])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:39e:6a80:dda4
 with SMTP id 98e67ed59e1d1-39e6a810c81mr72789a91.43.1789740435877; Fri, 18
 Sep 2026 07:07:15 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:46 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-4-irogers@google.com>
Subject: [PATCH v3 03/16] perf trace: Start BPF summary before starting workload
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
2.55.0.1082.g2b9226bbc0-goog

