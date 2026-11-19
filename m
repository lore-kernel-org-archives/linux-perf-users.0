Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046830;
	b=zB0+tOO8w4Js84kOw0GZFy/IRSIxDqO71zMRBcJU4g96b9K5GG1mBzMkMXxapinFldpy
	 BAu6Tq6vnPDnkQKTABZYwEH1BKtJzOFTzmXagc4tKVjwj/+Y16kRQlKDJcfV6xxsWn8eu
	 oqHiWivyqIySEKr0Ktpol6AMg9MCqZ9RNpTBvLkQjw92vt9F2xqq2nyYp2IqSyLVpc32/
	 OzgGl/drZ5mE3nS09qSc8E1LOBqCqihNir9c2H/JxcvPZcCee5b1O6np608VqFAnt5N9U
	 Kn/NgQp7g2mV+oAEIJy8HRHjyA+e8z/lLwljdDt6TiTyOTyfkK863Hz3AenwfSY2bhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0rT1WAIynsvY1Idl1H8eNd9TsDeiVixMB1NfkWQSSZ8=;
	b=fv8sl9jIflpl+SHDLcVMxtsFrH5ZylPYVidwjD+MB7eG1DLumAiVZL09slq8VApkqHuH
	 frBzT9EKs+QS3XjXr0+n2y9bC1PesTnO3XH+HgYHUQTGmHo+bqCJQsXBDrDNn4snlGqr9
	 yvJ8NGSFXtcMwquDQkUsd9ckK/8/OhkfSafROR/MV7QR9UHU9hEj0qYs1UmNasN+l++R+
	 7JDcYg8gra8VmvAewIEk1zRwU3LNv2pSA7i3tGEPrbt+Q8YYTFYhOa826IiS9FfYy+wsA
	 RAzWLM3ImC2pQgC9MZzElcw824czBc5qj2Y64nRt8wDyzLSXhYqgM0aJ8Y3v0Jsl4aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjmSVBzh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEF606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjmSVBzh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131DA1F000C4;
	Thu, 19 Nov 2026 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046830;
	bh=0rT1WAIynsvY1Idl1H8eNd9TsDeiVixMB1NfkWQSSZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjmSVBzhcu5MpI7rinkfNsRQWDKahVg6k0THwjQKjMsx/x5KeQJgrPhCdmujr009E
	 p8KN5jwewG187h/0qEPYadGy20DB0bTBFh0YO0tRBEillhT23RC+lrcz/fB9u/860Y
	 76apetgNZIw3zqoj6vldIyBV27AxtCUiSyt/8SJ3Z5V7UWrVqCN9dYMCOD1TgX1It6
	 gI5k3ZFAvB45/Jp1N7W/Hk4LfdPRrF4gGHdUUx+I2ccCjThvLA5DNhzKL0qLthtSbo
	 NpdSKksEjC4iIjwXfLRXlq3aUJXFGnYaG5rentd5x+pHu3gTZiOW2ihUZJ1efuugtJ
	 r/l3Z9xlqAeTQ==
Message-ID: <sashiko-outbox-222230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add stacktrace_ips test
 for tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119000112.2377949-3-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org>
 <20261119000112.2377949-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 00:07:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a tp subtest that checks the stack captured by bpf_get_stack()
> from a tracepoint program, recorded only for the test's own process.
> Depending on static calls and inlining, the stack may or may not have
> __traceiter_bpf_testmod_test_read in front of bpf_testmod_test_read,
> so accept both. Also check that the entry after it differs: x86
> kernels without commit 6d08340d1e35 ("Revert "perf/x86: Always store
> regs->ip in perf_callchain_kernel()"") report the tracepoint's caller
> twice.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119000112.2377=
949-1-andrii@kernel.org?part=3D2

