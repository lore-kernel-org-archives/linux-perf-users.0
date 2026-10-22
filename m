Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634588;
	b=Rmng8XOySG7lKb8dN5b97nmAD4XpdEgnvTi8+PH25m2szauldqkJSr+nOw3vTDvQdoRu
	 HHXLW3CQg4Vuo+qhz0iRlFImFqQE/a0BfhOmuUgRD4IA/jr+ckzSI80CS086PIRt9Vyvd
	 XvFDgBhJVTQKkcxTU24x8sPDhJ734oiCWyg8TuqDghuF4TxZZnyfSsrDe4kX7UNuF3D5Z
	 dZ9aInlMHjmDtWDMY2EASNNIxoxqfqRFkttEhqeS7XaQ6I4Ex+hkhK/VVVF5miZuf6YpQ
	 ucpJamGapYl/VVKjXy+boUrYA+GeK9vJe4B4t2xrdNTEZ3fKZFySNV6+ghfTmXk9t1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bTb1uIsI0QqJktg8Izz1DefpTItAWaJX58zmz11vqhw=;
	b=w0zDK6rTZVpYdC4m0oXVnTR0HqAn/hQ+vReu0mbgZi1RxK/49ZGiPcrECalcIQV0V8IU
	 PbuOwMutV6AHBX8v8pHF541v341JqOTfiVMXvFPA5iwd4MSzXBnRnLlVeV49bnzPLJzc8
	 U0zD1DoEyrsDhTrw/4E1HY2sEjoZx4+F584zM65vx9+ObJoaGxDeeS8gNO8318EjTSiz6
	 ZwIa0qUOUYJpAGx5Ent9rJ2bVNU7lX9jAnB+baRLKvCsIoCjUUQIRs97qC7xPkaQkyVoy
	 p28laLr2XpPzEf0xIo75WF9UpkOQ6IHqHzEEW4UO0JazShjpcsgr6CUJtI1mU46mxAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/Z+ix/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7444606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/Z+ix/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795E1F000C1;
	Thu, 22 Oct 2026 02:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634587;
	bh=bTb1uIsI0QqJktg8Izz1DefpTItAWaJX58zmz11vqhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/Z+ix/emQKx9f/F8zGJ4QJAzpmPPius+DKzS9ngZSkn4rZ83l53chRoerKdoLYlF
	 dg6yYGWcNDMEtp1SSdMF2g/PtWN+VS1Sq+Yj82V0F5HGBlgkKjrPk+/AeLtL4R6/Vn
	 cA/IQ0iV7p6PeBK0baqogFmThFIJyex4C4qi1aIeIYL3OChisrjna0hCM3VqubqMCU
	 INROdhkd9ts7FrgIkahVJbxLAGhWJJ3aM6lhmuFBOaQn1+dmqgXC2uEo7ORvlp/I1e
	 GonwfuwDoNa8P1MzGzRSDrsNUDzvr4S4FYyr4g7HBhxXUbgltiCafpxqxwkinHZzPG
	 Y7ZJZxjMPEUJw==
Message-ID: <sashiko-outbox-180854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:03:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> __arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
> uprobe_write() fails, and user space can make it fail:
> - -EINTR from get_user_pages_remote() when current is being killed.
> - -ENOMEM when COW can't be broken, since memcg is at its limit.
> - -EINVAL from __update_ref_ctr() when the process cleared the semaphore
>   of SDT probe.
>=20
> Kill the processes that call probed nop10. It warns in 8 of 8 runs:
>=20
>   WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0=
x3a0
>    uprobe_notify_resume+0x1c3/0x4c0
>    exit_to_user_mode_loop+0x63/0x4e0
>    exc_int3+0x1f3/0x250
> [ ... ]
>=20
> This depends on the previous patch. Without it WARN was the only sign of
> the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D4

