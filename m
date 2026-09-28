Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8F38CFED
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619991; cv=none; b=cAHErSIcBDW7wealMpoyrPX9kKX4ij0B6niGkXHyZwu6Aw0mew+MR1rBT6QAKRi9T6IgbGLyhCPJDd/o4kQmLy8G0X+0wsb87vryOKrtHRG+lGfQpu91Etpcc0VUgp+ufzm9sunl1aWKvEES2McgA3RFB6IqCLhcf2pkSJMdhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619991; c=relaxed/simple;
	bh=21FnBt6xz+cS1Eo3vnZo8gnR2+yMIJbL6y/GpuBa6Dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nUOmpmycFt6plcxIehROENJI4ZSwOcAGgpjfVOr4lpEx5a2UBGcyXqbp7HWfzjbEDV7oFdE8BD0IxSuVO1DJKjEidhIyBCQQRKW4KCs7WJqKw1lvDlzAe7lPGZz+CWwtAObhlEmQz2eZJOOMc7Pt/p4o0lOLaYkZahccl012zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBdqyMn0; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBdqyMn0"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33baaba6371so12326772eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619988; x=1791224788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39cwik9DwX/Gul1DUOxUABvjvx6S1yrwHfQQwFrAFYw=;
        b=KBdqyMn0XHfY9AGL+mnK6bZjbcMjrI+cISqzfPO5TwrMRr7EWnVdXUxPXEeWyFJsu+
         o6Fe7Bzr0eko4PoD4hgdNa6vdNGZn/Tg9oY798UlF2/rFIEHtO3siMHR0HjWMu+Qmt2D
         dUknox2LpnJFl5j65F22qMdrbK5+dZscp/+KZBwOVeSCIDwSuCvzN5EK5uOeQFg/UQF9
         Ex2QkgiPN6Ti2S2y2a7johyVXTHYliWI6mcUI5KDSSJJHGt+4PdJDU/tjFpvaBBqQP5L
         rX9mE0vdKrGuG5eEEUYxJxfOyCFzpeGrSSVk7P8js1WfRNM0mk2fMoEyWqCgn5YYfuch
         cekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619988; x=1791224788;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39cwik9DwX/Gul1DUOxUABvjvx6S1yrwHfQQwFrAFYw=;
        b=N+u642vxiAnoeR8LZFFaFqg9UzOE+6nfylIsNIsdr0whH2mQTFom81tjpc6kMNxusb
         hTU82bV1857n/7PqlbeUbyfN9eY7d7Fp1Q6OtyP/T5VNuZp+C42gU3mfVi9VKcGrOGev
         sCk75eqGygYlH+iWs0GoeFB5b60q8L3CjzowRjH73WKms95UAlXc9B6S5g5Q6E5B0juy
         4XNXPuUx+jTEo/TRQXJ8AkvktvcG3c+wDF3TRzuoamf70A/dhApOOdZcPxSfV6UHArRx
         ogzHRFMSWDEkO6y2QMbsDnr3jFn9kC2s+Od5EosBsAQL2yk51Xido1iEjnBGlHkjGtyA
         j07g==
X-Forwarded-Encrypted: i=1; AKwUvBy2v1Cz0EMQaKj8BtxYawCDOY5BDO6dD7CX8BFma5qkdSU/dVImdSD3Mg8LWrB/0EsFdzYcYysSCkYYaJwF05+S@vger.kernel.org
X-Gm-Message-State: AFuF++lva98RCtILb0bPu5Joh1+cr3lMW6oqtc0bJopP9g7YR8c+7Vys
	QFjq4an6gCLeg4y80LPNrkd42G5ZrOU8KjfT/Bk3UWDHtLEGkahBEhRTNsKAvfQpgBdkp/wD9Lp
	3VoR43FfzUg==
X-Received: from dlx24.prod.google.com ([2002:a05:7022:98:b0:14a:fd8a:cbe4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2506:b0:149:50cb:216f
 with SMTP id a92af1059eb24-14950cb2220mr4877126c88.33.1790619988070; Mon, 28
 Sep 2026 11:26:28 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:46 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-8-irogers@google.com>
Subject: [PATCH v6 07/26] perf trace: Start BPF summary before starting workload
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_start_bpf_summary() is called after evlist__start_workload(), so a
short lived workload can make its syscalls, or even exit, before the BPF
summary is enabled. It also ignores --delay. Enable it along with the
evlist, before the workload starts or after the initial delay.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f94745a60f4a..1ffe824ba670 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4855,17 +4855,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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

