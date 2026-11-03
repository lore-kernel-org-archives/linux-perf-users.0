Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711350;
	b=PbYx9NCo/c8DbPqy/Js1agKApmoCtj1xSyQ+mGTzU6f69mdk0Klg3esO+4yAb2z+Aglt
	 ZCZcdgkgt1OxlDU/6H28ouGpbpymqYZouWT3McqdUg2kenYqA77QUeAtl82j+mcVSrgbA
	 HDun625vdXJz+deFCVpfMVpHygpj4jhE0lptYR8J7u1WFOPaWahQcdlzmlXV6QBjnCsKm
	 HiOXooNgVilcLucrQXNC+AmKkc/4z4ufwhFKMmTZqnCGxU0US+uuZdLQ3h29ZXJNcCXvr
	 YnkimB94FtJdSWlpxg2HQc/256EwJNV1X6biOCvuqj7wRxJbUALqopUIwO5B15P/mcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711350;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c+qujEuDk3Qk423JLDWr5FOQJN45fWvJPf+U4ORaBOQ=;
	b=N9AHT2Rpj3W1nUPhYHVBFbMdA0REVl5pf5FJY6QMSyK12+AMz8WWTlrs6EduTZT9NuQj
	 VlP0Hqt4CqDQ/akUCbQuowzZGcpB3UOjkc4FKkn9rDqbM2jNzhZswpxUbTGjp/qxVT0Kg
	 /4c1OZY1qcD5tlX9cX1uxoMRYAhoM2b5HnxrY54Dnwxn4IwgHhyMJUhek6N57PEAspEzb
	 NsP3OfRAec/FtGtkHddRCT4xSn7LusSjgworHZGQf2hP/C2y9RfpLzLSwncM0Evmc3+/A
	 oUrPxhvsm3pbgtIj+2RyOV8h6LJHdt6F815u5q3doZkPLwmLlRVr82WL27aGvtIgIpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HvC6Zhg7;
	arc=none smtp.remote-ip=109.224.244.121
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B5606A335
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137B5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=HvC6Zhg7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793711346; x=1793970546;
	bh=c+qujEuDk3Qk423JLDWr5FOQJN45fWvJPf+U4ORaBOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HvC6Zhg70YgYD5MpyV3iXydlnPHHkevNUWeBECfdu4VfLlF1mFNiM6rxtnje1LSlZ
	 pLy61DrB7Ego/7JT5pbBZmLfukU0+Ea3iY7Hsyq3k04j15L9RJ6RZoCsXhBV8uYHU7
	 vpGLyJju/mcsxUUynNuKYksmRUR8qOxyautdg/YH6qqt/8dDJ4AcXqkzMxdJJ/G1mE
	 JNuz8SvXry3oIlRiqXoAjMrjfRLYEGpjUqGMP9T0OTYaWwq1Lg2GnSsNCzxwrQl4fh
	 2OWs3XLwZ4z3n32mlug9SVlV5QgbBgkBRV76Uhm61xjnsNeblBlJAJwy6uRRrB35wD
	 hUpuwe7ZWAvJg==
Date: Tue, 03 Nov 2026 13:09:01 +0000
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH 1/2] tracing/perf: Clear stop state in perf_trace_add()
Message-ID: <20261103130859.764885-2-paolobertinetti200f4@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: 45b61b53caece3e7dd1946562e99d041bf4d108f
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


