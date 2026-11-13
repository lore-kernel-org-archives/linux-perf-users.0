Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549992;
	b=pqMp1jdV3SjQH/rLlcQlGBCQZhcvXBOARQE5f5bx7+AsLVz6TsXqh/GlibgS/9ryS9Fu
	 /e6FPoFx+WvJO6yiRvTaQXiIRjfS8hOMPEwPlvbprwjGcCpL77PvlzTSLvcr85NUgFKLu
	 6mwov37EP3xIV7bh+onHAbyZuSZDnQ+ok0Yd6HExoj139FdHQe0KFqFwrre93xkTVHGZ5
	 I6gwqdw+LeONVLpDg7acH6KGhHU3dR3gVEE1VTDfChjU8/doe7gZmmKpjyJccbXzdvk6z
	 2mfg9ONBeVoIxrmKPYrRyHh21bTGOqgDq14EaGCPDc4n6dRQo5VdCUo8zSWhqG1jUQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7eBEbjSHRyTuLCGzueTU+2WxNcQni5Zc0I4RU+gEIe0=;
	b=D9B2Lb8LC20NWJOn8RFiu8jm5TFkAOhm6jj4EVkynSAWNB+TKE2kgaPN+hOwNRUYXiEw
	 LAREYpDvrH2Ko23fR9hGOhShmkYwdRljin+36TOddootuIPx1eBzK9eYIv3O5JKlPTedq
	 SL90pel8YQcbkWel9jtu2Cj+wZN5hmrHmUEVt/QnNZJKCAaORXxdNeL8o72Uv2gGsES3u
	 VYiFnGWqr12xrbIblJMAps2/pl46YQJqX2MggZYdP6nkg+OfRoTL2nnZp6iSOEaw5etVr
	 /i3Ms9HOvlEjVv3p4hQ9+bPfGl643umCthWCHpxWmceICT5CEojBySO4Bi+kX5ZriQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLSY4gDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78165606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLSY4gDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6F1F000C4;
	Fri, 13 Nov 2026 06:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549992;
	bh=7eBEbjSHRyTuLCGzueTU+2WxNcQni5Zc0I4RU+gEIe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLSY4gDnngO+R9mIpTEExbGq79evamXjMgiKmK3YeHOfe9h264ZX6wyrJUjwMd3DN
	 8eracm6S7vdXlp07ZxYzO8KLfylu8MmbQ+5jcuGW6CPFXG48sOwGIYkoBe56M2ghu/
	 z5WoU9CEfBYkdT3qId3juC1s0eHbFHcFV49fa8mPBo1ZizuSJ1lRHgkQWFvq7O9zVk
	 VZ9gCrZs+cUrb0YyTn6GifSic2TYZ4XjHeI/3kjX99A4hY7eVaIm29dRd4t3z5L28F
	 qFCry6EQKHXTTAvT9h/LuNdUQ0Lnv6ZQ9afHkwznF4Oou4YvAM4IRA22rZe0u4MviT
	 wT6YuYjUEYdyw==
Message-ID: <sashiko-outbox-212269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113055926.1159033-3-irogers@google.com>
References: <20261112233738.699031-1-irogers@google.com>
 <20261113055926.1159033-1-irogers@google.com>
 <20261113055926.1159033-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:06:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file
> when system-wide recording is permitted, a synthetic live UI test
> exercising the rolling window, pruning, pause/resume gaps, round-flush
> framing and zoom/cursor following, and a live workload recording test
> when scheduler events can be recorded system wide.
>=20
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113055926.1159=
033-1-irogers@google.com?part=3D2

