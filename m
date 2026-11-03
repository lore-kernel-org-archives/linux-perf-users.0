Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711353;
	b=LFnIDweSWFici93icO0bLdKgYgSdPpdAZgn2kD4FNg3bWvdIYhIhtcrfZEWvfbj+IIK3
	 yy0hGWFKMsLPWAlOHlgdz1UI99lbDi62weUyiKVj2wN4cs5mV/hKIt/5RkX2pD1R2y+MB
	 L8AoULLth5rOMKjXkwtyB6bfGgRdHt/zTm4vi1z56PjRXhxf2e9Td+KFQUxl9Ye5bg029
	 vBNWUix57ppou7sKWcTzEwvirtIT6598Kl0xNxguUmMuaZNj1vAIteh0JXScrLfB1USC+
	 dfiKuTGyrh1hGFMzu62jQ5Bihfc3fSjgc90rGyXMW763IOd0Bt32UG7i0MXaGPGxEPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711353;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MYoRPDO2ldHCIxVRmX3/6hlZLkNTnG6TdvBQMsOgf4o=;
	b=F9kYLrGt0VFWWmOfJQoPHfjk+Tvf7U9HcMynxRPiUgZJUamNKEm42IQzIbb5qXybyzsb
	 be6g2Jm/Scrz/dgrA8mR6Tna3CGxIB8k2u34MxNNkAdkwL/FJQrzsnkrrJQGuZG4k4oP7
	 TRBrX+FCfc+AImrUKg+5qrczXYm+LrsJPCTqkzTu8iGAxktXwvylCBdVPDiE+n9E03k7L
	 EP4sCCNi0Tx9F+Vxkeha5dUCMRZNmXcBqfPP2vE+BrZdL4rU+sW8fUYuBx5ZCJpEh1/JO
	 fWUPkp+klOmIZlIiWO+la9VWicf/X6HrFvtjF2mikEo2nRj0SD2fqL3YkEg6D3kV4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=bzYK01x7;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77D606D827
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B77D606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=bzYK01x7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793711350; x=1793970550;
	bh=MYoRPDO2ldHCIxVRmX3/6hlZLkNTnG6TdvBQMsOgf4o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bzYK01x7Ct8WmCsQajiFpoi+y4hRUxoGnYBTfuMdxjPgE60kJoMzZW+KG6bSyXEwn
	 xWMoA142BHwUJ4XCNweMO/hSvuVDpho3SIdPuIRmHOWApVAtgLCh50HcqJFrHUUKcm
	 z+9RK2B5AMgB9WomrzXXATyHV9XPyl8HdgSRiZMhYMRtDoK36OOhv5Yi67Rzi8BUfZ
	 +jjQg/EF/AckeHgvGhve2LqTJ5OjXDryLRd0QNuGwsiDEDdyaOaA9J+zL17T8QhszJ
	 dg057tppR7EZmne4yAPRP5Pm3U1y7JTrGmW5RYUylBrCy4j+QBsLWQBGHFXtKhjlx6
	 MSe08YKmedAiQ==
Date: Tue, 03 Nov 2026 13:09:06 +0000
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH 2/2] perf/hw_breakpoint: Clear stop state in hw_breakpoint_add()
Message-ID: <20261103130859.764885-3-paolobertinetti200f4@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: b95f0a1ddc38c8aad8ac8c0f7400dedcca5725d0
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

hw_breakpoint_add() sets PERF_HES_STOPPED when PERF_EF_START is
missing, but never clears it. The flag set by pmu->stop() stays, and
perf_bp_event() drops every later hit, so a breakpoint re-armed this
way delivers only its first overflow.

Set the state from PERF_EF_START on every add, as perf_swevent_add()
does.

Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: stable@vger.kernel.org
---
 kernel/events/hw_breakpoint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..7a606213f33d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -968,8 +968,7 @@ static int hw_breakpoint_event_init(struct perf_event *=
bp)
=20
 static int hw_breakpoint_add(struct perf_event *bp, int flags)
 {
-=09if (!(flags & PERF_EF_START))
-=09=09bp->hw.state =3D PERF_HES_STOPPED;
+=09bp->hw.state =3D (flags & PERF_EF_START) ? 0 : PERF_HES_STOPPED;
=20
 =09if (is_sampling_event(bp)) {
 =09=09bp->hw.last_period =3D bp->hw.sample_period;
--=20
2.53.0


