Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711695;
	b=PKKGjoe852dqjeBAP4UKfyNRT6jdjlWlAyTcgksY2K7t1f+DvlFowIn5TNnfH5139d7i
	 AmBi82nfOd53D9PAFl6ku6yxwvMNk1ky6IZtPxWYhSOCeFY472T86Z2inyC3/RD6k5O3J
	 tgVk307M4bPlwWBJm5UAi7k+lRxj8lYwDudGJ59d6Q2ETp3CF+IMgU0Y9CYIRjqEHj5wU
	 ErT535bHZKHM4/YgHSx62gq8mK+gwRdcLR9jH0S+JLe+bg61PWjgSXu4pCvuW+j0SDu+a
	 dAdhfzdNxidizW3l2sudqtrM5aMl+bHEgyUZ3YIxb9YXs3M/T7iWoygRIBlcwMMtwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/VnJyPDD5LY8+jdnhCSfmUanE9myN6vhRoX5a/seseo=;
	b=VLTbchWkWsy+XuLnl3KV1caReCZmJOa6PNz9CEz/xtalmMkB5q1drs8AUjwOCrPt5H/h
	 vcilj4XIe4Qmu6LJ7e/kpqTXuhuRNyRZItjY1BMizSKodMnaaNvdKxsCd9JV43mVMxCzY
	 tF07Q9n7du4l/E+s02og8abgHwTmkFi7osoZgfu+V29VmVCS3F6VIE/fNOsuNaLZX/EaK
	 K1eArnNjJYoiFO4htiQ9PYn4ZVD0K+ir3S1WI3jirT1cxkoOPtwBt45vYfwfz8uQI0VL4
	 01eGUL6kJeAWsipyZU8i1HaC/JRlaeN+Tr9HkBr1CXBd0QPpUQvatvGgU3Xj2UwP8RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdXX+dlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A87606A333
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdXX+dlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A241F0093A;
	Tue,  3 Nov 2026 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711695;
	bh=/VnJyPDD5LY8+jdnhCSfmUanE9myN6vhRoX5a/seseo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdXX+dlLotLkZ0FEQXBqsbcWJieQdkAPk1clhm3g3I9eB47NifKiNZn5eE76qRo/d
	 90ZFER71gFu/GCsWzipQi6A9EGSrVUsLFVqqVB78BfkghOp4NtjjfEtQSog7B5y00F
	 9R/69tfjIGNsfNOJ0Qnp15NHP99iz2pQ0yNzKj1ILAVuOIQSMXZ09urIdpBX3wOD4a
	 /plSy2MeuihTfC44zEDi2N/v3azEYlTKkoDTnkVJJcoeK0k49GnOoVRI8R1pgrL2c5
	 wXsuACMjlvKbDKf//tvy6qrCEP0j6SpTXIShdJpZnP3y/kzmFDB922h1OcWqRlveeG
	 57cJIxmF7EZhw==
Message-ID: <sashiko-outbox-195314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tracing/perf: Clear stop state in perf_trace_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bertinetti" <paolobertinetti200f4@proton.me>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103130859.764885-2-paolobertinetti200f4@proton.me>
References: <20261103130859.764885-2-paolobertinetti200f4@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:14:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
> __perf_event_overflow() stops the event with pmu->stop() and disables
> it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
> re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
> again and pmu->add() is called with PERF_EF_START.
>=20
> perf_trace_add() sets PERF_HES_STOPPED when PERF_EF_START is missing,
> but never clears it. The flag set by pmu->stop() stays, and
> perf_tp_event_match() drops every later hit. A tracepoint, kprobe or
> uprobe event re-armed this way delivers only its first overflow. This
> breaks self-profilers such as async-profiler, and the "Event re-armed
> with PERF_EVENT_IOC_REFRESH" perf test fails:
>=20
>   1000 events, count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
>   Tracepoint event : FAILED!
>=20
> Set the state from PERF_EF_START on every add, as perf_swevent_add()
> does.
>=20
> Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
> Reported-by: Francesco Nigro <nigro.fra@gmail.com>
> Closes: https://lore.kernel.org/r/20261021131006.2101248-1-nigro.fra@gmai=
l.com/
> Assisted-by: LLM
> Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103130859.7648=
85-2-paolobertinetti200f4@proton.me?part=3D1

