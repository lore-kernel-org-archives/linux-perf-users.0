Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275801;
	b=btzuW/dGleIGEJ9F/00wvPSbcGA+8v1Uiiogl1kCUn8lewB8f90LNq3FEZ4dn3re80CX
	 /r+34xfBq8ZtgYw/6nE5yT/ptMNLp9oXf5w2qaj9h2hGPTGXXvXCRwY7VHKXcLreYBtJp
	 rezCRONEpqQFIngDCDj72TlEPvPdTRB0/8XWTau6nDsFwF2detJzrCMuFZX4O7v3SwzLJ
	 0/NU89kZ/Ay4UEVTF7MO1JPELyiJtrUWWBhsMfrKQmOarFulHSQ1q23lQvAQza9vPbWLC
	 YBAV/gsdxii6qDjYyoZi3ML6f817O3cmuR0mFlJit+nURxqTcsMZcDdPKesiUzu9IYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hs+C/L2vK4pjuwKMUUqnuI1C5qUWdZU/iLOb9b47lIc=;
	b=n/NAsCDNrU4hYEfNIG143k6Zjn2ypCWJ5khkyoeB0LlvcAHMiTVxKuP10ek0UVZvf8DR
	 oVbwTLF+dDkoZ95ExbN5JWE8qvzBDWJ9XM5tyr039n/Ym6/PyxuQd2+95CNnIS/o+FXoF
	 dlBsyIze7vyciaXyFZY1LY2EZjL2dji7oS/qUqMonEKyWAZ0CC5F9Ct0oerjVMLlWd+a/
	 3K8L9h8gWv8QJ5OcDmbtc5giyrKnzAGWf6a/lzLu7iMPJ1KRru5x1qcI0L+gwfmh11tIH
	 Jo26rMQ8RxQaRr1kXj8d8S481HdmcGARFXKuYnJawZWJTrsrXK0Zjv9pp+yINxdlFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awvg6Z5+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89BD606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awvg6Z5+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF191F0089F;
	Tue, 10 Nov 2026 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275800;
	bh=hs+C/L2vK4pjuwKMUUqnuI1C5qUWdZU/iLOb9b47lIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awvg6Z5+cOQRn7zX1scmcYA1yh8rD81vhM3cYzSbUbU/2YtkSjG4A0F6QfPfaG0rV
	 mvucGfxBh/A892PkmbMxYdWZuzMCMHt34zW9K8ifs377K8rqTQj5yKYxTQEaOz76Np
	 tu14q//PJ3UeNYNvfIK3O6ES0SLvUoSf1JcDPmBijoIewr+19BezoLDCJiysUlx6Kp
	 tpqojf4qc1JktGkHdIt4Hxl5/V3shrueSaSTRiQOl6ig2nsrpxL1iOEkQgFhW5AVE5
	 8e99sEMS+OJEkc7PiS6RHedVOJoJboV21xACMFtsQThUsGFpXxqOv/4fxvN/SVRoQP
	 V6bUhIkNFasdg==
Message-ID: <sashiko-outbox-206007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] riscv: ftrace: use the frame pointer as the
 function graph return-address cookie
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110013750.36800-4-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:56:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The function graph tracer stamps every shadow-stack entry with a
> cookie, ftrace_ret_stack::retp, which stack unwinders later pass to
> ftrace_graph_ret_addr() to recover a return address that the tracer
> replaced with return_to_handler.  The match is an exact pointer
> comparison, so the producer and the consumer must agree on what the
> cookie is.  On riscv they don't:
>=20
>   * The dynamic ftrace path stores &arch_ftrace_regs(fregs)->ra, a
>     slot inside the transient ftrace trampoline frame.  The frame is
>     popped as soon as the callback returns, so the stored cookie is
>     an address that no consumer can ever reproduce.  It has never
>     matched anything since ftrace_graph_func() was introduced in
>     v6.8.
>=20
>   * The frame-pointer walker in walk_stackframe() passes &frame->ra,
> [ ... ]
>=20
> Fixes: 35e61e8827ee8 ("riscv: ftrace: Make function graph use ftrace dire=
ctly")
> Suggested-by: Martin Kaiser <martin@kaiser.cx>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D3

