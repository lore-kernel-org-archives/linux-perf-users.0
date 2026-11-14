Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615983;
	b=QWSQTdTHF8s+ERxVxB6Y1hwukiZBbYPEUzRmczv+gPDZv0FDf5WjHvTWtp0uFWOMdsmi
	 kW78fZ7lchQZlvdXUqEOAXKtn2YjAerBxdsJ+plf3CUKdQi0I7xEekwi2BhUzYallWnSU
	 vF0ZhBoeLqMC15uvPT+DNSDwxh7RhJeS2sZH7/DDkyXbtLjDnAhtafoGWEfOb0/HZsrFt
	 6vM7KeHy8r82IRIRp4E5a6q620ynAulD0tJMhLSBEbtQXwIRYnoskvKhrPP2QDB8UmEe5
	 M8VLS8ryaSGraLNhdroDODEbIKJXtdTeDKOb9KzSFkHDApwLyW02YJHRHL2qZdjyYag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t6cqJw3I0KkkzPCGJOT85eJyc9+uDj6rsRKARbOY5sw=;
	b=c2ChdUGpSFzPBjQ1Yb25T/vja4FqSrm9z32Wr6zUq9L2A8UDFgBFKor4fC9McQAsEJtp
	 YjkvxPeCwmULKG07BLqafoCZObrhvh21WFWZOk049IVKtEoxdVJ1Z8q7ZDDcONVTrYV8k
	 w6J4CUC9IzjCJTn1HtiuzfOGTmL/WNQnD7Jq9oHOsVRjgSmWV5qxG3fk0ryR+gOwKEPA2
	 RPtt4AaconEEvueDyUmiZtwV+8h/ZSWeyS8Rvj2BJe4u91wazmJqitoBOn7s5tmv7NB2Y
	 ySX4EFVGNPpKx/cnMBbjF1yklrAXgccXR7ZocAYLT3c3FrKHayo2MroWlx0nKlv9ABg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5yFxEDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E6606A333
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5yFxEDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5321F000C4;
	Sat, 14 Nov 2026 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615982;
	bh=t6cqJw3I0KkkzPCGJOT85eJyc9+uDj6rsRKARbOY5sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5yFxEDXR+whjLLNgMdqioTUredAFraMDxjgPdlEU7uU/9oCeRllmP+Rxn3+tLDkJ
	 i6vM7jeM8z/Oexs4stnJHPBxv3/i+bYRHC9EaCtysmOBP6okI6XLfJggw8hiJe59Vr
	 D6C73Jb02O00BzKd+pnPByA3JL/1tFbtgaXGAx7bbFHJaYxxYzJMSrIA+Sfj2gNBGb
	 /6hkMNw7Wb704GAdcxyA80VOAJT21ms/plniD6ymhzGTKBOXmAduARj8V4rjpVfNdD
	 CSV8HzH1mXnp3yxTI6sAyljk2LcVNpCNgzc3ZATPJwb9Ha2U/6Iba12oCqN2d6xCDX
	 rEGJPSW7xkEgg==
Message-ID: <sashiko-outbox-213921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add stacktrace_ips test for
 tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114001846.873499-3-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org>
 <20261114001846.873499-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:26:21 +0000
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
> so accept both. Also check that the entry after it differs: kernels
> without commit 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip
> in perf_callchain_kernel()"") report the tracepoint's caller twice.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114001846.8734=
99-1-andrii@kernel.org?part=3D2

