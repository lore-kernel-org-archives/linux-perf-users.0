Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8439A045
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620010; cv=none; b=JPUZWpvSBjP4kuUoYvyBowl+ME3/hoyyRcQLdQgBouDsn1UDIr9ITACto3QVsdGBcxeGHrQ0X+ERP3KgDOFHQGrlJxLXUV8J5d1M0VDGejOMbR0ji4AWVJR47k9OnraywMzc/ILlLy/0ZYINVn10b9RRf3P1PontUVm1OEuPUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620010; c=relaxed/simple;
	bh=stDGIRV3yP7UdnHBd91hd7iMzaRmovCfg0lN/hm+d1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJwU0lRQaAyZDjAmdVvIztXBdG2Fgbuo9BhdbTFQPW03mxGbpjLx9J+k4WfnyTW9/PUKMmECfDxUcLo73SR9xq28wAS9z16/yhiRKc4eQ3gzv55BafDZXEZXsmlMOyT8iPh5D5cSLUZegvPsKQyknFljdwcGkG4/8Nap6ZSU7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBM1kNLd; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBM1kNLd"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-142f4306744so9203712c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620009; x=1791224809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ps0C/R3sEFiSzvb3Yj5BZSk3NqGRn5rOIsit9hxlM0=;
        b=pBM1kNLd0P4leT1uNaQ6H5AQvXBxbwhNhCFVsS81UX9ka/AF9YiyKldX+/8ugODQTV
         tabmN+tTcRK+lgxfWiCGf3AhRfvjSVnmGbnRhhRvAT6e8ddj3Ax+prRpp2IYYzTcEHMF
         4KE0JqYgxHEeR9clgUxCGbbVcntWJfKP6LaVs2U58QoZigEl1q9TSRXH7qYnC2+/EJkH
         Zdako1rM5Z4VT0HdZxTisQIvBzke5Fmg335FdkXRp9du7cTfC7+7GxsVlxktVwgKq728
         OtqrOXbf0A0e9kV4bKlID/lAx/wRzVrTDCIFj2go+jHYjYj8aEpZi22w6kXGyRzF4+Gh
         /NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620009; x=1791224809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ps0C/R3sEFiSzvb3Yj5BZSk3NqGRn5rOIsit9hxlM0=;
        b=dgEYEcJURhR8uG2hsru7XfG/kk0mX9K+Om1NhHjJDOZiAhl6viglyee8YEbpZIZJxK
         L1ourzQr93jLQ59dkE1w5HNDepr/NF7SGzf+3Izu+YFJ3X4hzu7OS4m7LHBY9gW6UIhY
         IO1H2fKb9LYEpUDL9GniwQ0m2dDAPIhmlArfRcowuefxvuzqtjPvADcQHV+bfExasjJM
         FSIzeuLBy/u7sDnRKWumCwPEquyTmD+NJuj2sb7MBmLiAsZqQfnTOewR+lt7RX0kekY6
         weMgh76X6Dj6KLLWu3zjtqRvS+vVndYmkxRfvpyigbrsRNc9JxchX4YeDwm0DIGHK1P9
         C6Tw==
X-Forwarded-Encrypted: i=1; AKwUvBySM4NvApnAUfx2CDVF37dXdAOdQ7Z9I7eae26gUPngAYUQuIq2l4to4nvepwb6P5aj/dLpDC3cPoprDUG02wsL@vger.kernel.org
X-Gm-Message-State: AFuF++mnACXAvpQzz5fOUYwmO3OpHk4u9uKj2V87dYU31JQl6LEDVnje
	zkBBRcdr7DO1cqcSVd8xaQk2EJwB58t3ad6xkubV1l0t8vigvIShzhDgcBeWrzUGaARSfOQaZYV
	97G6zxZENlg==
X-Received: from dybdx31.prod.google.com ([2002:a05:7300:b19f:b0:34a:f2c6:9e54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b0d4:b0:143:3fa1:ed02
 with SMTP id a92af1059eb24-146ce67fc6dmr11361226c88.9.1790620008261; Mon, 28
 Sep 2026 11:26:48 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:55 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-17-irogers@google.com>
Subject: [PATCH v6 16/26] perf trace: Open the BPF output event on every CPU
 for task targets
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The bpf-output event is opened per task without inherit, and
__augmented_syscalls__ holds each CPU's event for the first thread in
the thread map. bpf_perf_event_output() only writes to an event active
on the current CPU, so the target's other threads and its children
aren't augmented.

As BPF now picks the target's tasks, open the event system wide. A CPU
event isn't enabled by exec, so for a workload enable it when opened,
BPF waiting for the exec instead.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 81d660bc87b9..ee844210e281 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4784,6 +4784,15 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->cgroup)
 		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
 
+	/* BPF picks the target's tasks, so take their output on every CPU. */
+	if (trace->syscalls.events.bpf_output && !target__has_cpu(&trace->opts.target)) {
+		struct evsel *bpf_output = trace->syscalls.events.bpf_output;
+
+		bpf_output->core.system_wide = true;
+		/* Exec doesn't enable a CPU event, BPF waits for the exec instead. */
+		bpf_output->immediate = target__enable_on_exec(&trace->opts.target);
+	}
+
 create_maps:
 	err = evlist__create_maps(evlist, &trace->opts.target);
 	if (err < 0) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

