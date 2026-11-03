Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711279;
	b=JpLcJvtwLkvaO1MH9c5rEMlHNxNYEJJax+0Cgrf6hDQnBsomOzbYQsyCQMf5edhy5b28
	 sAwgKKqbKCFU2b3hhotstfzZT2JUwPuGN5dRi6o5gTzfzKpeLt7f1Nx+OBLIa8akKgST+
	 VBv1rBy2aQunaBR09WiBwP76xtAL4TixRE+yBIXeZvBEDeKq8mkpDisoQsRXlpYElAzve
	 +BzxK8XYIA2CEZ3YA1KZX7MVD8zP40SpACFvz8h5SNTU41qCEJ6hA1UCRDWlHjow3eN7f
	 Jw/z1LAUwdzofY/VVsU/BQ6mTC1sxp/iesWQwz4Em7xh+Tt4FGUXT4RQMhGqTa+aliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711279;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=c+qujEuDk3Qk423JLDWr5FOQJN45fWvJPf+U4ORaBOQ=;
	b=t7buNowo7nQLKB8R0PUiMYrXpevOc88Es+1cup+AQeoG3/2YPMooqVL/TA/h9RXbHEOK
	 XUn0y5Lc5N2VwrFom3RENW3DZD3XBmub723JmwPKcXKiknavdWlriALQXLwJah+sQn5eD
	 kIwKN6ONuMYR+2sZ+DUfuCoJtWuhGnfeISrPhApN2p+J5SeIwehVLp4FZa7hivZq2B/IP
	 6YYVJ9nUL5pfZt5uUn43TcFupGHBYoaRru1YTXJXGvL6bgoZ5nB3t00UikzqFvhqOqaUk
	 odeSVB6uBEuSdRnrlUNw3TQ1ESe2HArn65BCtn0I13pvffOtc0rHSzN4ZFfgQUBN1og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=h71sQBFK;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA9606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEA9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=h71sQBFK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793711275; x=1793970475;
	bh=c+qujEuDk3Qk423JLDWr5FOQJN45fWvJPf+U4ORaBOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h71sQBFK5MSYvVPwsm0Uhf0Xo0Bhm38HqVE4LOA9recG1Z6hVjT12UzmHOAa7B8xF
	 ob4iacYi5q6KlkDqXsBL5y5dAoikZVFpvgYhVgN+PJyXINkSVc1aHsSCemMQzJVyMy
	 eZFrQJpKdLfP2IwcmZEhKgCbyPwa7rnJkdWqrMLdCxYcRiBWiSjimsdawjXV8fSrLp
	 ImTmu6I1WHVYMepAnPj/VH+vHMsvwGO0amz5d6vgtlzRaKSGyVZCyJfNaxGmPfccX1
	 NhuReYdQHvqgcg30gEhh2VX2TNQDXT8nblFlEw+1CuYrQPSDkyzYV9DP3oLb7IilZ+
	 dx3mHKVvgr4aw==
Date: Tue, 03 Nov 2026 13:07:48 +0000
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH 1/2] tracing/perf: Clear stop state in perf_trace_add()
Message-ID: <20261103130732.764081-2-paolobertinetti200f4@proton.me>
In-Reply-To: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: 2254ab1d1faf4e1e2b2aac196980988c4bfc813f
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
__perf_event_overflow() stops the event with pmu->stop() and disables
it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
again and pmu->add() is called with PERF_EF_START.

perf_trace_add() sets PERF_HES_STOPPED when PERF_EF_START is missing,
but never clears it. The flag set by pmu->stop() stays, and
perf_tp_event_match() drops every later hit. A tracepoint, kprobe or
uprobe event re-armed this way delivers only its first overflow. This
breaks self-profilers such as async-profiler, and the "Event re-armed
with PERF_EVENT_IOC_REFRESH" perf test fails:

  1000 events, count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
  Tracepoint event : FAILED!

Set the state from PERF_EF_START on every add, as perf_swevent_add()
does.

Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Reported-by: Francesco Nigro <nigro.fra@gmail.com>
Closes: https://lore.kernel.org/r/20261021131006.2101248-1-nigro.fra@gmail.=
com/
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: stable@vger.kernel.org
Link: https://github.com/async-profiler/async-profiler/issues/1813
---
 kernel/trace/trace_event_perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_per=
f.c
index 5b272856e5ab..a549897ee408 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -354,8 +354,7 @@ int perf_trace_add(struct perf_event *p_event, int flag=
s)
 =09struct trace_event_call *tp_event =3D p_event->tp_event;
 =09struct hw_perf_event *hwc =3D &p_event->hw;
=20
-=09if (!(flags & PERF_EF_START))
-=09=09p_event->hw.state =3D PERF_HES_STOPPED;
+=09hwc->state =3D (flags & PERF_EF_START) ? 0 : PERF_HES_STOPPED;
=20
 =09if (is_sampling_event(p_event)) {
 =09=09hwc->last_period =3D hwc->sample_period;
--=20
2.53.0


